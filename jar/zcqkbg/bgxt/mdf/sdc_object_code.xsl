<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="2.0">

<!-- 
 ! File:        $JXSL/sdc_object_code.xsl
 ! Programmer:  Jose M. Torres
 ! Date:        13 October 2006
 ! Description: This stylesheet generates the Pro*C code, header files, and
 !              SQL create and drop scripts from the jds protocol for the
 !              Scenario Data Client (SDC).
 !
 !
 !              To run this stylesheet on the jds_protocol.xml file type:
 !              saxon jds_protocol.xml sdc_object_code.xsl jtlshome=$JTLSHOME
-->

<xsl:param name="jtlshome" select="'/home/jtlsdev'"/>

<xsl:output method="text"/>

<!-- Variable definitions. -->

<xsl:variable name="proc_dir" select="concat($jtlshome, '/src/sdc/src/generated')"/>
<xsl:variable name="sql_dir" select="concat($jtlshome, '/script/sdr')"/>
<xsl:variable name="include_dir" select="concat($jtlshome, '/include/sdr')"/>

<xsl:variable name="copyright">
<xsl:text>-- Copyright notification
--
--   Copyright 2007 by ROLANDS &amp; ASSOCIATES Corporation
--
</xsl:text>
</xsl:variable>

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

<xsl:variable name="persistent_nodes" select="/JTLS-Data-System-Protocol/protocol/simulation-data/persistent/*[name() != 'SYSTEM']"/>
<xsl:variable name="enumerated_nodes" select="/JTLS-Data-System-Protocol/enumerations/*"/>
<xsl:variable name="constant_nodes" select="/JTLS-Data-System-Protocol/constants/*[name() != 'description']"/>
<xsl:variable name="typedef_nodes" select="/JTLS-Data-System-Protocol/typedefs/*[name() != 'description']"/>

<!-- Nodes for expansion of structure and JEDI attributes. We add the JEDI as
     a structure since it results in two columns -->
<xsl:variable name="override_structure">
  <structures>
    <JEDI>
      <index type="UINT_32"/>
      <type  type="STRING" db-column-width="MAX_DATA_TYPE_LENGTH"/>
    </JEDI>
  </structures>
</xsl:variable>
<xsl:variable name="standard_structures" select="/JTLS-Data-System-Protocol/structures/*[name() != 'description' and name() != 'TIME']"/>
<xsl:variable name="structure_nodes" select="$standard_structures | $override_structure/structures/*"/>

<!--
!! TEMPLATE:     match /JTLS-Data-System-Protocol
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 13 October 2006
!! DESCRIPTION:  This template accesses each SDC object and creates and opens,
!!               a file with the object's name, to write the code to it.
-->
<xsl:template match="/JTLS-Data-System-Protocol">

  <!-- Every persistent object gets a header and PRO*C source file for
       JODA object to SDC table management -->       
  <xsl:for-each select="$persistent_nodes">
    <xsl:variable name="table_name" select="name()"/>

    <xsl:variable name="local_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="filename_h" select="concat($proc_dir, '/', $local_name, '.h')"/>
    <xsl:result-document method="text" href="{$filename_h}">
      <xsl:call-template name="gen-header-files">
        <xsl:with-param name="location" select="$filename_h"/>
      </xsl:call-template>
    </xsl:result-document>

    <xsl:variable name="filename_pc" select="concat($proc_dir, '/', $local_name, '.pc')"/>
    <xsl:result-document method="text" href="{$filename_pc}">
      <xsl:call-template name="gen-pro-c-files">
        <xsl:with-param name="location" select="$filename_pc"/>
        <xsl:with-param name="local_name" select="$local_name"/>
      </xsl:call-template>
    </xsl:result-document>
  </xsl:for-each> <!-- persistent object -->

  <!-- Create the source code that acts as the top-level interface between
       JODA objects and SDC table management -->
  <xsl:variable name="filename_c" select="concat($proc_dir, '/object.pc')"/>
  <xsl:result-document method="text" href="{$filename_c}">
    <xsl:call-template name="gen-object-source-file">
    </xsl:call-template>
  </xsl:result-document>

  <xsl:variable name="filename_h" select="concat($proc_dir, '/object.h')"/>
  <xsl:result-document method="text" href="{$filename_h}">
    <xsl:call-template name="gen-object-header-file">
    </xsl:call-template>
  </xsl:result-document>

  <!-- the source code makefiles use a SRCFILES variable to identify the
       actual files to make. Create a file with the variable defined for
       each of the generated PRO*C source files -->
  <xsl:variable name="Makefile_srcfiles" select="concat($proc_dir, '/Makefile.srcfiles')"/>
  <xsl:result-document method="text" href="{$Makefile_srcfiles}">
    <xsl:call-template name="gen-makefile-srcfiles-file">
    </xsl:call-template>
  </xsl:result-document>

  <!-- create the SQL*Plus file that creates the database objects -->
  <xsl:variable name="create_sql" select="concat($sql_dir, '/sdc_tables_create.sql')"/>
  <xsl:result-document method="text" href="{$create_sql}">
    <xsl:call-template name="gen-sql-create-file">
    </xsl:call-template>
  </xsl:result-document>

  <!-- create the SQL*Plus file that destroys the database objects -->
  <xsl:variable name="drop_sql" select="concat($sql_dir, '/sdc_tables_drop.sql')"/>
  <xsl:result-document method="text" href="{$drop_sql}">
    <xsl:call-template name="gen-sql-drop-file">
    </xsl:call-template>
  </xsl:result-document>

  <!-- create a header file that defines objects that mimic the Oracle tables.
       This is for use by clients that want to interface with the tables -->
  <xsl:variable name="global_header" select="concat($include_dir, '/sdc.h')"/>
  <xsl:result-document method="text" href="{$global_header}">
    <xsl:call-template name="gen-global-header-file">
    </xsl:call-template>
  </xsl:result-document>

</xsl:template> <!-- match /JTLS-Data-System-Protocol -->


<!--
!! TEMPLATE:     gen-header-files
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 13 October 2006
!! DESCRIPTION:  This template writes the code for the header files from
!!               the persistent objects and their attributes found in the
!!               jds protocol.
-->
<xsl:template name="gen-header-files">
  <xsl:param name="location"/>

  <xsl:variable name="table_name" select="name()"/>

  <xsl:variable name="global_name">
    <xsl:call-template name="get-global-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:call-template name="file-header-block">
    <xsl:with-param name="location" select="$location"/>
    <xsl:with-param name="object" select="$table_name"/>
  </xsl:call-template>

  <!-- Create a wrapper object that will hold the data for the primary table
       and will hold independantly the array attributes -->
  <xsl:variable name="wrapper_name" select="concat($table_name, '_OBJECT')"/>
  <xsl:variable name="lower_wrapper_name">
    <xsl:call-template name="to-lower">
      <xsl:with-param name="base_name" select="$wrapper_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:value-of select="concat('typedef struct ', $lower_wrapper_name, ' {', $cr)"/>
  <xsl:value-of select="concat('   SDC_', $table_name, '_TABLE object;', $cr)"/>
  <xsl:for-each select="*/*[@array = 'variable']">

    <xsl:variable name="base_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="count_name">
      <xsl:call-template name="get-compound-name">
        <xsl:with-param name="base_name" select="$base_name"/>
        <xsl:with-param name="child_name" select="'_count'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="attribute_node">
      <xsl:call-template name="attribute-node-to-node-set"/>
    </xsl:variable>

    <xsl:value-of select="concat('   int ', $count_name, ';', $cr)"/>
    <xsl:for-each select="$attribute_node/*">

      <xsl:variable name="c_type" >
        <xsl:call-template name="jdsp-node-to-c-type"/>
      </xsl:variable>
      <xsl:variable name="compound_name">
        <xsl:call-template name="get-compound-name">
          <xsl:with-param name="base_name" select="$base_name"/>
          <xsl:with-param name="child_name" select="name()"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="c_length">
        <xsl:variable name="column_width">
          <xsl:call-template name="find-db-column-width"/>
        </xsl:variable>
        <xsl:if test="string-length($column_width) != 0">
          <xsl:value-of select="'*'"/>
        </xsl:if>
      </xsl:variable>

      <xsl:value-of select="concat('   ', $c_type, ' *', $c_length, $compound_name, ';', $cr)"/>
    </xsl:for-each>

  </xsl:for-each>
  <xsl:value-of select="concat('} ', $wrapper_name, ';', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Call the template to write the function prototypes that are defined in
       the Pro*C code. -->
  <xsl:call-template name="write-function-prototypes">
    <xsl:with-param name="table_name" select="$table_name"/>
    <xsl:with-param name="global_name" select="$global_name"/>
  </xsl:call-template>

</xsl:template> <!-- gen-header-files  -->


<!--
!! TEMPLATE:     file-header-block
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 16 October 2006
!! DESCRIPTION:  This template writes out the comment header block for
!!               each header file generated.
-->
<xsl:template name="file-header-block">
  <xsl:param name="location"/>
  <xsl:param name="object"/>

  <xsl:variable name="lower_object">
    <xsl:call-template name="get-object-name">
      <xsl:with-param name="base_name" select="$object"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:value-of select="concat('#ifndef __', $object, '_INC', $cr)"/>
  <xsl:value-of select="concat('#define __', $object, '_INC', $cr)"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        ', $location, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This is an automatically generated PRO*C header file for the', $cr)"/>
  <xsl:value-of select="concat(' *              ', $object, ' source code. Do not change this file manually,', $cr)"/>
  <xsl:value-of select="concat(' *              the contents will be overwritten the next time the JDS Protocol', $cr)"/>
  <xsl:value-of select="concat(' *              is modified.', $cr)"/>
  <xsl:value-of select="concat(' *---------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsobj_', $lower_object, '.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;sdr/sdc.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;object.h&quot;', $cr)"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- file-header-block  -->


<!--
!! TEMPLATE:     write-function-prototypes
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 16 October 2006
!! DESCRIPTION:  This template takes the object's table_name and global_name
!!               and writes the function prototypes to the header file.
-->
<xsl:template name="write-function-prototypes">
  <xsl:param name="table_name"/>
  <xsl:param name="global_name"/>

  <xsl:value-of select="concat('#ifdef __', $table_name, '_SOURCE__', $cr)"/>
  <xsl:value-of select="concat('#define __', $table_name, '_TYPE', $cr)"/>
  <xsl:value-of select="concat('#else', $cr)"/>
  <xsl:value-of select="concat('#define __', $table_name, '_TYPE extern', $cr)"/>
  <xsl:value-of select="concat('#endif', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('__', $table_name, '_TYPE void ', $global_name, 'ProcessUpdate( BIT_FIELD_128, PERSISTENT_CONTAINER, OBJECT_ANY * );', $cr)"/>
  <xsl:value-of select="concat('__', $table_name, '_TYPE int  ', $global_name, 'InsertAll( void );', $cr)"/>
  <xsl:value-of select="concat('__', $table_name, '_TYPE int  ', $global_name, 'ObjectInsert( OBJECT_ANY * );', $cr)"/>
  <xsl:value-of select="concat('__', $table_name, '_TYPE int  ', $global_name, 'ObjectRemove( OBJECT_ANY * );', $cr)"/>
  <xsl:value-of select="concat('__', $table_name, '_TYPE int  ', $global_name, 'DynamicUpdate( int, OBJECT_ANY *, BIT_FIELD_128 );', $cr)"/>
  <xsl:value-of select="concat('__', $table_name, '_TYPE int  ', $global_name, 'StandardUpdate( int, OBJECT_ANY *, BIT_FIELD_128 );', $cr)"/>
  <xsl:value-of select="concat('__', $table_name, '_TYPE int  ', $global_name, 'SingleUpdate( int, OBJECT_ANY *, BIT_FIELD_128 );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('#endif /* __', $table_name, '_INC */', $cr)"/>
</xsl:template> <!-- write-function-prototypes  -->


<!--
!! TEMPLATE:     gen-pro-c-files
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 17 October 2006
!! DESCRIPTION:  This template writes the Pro*C code from the objects
!!               and their attributes found in the jds protocol.
-->
<xsl:template name="gen-pro-c-files">
  <xsl:param name="location"/>
  <xsl:param name="local_name"/>

  <xsl:variable name="table_name" select="name()"/>

  <xsl:variable name="global_name">
    <xsl:call-template name="get-global-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="object_name">
    <xsl:call-template name="get-object-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:call-template name="pro-c-header-block">
    <xsl:with-param name="location" select="$location"/>
    <xsl:with-param name="object" select="$table_name"/>
  </xsl:call-template>

  <xsl:value-of select="concat('#include &quot;', $local_name, '.h&quot;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('EXEC SQL INCLUDE SQLCA;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:for-each select="*/*[@array = 'variable']">
    <xsl:variable name="subname">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('static void ', $local_name, $subname, 'Insert( ', $table_name, '_OBJECT * );', $cr)"/>
    <xsl:value-of select="concat('static void ', $local_name, $subname, 'Delete( ', $table_name, '_OBJECT * );', $cr)"/>
    <xsl:value-of select="concat('static void ', $local_name, $subname, 'ErrorRecord( ', $table_name, '_OBJECT *, int );', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="concat('static void ', $local_name, 'ErrorRecord( ', $table_name, '_OBJECT * );', $cr)"/>
  <xsl:value-of select="concat('static void ', $local_name, 'ErrorItem( ', $table_name, '_OBJECT *, int, int );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

  <!-- Template calls for each function to be written. -->
  <xsl:call-template name="function-process-update">
    <xsl:with-param name="table_name" select="$table_name"/>
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
  </xsl:call-template>

  <xsl:call-template name="function-insert-all">
    <xsl:with-param name="table_name" select="$table_name"/>
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="object_name" select="$object_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
  </xsl:call-template>

  <xsl:call-template name="function-object-insert">
    <xsl:with-param name="table_name" select="$table_name"/>
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="object_name" select="$object_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
  </xsl:call-template>

  <xsl:call-template name="function-object-remove">
    <xsl:with-param name="table_name" select="$table_name"/>
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="object_name" select="$object_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
  </xsl:call-template>

  <xsl:call-template name="function-dynamic-update">
    <xsl:with-param name="table_name" select="$table_name"/>
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="object_name" select="$object_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
  </xsl:call-template>

  <xsl:call-template name="function-standard-update">
    <xsl:with-param name="table_name" select="$table_name"/>
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="object_name" select="$object_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
  </xsl:call-template>

  <xsl:call-template name="function-single-update">
    <xsl:with-param name="table_name" select="$table_name"/>
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="object_name" select="$object_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
  </xsl:call-template>

  <xsl:call-template name="function-object-arrays-insert">
    <xsl:with-param name="table_name" select="$table_name"/>
  </xsl:call-template>

  <xsl:call-template name="function-object-arrays-delete">
    <xsl:with-param name="table_name" select="$table_name"/>
  </xsl:call-template>

  <xsl:call-template name="function-object-arrays-error">
    <xsl:with-param name="table_name" select="$table_name"/>
  </xsl:call-template>

  <xsl:call-template name="function-error-record">
    <xsl:with-param name="table_name" select="$table_name"/>
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="object_name" select="$object_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
  </xsl:call-template>

  <xsl:call-template name="function-error-item">
    <xsl:with-param name="table_name" select="$table_name"/>
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="object_name" select="$object_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
  </xsl:call-template>

</xsl:template> <!-- gen-pro-c-files  -->


<!--
!! TEMPLATE:     pro-c-header-block
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 17 October 2006
!! DESCRIPTION:  This template writes out the comment header block for
!!               each Pro*C file generated.
-->
<xsl:template name="pro-c-header-block">
  <xsl:param name="location"/>
  <xsl:param name="object"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        ', $location, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This is an automatically generated PRO*C source file that', $cr)"/>
  <xsl:value-of select="concat(' *              interacts with the ', $object, ' table. Do not change this', $cr)"/>
  <xsl:value-of select="concat(' *              file manually, the contents will be overwritten the next time', $cr)"/>
  <xsl:value-of select="concat(' *              the JDS Protocol is modified.', $cr)"/>
  <xsl:value-of select="concat(' *---------------------------------------------------------------------------*/', $cr)"/>

  <xsl:value-of select="concat('#define __', $object, '_SOURCE__', $cr)"/>
  <xsl:value-of select="concat('#include &lt;stdlib.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &lt;string.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_logger.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_net.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_array.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jtls/simtime.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;sdc.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;hash.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;object.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;vocab.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;queue.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;database.h&quot;', $cr)"/>
</xsl:template> <!-- pro-c-header-block  -->


<!--
!! TEMPLATE:     function-process-update
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 17 October 2006
!! DESCRIPTION:  This template writes out the Pro*C code for the
!!               function ProcessUpdate of each object.
-->
<xsl:template name="function-process-update">
  <xsl:param name="table_name"/>
  <xsl:param name="global_name"/>
  <xsl:param name="local_name"/>

  <xsl:variable name="local_ptr" select="concat($local_name, 'Ptr')"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $global_name, 'ProcessUpdate', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function processes an update from the JDS and updates', $cr)"/>
  <xsl:value-of select="concat(' *               the corresponding ', $table_name, '_OBJECT structure.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>

  <xsl:value-of select="concat('void ', $global_name, 'ProcessUpdate( BIT_FIELD_128 maskField, PERSISTENT_CONTAINER object, OBJECT_ANY *', $local_name, ' ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   ', $table_name, '_CONTAINER objPtr = (', $table_name, '_CONTAINER) object;', $cr)"/>
  <xsl:value-of select="concat('   ', $table_name, '_OBJECT *', $local_ptr, ' = (', $table_name, '_OBJECT *) ', $local_name, ';', $cr)"/>
  <xsl:value-of select="concat('   int index;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   simtime_db_snprintf( ', $local_ptr, '->object.time, SDC_MAX_DB_TEXT_TIME_LENGTH + 1, SdcGameTime );', $cr)"/>
  <xsl:value-of select="concat('   for ( index = 0; index &lt; NUMBER_OF_', $table_name, '_FIELDS+1; index++ ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      if ( ! BITF_ISON( maskField, index ) ) {', $cr)"/>
  <xsl:value-of select="concat('         continue;', $cr)"/>
  <xsl:value-of select="concat('      }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      switch ( index ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('         char *dataStr;', $cr)"/>
  <xsl:value-of select="concat('         int type;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:for-each select="*/*[not(@array = 'variable' or name() = 'comment' or name() = 'computed')]">
    <xsl:variable name="common_name" select="name()"/>
    <xsl:variable name="com_attr_type" select="@type"/>

    <xsl:variable name="common_upper_name">
      <xsl:call-template name="to-upper">
        <xsl:with-param name="base_name" select="$common_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="commonname">
      <xsl:call-template name="remove-underscores">
        <xsl:with-param name="base_name" select="$common_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="vocab_name">
      <xsl:call-template name="find-vocabulary-name"/>
    </xsl:variable>

    <xsl:variable name="com_glo_name">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="$common_upper_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="max_len">
      <xsl:call-template name="find-db-column-width"/>
    </xsl:variable>

    <xsl:variable name="jedi_max_len">
      <xsl:call-template name="find-jedi-db-column-width"/>
    </xsl:variable>

    <xsl:value-of select="concat('         case ', $table_name, '_FIELD_', $common_upper_name, ': {', $cr)"/>

    <xsl:choose>
      <xsl:when test="$com_attr_type = 'JEDI'">
        <xsl:value-of select="concat('            ', $local_ptr, '-&gt;object.', $commonname, 'Index = JEDI_GET_INDEX( objPtr-&gt;object_ptr-&gt;')"/>
        <xsl:value-of select="concat($common_name, ' );', $cr)"/>
        <xsl:value-of select="concat('            type = JEDI_GET_OBJECT_CLASS( objPtr-&gt;object_ptr-&gt;', $common_name, ' );', $cr)"/>
        <xsl:value-of select="concat('            dataStr = ObjectTypeInfo[type].name;', $cr)"/>
        <xsl:value-of select="concat('            strncpy( ', $local_ptr, '-&gt;object.', $commonname, 'Type, dataStr, SDC_', $jedi_max_len, ' );', $cr)"/>
        <xsl:value-of select="concat('            ', $local_ptr, '-&gt;object.', $commonname, 'Type[SDC_', $jedi_max_len, '] = ', $apos, '\0', $apos, ';', $cr)"/>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'STRING' or $com_attr_type = 'SHARED_STRING'">
        <xsl:value-of select="concat('            strncpy( ', $local_ptr, '-&gt;object.', $commonname, ', objPtr-&gt;object_ptr-&gt;', $common_name)"/>
        <xsl:value-of select="concat(', SDC_', $max_len, ' );', $cr)"/>
        <xsl:value-of select="concat('            ', $local_ptr, '-&gt;object.', $commonname, '[SDC_', $max_len, '] = ', $apos, '\0', $apos, ';', $cr)"/>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'LOCATION'">
        <xsl:value-of select="concat('            ', $local_ptr, '-&gt;object.', $commonname, 'Lat = objPtr-&gt;object_ptr-&gt;')"/>
        <xsl:value-of select="concat($common_name, '.lat;', $cr)"/>
        <xsl:value-of select="concat('            ', $local_ptr, '-&gt;object.', $commonname, 'Lon = objPtr-&gt;object_ptr-&gt;')"/>
        <xsl:value-of select="concat($common_name, '.lon;', $cr)"/>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'TIME'">
        <xsl:value-of select="concat('            simtime_db_snprintf( ', $local_ptr, '-&gt;object.', $commonname, ', SDC_MAX_DB_TEXT_TIME_LENGTH + 1, objPtr-&gt;object_ptr-&gt;', $common_name, '.time );', $cr)"/>
      </xsl:when>

      <xsl:when test="string-length($vocab_name) = 0">
        <xsl:value-of select="concat('            ', $local_ptr, '-&gt;object.', $commonname, ' = objPtr-&gt;object_ptr-&gt;', $common_name, ';', $cr)"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="concat('            static VOCAB_GROUP vocabGroup = NULL;', $cr)"/>
        <xsl:value-of select="concat('            if ( vocabGroup == NULL ) {', $cr)"/>
        <xsl:value-of select="concat('               vocabGroup = VocabGetGroup( &quot;', $vocab_name, '&quot; );', $cr)"/>
        <xsl:value-of select="concat('            }', $cr)"/>
        <xsl:value-of select="concat('            VocabAssignItemNameFromGroup(', $cr)"/>
        <xsl:value-of select="concat('               ', $local_ptr, '-&gt;object.', $commonname)"/>
        <xsl:value-of select="concat(', SDC_', $max_len, ',', $cr)"/>
        <xsl:value-of select="concat('               vocabGroup, objPtr-&gt;object_ptr-&gt;', $common_name, ' );', $cr)"/>
      </xsl:otherwise>

    </xsl:choose>

    <xsl:value-of select="concat('            break;', $cr)"/>
    <xsl:value-of select="concat('         }', $cr)"/>
    <xsl:value-of select="$cr"/>

  </xsl:for-each>

  <!-- process the array attributes -->
  <xsl:for-each select="*/*[@array = 'variable']">
    <xsl:variable name="attr_name" select="name()"/>

    <xsl:variable name="attr_local">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="$attr_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="field_name">
      <xsl:call-template name="to-upper">
        <xsl:with-param name="base_name" select="concat($table_name, '_FIELD_', $attr_name)"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="acronym">
      <xsl:call-template name="get-acronym-name">
        <xsl:with-param name="base_name" select="$attr_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="count_name">
      <xsl:call-template name="get-compound-name">
        <xsl:with-param name="base_name" select="$attr_local"/>
        <xsl:with-param name="child_name" select="'_count'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="attribute_node">
      <xsl:call-template name="attribute-node-to-node-set"/>
    </xsl:variable>

    <xsl:value-of select="concat('         case ', $field_name, ': {', $cr)"/>

    <!-- Each character array will need a vocab translation -->
    <xsl:for-each select="$attribute_node/*">
      <xsl:variable name="compound_name">
        <xsl:call-template name="get-compound-name">
          <xsl:with-param name="base_name" select="$attr_local"/>
          <xsl:with-param name="child_name" select="name()"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="c_type" >
        <xsl:call-template name="jdsp-node-to-c-type"/>
      </xsl:variable>
      <xsl:if test="$c_type = 'char'">
        <xsl:variable name="group_name" select="concat($compound_name, 'Group')"/>
        <xsl:value-of select="concat('            static VOCAB_GROUP ', $group_name, ' = NULL;', $cr)"/>
      </xsl:if>
    </xsl:for-each>

    <xsl:value-of select="concat('            int nbrPoints = ', $local_ptr, '->', $count_name, ';', $cr)"/>
    <xsl:value-of select="concat('            int index = 0;', $cr)"/>

    <!-- initialize the vocab groups for character attributes -->
    <xsl:for-each select="$attribute_node/*">
      <xsl:variable name="compound_name">
        <xsl:call-template name="get-compound-name">
          <xsl:with-param name="base_name" select="$attr_local"/>
          <xsl:with-param name="child_name" select="name()"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="c_type" >
        <xsl:call-template name="jdsp-node-to-c-type"/>
      </xsl:variable>
      <xsl:if test="$c_type = 'char'">
        <xsl:variable name="group_name" select="concat($compound_name, 'Group')"/>
        <xsl:variable name="vocab_name" >
          <xsl:call-template name="find-vocabulary-name"/>
        </xsl:variable>
        <xsl:value-of select="concat('            if ( ', $group_name, ' == NULL ) {', $cr)"/>
        <xsl:value-of select="concat('               ', $group_name, ' = VocabGetGroup( &quot;', $vocab_name, '&quot; );', $cr)"/>
        <xsl:value-of select="concat('            }', $cr)"/>
      </xsl:if>
    </xsl:for-each>

    <!-- if arrays have been reserved free them -->
    <xsl:for-each select="$attribute_node/*">
      <xsl:variable name="compound_name">
        <xsl:call-template name="get-compound-name">
          <xsl:with-param name="base_name" select="$attr_local"/>
          <xsl:with-param name="child_name" select="name()"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="c_type" >
        <xsl:call-template name="jdsp-node-to-c-type"/>
      </xsl:variable>

      <xsl:value-of select="concat('            if ( ', $local_ptr, '->', $compound_name, ' ) {', $cr)"/>
      <xsl:if test="$c_type = 'char'">
        <xsl:value-of select="concat('               for ( index = 0; index &lt; nbrPoints; index++ ) {', $cr)"/>
        <xsl:value-of select="concat('                  free( ', $local_ptr, '->', $compound_name, '[index] );', $cr)"/>
        <xsl:value-of select="concat('               }', $cr)"/>
      </xsl:if>
      <xsl:value-of select="concat('               free( ', $local_ptr, '->', $compound_name, ' );', $cr)"/>
      <xsl:value-of select="concat('            }', $cr)"/>
    </xsl:for-each>

    <!-- reserve new arrays of the proper size -->
    <xsl:value-of select="concat('            nbrPoints = array_get_length( objPtr->object_ptr->', $attr_name, ' );', $cr)"/>
    <xsl:value-of select="concat('            ', $local_ptr, '->', $count_name, ' = nbrPoints;', $cr)"/>
    <xsl:for-each select="$attribute_node/*">

      <xsl:variable name="compound_name">
        <xsl:call-template name="get-compound-name">
          <xsl:with-param name="base_name" select="$attr_local"/>
          <xsl:with-param name="child_name" select="name()"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="c_type" >
        <xsl:call-template name="jdsp-node-to-c-type"/>
      </xsl:variable>
      <xsl:variable name="c_extension" >
        <xsl:if test="$c_type = 'char'">
          <xsl:value-of select="'*'"/>
        </xsl:if>
      </xsl:variable>

      <xsl:value-of select="concat('            ', $local_ptr, '->', $compound_name, ' = (', $c_type, ' ', $c_extension, '*) calloc( nbrPoints, sizeof( ', $c_type, $c_extension, ' ) );', $cr)"/>
    </xsl:for-each>

    <!-- move the values off the JODA object into the local structure -->
    <xsl:value-of select="concat('            for ( index = 0; index &lt; nbrPoints; index++ ) {', $cr)"/>
    <xsl:for-each select="$attribute_node/*">

      <xsl:variable name="compound_name">
        <xsl:call-template name="get-compound-name">
          <xsl:with-param name="base_name" select="$attr_local"/>
          <xsl:with-param name="child_name" select="name()"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="compound_extension">
        <xsl:call-template name="get-compound-extension">
          <xsl:with-param name="base_name" select="$attr_name"/>
          <xsl:with-param name="child_name" select="name()"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="c_type" >
        <xsl:call-template name="jdsp-node-to-c-type"/>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="$c_type = 'char'">
          <xsl:variable name="column_width" >
            <xsl:call-template name="find-db-column-width"/>
          </xsl:variable>
          <xsl:variable name="group_name" select="concat($compound_name, 'Group')"/>
          <xsl:value-of select="concat('               ', $local_ptr, '->', $compound_name, '[index] = (char *) calloc( SDC_', $column_width, ' + 1, sizeof( char ) );', $cr)"/>
          <xsl:value-of select="concat('               VocabAssignItemNameFromGroup(', $cr)"/>
          <xsl:value-of select="concat('                  ', $local_ptr, '->', $compound_name, '[index], SDC_', $column_width, ',', $cr)"/>
          <xsl:value-of select="concat('                  ', $group_name, ', objPtr->object_ptr->', $attr_name, '[index] );', $cr)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('               ', $local_ptr, '->', $compound_name, '[index] = objPtr->object_ptr->', $attr_name, '[index]', $compound_extension, ';', $cr)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    <xsl:value-of select="concat('            }', $cr)"/>
    <xsl:value-of select="concat('            break;', $cr)"/>
    <xsl:value-of select="concat('         }', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each> <!-- array attribute -->

  <xsl:value-of select="concat('         default: {', $cr)"/>
  <xsl:value-of select="concat('            break;', $cr)"/>
  <xsl:value-of select="concat('         }', $cr)"/>
  <xsl:value-of select="concat('      } /* end switch on the mask index */', $cr)"/>
  <xsl:value-of select="concat('   } /* end for each mask index */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $global_name, 'ProcessUpdate */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- function-process-update -->


<!--
!! TEMPLATE:     function-insert-all
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 6 November 2006
!! DESCRIPTION:  This template writes out the Pro*C code for the
!!               function InsertAll of each object.
-->
<xsl:template name="function-insert-all">
  <xsl:param name="table_name"/>
  <xsl:param name="global_name"/>
  <xsl:param name="object_name"/>
  <xsl:param name="local_name"/>

  <xsl:variable name="func_name" select="concat($global_name, 'InsertAll')"/>
  <xsl:variable name="table_type" select="concat('SDC_', $table_name, '_TABLE')"/>
  <xsl:variable name="object_type" select="concat($table_name, '_OBJECT')"/>
  <xsl:variable name="array_of" select="concat('arrayOf', $global_name)"/>
  <xsl:variable name="object_array" select="concat($local_name, 'Array')"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $func_name, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function retrieves all the ', $object_type, ' structures', $cr)"/>
  <xsl:value-of select="concat(' *               from the internal memory, and inserts them into the', $cr)"/>
  <xsl:value-of select="concat(' *               sdc_', $object_name, ' table in groups. This is done for performance,', $cr)"/>
  <xsl:value-of select="concat(' *               since the group insert is suppossed to be more efficient.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('int ', $func_name, '( void ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL BEGIN DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="concat('   ', $table_type, ' ', $object_array, '[OBJECT_GROUP_SIZE];', $cr)"/>
  <xsl:value-of select="concat('   int count;', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL END DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="concat('   OBJECT_ANY **', $array_of, ';', $cr)"/>
  <xsl:value-of select="concat('   int totalCount;', $cr)"/>
  <xsl:value-of select="concat('   int index;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   /* Get the objects from the database, along with the number of objects */', $cr)"/>
  <xsl:value-of select="concat('   totalCount = HashRetrieveAll( OBJECT_CLASS_', $table_name, ',  &amp;', $array_of, ' );', $cr)"/>
  <xsl:value-of select="concat('   for ( index = 0; index &lt; totalCount; ) {', $cr)"/>
  <xsl:value-of select="concat('      /* Load the array with up to the maximum number of objects */', $cr)"/>
  <xsl:value-of select="concat('      for ( count = 0; count &lt; OBJECT_GROUP_SIZE &amp;&amp; index &lt; totalCount; count++ ) {', $cr)"/>
  <xsl:value-of select="concat('          memcpy( &amp;', $object_array, '[count], ', $array_of, '[index], sizeof( ', $table_type, ' ) );', $cr)"/>
  <xsl:value-of select="concat('          index++;', $cr)"/>
  <xsl:value-of select="concat('       }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Create the group insert statement with a list of column names that are
       being inserted -->
  <xsl:value-of select="concat('      /* Perform the group insert */', $cr)"/>
  <xsl:value-of select="concat('      EXEC SQL FOR :count INSERT INTO sdc_', $object_name, $cr)"/>
  <xsl:value-of select="'         (time, side_view, '"/>
  <xsl:for-each select="*/*[not(@array = 'variable' or name() = 'comment' or name() = 'computed')]">

    <xsl:variable name="attribute" select="name()"/>
    <xsl:variable name="sub_nodes">
      <xsl:call-template name="attribute-node-to-node-set"/>
    </xsl:variable>

    <xsl:for-each select="$sub_nodes/*">

      <xsl:variable name="struct_name">
        <xsl:call-template name="get-compound-sql-name">
          <xsl:with-param name="base_name" select="$attribute"/>
          <xsl:with-param name="child_name" select="name()"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:value-of select="$struct_name"/>
      <xsl:if test="position() != last()">
        <xsl:value-of select="', '"/>
      </xsl:if>
    </xsl:for-each> <!-- sub node of the attribute -->
    <xsl:if test="position() != last()">
      <xsl:value-of select="', '"/>
    </xsl:if>
  </xsl:for-each> <!-- non-array attribute -->
  <xsl:value-of select="concat(')', $cr)"/>
  <xsl:value-of select="concat('         VALUES ( :', $object_array, ' );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      if ( sqlca.sqlcode &lt; 0 ) {', $cr)"/>
  <xsl:value-of select="concat('         int problemIndex = index - (count - sqlca.sqlerrd[2]) - 1;', $cr)"/>
  <xsl:value-of select="concat('         logger_error_msg( &quot;Unable to group insert %d ', $table_name, ' records\n&quot;, count );', $cr)"/>
  <xsl:value-of select="concat('         DatabaseSqlError( );', $cr)"/>
  <xsl:value-of select="concat('         ', $local_name, 'ErrorRecord( (',  $object_type, ' *) ', $array_of, '[problemIndex] );', $cr)"/>
  <xsl:value-of select="concat('      }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      ObjectInsertsProcessed += count;', $cr)"/>
  <xsl:value-of select="concat('   } /* end of loop until we', $apos, 've inserted all objects */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- call the function to insert attribute array sub-tables -->
  <xsl:for-each select="*/*[@array = 'variable']">
    <xsl:variable name="subname">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('   for ( index = 0; index &lt; totalCount; index++ ) {', $cr)"/>
    <xsl:value-of select="concat('      ', $local_name, $subname, 'Insert( (',  $object_type, ' *) ', $array_of, '[index] );', $cr)"/>
    <xsl:value-of select="concat('   }', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each>

  <xsl:value-of select="concat('   free( ', $array_of, ' );', $cr)"/>
  <xsl:value-of select="concat('   return( 1 );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $func_name, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- function-insert-all -->


<!--
!! TEMPLATE:     function-object-insert
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 7 November 2006
!! DESCRIPTION:  This template writes out the Pro*C code for the
!!               function ObjectInsert of each object.
-->
<xsl:template name="function-object-insert">
  <xsl:param name="table_name"/>
  <xsl:param name="global_name"/>
  <xsl:param name="object_name"/>
  <xsl:param name="local_name"/>

  <xsl:variable name="func_name" select="concat($global_name, 'ObjectInsert')"/>
  <xsl:variable name="table_type" select="concat('SDC_', $table_name, '_TABLE')"/>
  <xsl:variable name="object_type" select="concat($table_name, '_OBJECT')"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $func_name, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function inserts the given ', $local_name, ' structure into the', $cr)"/>
  <xsl:value-of select="concat(' *               sdc_', $object_name, ' table. A successful insertion returns a 1.', $cr)"/>
  <xsl:value-of select="concat(' *               Failure returns a 0. We do not commit the insertion within', $cr)"/>
  <xsl:value-of select="concat(' *               this function; that is done externally.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('int ', $func_name, '( OBJECT_ANY *', $local_name, ' )', $cr)"/>
  <xsl:value-of select="concat('   {', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL BEGIN DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="concat('   ', $table_type, ' *', $local_name, 'Ptr = (', $table_type, ' *) ', $local_name, ';', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL END DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL INSERT INTO sdc_', $object_name, $cr)"/>
  <xsl:value-of select="'      (time, side_view, '"/>
  <xsl:for-each select="*/*[not(@array = 'variable' or name() = 'comment' or name() = 'computed')]">

    <xsl:variable name="attribute" select="name()"/>
    <xsl:variable name="sub_nodes">
      <xsl:call-template name="attribute-node-to-node-set"/>
    </xsl:variable>

    <xsl:for-each select="$sub_nodes/*">

      <xsl:variable name="struct_name">
        <xsl:call-template name="get-compound-sql-name">
          <xsl:with-param name="base_name" select="$attribute"/>
          <xsl:with-param name="child_name" select="name()"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:value-of select="$struct_name"/>
      <xsl:if test="position() != last()">
        <xsl:value-of select="', '"/>
      </xsl:if>
    </xsl:for-each> <!-- sub node of the attribute -->
    <xsl:if test="position() != last()">
      <xsl:value-of select="', '"/>
    </xsl:if>
  </xsl:for-each> <!-- non-array attribute -->
  <xsl:value-of select="concat(')', $cr)"/>
  <xsl:value-of select="concat('      VALUES (:', $local_name, 'Ptr);', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   if ( sqlca.sqlcode &lt; 0 ) {', $cr)"/>
  <xsl:value-of select="concat('      logger_error_msg( &quot;Unable to insert ', $table_name, ' record\n&quot; );', $cr)"/>
  <xsl:value-of select="concat('      DatabaseSqlError( );', $cr)"/>
  <xsl:value-of select="concat('      ', $local_name, 'ErrorRecord( (', $object_type, ' *) ', $local_name, ' );', $cr)"/>
  <xsl:value-of select="concat('      return( 0 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- call the function to insert attribute array sub-tables -->
  <xsl:for-each select="*/*[@array = 'variable']">
    <xsl:variable name="subname">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('   ', $local_name, $subname, 'Insert( (',  $object_type, ' *) ', $local_name, ' );', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each>

  <xsl:value-of select="concat('   ObjectInsertsProcessed++;', $cr)"/>
  <xsl:value-of select="concat('   return( 1 );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $func_name, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- function-object-insert -->


<!--
!! TEMPLATE:     function-object-remove
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 7 November 2006
!! DESCRIPTION:  This template writes out the Pro*C code for the
!!               function ObjectRemove of each object.
-->
<xsl:template name="function-object-remove">
  <xsl:param name="table_name"/>
  <xsl:param name="global_name"/>
  <xsl:param name="object_name"/>
  <xsl:param name="local_name"/>

  <xsl:variable name="func_name" select="concat($global_name, 'ObjectRemove')"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $func_name, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function removes the given ', $local_name, ' structure from', $cr)"/>
  <xsl:value-of select="concat(' *               the sdc_', $object_name, ' table. A successful removal returns a 1.', $cr)"/>
  <xsl:value-of select="concat(' *               Failure returns a 0. We do not commit the update within', $cr)"/>
  <xsl:value-of select="concat(' *               this function; that is done externally.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('int ', $func_name, '( OBJECT_ANY *', $local_name, ' ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL BEGIN DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="concat('   ', $table_name, '_OBJECT *', $local_name, 'Ptr = (', $table_name, '_OBJECT *) ', $local_name, ';', $cr)"/>
  <xsl:value-of select="concat('   int sideNbr = ', $local_name, 'Ptr-&gt;object.sideView;', $cr)"/>
  <xsl:value-of select="concat('   int idNbr = ', $local_name, 'Ptr-&gt;object.idIndex;', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL END DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL DELETE FROM sdc_', $object_name, $cr)"/>
  <xsl:value-of select="concat('      WHERE side_view = :sideNbr AND id_index = :idNbr;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   if ( sqlca.sqlcode &lt; 0 ) {', $cr)"/>
  <xsl:value-of select="concat('      logger_error_msg( &quot;Unable to remove ', $table_name, ' record\n&quot; );', $cr)"/>
  <xsl:value-of select="concat('      DatabaseSqlError( );', $cr)"/>
  <xsl:value-of select="concat('      ', $local_name, 'ErrorRecord( ', $local_name, 'Ptr );', $cr)"/>
  <xsl:value-of select="concat('      return( 0 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- call the function to delete attribute array sub-tables -->
  <xsl:for-each select="*/*[@array = 'variable']">
    <xsl:variable name="subname">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('   ', $local_name, $subname, 'Delete( ', $local_name, 'Ptr );', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each>

  <xsl:value-of select="concat('   ObjectDeletesProcessed++;', $cr)"/>
  <xsl:value-of select="concat('   return( 1 );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $func_name, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- function-object-remove -->


<!--
!! TEMPLATE:     function-dynamic-update
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 7 November 2006
!! DESCRIPTION:  This template writes out the Pro*C code for the
!!               function DynamicUpdate of each object.
-->
<xsl:template name="function-dynamic-update">
  <xsl:param name="table_name"/>
  <xsl:param name="global_name"/>
  <xsl:param name="object_name"/>
  <xsl:param name="local_name"/>

  <xsl:variable name="func_name" select="concat($global_name, 'DynamicUpdate')"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $func_name, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function updates the given ', $local_name, ' structure in the', $cr)"/>
  <xsl:value-of select="concat(' *               sdc_', $object_name, ' table using a dynamic SQL string. A successful', $cr)"/>
  <xsl:value-of select="concat(' *               update returns a 1. Failure returns a 0. We do not commit', $cr)"/>
  <xsl:value-of select="concat(' *               the update within this function; that is done externally.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('int ', $func_name, '( int updateSide, OBJECT_ANY *', $local_name, ', BIT_FIELD_128 maskField ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   ', $table_name, '_OBJECT *', $local_name, 'Ptr = (', $table_name, '_OBJECT *) ', $local_name, ';', $cr)"/>
  <xsl:value-of select="concat('   char *posPtr;', $cr)"/>
  <xsl:value-of select="concat('   int count = 0;', $cr)"/>
  <xsl:value-of select="concat('   int index;', $cr)"/>
  <xsl:value-of select="concat('   size_t bufferLength = OBJECT_DYNAMIC_STRING_LEN;', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL BEGIN DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="concat('   char *sqlString;', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL END DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- call the functions to update attribute array sub-tables -->
  <xsl:for-each select="*/*[@array = 'variable']">

    <xsl:variable name="subname">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="field_id">
      <xsl:call-template name="to-upper">
        <xsl:with-param name="base_name" select="concat( $table_name, '_FIELD_', name())"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('   if ( BITF_ISON( maskField, ', $field_id, ' ) ) {', $cr)"/>
    <xsl:value-of select="concat('      ', $local_name, $subname, 'Insert( ', $local_name, 'Ptr );', $cr)"/>
    <xsl:value-of select="concat('   }', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each>

  <xsl:value-of select="concat('   /* Start a dynamic string */', $cr)"/>
  <xsl:value-of select="concat('   sqlString = QueueGetStringPointer( );', $cr)"/>
  <xsl:value-of select="concat('   strncpy( sqlString, &quot;UPDATE sdc_', $object_name, ' SET &quot;, bufferLength );', $cr)"/>
  <xsl:value-of select="concat('   bufferLength -= strlen( sqlString );', $cr)"/>
  <xsl:value-of select="concat('   posPtr = sqlString + strlen( sqlString );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   /* Add each updated item to the string */', $cr)"/>
  <xsl:value-of select="concat('   for ( index = 0; index &lt; NUMBER_OF_', $table_name, '_FIELDS+1; index++ ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      if ( ! BITF_ISON( maskField, index ) ) {', $cr)"/>
  <xsl:value-of select="concat('         continue;', $cr)"/>
  <xsl:value-of select="concat('      }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      switch ( index ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:for-each select="*/*[not(@array = 'variable' or name() = 'comment' or name() = 'computed' or name() = 'id')]">
    <xsl:variable name="common_name" select="name()"/>
    <xsl:variable name="com_attr_type" select="@type"/>

    <xsl:variable name="common_upper_name">
      <xsl:call-template name="to-upper">
        <xsl:with-param name="base_name" select="$common_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="commonname">
      <xsl:call-template name="remove-underscores">
        <xsl:with-param name="base_name" select="$common_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="com_name">
      <xsl:call-template name="remove-us-id">
        <xsl:with-param name="base_name" select="$common_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="vocab_name">
      <xsl:call-template name="find-vocabulary-name"/>
    </xsl:variable>

    <xsl:if test="not($common_name = 'id')">
      <xsl:value-of select="concat('         case ', $table_name, '_FIELD_', $common_upper_name, ': {', $cr)"/>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$com_attr_type = 'JEDI'">
        <xsl:if test="not($common_name = 'id')">
          <xsl:value-of select="concat('            snprintf( posPtr, bufferLength, &quot;', $com_name, '_index = %d, ', $com_name, '_type = ', $apos, '%s', $apos, ', &quot;,', $cr)"/>
          <xsl:value-of select="concat('                     ', $local_name, 'Ptr-&gt;object.', $commonname, 'Index, ', $local_name, 'Ptr-&gt;object.')"/>
          <xsl:value-of select="concat($commonname, 'Type );', $cr)"/>
          <xsl:value-of select="concat('            bufferLength -= strlen( posPtr );', $cr)"/>
          <xsl:value-of select="concat('            posPtr += strlen( posPtr );', $cr)"/>
          <xsl:value-of select="concat('            count++;', $cr)"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'LOCATION'">
        <xsl:value-of select="concat('            snprintf( posPtr, bufferLength, &quot;', $common_name, '_lat = %f, ', $common_name, '_lon = %f, &quot;,', $cr)"/>
        <xsl:value-of select="concat('                     ', $local_name, 'Ptr-&gt;object.', $commonname, 'Lat, ')"/>
        <xsl:value-of select="concat($local_name, 'Ptr-&gt;object.', $commonname, 'Lon );', $cr)"/>
        <xsl:value-of select="concat('            bufferLength -= strlen( posPtr );', $cr)"/>
        <xsl:value-of select="concat('            posPtr += strlen( posPtr );', $cr)"/>
        <xsl:value-of select="concat('            count++;', $cr)"/>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'REAL_32'">
        <xsl:value-of select="concat('            snprintf( posPtr, bufferLength, &quot;', $common_name, ' = %f, &quot;, ', $local_name, 'Ptr-&gt;object.')"/>
        <xsl:value-of select="concat($commonname, ' );', $cr)"/>
        <xsl:value-of select="concat('            bufferLength -= strlen( posPtr );', $cr)"/>
        <xsl:value-of select="concat('            posPtr += strlen( posPtr );', $cr)"/>
        <xsl:value-of select="concat('            count++;', $cr)"/>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'TIME'">
        <xsl:value-of select="concat('            snprintf( posPtr, bufferLength, &quot;', $common_name, ' = ', $apos, '%s', $apos, ', &quot;, ', $local_name, 'Ptr-&gt;object.', $commonname, ' );', $cr)"/>
        <xsl:value-of select="concat('            bufferLength -= strlen( posPtr );', $cr)"/>
        <xsl:value-of select="concat('            posPtr += strlen( posPtr );', $cr)"/>
        <xsl:value-of select="concat('            count++;', $cr)"/>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'STRING' or $com_attr_type = 'SHARED_STRING'">
        <xsl:value-of select="concat('            snprintf( posPtr, bufferLength, &quot;', $common_name, ' = ', $apos, '%s', $apos, ', &quot;, ', $local_name)"/>
        <xsl:value-of select="concat('Ptr-&gt;object.', $commonname, ' );', $cr)"/>
        <xsl:value-of select="concat('            bufferLength -= strlen( posPtr );', $cr)"/>
        <xsl:value-of select="concat('            posPtr += strlen( posPtr );', $cr)"/>
        <xsl:value-of select="concat('            count++;', $cr)"/>
      </xsl:when>

      <xsl:when test="string-length($vocab_name) = 0">
        <xsl:value-of select="concat('            snprintf( posPtr, bufferLength, &quot;', $common_name, ' = %d, &quot;, ', $local_name)"/>
        <xsl:value-of select="concat('Ptr-&gt;object.', $commonname, ' );', $cr)"/>
        <xsl:value-of select="concat('            bufferLength -= strlen( posPtr );', $cr)"/>
        <xsl:value-of select="concat('            posPtr += strlen( posPtr );', $cr)"/>
        <xsl:value-of select="concat('            count++;', $cr)"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="concat('            snprintf( posPtr, bufferLength, &quot;', $common_name, ' = ', $apos, '%s', $apos, ', &quot;, ', $local_name)"/>
        <xsl:value-of select="concat('Ptr-&gt;object.', $commonname, ' );', $cr)"/>
        <xsl:value-of select="concat('            bufferLength -= strlen( posPtr );', $cr)"/>
        <xsl:value-of select="concat('            posPtr += strlen( posPtr );', $cr)"/>
        <xsl:value-of select="concat('            count++;', $cr)"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:value-of select="concat('            break;', $cr)"/>
    <xsl:value-of select="concat('         }', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each>

  <xsl:value-of select="concat('         default: {', $cr)"/>
  <xsl:value-of select="concat('            break;', $cr)"/>
  <xsl:value-of select="concat('         }', $cr)"/>
  <xsl:value-of select="concat('      } /* end switch on the mask index */', $cr)"/>
  <xsl:value-of select="concat('   } /* end for each mask index */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   /* If there were no updates that we cared about, then successfully leave */', $cr)"/>
  <xsl:value-of select="concat('   if ( ! count ) {', $cr)"/>
  <xsl:value-of select="concat('      return( 1 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   /* Finish the string for submitting */', $cr)"/>
  <xsl:value-of select="concat('   snprintf( posPtr, bufferLength, &quot;time = ', $apos, '%s', $apos, ' WHERE side_view = %d AND id_index = %d&quot;,', $cr)"/>
  <xsl:value-of select="concat('         ', $local_name, 'Ptr->object.time, updateSide, ', $local_name, 'Ptr->object.idIndex );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   if ( HashUpdateMode == HASH_UPDATE_QUEUE ) {', $cr)"/>
  <xsl:value-of select="concat('      QueueAddString( OBJECT_CLASS_', $table_name, ', sqlString );', $cr)"/>
  <xsl:value-of select="concat('      return( 1 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL EXECUTE IMMEDIATE :sqlString;', $cr)"/>
  <xsl:value-of select="concat('   if ( sqlca.sqlcode &lt; 0 ) {', $cr)"/>
  <xsl:value-of select="concat('      logger_error_msg( &quot;SQL Error With Dynamic String:\n   %s\n&quot;, sqlString );', $cr)"/>
  <xsl:value-of select="concat('      DatabaseSqlError( );', $cr)"/>
  <xsl:value-of select="concat('      return( 0 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   ObjectUpdatesProcessed++;', $cr)"/>
  <xsl:value-of select="concat('   return( 1 );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $func_name, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- function-dynamic-update -->


<!--
!! TEMPLATE:     function-standard-update
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 13 November 2006
!! DESCRIPTION:  This template writes out the Pro*C code for the
!!               function StandardUpdate of each object.
-->
<xsl:template name="function-standard-update">
  <xsl:param name="table_name"/>
  <xsl:param name="global_name"/>
  <xsl:param name="object_name"/>
  <xsl:param name="local_name"/>

  <xsl:variable name="func_name" select="concat($global_name, 'StandardUpdate')"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $func_name, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function updates the given ', $local_name, ' structure in the', $cr)"/>
  <xsl:value-of select="concat(' *               sdc_', $object_name, ' table using a series of standard SQL strings.', $cr)"/>
  <xsl:value-of select="concat(' *               A successful update returns a 1. Failure returns a 0. We do', $cr)"/>
  <xsl:value-of select="concat(' *               not commit the update within this function; that is done', $cr)"/>
  <xsl:value-of select="concat(' *               externally.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('int ', $func_name, '( int updateSide, OBJECT_ANY *', $local_name, ', BIT_FIELD_128 maskField ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL BEGIN DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="concat('   ', $table_name, '_OBJECT *', $local_name, 'Ptr = (', $table_name, '_OBJECT *) ', $local_name, ';', $cr)"/>
  <xsl:value-of select="concat('   int side = updateSide;', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL END DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="concat('   int index;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL UPDATE sdc_', $object_name, $cr)"/>
  <xsl:value-of select="concat('      SET time = :', $local_name, 'Ptr-&gt;object.time', $cr)"/>
  <xsl:value-of select="concat('      WHERE side_view = :side AND id_index = :', $local_name, 'Ptr-&gt;object.idIndex;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   if ( sqlca.sqlcode &lt; 0 ) {', $cr)"/>
  <xsl:value-of select="concat('      logger_error_msg( &quot;Unable to update ', $table_name, ' record\n&quot; );', $cr)"/>
  <xsl:value-of select="concat('      DatabaseSqlError( );', $cr)"/>
  <xsl:value-of select="concat('      ', $local_name, 'ErrorItem( ', $local_name, 'Ptr, ', $table_name, '_FIELD_INVALID, 1 );', $cr)"/>
  <xsl:value-of select="concat('      return( 0 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   for ( index = 0; index &lt; NUMBER_OF_', $table_name, '_FIELDS+1; index++ ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      if ( ! BITF_ISON( maskField, index ) ) {', $cr)"/>
  <xsl:value-of select="concat('         continue;', $cr)"/>
  <xsl:value-of select="concat('      }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      switch ( index ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:for-each select="*/*[not(@array = 'variable' or name() = 'comment' or name() = 'computed')]">
    <xsl:variable name="common_name" select="name()"/>
    <xsl:variable name="com_attr_type" select="@type"/>

    <xsl:variable name="common_upper_name">
      <xsl:call-template name="to-upper">
        <xsl:with-param name="base_name" select="$common_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="commonname">
      <xsl:call-template name="remove-underscores">
        <xsl:with-param name="base_name" select="$common_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="com_name">
      <xsl:call-template name="remove-us-id">
        <xsl:with-param name="base_name" select="$common_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="field_id" select="concat( $table_name, '_FIELD_', $common_upper_name)"/>

    <xsl:if test="not($common_name = 'id')">
      <xsl:value-of select="concat('         case ', $field_id, ': {', $cr)"/>
     <xsl:value-of select="$cr"/>
      <xsl:value-of select="concat('            EXEC SQL UPDATE sdc_', $object_name, $cr)"/>
      <xsl:value-of select="'               SET '"/>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$com_attr_type = 'JEDI'">
        <xsl:if test="not($common_name = 'id')">
          <xsl:value-of select="concat($com_name, '_index = :', $local_name, 'Ptr-&gt;object.', $commonname, 'Index,', $cr)"/>
          <xsl:value-of select="concat('                   ', $com_name, '_type = :', $local_name, 'Ptr-&gt;object.', $commonname, 'Type', $cr)"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'LOCATION'">
        <xsl:value-of select="concat($common_name, '_lat = :', $local_name, 'Ptr-&gt;object.', $commonname, 'Lat,', $cr)"/>
        <xsl:value-of select="concat('                   ', $common_name, '_lon = :', $local_name, 'Ptr-&gt;object.', $commonname, 'Lon', $cr)"/>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'TIME'">
        <xsl:value-of select="concat($common_name, ' = :', $local_name, 'Ptr-&gt;object.', $commonname, $cr)"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="concat($common_name, ' = :', $local_name, 'Ptr-&gt;object.', $commonname, $cr)"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="not($common_name = 'id')">
      <xsl:value-of select="concat('               WHERE side_view = :side AND id_index = :', $local_name, 'Ptr-&gt;object.idIndex;', $cr)"/>
      <xsl:value-of select="$cr"/>

      <xsl:value-of select="concat('            if ( sqlca.sqlcode &lt; 0 ) {', $cr)"/>
      <xsl:value-of select="concat('               logger_error_msg( &quot;Unable to Update ', $table_name, ' record\n&quot; );', $cr)"/>
      <xsl:value-of select="concat('               DatabaseSqlError( );', $cr)"/>
      <xsl:value-of select="concat('               ', $local_name, 'ErrorItem( ', $local_name, 'Ptr, ', $field_id, ', 1 );', $cr)"/>
      <xsl:value-of select="concat('               return( 0 );', $cr)"/>
      <xsl:value-of select="concat('            }', $cr)"/>
      <xsl:value-of select="$cr"/>
      <xsl:value-of select="concat('            ObjectUpdatesProcessed++;', $cr)"/>
      <xsl:value-of select="concat('            break;', $cr)"/>
      <xsl:value-of select="concat('         }', $cr)"/>
      <xsl:value-of select="$cr"/>
    </xsl:if>
  </xsl:for-each>

  <!-- call the functions to update attribute array sub-tables -->
  <xsl:for-each select="*/*[@array = 'variable']">

    <xsl:variable name="subname">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="field_id">
      <xsl:call-template name="to-upper">
        <xsl:with-param name="base_name" select="concat( $table_name, '_FIELD_', name())"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('         case ', $field_id, ': {', $cr)"/>
    <xsl:value-of select="concat('            ', $local_name, $subname, 'Insert( ', $local_name, 'Ptr );', $cr)"/>
    <xsl:value-of select="concat('            break;', $cr)"/>
    <xsl:value-of select="concat('         }', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each>

  <xsl:value-of select="concat('         default: {', $cr)"/>
  <xsl:value-of select="concat('            break;', $cr)"/>
  <xsl:value-of select="concat('         }', $cr)"/>
  <xsl:value-of select="concat('      } /* end switch on the mask index */', $cr)"/>
  <xsl:value-of select="concat('   } /* end for each mask index */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   return( 1 );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $func_name, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- function-standard-update -->


<!--
!! TEMPLATE:     function-single-update
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 21 November 2006
!! DESCRIPTION:  This template writes out the Pro*C code for the
!!               function SingleUpdate of each object.
-->
<xsl:template name="function-single-update">
  <xsl:param name="table_name"/>
  <xsl:param name="global_name"/>
  <xsl:param name="object_name"/>
  <xsl:param name="local_name"/>

  <xsl:variable name="func_name" select="concat($global_name, 'SingleUpdate')"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $func_name, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function performs a single update that updates all', $cr)"/>
  <xsl:value-of select="concat(' *               columns except the side and object type data within the', $cr)"/>
  <xsl:value-of select="concat(' *               sdc_', $object_name, ' table using a single update statement. A', $cr)"/>
  <xsl:value-of select="concat(' *               successful update returns a 1, a failure a 0.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('int ', $func_name, '( int updateSide, OBJECT_ANY *', $local_name, ', BIT_FIELD_128 maskField ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL BEGIN DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="concat('   int side = updateSide;', $cr)"/>
  <xsl:value-of select="concat('   ', $table_name, '_OBJECT *', $local_name, 'Ptr = (', $table_name, '_OBJECT *) ', $local_name, ';', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL END DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL UPDATE sdc_', $object_name, $cr)"/>
  <xsl:value-of select="concat('      SET time = :', $local_name, 'Ptr-&gt;object.time')"/>

  <xsl:for-each select="*/*[not(@array = 'variable' or name() = 'comment' or name() = 'computed')]">
    <xsl:variable name="common_name" select="name()"/>
    <xsl:variable name="com_attr_type" select="@type"/>

    <xsl:variable name="common_upper_name">
      <xsl:call-template name="to-upper">
        <xsl:with-param name="base_name" select="$common_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="commonname">
      <xsl:call-template name="remove-underscores">
        <xsl:with-param name="base_name" select="$common_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="com_name">
      <xsl:call-template name="remove-us-id">
        <xsl:with-param name="base_name" select="$common_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$com_attr_type = 'JEDI'">
        <xsl:if test="not($common_name = 'id')">
          <xsl:value-of select="concat('          ', $com_name, '_type = :', $local_name, 'Ptr-&gt;object.', $commonname, 'Type,', $cr)"/>
          <xsl:value-of select="concat('          ', $com_name, '_index = :', $local_name, 'Ptr-&gt;object.', $commonname, 'Index')"/>
        </xsl:if>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'LOCATION'">
        <xsl:value-of select="concat('          ', $common_name, '_lat = :', $local_name, 'Ptr-&gt;object.', $commonname, 'Lat,', $cr)"/>
        <xsl:value-of select="concat('          ', $common_name, '_lon = :', $local_name, 'Ptr-&gt;object.', $commonname, 'Lon')"/>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'TIME'">
        <xsl:value-of select="concat('          ', $common_name, ' = :', $local_name, 'Ptr-&gt;object.', $commonname)"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="concat('          ', $common_name, ' = :', $local_name, 'Ptr-&gt;object.', $commonname)"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="not(position() = last())">
      <xsl:value-of select="','"/>
    </xsl:if>
    <xsl:value-of select="$cr"/>
  </xsl:for-each>

  <xsl:value-of select="concat('      WHERE side_view = :side AND id_index = :', $local_name, 'Ptr-&gt;object.idIndex;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   if ( sqlca.sqlcode &lt; 0 ) {', $cr)"/>
  <xsl:value-of select="concat('      logger_error_msg( &quot;Unable to update ', $table_name, ' record\n&quot; );', $cr)"/>
  <xsl:value-of select="concat('      DatabaseSqlError( );', $cr)"/>
  <xsl:value-of select="concat('      ', $local_name, 'ErrorRecord( ', $local_name, 'Ptr );', $cr)"/>
  <xsl:value-of select="concat('      return( 0 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- call the functions to update attribute array sub-tables -->
  <xsl:for-each select="*/*[@array = 'variable']">

    <xsl:variable name="subname">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('   ', $local_name, $subname, 'Insert( ', $local_name, 'Ptr );', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each>

  <xsl:value-of select="concat('   ObjectUpdatesProcessed++;', $cr)"/>
  <xsl:value-of select="concat('   return( 1 );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $func_name, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- function-single-update -->


<!--
!! TEMPLATE:     function-object-arrays-insert
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 17 August 2007
!! DESCRIPTION:  This template writes out a function for each array attribute
!!               within the current object. These functions perform group
!!               inserts of the array values within the appropriate sub-table.
-->
<xsl:template name="function-object-arrays-insert">
  <xsl:param name="table_name"/>

  <xsl:variable name="local_name">
    <xsl:call-template name="get-local-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="macro_name">
    <xsl:call-template name="to-upper">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="object_type" select="concat($macro_name, '_OBJECT')"/>
  <xsl:variable name="object_ptr" select="concat($local_name, 'Ptr')"/>

  <xsl:for-each select="*/*[@array = 'variable']">

    <xsl:variable name="subsql" select="name()"/>

    <xsl:variable name="subname">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="sublocal">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="acronym">
      <xsl:call-template name="get-acronym-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="global_acronym">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="$acronym"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="attribute_node">
      <xsl:call-template name="attribute-node-to-node-set"/>
    </xsl:variable>

    <xsl:variable name="func_name" select="concat($local_name, $subname, 'Insert')"/>
    <xsl:variable name="error_func" select="concat($local_name, $subname, 'ErrorRecord')"/>
    <xsl:variable name="delete_func" select="concat($local_name, $subname, 'Delete')"/>
    <xsl:variable name="subtable" select="concat('SDC_', $macro_name, '_', $acronym, '_TABLE')"/>
    <xsl:variable name="subarray" select="concat($local_name, $global_acronym, 'Array')"/>
    <xsl:variable name="subcount" select="concat($sublocal, 'Count')"/>
    <xsl:variable name="sql_table">
      <xsl:call-template name="to-lower">
        <xsl:with-param name="base_name" select="concat('sdc_', $table_name, '_', $acronym)"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
    <xsl:value-of select="concat(' * FUNCTION:     ', $func_name, $cr)"/>
    <xsl:value-of select="concat(' * DESCRIPTION:  This function performs a group load of the ', $sublocal, $cr)"/>
    <xsl:value-of select="concat(' *               attribute array into the ', $sql_table, ' table.', $cr)"/>
    <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
    <xsl:value-of select="concat('static void ', $func_name, '( ', $object_type, ' *', $object_ptr, ' ) {', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="concat('   EXEC SQL BEGIN DECLARE SECTION;', $cr)"/>
    <xsl:value-of select="concat('   ', $subtable, ' ', $subarray, '[OBJECT_GROUP_SIZE];', $cr)"/>
    <xsl:value-of select="concat('   int count;', $cr)"/>
    <xsl:value-of select="concat('   EXEC SQL END DECLARE SECTION;', $cr)"/>
    <xsl:value-of select="concat('   int totalCount;', $cr)"/>
    <xsl:value-of select="concat('   int index;', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="concat('   ', $delete_func, '( ', $object_ptr, ' );', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="concat('   totalCount = ', $object_ptr, '->', $subcount, ';', $cr)"/>
    <xsl:value-of select="concat('   for ( index = 0; index &lt; totalCount; ) {', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="concat('      /* Load the array with up to the maximum number of objects */', $cr)"/>
    <xsl:value-of select="concat('      for ( count = 0; count &lt; OBJECT_GROUP_SIZE &amp;&amp; index &lt; totalCount; count++ ) {', $cr)"/>
    <xsl:value-of select="concat('         ', $subarray, '[count].sideView = ', $object_ptr, '->object.sideView;', $cr)"/>
    <xsl:value-of select="concat('         ', $subarray, '[count].idIndex = ', $object_ptr, '->object.idIndex;', $cr)"/>
    <xsl:value-of select="concat('         ', $subarray, '[count].sequenceNbr = index + 1;', $cr)"/>

    <xsl:for-each select="$attribute_node/*">

      <xsl:variable name="child_name">
        <xsl:call-template name="get-local-name">
          <xsl:with-param name="base_name" select="name()"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="compound_name">
        <xsl:call-template name="get-compound-name">
          <xsl:with-param name="base_name" select="$sublocal"/>
          <xsl:with-param name="child_name" select="name()"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="c_type" >
        <xsl:call-template name="jdsp-node-to-c-type"/>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="$c_type = 'char'">
          <xsl:variable name="c_length">
            <xsl:call-template name="find-db-column-width"/>
          </xsl:variable>
          <xsl:value-of select="concat('         strncpy( ', $subarray, '[count].', $child_name, ', ',  $object_ptr, '->', $compound_name, '[index], SDC_', $c_length, ');', $cr)"/>
          <xsl:value-of select="concat('         ', $subarray, '[count].', $child_name, '[SDC_', $c_length, '] = ', $apos, '\0', $apos, ';', $cr)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('         ', $subarray, '[count].', $child_name, ' = ',  $object_ptr, '->', $compound_name, '[index];', $cr)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>

    <xsl:value-of select="concat('         index++;', $cr)"/>
    <xsl:value-of select="concat('       }', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="concat('      /* Perform the group insert */', $cr)"/>
    <xsl:value-of select="concat('      EXEC SQL FOR :count INSERT INTO ', $sql_table, $cr)"/>
    <xsl:value-of select="'         (side_view, id_index, sequence_number, '"/>
    <xsl:for-each select="$attribute_node/*">
      <xsl:value-of select="name()"/>
      <xsl:if test="position() != last()">
        <xsl:value-of select="', '"/>
      </xsl:if>
    </xsl:for-each>
    <xsl:value-of select="concat(')', $cr)"/>
    <xsl:value-of select="concat('         VALUES ( :', $subarray, ' );', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="concat('      if ( sqlca.sqlcode &lt; 0 ) {', $cr)"/>
    <xsl:value-of select="concat('         int problemIndex = index - (count - sqlca.sqlerrd[2]) - 1;', $cr)"/>
    <xsl:value-of select="concat('         logger_error_msg( &quot;Unable to group insert %d ', $table_name, ' ', $subname, ' records\n&quot; );', $cr)"/>
    <xsl:value-of select="concat('         DatabaseSqlError( );', $cr)"/>
    <xsl:value-of select="concat('         ', $error_func, '( ', $object_ptr, ', problemIndex );', $cr)"/>
    <xsl:value-of select="concat('      }', $cr)"/>
    <xsl:value-of select="concat('   } /* end of loop until we have inserted all objects */', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="concat('   return;', $cr)"/>
    <xsl:value-of select="concat('} /* end of function ', $func_name, ' */', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each> <!-- array attribute -->

</xsl:template> <!-- function-object-arrays-insert -->


<!--
!! TEMPLATE:     function-object-arrays-delete
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 17 August 2007
!! DESCRIPTION:  This template writes out a function for each array attribute
!!               within the current object. These functions remove the array
!!               values from the appropriate sub-table.
-->
<xsl:template name="function-object-arrays-delete">
  <xsl:param name="table_name"/>

  <xsl:variable name="local_name">
    <xsl:call-template name="get-local-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="macro_name">
    <xsl:call-template name="to-upper">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="object_type" select="concat($macro_name, '_OBJECT')"/>
  <xsl:variable name="object_ptr" select="concat($local_name, 'Ptr')"/>

  <xsl:for-each select="*/*[@array = 'variable']">

    <xsl:variable name="subname">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="acronym">
      <xsl:call-template name="get-acronym-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="func_name" select="concat($local_name, $subname, 'Delete')"/>
    <xsl:variable name="error_func" select="concat($local_name, $subname, 'ErrorRecord')"/>
    <xsl:variable name="sql_table">
      <xsl:call-template name="to-lower">
        <xsl:with-param name="base_name" select="concat('sdc_', $table_name, '_', $acronym)"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
    <xsl:value-of select="concat(' * FUNCTION:     ', $func_name, $cr)"/>
    <xsl:value-of select="concat(' * DESCRIPTION:  This function performs a delete of the ', $subname, $cr)"/>
    <xsl:value-of select="concat(' *               attribute array from the ', $sql_table, ' table.', $cr)"/>
    <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
    <xsl:value-of select="concat('static void ', $func_name, '( ', $object_type, ' *', $object_ptr, ' ) {', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="concat('   EXEC SQL BEGIN DECLARE SECTION;', $cr)"/>
    <xsl:value-of select="concat('   int sideNbr = ', $object_ptr, '->object.sideView;', $cr)"/>
    <xsl:value-of select="concat('   int idNbr = ', $object_ptr, '->object.idIndex;', $cr)"/>
    <xsl:value-of select="concat('   EXEC SQL END DECLARE SECTION;', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="concat('   EXEC SQL DELETE FROM ', $sql_table, $cr)"/>
    <xsl:value-of select="concat('       WHERE side_view = :sideNbr AND id_index = :idNbr;', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="concat('   if ( sqlca.sqlcode &lt; 0 ) {', $cr)"/>
    <xsl:value-of select="concat('      logger_error_msg( &quot;Unable to remove %d ', $table_name, ' ', $subname, ' records\n&quot; );', $cr)"/>
    <xsl:value-of select="concat('      DatabaseSqlError( );', $cr)"/>
    <xsl:value-of select="concat('      ', $error_func, '( ', $object_ptr, ', 1 );', $cr)"/>
    <xsl:value-of select="concat('   }', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="concat('   return;', $cr)"/>
    <xsl:value-of select="concat('} /* end of function ', $func_name, ' */', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each> <!-- array attribute -->

</xsl:template> <!-- function-object-arrays-delete -->

<!--
!! TEMPLATE:     function-object-arrays-error
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 17 August 2007
!! DESCRIPTION:  This template writes out a function for each array attribute
!!               within the current object. These functions list the attribute
!!               values for the array attribute.
-->
<xsl:template name="function-object-arrays-error">
  <xsl:param name="table_name"/>

  <xsl:variable name="local_name">
    <xsl:call-template name="get-local-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="macro_name">
    <xsl:call-template name="to-upper">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="object_type" select="concat($macro_name, '_OBJECT')"/>
  <xsl:variable name="object_ptr" select="concat($local_name, 'Ptr')"/>

  <xsl:for-each select="*/*[@array = 'variable']">

    <xsl:variable name="subname">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="sublocal">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="acronym">
      <xsl:call-template name="get-acronym-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="attribute_node">
      <xsl:call-template name="attribute-node-to-node-set"/>
    </xsl:variable>

    <xsl:variable name="func_name" select="concat($local_name, $subname, 'ErrorRecord')"/>

    <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
    <xsl:value-of select="concat(' * FUNCTION:     ', $func_name, $cr)"/>
    <xsl:value-of select="concat(' * DESCRIPTION:  This function writes the values of a specific array element.', $cr)"/>
    <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
    <xsl:value-of select="concat('static void ', $func_name, '( ', $object_type, ' *', $object_ptr, ', int index ) {', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="concat('   logger_error_msg( &quot;   sideView = %d\n&quot;, ', $object_ptr, '->object.sideView );', $cr)"/>
    <xsl:value-of select="concat('   logger_error_msg( &quot;   idIndex = %d\n&quot;, ', $object_ptr, '->object.idIndex );', $cr)"/>
    <xsl:value-of select="concat('   logger_error_msg( &quot;   sequenceNbr = %d\n&quot;, index );', $cr)"/>

    <xsl:for-each select="$attribute_node/*">

      <xsl:variable name="child_name">
        <xsl:call-template name="get-local-name">
          <xsl:with-param name="base_name" select="name()"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="compound_name">
        <xsl:call-template name="get-compound-name">
          <xsl:with-param name="base_name" select="$sublocal"/>
          <xsl:with-param name="child_name" select="name()"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="c_type">
        <xsl:call-template name="jdsp-node-to-c-output-type"/>
      </xsl:variable>

      <xsl:value-of select="concat('   logger_error_msg( &quot;   ', $child_name, ' = %', $c_type, '\n&quot;, ', $object_ptr, '->', $compound_name, '[index] );', $cr)"/>
    </xsl:for-each>
    <xsl:value-of select="$cr"/>

    <xsl:value-of select="concat('   return;', $cr)"/>
    <xsl:value-of select="concat('} /* end of function ', $func_name, ' */', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each> <!-- array attribute -->

</xsl:template> <!-- function-object-arrays-error -->


<!--
!! TEMPLATE:     function-error-record
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 28 May 2007
!! DESCRIPTION:  This template writes out the Pro*C code for the function that
!!               logs the attribute values of an error object.
-->
<xsl:template name="function-error-record">
  <xsl:param name="table_name"/>
  <xsl:param name="global_name"/>
  <xsl:param name="object_name"/>
  <xsl:param name="local_name"/>

  <xsl:variable name="func_name" select="concat($local_name, 'ErrorRecord')"/>
  <xsl:variable name="func_item" select="concat($local_name, 'ErrorItem')"/>
  <xsl:variable name="object_type" select="concat($table_name, '_OBJECT')"/>
  <xsl:variable name="object_ptr" select="concat($local_name, 'Ptr')"/>
  <xsl:variable name="nbr_fields" select="concat('NUMBER_OF_', $table_name, '_FIELDS')"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $func_name, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function writes the elements and values of a', $cr)"/>
  <xsl:value-of select="concat(' *               ', $table_name, ' object to the error log.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('static void ', $func_name, '( ', $object_type, ' *', $object_ptr, ' ) {', $cr)"/>
  <xsl:value-of select="concat('   int index;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   ', $func_item, '( ', $object_ptr, ', ', $table_name, '_FIELD_INVALID, 1 );', $cr)"/>
  <xsl:value-of select="concat('   for ( index = 1; index &lt; ', $nbr_fields, '; index++ ) {', $cr)"/>
  <xsl:value-of select="concat('      ', $func_item, '( ', $object_ptr, ', index, 0 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $func_name, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- function-error-record -->


<!--
!! TEMPLATE:     function-error-item
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 28 May 2007
!! DESCRIPTION:  This template 
-->
<xsl:template name="function-error-item">
  <xsl:param name="table_name"/>
  <xsl:param name="global_name"/>
  <xsl:param name="object_name"/>
  <xsl:param name="local_name"/>

  <xsl:variable name="func_name" select="concat($local_name, 'ErrorItem')"/>
  <xsl:variable name="object_type" select="concat($table_name, '_OBJECT')"/>
  <xsl:variable name="object_ptr" select="concat($local_name, 'Ptr')"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $func_name, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function writes a specific element and value of a', $cr)"/>
  <xsl:value-of select="concat(' *               ', $table_name, ' object to the error log.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('static void ', $func_name, '( ', $object_type, ' *', $object_ptr, ', int item, int objectInfo ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   if ( objectInfo ) {', $cr)"/>
  <xsl:value-of select="concat('      logger_error_msg( &quot;   time = %s\n&quot;, ', $object_ptr, '->object.time );', $cr)"/>
  <xsl:value-of select="concat('      logger_error_msg( &quot;   sideView = %d\n&quot;, ', $object_ptr, '->object.sideView );', $cr)"/>
  <xsl:value-of select="concat('      logger_error_msg( &quot;   idIndex = %d\n&quot;, ', $object_ptr, '->object.idIndex );', $cr)"/>
  <xsl:value-of select="concat('      logger_error_msg( &quot;   idType = %s\n&quot;, ', $object_ptr, '->object.idType );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   switch ( item ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:for-each select="*/*[not(@array = 'variable' or name() = 'comment' or name() = 'computed' or name() = 'id')]">
    <xsl:variable name="common_name" select="name()"/>
    <xsl:variable name="com_attr_type" select="@type"/>

    <xsl:variable name="common_upper_name">
      <xsl:call-template name="to-upper">
        <xsl:with-param name="base_name" select="$common_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="commonname">
      <xsl:call-template name="remove-underscores">
        <xsl:with-param name="base_name" select="$common_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="com_name">
      <xsl:call-template name="remove-us-id">
        <xsl:with-param name="base_name" select="$common_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="vocab_name">
      <xsl:call-template name="find-vocabulary-name"/>
    </xsl:variable>

    <xsl:variable name="field_id" select="concat($table_name, '_FIELD_', $common_upper_name)"/>
    <xsl:value-of select="concat('      case ', $field_id, ': {', $cr)"/>

    <xsl:choose>
      <xsl:when test="$com_attr_type = 'JEDI'">
        <xsl:value-of select="concat('         logger_error_msg( &quot;   ', $commonname, 'Type = %s\n&quot;, ', $object_ptr, '->object.', $commonname, 'Type );', $cr)"/>
        <xsl:value-of select="concat('         logger_error_msg( &quot;   ', $commonname, 'Index = %d\n&quot;, ', $object_ptr, '->object.', $commonname, 'Index );', $cr)"/>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'LOCATION'">
        <xsl:value-of select="concat('         logger_error_msg( &quot;   ', $commonname, 'Lat = %f\n&quot;, ', $object_ptr, '->object.', $commonname, 'Lat );', $cr)"/>
        <xsl:value-of select="concat('         logger_error_msg( &quot;   ', $commonname, 'Lon = %f\n&quot;, ', $object_ptr, '->object.', $commonname, 'Lon );', $cr)"/>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'TIME'">
        <xsl:value-of select="concat('         logger_error_msg( &quot;   ', $commonname, ' = %s\n&quot;, ', $object_ptr, '->object.', $commonname, ' );', $cr)"/>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'REAL_32'">
        <xsl:value-of select="concat('         logger_error_msg( &quot;   ', $commonname, ' = %f\n&quot;, ', $object_ptr, '->object.', $commonname, ' );', $cr)"/>
      </xsl:when>

      <xsl:when test="$com_attr_type = 'STRING' or $com_attr_type = 'SHARED_STRING'">
        <xsl:value-of select="concat('         logger_error_msg( &quot;   ', $commonname, ' = %s\n&quot;, ', $object_ptr, '->object.', $commonname, ' );', $cr)"/>
      </xsl:when>

      <xsl:when test="string-length($vocab_name) = 0">
        <xsl:value-of select="concat('         logger_error_msg( &quot;   ', $commonname, ' = %d\n&quot;, ', $object_ptr, '->object.', $commonname, ' );', $cr)"/>
      </xsl:when>

      <xsl:otherwise>
        <xsl:value-of select="concat('         logger_error_msg( &quot;   ', $commonname, ' = %s\n&quot;, ', $object_ptr, '->object.', $commonname, ' );', $cr)"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:value-of select="concat('         break;', $cr)"/>
    <xsl:value-of select="concat('      }', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each>

  <xsl:value-of select="concat('   } /* end switch on the item */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $func_name, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- function-error-item -->


<!--
!! TEMPLATE:     gen-sql-create-file
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 27 November 2006
!! DESCRIPTION:  This template writes out the SQL script for the
!!               creation of the tables.
-->
<xsl:template name="gen-sql-create-file">
  <xsl:value-of select="concat('-- This sql script file is responsible for creating the SDC (Scenario', $cr)"/>
  <xsl:value-of select="concat('-- Data Client) related tables within the Scenario Data Repository (SDR).', $cr)"/>
  <xsl:value-of select="concat('--', $cr)"/>
  <xsl:value-of select="concat($copyright, $cr)"/>
  <xsl:value-of select="concat('-- Turn off verification. This suppresses listing substitution lines when', $cr)"/>
  <xsl:value-of select="concat('-- defines are replaced by their real values', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('SET VERIFY OFF', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('-- The following defines are used for variable character strings. These', $cr)"/>
  <xsl:value-of select="concat('-- should match the same defines in the SDC code. If a define is changed', $cr)"/>
  <xsl:value-of select="concat('-- here, it should also be changed in the code.', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:for-each select="constants/*[not(name() = 'description')]">
    <xsl:value-of select="concat('DEFINE SDC_', name(), ' = ', @value, $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="$cr"/>

  <xsl:for-each select="$persistent_nodes">
    <xsl:variable name="table_name" select="name()"/>

    <xsl:variable name="object_name">
      <xsl:call-template name="get-object-name">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('CREATE TABLE sdc_', $object_name, $cr)"/>
    <xsl:value-of select="concat('   (time DATE,', $cr)"/>
    <xsl:value-of select="concat('    side_view NUMBER(2) NOT NULL,', $cr)"/>

    <xsl:for-each select="*/*[not(@array = 'variable' or name() = 'comment' or name() = 'computed')]">
      <xsl:variable name="common_name" select="name()"/>
      <xsl:variable name="com_attr_type" select="@type"/>

      <xsl:variable name="com_name">
        <xsl:call-template name="remove-us-id">
          <xsl:with-param name="base_name" select="$common_name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="max_len">
        <xsl:call-template name="find-db-column-width"/>
      </xsl:variable>

      <xsl:variable name="jedi_max_len">
        <xsl:call-template name="find-jedi-db-column-width"/>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="$com_attr_type = 'JEDI'">
          <xsl:value-of select="concat('    ', $com_name, '_index NUMBER(20),', $cr)"/>
          <xsl:value-of select="concat('    ', $com_name, '_type VARCHAR2(&amp;SDC_', $jedi_max_len, ')')"/>
        </xsl:when>

        <xsl:when test="$com_attr_type = 'LOCATION'">
          <xsl:value-of select="concat('    ', $common_name, '_lat FLOAT,', $cr)"/>
          <xsl:value-of select="concat('    ', $common_name, '_lon FLOAT')"/>
        </xsl:when>

        <xsl:when test="$com_attr_type = 'TIME'">
          <xsl:value-of select="concat('    ', $common_name, ' DATE')"/>
        </xsl:when>

        <xsl:when test="$com_attr_type = 'REAL_32'">
          <xsl:value-of select="concat('    ', $common_name, ' FLOAT')"/>
        </xsl:when>

        <xsl:when test="string-length($max_len) != 0">
          <xsl:value-of select="concat('    ', $common_name, ' VARCHAR2(&amp;SDC_', $max_len, ')')"/>
        </xsl:when>

        <xsl:when test="$com_attr_type = 'UINT_8'">
          <xsl:value-of select="concat('    ', $common_name, ' NUMBER(3)')"/>
        </xsl:when>

        <xsl:when test="$com_attr_type = 'UINT_16' or $com_attr_type = 'UINT_32'">
          <xsl:value-of select="concat('    ', $common_name, ' NUMBER(20)')"/>
        </xsl:when>

        <xsl:when test="$com_attr_type = 'INT_16' or $com_attr_type = 'INT_32'">
          <xsl:value-of select="concat('    ', $common_name, ' NUMBER(5) NOT NULL')"/>
        </xsl:when>

        <xsl:otherwise> <!-- an enumerated type w/o a max length -->
          <xsl:value-of select="concat('    ', $common_name, ' NUMBER(10)')"/>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:if test="not(position() = last())">
        <xsl:value-of select="concat(',', $cr)"/>
      </xsl:if>
    </xsl:for-each>
     <xsl:value-of select="concat(');', $cr)"/>

    <xsl:value-of select="concat('CREATE UNIQUE INDEX sdc_', $object_name, '_i ON sdc_', $object_name, '(side_view, id_index);', $cr)"/>

    <xsl:if test="$object_name = 'combat_system'">
      <xsl:value-of select="concat('CREATE INDEX sdc_', $object_name, '_owner_i ON sdc_', $object_name, '(unit_index);', $cr)"/>
    </xsl:if>

    <xsl:if test="$object_name = 'supply_category'">
      <xsl:value-of select="concat('CREATE INDEX sdc_', $object_name, '_owner_i ON sdc_', $object_name, '(owning_unit_index);', $cr)"/>
    </xsl:if>
    <xsl:value-of select="$cr"/>

    <!-- For each attribute that is an array create a child table to hold the
         array information -->
    <xsl:for-each select="*/*[@array = 'variable']">
      <xsl:variable name="attr_name" select="name()"/>

      <xsl:variable name="acronym">
        <xsl:call-template name="get-acronym-name">
          <xsl:with-param name="base_name" select="$attr_name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="subtable_name">
        <xsl:call-template name="to-lower">
          <xsl:with-param name="base_name" select="concat('sdc_', $object_name, '_', $acronym)"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="subindex_name" select="concat($subtable_name, '_i')"/>

      <xsl:variable name="attribute_node">
        <xsl:call-template name="attribute-node-to-node-set"/>
      </xsl:variable>

      <xsl:value-of select="concat('CREATE TABLE ', $subtable_name, $cr)"/>
      <xsl:value-of select="concat('   (side_view NUMBER(2) NOT NULL,', $cr)"/>
      <xsl:value-of select="concat('    id_index NUMBER(20) NOT NULL,', $cr)"/>
      <xsl:value-of select="concat('    sequence_number NUMBER(10) NOT NULL,', $cr)"/>

      <xsl:for-each select="$attribute_node/*">

        <xsl:variable name="sql_type" >
          <xsl:call-template name="jdsp-node-to-sql-type"/>
        </xsl:variable>

        <xsl:value-of select="concat('    ', name(), ' ', $sql_type)"/>

        <xsl:if test="$sql_type = 'VARCHAR2'">
          <xsl:variable name="length">
            <xsl:call-template name="find-db-column-width"/>
          </xsl:variable>
          <xsl:value-of select="concat('(&amp;SDC_', $length, ')')"/>
        </xsl:if>

        <xsl:choose>
          <xsl:when test="position() = last()">
            <xsl:value-of select="');'"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="','"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$cr"/>
      </xsl:for-each>
      <xsl:value-of select="concat('CREATE UNIQUE INDEX ', $subindex_name, ' ON ', $subtable_name, '(side_view, id_index, sequence_number);', $cr)"/>
      <xsl:value-of select="$cr"/>

    </xsl:for-each> <!-- array attribute -->

  </xsl:for-each> <!-- persistent object -->
  <xsl:value-of select="concat('-- DO NOT USE QUIT OR EXIT (called from within another sql script)', $cr)"/>
</xsl:template> <!-- gen-sql-create-file -->


<!--
!! TEMPLATE:     gen-sql-drop-file
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 27 November 2006
!! DESCRIPTION:  This template writes out the SQL script for the
!!               drops of the tables.
-->
<xsl:template name="gen-sql-drop-file">
  <xsl:value-of select="concat('-- This sql script file is responsible for creating the SDC (Scenario', $cr)"/>
  <xsl:value-of select="concat('-- Data Client) related tables within the Scenario Data Repository (SDR).', $cr)"/>
  <xsl:value-of select="concat('--', $cr)"/>
  <xsl:value-of select="concat($copyright, $cr)"/>

  <xsl:for-each select="$persistent_nodes">
    <xsl:variable name="table_name" select="name()"/>

    <xsl:variable name="object_name">
      <xsl:call-template name="get-object-name">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('DROP TABLE sdc_', $object_name, ';', $cr)"/>

    <!-- For each attribute that is an array drop the child table that holds
         the array information -->
    <xsl:for-each select="*/*[@array = 'variable']">
      <xsl:variable name="attr_name" select="name()"/>

      <xsl:variable name="acronym">
        <xsl:call-template name="get-acronym-name">
          <xsl:with-param name="base_name" select="$attr_name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="subtable_name">
        <xsl:call-template name="to-lower">
          <xsl:with-param name="base_name" select="concat('sdc_', $object_name, '_', $acronym)"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="concat('DROP TABLE ', $subtable_name, ';', $cr)"/>

    </xsl:for-each> <!-- array attribute -->
  </xsl:for-each> <!-- persistent node -->
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('-- DO NOT USE QUIT OR EXIT (called from within another sql script)', $cr)"/>
</xsl:template> <!-- gen-sql-drop-file -->


<!--
!! TEMPLATE:     gen-global-header-file
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 28 August 2007
!! DESCRIPTION:  This template writes out structures that match the Oracle
!!               tables and can be used to interface with them.
-->
<xsl:template name="gen-global-header-file">

  <xsl:value-of select="concat('#ifndef __SDC_INCLUDE__', $cr)"/>
  <xsl:value-of select="concat('#define __SDC_INCLUDE__', $cr)"/>
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        sdc.h', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This file contains structures that match the format of the SDC', $cr)"/>
  <xsl:value-of select="concat(' *              Oracle tables. These structures can be used to perform group', $cr)"/>
  <xsl:value-of select="concat(' *              retrieves of data from those tables.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- for each constant within the protocol create a matching macro -->
  <xsl:value-of select="concat('#define SDC_MAX_DB_TEXT_TIME_LENGTH 19', $cr)"/>
  <xsl:for-each select="$constant_nodes">
    <xsl:value-of select="concat('#define SDC_', name(), ' ', @value, $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="$cr"/>

  <!-- For each object that is used by the SDC create the needed structures.
       A structure exists for the object and for any array attributes that
       are part of the object -->
  <xsl:for-each select="$persistent_nodes">

    <xsl:variable name="object_name" select="concat('SDC_', name())"/>
    <xsl:variable name="structure_name" select="concat($object_name, '_TABLE')"/>
    <xsl:variable name="lower_structure">
      <xsl:call-template name="to-lower">
        <xsl:with-param name="base_name" select="$structure_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('typedef struct ', $lower_structure, ' {', $cr)"/>
    <xsl:value-of select="concat('   char time[SDC_MAX_DB_TEXT_TIME_LENGTH+1];', $cr)"/>
    <xsl:value-of select="concat('   int sideView;', $cr)"/>

    <!-- Add a structure element for each of the object attributes. Some object
         attributes result in multiple Oracle columns and will therefore result
         in multiple structure elements  -->
    <xsl:for-each select="*/*[not(@array = 'variable' or name() = 'comment' or name() = 'computed')]">
      <xsl:variable name="attribute" select="name()"/>
      <xsl:variable name="attr_type" select="@type"/>

      <xsl:variable name="local_name">
        <xsl:call-template name="get-local-name">
          <xsl:with-param name="base_name" select="$attribute"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="sub_nodes">
        <xsl:call-template name="attribute-node-to-node-set"/>
      </xsl:variable>

      <xsl:for-each select="$sub_nodes/*">

        <xsl:variable name="c_type" >
          <xsl:call-template name="jdsp-node-to-c-type"/>
        </xsl:variable>

        <xsl:variable name="struct_name">
          <xsl:call-template name="get-compound-name">
            <xsl:with-param name="base_name" select="$local_name"/>
            <xsl:with-param name="child_name" select="name()"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="char_array">
          <xsl:if test="$c_type = 'char'">
            <xsl:variable name="length">
              <xsl:call-template name="find-db-column-width"/>
            </xsl:variable>
            <xsl:value-of select="concat('[SDC_', $length, '+1]')"/>
          </xsl:if>
        </xsl:variable>

        <xsl:value-of select="concat('   ', $c_type, ' ', $struct_name, $char_array, ';', $cr)"/>

      </xsl:for-each> <!-- sub node of the attribute -->
    </xsl:for-each> <!-- non-array attribute -->
    <xsl:value-of select="concat('} ', $structure_name, ';', $cr)"/>
    <xsl:value-of select="$cr"/>

    <!-- Create an indicator structure for this JODA object -->
    <xsl:variable name="indicator_name" select="concat($object_name, '_INDICATOR')"/>
    <xsl:variable name="lower_indicator">
      <xsl:call-template name="to-lower">
        <xsl:with-param name="base_name" select="$indicator_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('typedef struct ', $lower_indicator, ' {', $cr)"/>
    <xsl:value-of select="concat('   short time;', $cr)"/>
    <xsl:value-of select="concat('   short sideView;', $cr)"/>

    <!-- Add a structure element for each of the object attributes. Some object
         attributes result in multiple Oracle columns and will therefore result
         in multiple structure elements  -->
    <xsl:for-each select="*/*[not(@array = 'variable' or name() = 'comment' or name() = 'computed')]">
      <xsl:variable name="attribute" select="name()"/>
      <xsl:variable name="attr_type" select="@type"/>

      <xsl:variable name="local_name">
        <xsl:call-template name="get-local-name">
          <xsl:with-param name="base_name" select="$attribute"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="sub_nodes">
        <xsl:call-template name="attribute-node-to-node-set"/>
      </xsl:variable>

      <xsl:for-each select="$sub_nodes/*">

        <xsl:variable name="struct_name">
          <xsl:call-template name="get-compound-name">
            <xsl:with-param name="base_name" select="$local_name"/>
            <xsl:with-param name="child_name" select="name()"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="concat('   short ', $struct_name, ';', $cr)"/>

      </xsl:for-each> <!-- sub node of the attribute -->
    </xsl:for-each> <!-- non-array attribute -->
    <xsl:value-of select="concat('} ', $indicator_name, ';', $cr)"/>
    <xsl:value-of select="$cr"/>

    <!-- For each array attribute of the object create a table structure -->
    <xsl:for-each select="*/*[@array = 'variable']">
      <xsl:variable name="attribute" select="name()"/>
      <xsl:variable name="attr_type" select="@type"/>
      <xsl:variable name="local_name">
        <xsl:call-template name="get-local-name">
          <xsl:with-param name="base_name" select="$attribute"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="attr_acronym">
        <xsl:call-template name="get-acronym-name">
          <xsl:with-param name="base_name" select="$attribute"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="substruct_name" select="concat($object_name, '_', $attr_acronym, '_TABLE')"/>
      <xsl:variable name="lower_substruct_name">
        <xsl:call-template name="to-lower">
          <xsl:with-param name="base_name" select="$substruct_name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:value-of select="concat('typedef struct ', $lower_substruct_name, ' {', $cr)"/>
      <xsl:value-of select="concat('   int sideView;', $cr)"/>
      <xsl:value-of select="concat('   int idIndex;', $cr)"/>
      <xsl:value-of select="concat('   int sequenceNbr;', $cr)"/>
      <xsl:variable name="attribute_node">
        <xsl:call-template name="attribute-node-to-node-set"/>
      </xsl:variable>

      <xsl:for-each select="$attribute_node/*">

        <xsl:variable name="c_type" >
          <xsl:call-template name="jdsp-node-to-c-type"/>
        </xsl:variable>
        <xsl:variable name="struct_name">
          <xsl:call-template name="get-local-name">
            <xsl:with-param name="base_name" select="name()"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="c_length">
          <xsl:variable name="column_width">
            <xsl:call-template name="find-db-column-width"/>
          </xsl:variable>
          <xsl:if test="string-length($column_width) != 0">
            <xsl:value-of select="concat('[SDC_', $column_width, '+1]')"/>
          </xsl:if>
        </xsl:variable>

        <xsl:value-of select="concat('   ', $c_type, ' ', $struct_name, $c_length, ';', $cr)"/>
      </xsl:for-each>
      <xsl:value-of select="concat('} ', $substruct_name, ';', $cr)"/>
      <xsl:value-of select="$cr"/>

    </xsl:for-each> <!-- array attribute -->

    <!-- For each array attribute of the object create an indicator structure -->
    <xsl:for-each select="*/*[@array = 'variable']">
      <xsl:variable name="attribute" select="name()"/>
      <xsl:variable name="attr_type" select="@type"/>
      <xsl:variable name="local_name">
        <xsl:call-template name="get-local-name">
          <xsl:with-param name="base_name" select="$attribute"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="attr_acronym">
        <xsl:call-template name="get-acronym-name">
          <xsl:with-param name="base_name" select="$attribute"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="subindicator_name" select="concat($object_name, '_', $attr_acronym, '_INDICATOR')"/>
      <xsl:variable name="lower_subindicator_name">
        <xsl:call-template name="to-lower">
          <xsl:with-param name="base_name" select="$subindicator_name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:value-of select="concat('typedef struct ', $lower_subindicator_name, ' {', $cr)"/>
      <xsl:value-of select="concat('   short sideView;', $cr)"/>
      <xsl:value-of select="concat('   short idIndex;', $cr)"/>
      <xsl:value-of select="concat('   short sequenceNbr;', $cr)"/>
      <xsl:variable name="attribute_node">
        <xsl:call-template name="attribute-node-to-node-set"/>
      </xsl:variable>

      <xsl:for-each select="$attribute_node/*">

        <xsl:variable name="struct_name">
          <xsl:call-template name="get-local-name">
            <xsl:with-param name="base_name" select="name()"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="concat('   short ', $struct_name, ';', $cr)"/>
      </xsl:for-each>
      <xsl:value-of select="concat('} ', $subindicator_name, ';', $cr)"/>
      <xsl:value-of select="$cr"/>

    </xsl:for-each> <!-- array attribute -->

  </xsl:for-each> <!-- persistent_node -->
  <xsl:value-of select="concat('#endif /* not defined __SDC_INCLUDE__ */', $cr)"/>

</xsl:template> <!-- gen-global-header-file -->


<!--
!! TEMPLATE:     gen-makefile-srcfiles-file
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 15 May 2007
!! DESCRIPTION:  This template writes out the Makefile.srcfiles to
!!               aid the make.
-->
<xsl:template name="gen-makefile-srcfiles-file">

  <xsl:value-of select="concat('SRCFILES = object.pc \', $cr)"/>
  <xsl:for-each select="$persistent_nodes">
    <xsl:variable name="table_name" select="name()"/>

    <xsl:variable name="local_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat(' ', $local_name, '.pc \', $cr)"/>
  </xsl:for-each>

  <xsl:value-of select="$cr"/>

</xsl:template> <!-- gen-makefile-srcfiles-file -->


<!--
!! TEMPLATE:     gen-object-source-file
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 09 August 2007
!! DESCRIPTION:  This template writes out the object.c source file that serves
!!               as the top-level interface between the JODA and SDC.
-->
<xsl:template name="gen-object-source-file">

  <xsl:variable name="filename" select="'object.c'"/>
  <xsl:variable name="header" select="'object.h'"/>
  <xsl:variable name="initialize_function" select="'ObjectInitialize'"/>
  <xsl:variable name="translate_function" select="'ObjectNameToClass'"/>
  <xsl:variable name="bitmap_function" select="'ObjectGetBitMask'"/>
  <xsl:variable name="truncate_function" select="'ObjectTruncateTables'"/>
  <xsl:variable name="trun_single_function" select="'ObjectTruncateSpecificTable'"/>
  <xsl:variable name="empty_function" select="'ObjectEmptyTables'"/>
  <xsl:variable name="empty_single_function" select="'ObjectEmptySpecificTable'"/>
  <xsl:variable name="disable_function" select="'ObjectDisableConstraints'"/>
  <xsl:variable name="enable_function" select="'ObjectEnableConstraints'"/>

  <!-- Write out the general header information -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        ', $filename, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This file contains the source code to store, retrieve,', $cr)"/>
  <xsl:value-of select="concat(' *              update and convert objects received from the JDS. This file', $cr)"/>
  <xsl:value-of select="concat(' *              is automatically generated from a stylesheet. Any changes', $cr)"/>
  <xsl:value-of select="concat(' *              made directly to this file will be lost.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('#define __OBJECT_SOURCE__', $cr)"/>
  <xsl:value-of select="concat('#include &lt;stdlib.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &lt;string.h&gt;', $cr)"/>

  <!-- inlcude the header file for each type of object -->
  <xsl:for-each select="$persistent_nodes">
    <xsl:variable name="object_name" select="name()"/>

    <xsl:variable name="local_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="$object_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('#include &quot;', $local_name, '.h&quot;', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="concat('#include &quot;database.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;', $header, '&quot;', $cr)"/>
  <xsl:value-of select="concat('EXEC SQL INCLUDE SQLCA;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

  <!-- write the function that fills the ObjectTypeInfo array which is used
       by the rest of the SDC code to interact with the generated JODA object
       code -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $initialize_function, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function is responsible for initializing the data that', $cr)"/>
  <xsl:value-of select="concat(' *               is used to track and update objects. The function should', $cr)"/>
  <xsl:value-of select="concat(' *               only be called once.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('void ', $initialize_function, '( void ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   memset( ObjectTypeInfo, 0, sizeof( ObjectTypeInfo ) );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   ObjectTypeInfo[OBJECT_CLASS_INVALID].name = &quot;&quot;;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:for-each select="$persistent_nodes">
    <xsl:variable name="object_name" select="name()"/>

    <xsl:variable name="global_name">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="$object_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="array_position" select="concat('ObjectTypeInfo[OBJECT_CLASS_', $object_name, ']')"/>
    <xsl:value-of select="concat('   ', $array_position, '.name = &quot;', $object_name, '&quot;;', $cr)"/>
    <xsl:value-of select="concat('   ', $array_position, '.size = sizeof( ', $object_name, '_OBJECT );', $cr)"/>
    <xsl:value-of select="concat('   ', $array_position, '.update = ', $global_name, 'ProcessUpdate;', $cr)"/>
    <xsl:value-of select="concat('   ', $array_position, '.sqlGroupInsert = ', $global_name, 'InsertAll;', $cr)"/>
    <xsl:value-of select="concat('   ', $array_position, '.sqlInsert = ', $global_name, 'ObjectInsert;', $cr)"/>
    <xsl:value-of select="concat('   ', $array_position, '.sqlDelete = ', $global_name, 'ObjectRemove;', $cr)"/>
    <xsl:value-of select="concat('   ', $array_position, '.sqlUpdate = ', $global_name, 'StandardUpdate;', $cr)"/>
    <xsl:value-of select="concat('   ', $array_position, '.sqlDynamic = ', $global_name, 'DynamicUpdate;', $cr)"/>
    <xsl:value-of select="concat('   ', $array_position, '.sqlSingle = ', $global_name, 'SingleUpdate;', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each>

  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $initialize_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

  <!-- write the function that translates an object name from the ObjectTypeInfo
       array into an object class -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $translate_function, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function translates an object class name used by the SDC', $cr)"/>
  <xsl:value-of select="concat(' *               into an OBJECT_CLASS enumeration. If a matching name is not', $cr)"/>
  <xsl:value-of select="concat(' *               found then OBJECT_CLASS_INVALID is returned.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('OBJECT_CLASS ', $translate_function, '( const char *objName ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   OBJECT_CLASS objClass;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   for ( objClass = 0; objClass &lt; NUMBER_OF_PERSISTENT_OBJECT_CLASSES; objClass++ ) {', $cr)"/>
  <xsl:value-of select="concat('      if ( ! ObjectTypeInfo[objClass].name ) {', $cr)"/>
  <xsl:value-of select="concat('         continue;', $cr)"/>
  <xsl:value-of select="concat('      }', $cr)"/>
  <xsl:value-of select="concat('      if ( ! strcmp( objName, ObjectTypeInfo[objClass].name ) ) {', $cr)"/>
  <xsl:value-of select="concat('         return( objClass );', $cr)"/>
  <xsl:value-of select="concat('      }', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   return ( OBJECT_CLASS_INVALID );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $translate_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

  <!-- write out the function that takes a container and returns a bitmap of
       the fields that are updated in the container -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $bitmap_function, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function translates the updated fields within an object', $cr)"/>
  <xsl:value-of select="concat(' *               container into a bitmap which is then used by the SDC.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('char *', $bitmap_function, '( JEDI jedi, PERSISTENT_CONTAINER cont ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   int objClass = JEDI_GET_OBJECT_CLASS( jedi );', $cr)"/>
  <xsl:value-of select="concat('   char *maskField = malloc( sizeof( char[128] ) );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   BITFP_ALLOFF( maskField, sizeof( char[128] ) );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   switch ( objClass ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:for-each select="$persistent_nodes">
    <xsl:variable name="object_name" select="name()"/>

    <xsl:variable name="lower_name">
      <xsl:call-template name="get-object-name">
        <xsl:with-param name="base_name" select="$object_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('      case OBJECT_CLASS_', $object_name, ':', $cr)"/>
    <xsl:value-of select="concat('         return( get_', $lower_name, '_field_bits( (', $object_name, '_CONTAINER) cont, maskField ) );', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each>
  <xsl:value-of select="concat('      default:', $cr)"/>
  <xsl:value-of select="concat('        return( (char *) NULL );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   } /* end switch on JEDI Object Class */', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $bitmap_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Write out the function responsible for truncating all tables -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $truncate_function, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function is responsible for truncating all the tables', $cr)"/>
  <xsl:value-of select="concat(' *               used by the SDC database.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('void ', $truncate_function, '( void ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL WHENEVER SQLERROR DO DatabaseSqlError( );', $cr)"/>

  <xsl:for-each select="$persistent_nodes">
    <xsl:variable name="object_name" select="name()"/>

    <xsl:variable name="lower_name">
      <xsl:call-template name="get-object-name">
        <xsl:with-param name="base_name" select="$object_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="table_name" select="concat('sdc_', $lower_name)"/>
    <xsl:value-of select="concat('   EXEC SQL TRUNCATE TABLE ', $table_name, ';', $cr)"/>

    <!-- For each attribute that is an array truncate the child table -->
    <xsl:for-each select="*/*[@array = 'variable']">
      <xsl:variable name="attr_name" select="name()"/>

      <xsl:variable name="acronym">
        <xsl:call-template name="get-acronym-name">
          <xsl:with-param name="base_name" select="$attr_name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="subtable_name">
        <xsl:call-template name="to-lower">
          <xsl:with-param name="base_name" select="concat('sdc_', $object_name, '_', $acronym)"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="subindex_name" select="concat($subtable_name, '_i')"/>
      <xsl:value-of select="concat('   EXEC SQL TRUNCATE TABLE ', $subtable_name, ';', $cr)"/>

    </xsl:for-each> <!-- array attribute -->

  </xsl:for-each> <!-- persistent object -->
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   EXEC SQL COMMIT;', $cr)"/>
  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $truncate_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

  <!-- Write out the function responsible for truncating a specific table -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $trun_single_function, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function truncates a single table that is used by the', $cr)"/>
  <xsl:value-of select="concat(' *               SDC. It identifies the table by the object class enumeration.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('void ', $trun_single_function, '( OBJECT_CLASS objClass ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL WHENEVER SQLERROR DO DatabaseSqlError( );', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   switch ( objClass ) {', $cr)"/>
  <xsl:value-of select="concat('   ', $cr)"/>
  <xsl:for-each select="$persistent_nodes">
    <xsl:variable name="object_name" select="name()"/>

    <xsl:variable name="lower_name">
      <xsl:call-template name="get-object-name">
        <xsl:with-param name="base_name" select="$object_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="table_name" select="concat('sdc_', $lower_name)"/>

    <xsl:value-of select="concat('      case OBJECT_CLASS_', $object_name, ':', $cr)"/>
    <xsl:value-of select="concat('         EXEC SQL TRUNCATE TABLE ', $table_name, ';', $cr)"/>

    <!-- For each attribute that is an array truncate the child table -->
    <xsl:for-each select="*/*[@array = 'variable']">
      <xsl:variable name="attr_name" select="name()"/>

      <xsl:variable name="acronym">
        <xsl:call-template name="get-acronym-name">
          <xsl:with-param name="base_name" select="$attr_name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="subtable_name">
        <xsl:call-template name="to-lower">
          <xsl:with-param name="base_name" select="concat('sdc_', $object_name, '_', $acronym)"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="subindex_name" select="concat($subtable_name, '_i')"/>
      <xsl:value-of select="concat('         EXEC SQL TRUNCATE TABLE ', $subtable_name, ';', $cr)"/>

    </xsl:for-each> <!-- array attribute -->
    <xsl:value-of select="concat('         break;', $cr)"/>

  </xsl:for-each> <!-- persistent object -->
  <xsl:value-of select="concat('      default:', $cr)"/>
  <xsl:value-of select="concat('         break;', $cr)"/>
  <xsl:value-of select="concat('   } /* end switch on the object class */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   EXEC SQL COMMIT;', $cr)"/>
  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $trun_single_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

  <!-- Write out the function responsible for emptying all tables -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $empty_function, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function is responsible for emptying all the tables', $cr)"/>
  <xsl:value-of select="concat(' *               used by the SDC database of records with a specific side_view.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('void ', $empty_function, '( int sideView ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL WHENEVER SQLERROR DO DatabaseSqlError( );', $cr)"/>

  <xsl:for-each select="$persistent_nodes">
    <xsl:variable name="object_name" select="name()"/>

    <xsl:variable name="lower_name">
      <xsl:call-template name="get-object-name">
        <xsl:with-param name="base_name" select="$object_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="table_name" select="concat('sdc_', $lower_name)"/>
    <xsl:value-of select="concat('   EXEC SQL DELETE FROM ', $table_name, ' WHERE side_view = :sideView;', $cr)"/>

    <!-- For each attribute that is an array truncate the child table -->
    <xsl:for-each select="*/*[@array = 'variable']">
      <xsl:variable name="attr_name" select="name()"/>

      <xsl:variable name="acronym">
        <xsl:call-template name="get-acronym-name">
          <xsl:with-param name="base_name" select="$attr_name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="subtable_name">
        <xsl:call-template name="to-lower">
          <xsl:with-param name="base_name" select="concat('sdc_', $object_name, '_', $acronym)"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="subindex_name" select="concat($subtable_name, '_i')"/>
      <xsl:value-of select="concat('   EXEC SQL DELETE FROM ', $subtable_name, ' WHERE side_view = :sideView;', $cr)"/>

    </xsl:for-each> <!-- array attribute -->

  </xsl:for-each> <!-- persistent object -->
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   EXEC SQL COMMIT;', $cr)"/>
  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $empty_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

  <!-- Write out the function responsible for emptying the tables associated
       with a specific object class -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $empty_single_function, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function is responsible for emptying all records for', $cr)"/>
  <xsl:value-of select="concat(' *               a speciifc side_view from all tables associated with an', $cr)"/>
  <xsl:value-of select="concat(' *               object class.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('void ', $empty_single_function, '( OBJECT_CLASS objClass, int sideView ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL WHENEVER SQLERROR DO DatabaseSqlError( );', $cr)"/>

  <xsl:value-of select="concat('   switch ( objClass ) {', $cr)"/>
  <xsl:value-of select="concat('   ', $cr)"/>
  <xsl:for-each select="$persistent_nodes">
    <xsl:variable name="object_name" select="name()"/>

    <xsl:variable name="lower_name">
      <xsl:call-template name="get-object-name">
        <xsl:with-param name="base_name" select="$object_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="table_name" select="concat('sdc_', $lower_name)"/>

    <xsl:value-of select="concat('      case OBJECT_CLASS_', $object_name, ':', $cr)"/>
    <xsl:value-of select="concat('         EXEC SQL DELETE FROM ', $table_name, ' WHERE side_view = :sideView;', $cr)"/>

    <!-- For each attribute that is an array truncate the child table -->
    <xsl:for-each select="*/*[@array = 'variable']">
      <xsl:variable name="attr_name" select="name()"/>

      <xsl:variable name="acronym">
        <xsl:call-template name="get-acronym-name">
          <xsl:with-param name="base_name" select="$attr_name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="subtable_name">
        <xsl:call-template name="to-lower">
          <xsl:with-param name="base_name" select="concat('sdc_', $object_name, '_', $acronym)"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="subindex_name" select="concat($subtable_name, '_i')"/>
      <xsl:value-of select="concat('         EXEC SQL DELETE FROM ', $subtable_name, ' WHERE side_view = :sideView;', $cr)"/>

    </xsl:for-each> <!-- array attribute -->
    <xsl:value-of select="concat('         break;', $cr)"/>

  </xsl:for-each> <!-- persistent object -->
  <xsl:value-of select="concat('      default:', $cr)"/>
  <xsl:value-of select="concat('         break;', $cr)"/>
  <xsl:value-of select="concat('   } /* end switch on the object class */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   EXEC SQL COMMIT;', $cr)"/>
  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $empty_single_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

  <!-- Write out the function responsible for disabling all constraints -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $disable_function, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function is responsible for disabling constraints on', $cr)"/>
  <xsl:value-of select="concat(' *               all the tables used by the SDC database. This is done', $cr)"/>
  <xsl:value-of select="concat(' *               before downloading data from the JODA to speed up the', $cr)"/>
  <xsl:value-of select="concat(' *               download process.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('void ', $disable_function, '( void ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL WHENEVER SQLERROR CONTINUE;', $cr)"/>

  <xsl:for-each select="$persistent_nodes">
    <xsl:variable name="object_name" select="name()"/>

    <xsl:variable name="lower_name">
      <xsl:call-template name="get-object-name">
        <xsl:with-param name="base_name" select="$object_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="index_name" select="concat('sdc_', $lower_name, '_i')"/>

    <xsl:value-of select="concat('   EXEC SQL DROP INDEX ', $index_name, ';', $cr)"/>

    <!-- For each attribute that is an array truncate the child table -->
    <xsl:for-each select="*/*[@array = 'variable']">
      <xsl:variable name="attr_name" select="name()"/>

      <xsl:variable name="acronym">
        <xsl:call-template name="get-acronym-name">
          <xsl:with-param name="base_name" select="$attr_name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="subtable_name">
        <xsl:call-template name="to-lower">
          <xsl:with-param name="base_name" select="concat('sdc_', $object_name, '_', $acronym)"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="subindex_name" select="concat($subtable_name, '_i')"/>
      <xsl:value-of select="concat('   EXEC SQL DROP INDEX ', $subindex_name, ';', $cr)"/>

    </xsl:for-each> <!-- array attribute -->
  </xsl:for-each> <!-- persistent object -->
  <xsl:value-of select="concat('   EXEC SQL DROP INDEX sdc_combat_system_owner_i;', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL DROP INDEX sdc_supply_category_owner_i;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   EXEC SQL COMMIT;', $cr)"/>
  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $disable_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

  <!-- Write out the function responsible for enabling all constraints -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ', $enable_function, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function is responsible for enabling constraints on', $cr)"/>
  <xsl:value-of select="concat(' *               all the tables used by the SDC database. This is done', $cr)"/>
  <xsl:value-of select="concat(' *               after downloading to restore the constraints.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('void ', $enable_function, '( void ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL WHENEVER SQLERROR DO DatabaseSqlError( );', $cr)"/>

  <xsl:for-each select="$persistent_nodes">
    <xsl:variable name="object_name" select="name()"/>

    <xsl:variable name="lower_name">
      <xsl:call-template name="get-object-name">
        <xsl:with-param name="base_name" select="$object_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="table_name" select="concat('sdc_', $lower_name)"/>
    <xsl:variable name="index_name" select="concat('sdc_', $lower_name, '_i')"/>

    <xsl:value-of select="concat('   EXEC SQL CREATE UNIQUE INDEX ', $index_name, ' ON ', $table_name, '(side_view, id_index);', $cr)"/>

    <!-- For each attribute that is an array truncate the child table -->
    <xsl:for-each select="*/*[@array = 'variable']">
      <xsl:variable name="attr_name" select="name()"/>

      <xsl:variable name="acronym">
        <xsl:call-template name="get-acronym-name">
          <xsl:with-param name="base_name" select="$attr_name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="subtable_name">
        <xsl:call-template name="to-lower">
          <xsl:with-param name="base_name" select="concat('sdc_', $object_name, '_', $acronym)"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="subindex_name" select="concat($subtable_name, '_i')"/>
      <xsl:value-of select="concat('   EXEC SQL CREATE UNIQUE INDEX ', $subindex_name, ' ON ', $subtable_name, '(side_view, id_index, sequence_number);', $cr)"/>

    </xsl:for-each> <!-- array attribute -->
  </xsl:for-each> <!-- persistent object -->
  <xsl:value-of select="concat('   EXEC SQL CREATE INDEX sdc_combat_system_owner_i ON sdc_combat_system(unit_index);', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL CREATE INDEX sdc_supply_category_owner_i ON sdc_supply_category(owning_unit_index);', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   EXEC SQL COMMIT;', $cr)"/>
  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $enable_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- gen-object-source-file -->


<!--
!! TEMPLATE:     gen-object-header-file
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 09 August 2007
!! DESCRIPTION:  This template writes out the object.h header file that defines
!!               the structures, macros, and variables used by object.c. The only
!!               dynamic portion of this file is the length macros which are
!!               taken from the jdsp constants.
-->
<xsl:template name="gen-object-header-file">

  <xsl:variable name="filename" select="'object.h'"/>
  <xsl:variable name="sourcefile" select="'object.c'"/>
  <xsl:variable name="inc_macro" select="'_SDC_OBJECT_INC'"/>

  <xsl:value-of select="concat('#ifndef ', $inc_macro, $cr)"/>
  <xsl:value-of select="concat('#define ', $inc_macro, $cr)"/>
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        ', $filename, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This file is the header file for the ', $sourcefile, ' source', $cr)"/>
  <xsl:value-of select="concat(' *              file. This file defines the functions, macros, and external', $cr)"/>
  <xsl:value-of select="concat(' *              variables used by ', $sourcefile, '. This file', $cr)"/>
  <xsl:value-of select="concat(' *              is automatically generated from a stylesheet. Any changes', $cr)"/>
  <xsl:value-of select="concat(' *              made directly to this file will be lost.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_enumerations.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_bit_field.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_types.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;sdr/sdc.h&quot;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('/* The following macro is used for inserting multiple records of the same', $cr)"/>
  <xsl:value-of select="concat('   type into a table with one statement */', $cr)"/>
  <xsl:value-of select="concat('#define OBJECT_GROUP_SIZE 500', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('/* The following macro defines the maximum string size we expect when', $cr)"/>
  <xsl:value-of select="concat('   performing a dynamic update */', $cr)"/>
  <xsl:value-of select="concat('#define OBJECT_DYNAMIC_STRING_LEN 4095', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('/* Define a variable to loop on reading Joda messages. This is the maximum', $cr)"/>
  <xsl:value-of select="concat('   number of Joda messages we will read before checking for user input. Also,', $cr)"/>
  <xsl:value-of select="concat('   if we are in group update mode, this is the maximum number of updates we', $cr)"/>
  <xsl:value-of select="concat('   will store before processing */', $cr)"/>
  <xsl:value-of select="concat('#define OBJECT_MAX_PROCESSED 500', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('/* The ObjectIndex typedef is used to store the index for an object */', $cr)"/>
  <xsl:value-of select="concat('typedef unsigned int ObjectIndex;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('/* The OBJECT_ANY structure gives the head information shared by all object', $cr)"/>
  <xsl:value-of select="concat('   types. We can cast any object type to this value to examine its head', $cr)"/>
  <xsl:value-of select="concat('   information */', $cr)"/>
  <xsl:value-of select="concat('typedef struct object_any {', $cr)"/>
  <xsl:value-of select="concat('   char  time[SDC_MAX_DB_TEXT_TIME_LENGTH+1]; /* Game time of last update */', $cr)"/>
  <xsl:value-of select="concat('   int   sideView;             /* JTLS side index that knows this object */', $cr)"/>
  <xsl:value-of select="concat('   int   idIndex;              /* SAID index for the object */', $cr)"/>
  <xsl:value-of select="concat('   char  idType[SDC_MAX_DATA_TYPE_LENGTH+1]; /* Text type of the object */', $cr)"/>
  <xsl:value-of select="concat('} OBJECT_ANY;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('/* The OBJECT_INFO structure contains information about each of the', $cr)"/>
  <xsl:value-of select="concat('   object types, such as the size of the structure and the functions to', $cr)"/>
  <xsl:value-of select="concat('   perform inserts and updates */', $cr)"/>
  <xsl:value-of select="concat('typedef void (*ObjectUpdateProc)( BIT_FIELD_128, PERSISTENT_CONTAINER, OBJECT_ANY * );', $cr)"/>
  <xsl:value-of select="concat('typedef int  (*ObjectSqlProc)( OBJECT_ANY * );', $cr)"/>
  <xsl:value-of select="concat('typedef int  (*ObjectDownloadProc)( void );', $cr)"/>
  <xsl:value-of select="concat('typedef int  (*ObjectSqlUpdate)( int, OBJECT_ANY *, BIT_FIELD_128 );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('typedef struct object_info {', $cr)"/>
  <xsl:value-of select="concat('   char *name;                     /* Text name of type of object */', $cr)"/>
  <xsl:value-of select="concat('   size_t size;                    /* Size of the corresponding obj structure */', $cr)"/>
  <xsl:value-of select="concat('   ObjectUpdateProc update;        /* Function to process a GDS update/create', $cr)"/>
  <xsl:value-of select="concat('                                      and transfer the data to the local', $cr)"/>
  <xsl:value-of select="concat('                                      structure */', $cr)"/>
  <xsl:value-of select="concat('   ObjectDownloadProc sqlGroupInsert; /* Function to insert all objects of this', $cr)"/>
  <xsl:value-of select="concat('                                      type into the proper oracle table */', $cr)"/>
  <xsl:value-of select="concat('   ObjectSqlProc sqlInsert;        /* Function to insert a single object of this', $cr)"/>
  <xsl:value-of select="concat('                                      type into the proper oracle table */', $cr)"/>
  <xsl:value-of select="concat('   ObjectSqlProc sqlDelete;        /* Function to delete a single object of this', $cr)"/>
  <xsl:value-of select="concat('                                      type from the proper oracle table */', $cr)"/>
  <xsl:value-of select="concat('   ObjectSqlUpdate sqlUpdate;      /* Function to update a single object of this', $cr)"/>
  <xsl:value-of select="concat('                                      type using individual update statements */', $cr)"/>
  <xsl:value-of select="concat('   ObjectSqlUpdate sqlDynamic;     /* Function to update a single object of', $cr)"/>
  <xsl:value-of select="concat('                                      this type using a dynamic SQL statement */', $cr)"/>
  <xsl:value-of select="concat('   ObjectSqlUpdate sqlSingle;      /* Function to update all columns of an', $cr)"/>
  <xsl:value-of select="concat('                                      object (except the ID columns) using a', $cr)"/>
  <xsl:value-of select="concat('                                      single SQL statement */', $cr)"/>
  <xsl:value-of select="concat('} OBJECT_INFO;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('#ifdef __OBJECT_SOURCE__', $cr)"/>
  <xsl:value-of select="concat('#define __OBJECT_TYPE', $cr)"/>
  <xsl:value-of select="concat('#define __OBJECT_INIT(x) = x', $cr)"/>
  <xsl:value-of select="concat('#else', $cr)"/>
  <xsl:value-of select="concat('#define __OBJECT_TYPE extern', $cr)"/>
  <xsl:value-of select="concat('#define __OBJECT_INIT(x)', $cr)"/>
  <xsl:value-of select="concat('#endif', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('__OBJECT_TYPE void ObjectInitialize( void );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE OBJECT_CLASS ObjectNameToClass( const char * );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE char *ObjectGetBitMask( JEDI, PERSISTENT_CONTAINER );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE void ObjectTruncateTables( void );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE void ObjectTruncateSpecificTable( OBJECT_CLASS );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE void ObjectEmptyTables( int );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE void ObjectEmptySpecificTable( OBJECT_CLASS, int );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE void ObjectDisableConstraints( void );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE void ObjectEnableConstraints( void );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('__OBJECT_TYPE int ObjectUpdatesProcessed __OBJECT_INIT( 0 );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE int ObjectDeletesProcessed __OBJECT_INIT( 0 );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE int ObjectInsertsProcessed __OBJECT_INIT( 0 );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE int ObjectPacketsProcessed __OBJECT_INIT( 0 );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE OBJECT_INFO ObjectTypeInfo[NUMBER_OF_PERSISTENT_OBJECT_CLASSES+1];', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('#endif /* ', $inc_macro, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- gen-object-header-file -->


<!--
!! TEMPLATE:     remove-us-id
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 7 November 2006
!! DESCRIPTION:  This template takes a string with an '_id' suffix and
!!               removes it.
-->
<xsl:template name="remove-us-id">
  <xsl:param name="base_name"/>

  <xsl:choose>
    <xsl:when test="contains($base_name, '_id')">
      <xsl:value-of select="substring-before($base_name, '_id')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$base_name"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template> <!-- remove-us-id -->


<!--
!! TEMPLATE:     find-vocabulary-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 29 September 2006
!! DESCRIPTION:  This template expects the current path to be pointing to a
!!               common knowledge subitem (an attribute) of an object. The
!!               template determines the vocabulary that might be associated
!!               with the attribute. If there is no associated template then
!!               the value is "". Otherwise, it will be the vocabulary name.
!!               Vocabularies may be a variable of the attribute or may be
!!               a variable of the attribute's type (enumeration or typedef).
!!               All places must be checked.
-->
<xsl:template name="find-vocabulary-name">

  <xsl:choose>
    <xsl:when test="not(string-length(@vocab) = 0)">
      <xsl:value-of select="@vocab"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="type" select="@type"/>
      <xsl:variable name="enum_count" select="count($enumerated_nodes[name()=$type])"/>
      <xsl:choose>
        <xsl:when test="$enum_count != 0">
          <xsl:value-of select="$enumerated_nodes[name()=$type]/@vocab"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$typedef_nodes[name() = $type]/@vocab"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- find-vocabulary-name -->


<!--
!! TEMPLATE:     find-db-column-width
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 10 May 2007
!! DESCRIPTION:  This template expects the current path to be pointing to a
!!               common knowledge subitem (an attribute) of an object. The
!!               template determines the max length that might be associated
!!               with the attribute. If there is no associated template then
!!               the value is "". Otherwise, it will be the max length name.
!!               Max lengths may be a variable of the attribute or a variable
!!               of the attirbute's type (enumeration or typedef). All places
!!               must be checked.
-->
<xsl:template name="find-db-column-width">

  <xsl:choose>
    <xsl:when test="not(string-length(@db-column-width) = 0)">
      <xsl:value-of select="@db-column-width"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="type" select="@type"/>
      <xsl:variable name="enum_count" select="count($enumerated_nodes[name()=$type])"/>
      <xsl:choose>
        <xsl:when test="$type = 'TIME'">
          <xsl:value-of select="'MAX_DB_TEXT_TIME_LENGTH'"/>
        </xsl:when>
        <xsl:when test="$enum_count != 0">
          <xsl:value-of select="$enumerated_nodes[name()=$type]/@db-column-width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$typedef_nodes[name() = $type]/@db-column-width"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- find-db-column-width -->


<!--
!! TEMPLATE:     find-jedi-db-column-width
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 11 May 2007
!! DESCRIPTION:  This template expects the current path to be pointing to a
!!               common knowledge subitem (an attribute) of an object. The
!!               template determines jedi max length that might be associated
!!               with the attribute. If there is no associated template then
!!               the value is "". Otherwise, it will be jedi max length name.
!!               Jedi max length may be a variable of the attribute or may be
!!               a variable of the attirbutes type. Both places must be checked.
-->
<xsl:template name="find-jedi-db-column-width">

  <xsl:choose>
    <xsl:when test="not(string-length(@db-column-width) = 0)">
      <xsl:value-of select="@db-column-width"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="type" select="@type"/>
      <xsl:for-each select="$typedef_nodes[name()=$type]">
        <xsl:if test="not(string-length(@db-column-width) = 0)">
          <xsl:value-of select="@db-column-width"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- find-jedi-db-column-width -->


<!--
!! TEMPLATE:     jdsp-node-to-c-type
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 16 August 2007
!! DESCRIPTION:  This template expects the path to be at an attribute node. It
!!               examines the node to determine the equivalent C type for the
!!               SDC. If the attribute is a structure (including a JEDI) the
!!               returned type is blank.
-->
<xsl:template name="jdsp-node-to-c-type">

  <xsl:variable name="type" select="@type"/>
  <xsl:variable name="vocab_name">
    <xsl:call-template name="find-db-column-width"/>
  </xsl:variable>

  <!-- Determine the attribute type. -->

  <xsl:choose>
    <xsl:when test="$type = 'REAL_32'">
      <xsl:value-of select="'float'"/>
    </xsl:when>

    <xsl:when test="$type = 'STRING' or $type = 'SHARED_STRING' or $type = 'TIME'">
      <xsl:value-of select="'char'"/>
    </xsl:when>

    <xsl:when test="string-length($vocab_name) > 0">
      <xsl:value-of select="'char'"/>
    </xsl:when>

    <xsl:when test="count($structure_nodes[name() = $type]) > 0">
      <xsl:value-of select="''"/>
    </xsl:when>

    <xsl:otherwise> <!-- must be an enumerated type -->
      <xsl:value-of select="'int'"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- jdsp-node-to-c-type -->


<!--
!! TEMPLATE:     jdsp-node-to-c-output-type
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 16 August 2007
!! DESCRIPTION:  This template expects the path to be at an attribute node. It
!!               examines the node to determine the equivalent C output type.
!!               If the attribute is a structure (including a JEDI) the
!!               returned type is blank.
-->
<xsl:template name="jdsp-node-to-c-output-type">

  <xsl:variable name="type" select="@type"/>
  <xsl:variable name="vocab_name">
    <xsl:call-template name="find-db-column-width"/>
  </xsl:variable>

  <!-- Determine the attribute type. -->

  <xsl:choose>
    <xsl:when test="$type = 'REAL_32'">
      <xsl:value-of select="'f'"/>
    </xsl:when>

    <xsl:when test="$type = 'STRING' or $type = 'SHARED_STRING' or $type = 'TIME'">
      <xsl:value-of select="'s'"/>
    </xsl:when>

    <xsl:when test="string-length($vocab_name) > 0">
      <xsl:value-of select="'s'"/>
    </xsl:when>

    <xsl:when test="count($structure_nodes[name() = $type]) > 0">
      <xsl:value-of select="''"/>
    </xsl:when>

    <xsl:otherwise> <!-- must be an enumerated type -->
      <xsl:value-of select="'d'"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- jdsp-node-to-c-output-type -->


<!--
!! TEMPLATE:     jdsp-node-to-sql-type
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 16 August 2007
!! DESCRIPTION:  This template expects the path to be at an attribute node. It
!!               examines the node to determine the equivalent SQL type for the
!!               SDC. If the attribute is a structure (including a JEDI) the
!!               returned type is blank.
-->
<xsl:template name="jdsp-node-to-sql-type">

  <xsl:variable name="type" select="@type"/>
  <xsl:variable name="vocab_name">
    <xsl:call-template name="find-db-column-width"/>
  </xsl:variable>

  <!-- Determine the attribute type. -->

  <xsl:choose>
    <xsl:when test="$type = 'REAL_32'">
      <xsl:value-of select="'FLOAT'"/>
    </xsl:when>

    <xsl:when test="$type = 'STRING' or $type = 'SHARED_STRING'">
      <xsl:value-of select="'VARCHAR2'"/>
    </xsl:when>

    <xsl:when test="string-length($vocab_name) > 0">
      <xsl:value-of select="'VARCHAR2'"/>
    </xsl:when>

    <xsl:when test="count($structure_nodes[name() = $type]) > 0">
      <xsl:value-of select="''"/>
    </xsl:when>

    <xsl:otherwise> <!-- must be an enumerated type -->
      <xsl:value-of select="'NUMBER(10)'"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- jdsp-node-to-sql-type -->


<!--
!! TEMPLATE:     attribute-node-to-node-set
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 16 August 2007
!! DESCRIPTION:  This template expects the path to be at an attribute node. If
!!               the attribute is a simple node it returns the node. If the
!!               attribute is a structure it returns the node set of the
!!               structure's attributes.
-->
<xsl:template name="attribute-node-to-node-set">

  <xsl:variable name="type" select="@type"/>
  <xsl:choose>
    <xsl:when test="count($structure_nodes[name() = $type]) > 0">
      <xsl:copy-of select="$structure_nodes[name() = $type]/*[name() != 'description']"/>
    </xsl:when>

    <xsl:otherwise> <!-- must be a simple type -->
      <xsl:copy-of select="."/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- attribute-node-to-node-set -->


<!--
!! TEMPLATE:     to-lower
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 16 August 2007
!! DESCRIPTION:  This template takes a string and switches all characters
!!               to lower case.
-->
<xsl:template name="to-lower">
  <xsl:param name="base_name"/>
  <xsl:value-of select="translate($base_name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
</xsl:template> <!-- to-lower -->


<!--
!! TEMPLATE:     to-upper
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 2 August 2006
!! DESCRIPTION:  This template takes a string and capitalizes all characters
!!               in the string.
-->
<xsl:template name="to-upper">
  <xsl:param name="base_name"/>
  <xsl:value-of select="translate($base_name, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
</xsl:template> <!-- to-upper -->


<!--
!! TEMPLATE:     get-global-name-us
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 3 August 2006
!! DESCRIPTION:  This template gets the global variable name used for the object
!!               or attribute and keeps the underscore. An example is an object of
!!               AIR_MISSION which has a global name of Air_Mission.
-->
<xsl:template name="get-global-name-us">
  <xsl:param name="base_name"/>

  <xsl:choose>
    <xsl:when test="contains($base_name, '_')">
      <xsl:variable name="first" select="substring-before($base_name, '_')"/>
      <xsl:variable name="first_letter" select="substring($first, 1, 1)"/>
      <xsl:variable name="f_other_letters" select="substring($first, 2)"/>
      <xsl:variable name="f_rest" select="translate($f_other_letters, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
      <xsl:variable name="next" select="substring-after($base_name, '_')"/>

      <xsl:variable name="final">
        <xsl:call-template name="get-global-name-us">
          <xsl:with-param name="base_name" select="$next"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:value-of select="concat($first_letter,$f_rest,'_',$final)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="f_letter" select="substring($base_name, 1, 1)"/>
      <xsl:variable name="f_o_letters" select="substring($base_name, 2)"/>
      <xsl:variable name="f_r" select="translate($f_o_letters, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
      <xsl:value-of select="concat($f_letter, $f_r)"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template> <!-- get-global-name-us -->


<!--
!! TEMPLATE:     get-compound-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 17 August 2007
!! DESCRIPTION:  This template creates a local name for a compound attribute.
!!               If the two names match, then the base attribute is assumed to
!!               be a simple type rather than a structure and the name is
!!               returned. Otherwise the child name is appended to the base
!!               name and the result returned.
-->
<xsl:template name="get-compound-name">
  <xsl:param name="base_name"/>
  <xsl:param name="child_name"/>

  <xsl:variable name="child_local">
    <xsl:call-template name="get-local-name">
      <xsl:with-param name="base_name" select="$child_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$base_name = $child_local">
      <xsl:value-of select="$base_name"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="child_global">
        <xsl:call-template name="get-global-name">
           <xsl:with-param name="base_name"  select="$child_name"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="concat($base_name, $child_global)"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- get-compound-name -->


<!--
!! TEMPLATE:     get-compound-sql-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 17 August 2007
!! DESCRIPTION:  This template creates an SQL name for a compound attribute.
!!               If the two names match, then the base attribute is assumed to
!!               be a simple type rather than a structure and the name is
!!               returned. Otherwise the child name is appended to the base
!!               name and the result returned.
-->
<xsl:template name="get-compound-sql-name">
  <xsl:param name="base_name"/>
  <xsl:param name="child_name"/>

  <xsl:choose>
    <xsl:when test="$base_name = $child_name">
      <xsl:value-of select="$base_name"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="com_name">
        <xsl:call-template name="remove-us-id">
          <xsl:with-param name="base_name" select="$base_name"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="concat($com_name, '_', $child_name)"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- get-compound-sql-name -->


<!--
!! TEMPLATE:     get-compound-extension
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 17 August 2007
!! DESCRIPTION:  This template creates an array extension for accessing the
!!               JDSP attribute. If the two parameters are equal then no array
!!               extension exists. Otherwise, the child_name is used as the
!!               array extension.
-->
<xsl:template name="get-compound-extension">
  <xsl:param name="base_name"/>
  <xsl:param name="child_name"/>

  <xsl:choose>
    <xsl:when test="$base_name = $child_name">
      <xsl:value-of select="''"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="concat('.', $child_name)"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- get-compound-extension -->


<!--
!! TEMPLATE:     get-object-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This template gets the name used within the code for an object.
!!               This consists of the object name in lower case.
-->
<xsl:template name="get-object-name">
   <xsl:param name="base_name"/>

   <xsl:value-of select="translate($base_name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
</xsl:template> <!-- get-object-name -->


<!--
!! TEMPLATE:     get-acronym-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 04 January 2007
!! DESCRIPTION:  This template gets the acronym name used for the object or
!!               attribute. An example is an object of AIR_MISSION_EVENT
!!               which has an acronym name of AME.
-->
<xsl:template name="get-acronym-name">
   <xsl:param name="base_name"/>

   <xsl:variable name="macro_name">
      <xsl:call-template name="to-upper">
         <xsl:with-param name="base_name" select="$base_name"/>
      </xsl:call-template>
   </xsl:variable>

   <xsl:variable name="first" select="substring($macro_name, 1, 1)"/>

   <xsl:variable name="result">
      <xsl:if test="contains($macro_name, '_')">
         <xsl:call-template name="get-acronym-name">
            <xsl:with-param name="base_name" select="substring-after($macro_name, '_')"/>
         </xsl:call-template>
      </xsl:if>
   </xsl:variable>

   <xsl:value-of select="concat($first, $result)"/>

</xsl:template> <!-- get-acronym-name -->


<!--
!! TEMPLATE:     get-local-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This template gets the local variable name used for the object
!!               or attribute. An example is an object of AIR_MISSION which has
!!               a local name of airMission.
-->
<xsl:template name="get-local-name">
  <xsl:param name="base_name"/>

  <xsl:variable name="object_name">
    <xsl:call-template name="get-object-name">
      <xsl:with-param name="base_name" select="$base_name"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="local_name">
    <xsl:call-template name="remove-underscores">
      <xsl:with-param name="base_name" select="$object_name"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:value-of select="$local_name"/>
</xsl:template> <!-- get-local-name -->


<!--
!! TEMPLATE:     get-global-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This template gets the global variable name used for the object
!!               or attribute. An example is an object of AIR_MISSION which has
!!               a global name of AirMission.
-->
<xsl:template name="get-global-name">
   <xsl:param name="base_name"/>

   <xsl:variable name="local_name">
      <xsl:call-template name="get-local-name">
         <xsl:with-param name="base_name" select="$base_name"/>
      </xsl:call-template>
   </xsl:variable>
   <xsl:variable name="first_raw" select="substring($local_name, 1, 1)"/>
   <xsl:variable name="first" select="translate($first_raw, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
   <xsl:variable name="last" select="substring($local_name, 2)"/>
   <xsl:value-of select="concat($first, $last)"/>
</xsl:template> <!-- get-global-name -->


<!--
!! TEMPLATE:     remove-underscores
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This template removes underscores from the passed in parameter
!!               and capitalizes the first letter after each underscore. This
!!               is a recursive call so all underscores will be affected. As
!!               an example air_mission_event becomes airMissionEvent.
-->
<xsl:template name="remove-underscores">
  <xsl:param name="base_name"/>

  <xsl:choose>
    <xsl:when test="contains($base_name, '_')">
      <xsl:variable name="first" select="substring-before($base_name, '_')"/>
      <xsl:variable name="end" select="substring-after($base_name, '_')"/>
      <xsl:variable name="middle_lower" select="substring($end, 1, 1)"/>
      <xsl:variable name="middle" select="translate($middle_lower, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
      <xsl:variable name="last" select="substring($end, 2)"/>
      <xsl:variable name="final">
        <xsl:call-template name="remove-underscores">
          <xsl:with-param name="base_name" select="concat($first, $middle, $last)"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="$final"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$base_name"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template> <!-- remove-underscores -->

</xsl:stylesheet>
