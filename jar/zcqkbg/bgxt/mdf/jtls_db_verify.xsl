<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.1">
<!-- 
!! File:        $JTLSHOME/script/xsl/jtls_db_verify.xsl
!! Description: This stylesheet verifies the jtls_database.xml file for
!!  consistency between data items. The following items are checked:
!!
!!  1) table, column, and constraint names are 30 characters or less
!!     (Oracle limit on database items)
!!  2) Table & Constraint names are unique among object names
!!  3) Column names are unique
!!  4) Columns with a set_select_key attribute of yes have either
!!     a primary attribute of yes or have a reference constraint
!!  5) Tables with a set_type of selectable contain at least one
!!      column with a set_select_key attribute of yes
!!  6) Tables with a set_type attribute of dependent must have one or more
!!     column cosntraints with a set_action attribute of primary
!!  7) Columns with a constraint set_action attribute of primary should be
!!     in tables with a set_type of dependent
!!  8) References to tables or columns contain a valid name
!!  9) Alter tags with action='insert' or action='default' attribute contain
!!     entry tags with reference column names as attributes
!!  10) Every reference and foreign key constraint must have a set_action
!!     attribute
!!  11) Every reference and foreign key constraint must have a cascade
!!     attribute
!!  12) Constraints that have a set_action of ignore should only appear if:
!!      A) its owning table has a set_type of dependent or auto-fill
!!      B) its reference is to a table with a set_type of baseline
!!  13) Columns that have a constraint with a set_action of nullify
!!     must have a null attribute of yes
!!  14) Table with a set_type="orphan" must have a set_parent attribute
!!  15) Only tables with a set-type="orphan" should have a set_parent
!!     attribute
!!  16) Insure that reference and foreign key constraints with a
!!     set_action of follow do not create a circular loop
!!
!! Output is written to the screen one problem per line with each error
!! condition starting with the keyword "Error".
!!
!! To run this stylesheet on the jtls_database.xml file type:
!! saxon jtls_database.xml jtls_db_verify.xsl jtlshome=$JTLSHOME version=3.4
-->
<xsl:param name="jtlshome" select="'/home/jtlsdev'"/>
<xsl:param name="version" select="'3.4'"/>

<xsl:output method="text"/>

<xsl:variable name="cr">
  <xsl:text>
</xsl:text>
</xsl:variable>

<xsl:variable name="tab">
  <xsl:text>	</xsl:text>
</xsl:variable>

<xsl:variable name="apos">
  <xsl:text>'</xsl:text>
</xsl:variable>

<xsl:variable name="dds_script_home" select="concat($jtlshome, '/script/dds/version', $version, '/scripts')"/>


<!--
!! TEMPLATE:     match /JTLS-Database
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 17 February 2009
!! DESCRIPTION:  This is the main driver template for verifying the JTLS 
!!               database XML file.
-->
<xsl:template match="/JTLS-Database">

  <!-- 1) table, column, and constraint names are 30 characters or less
       (Oracle limit on database items) -->
  <xsl:for-each select="//table | //column | //constraint">
    <xsl:if test="string-length(@name) > 30">
      <xsl:value-of select="concat('Error: Object ', @name, ' is too long a name for an Oracle object.', $cr)"/>
    </xsl:if>
  </xsl:for-each> <!-- table or column or constraint tag -->

  <!-- 2) Table & Constraint names are unique among object names -->
  <xsl:variable name="unique_nodes" select="//table | //constraint"/>
  <xsl:for-each select="$unique_nodes">
    <xsl:variable name="object_name" select="@name"/>
    <xsl:variable name="current" select="position()"/>
    <xsl:if test="count($unique_nodes[position() > $current and @name = $object_name]) > 0">
      <xsl:value-of select="concat('Error - Object ', $object_name, ' is not unique.', $cr)"/>
    </xsl:if>
  </xsl:for-each>

  <!-- 3) Column names are unique -->
  <xsl:for-each select="//table">
    <xsl:variable name="table_name" select="@name"/>
    <xsl:for-each select="column">
      <xsl:variable name="object_name" select="@name"/>
      <xsl:if test="count(following-sibling::*[@name = $object_name]) > 0">
        <xsl:value-of select="concat('Error - Column ', $object_name, ' is defined multiple times in table ', $table_name, '.', $cr)"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:for-each>

  <!-- 4) Columns with a set_select_key attribute of yes have either
       a primary attribute of yes or have a reference constraint -->
  <xsl:for-each select="//table">
    <xsl:variable name="table_name" select="@name"/>
    <xsl:for-each select="column[@set_select_key='yes']">
      <xsl:if test="not(@primary = 'yes') and count(constraint[@type = 'reference']) = 0">
        <xsl:value-of select="concat('Error - Column ', @name, ' table ', $table_name, ' has a set_select=yes but is not a primary nor a reference column.', $cr)"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:for-each>

  <!-- 5) Tables with a set_type of selectable contain at least one
        column with a set_select_key attribute of yes -->
  <xsl:for-each select="//table[contains(@set_type,'selectable')]">
    <xsl:variable name="table_name" select="@name"/>
    <xsl:if test="count(column[@set_select_key='yes']) = 0">
      <xsl:value-of select="concat('Error - Table ', $table_name, ' has a set_type=selectable but has no columns w/a set_select_key=yes.', $cr)"/>
    </xsl:if>
  </xsl:for-each>

  <!-- 6) Tables with a set_type attribute of dependent must have one or more
       column cosntraints with a set_action attribute of primary -->
  <xsl:for-each select="//table[contains(@set_type,'dependent')]">
    <xsl:variable name="table_name" select="@name"/>
    <xsl:if test="count(column/constraint[contains(@set_action,'primary')]) = 0">
      <xsl:value-of select="concat('Error - Table ', $table_name, ' has a set_type=dependent but has no column constraint w/a set_action=primary.', $cr)"/>
    </xsl:if>
  </xsl:for-each>

  <!-- 7) Columns with a constraint set_action attribute of primary should be
       in tables with a set_type of dependent -->
  <xsl:for-each select="//table[not(contains(@set_type,'dependent'))]">
    <xsl:variable name="table_name" select="@name"/>
    <xsl:if test="count(column/constraint[contains(@set_action,'primary')]) > 0">
      <xsl:value-of select="concat('Error - Table ', $table_name, ' is not a set_type=dependent but has column constraints w/a set_action=primary.', $cr)"/>
    </xsl:if>
  </xsl:for-each>

  <!-- 8) References to tables or columns contain a valid name -->
  <!-- Check //reference/@table -->
  <xsl:for-each select="//alter">
    <xsl:variable name="table_name" select="@table"/>
    <xsl:if test="count(//table[@name = $table_name]) = 0">
      <xsl:value-of select="concat('Error - alter/@table attribute refers to unknown table, ', $table_name, '.', $cr)"/>
    </xsl:if>
  </xsl:for-each>

  <!-- Check reference/@table, //reference/@column, //reference/column/@name -->
  <xsl:for-each select="//reference">
    <xsl:variable name="table_name" select="@table"/>
    <xsl:variable name="table_node" select="//table[@name = $table_name]"/>
    <xsl:if test="count($table_node) = 0">
      <xsl:value-of select="concat('Error - reference/@table attribute refers to unknown table, ', $table_name, '.', $cr)"/>
    </xsl:if>

    <xsl:if test="@column">
      <xsl:variable name="column_name" select="@column"/>
      <xsl:if test="count($table_node/column[@name = $column_name]) = 0">
        <xsl:value-of select="concat('Error - reference/@column attribute refers to unknown column, ', $column_name, '.', $cr)"/>
      </xsl:if>
    </xsl:if>

    <xsl:for-each select="column">
      <xsl:variable name="column_name" select="@name"/>
      <xsl:if test="count($table_node/column[@name = $column_name]) = 0">
        <xsl:value-of select="concat('Error - reference/column/@name attribute refers to unknown column, ', $column_name, '.', $cr)"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:for-each> <!-- //reference tag -->

  <!-- Check //constraint/column/@name,
             //constraint/translate/@column,
             //constraint/between/@column
             //constraint/greater-than/@column
             //constraint/greater-than-or-equal/@column
             //constraint/less-than/@column
             //constraint/less-than-or-equal/@column
             //constraint/not-equal/@column
             //constraint/equal/@column
             //constraint/not-null/@column
             //constraint/member-of/@column
  -->
  <xsl:for-each select="//table">
    <xsl:variable name="table_columns" select="column"/>
    <xsl:for-each select="constraint/column | */constraint/column">
      <xsl:variable name="column_name" select="@name"/>
      <xsl:if test="count($table_columns[@name=$column_name]) = 0">
        <xsl:value-of select="concat('Error - Constraint contains reference to unknown column ,', $column_name, '.', $cr)"/>
      </xsl:if>
    </xsl:for-each>

    <xsl:for-each select="constraint/*[@column] | */constraint/*[not(name() = 'reference') and @column]">
      <xsl:variable name="column_name" select="@column"/>
      <xsl:if test="count($table_columns[@name=$column_name]) = 0">
        <xsl:value-of select="concat('Error - Constraint contains reference to unknown column, ', $column_name, '.', $cr)"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:for-each>

  <!-- 9) Alter tags with action='insert' or action='default' attribute contain
       entry tags with reference column names as attributes -->
  <xsl:for-each select="//alter[@action='insert' or @action='default']">
    <xsl:variable name="table_name" select="@table"/>
    <xsl:variable name="table_columns" select="//table[@name=$table_name]/column"/>
    <xsl:for-each select="entry">
      <xsl:for-each select="@*">
        <xsl:variable name="position" select="position()"/>
        <xsl:variable name="column_node" select="$table_columns[position() = $position]"/>
        <xsl:if test="not(name() = $column_node/@name)">
          <xsl:value-of select="concat('Error - Alter table ', $table_name, ' entry attribute ', name(), ' is either in the wrong position or is not a valid column name.', $cr)"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:for-each> <!-- alter tag with an insert/default action -->

  <!-- 10) Every reference and foreign key constraint must have a set_action
       attribute -->
  <xsl:for-each select="//constraint[(@type='reference' or @type='fk') and not(@set_action)]">
    <xsl:value-of select="concat('Error - Constraint ', @name, ' is a reference or foreign key constraint but does not have a set_action attribute.', $cr)"/>
  </xsl:for-each>

  <!-- 11) Every reference and foreign key constraint must have a cascade
       attribute -->
  <xsl:for-each select="//constraint[(@type='reference' or @type='fk') and not(@cascade)]">
    <xsl:value-of select="concat('Error - Constraint ', @name, ' is a reference or foreign key constraint but does not have a cascade attribute.', $cr)"/>
  </xsl:for-each>

  <!-- 12) Constraints that have a set_action of ignore should only appear if:
           A) its owning table has a set_type of dependent or auto-fill
           B) its reference is to a table with a set_type of baseline -->
  <xsl:for-each select="//table[not(@set_type='dependent') and not(@set_type='auto-fill')]/column/constraint[contains(@set_action,'ignore')]">
    <xsl:variable name="reference_table" select="reference/@table"/>
    <xsl:if test="count(//table[@name=$reference_table and not(@set_type='baseline')]) > 0">
      <xsl:value-of select="concat('Error - Constraint ', @name, ' has a set_action=ignore but is not part of a dependent table nor does it refer to a baseline table.', $cr)"/>
    </xsl:if>
  </xsl:for-each>

  <!-- 13) Columns that have a constraint with a set_action of nullify
       must have a null attribute of yes -->
  <xsl:for-each select="//column[@null='no']/constraint[contains(@set_action,'nullify')]">
    <xsl:value-of select="concat('Error - Constraint ', @name, ' has a set_action of nullify but its column may not be NULL.', $cr)"/>
  </xsl:for-each>

  <!-- 14) Table with a set_type="orphan" must have a set_parent attribute -->
  <xsl:for-each select="//table[@set_type='orphan' and not(@set_parent)]">
    <xsl:value-of select="concat('Error - Table ', @name, ' has a set_type=orphan but has no set_parent attribute.', $cr)"/>
  </xsl:for-each>

  <!-- 15) Only tables with a set-type="orphan" should have a set_parent
       attribute -->
  <xsl:for-each select="//table[not(@set_type='orphan') and @set_parent]">
    <xsl:value-of select="concat('Error - Table ', @name, ' has a set_parent attribute but its set_type is not orphan.', $cr)"/>
  </xsl:for-each>

  <!-- 16) Insure that reference and foreign key constraints with a
       set_action of follow do not create a circular loop -->

</xsl:template> <!-- match /JTLS-Database -->

</xsl:stylesheet>
