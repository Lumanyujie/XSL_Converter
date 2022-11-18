<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://saxon.sf.net/">

<!-- This stylesheet procedure is used to verify the structure of an imt screen
     file. The following checks are made:
     1) The table/@id attribute matches the name of the file, which is passed
        in. The attribute is permitted to have an additional _Screen appended
        to it.
     2) The types/data/@value attributes refer to valid JDSP persistent objects
     3) The leading portions of the tc/@query are existing JDSP attributes for
        at least one of the types/data/@value JDSP objects. By leading portion
        we mean support_unit_id in the query support_unit_id.caliber. We have
        no way to check the second portion since we don't know what type of
        object support_unit_id references.
     4) The leading portions of the filter/@name attributes are existing
        JDSP attributes for each of the types/data/@value JDSP objects.
     5) If attributes tc/@query and filter/@name has a trailing portion, then
        the leading portion must be a JEDI attribute if it exists with a
        types/data/@value JDSP object.
     6) match/qb/@query attribute must also pass checks 3 & 5
     7) Attributes filter/@vocab references a valid vocabulary group in either
        the static of dynamic vocabulary files
     8) Attributes filter/exclude/data/@value must be valid entries in the
        filter/@vocab group.
     9) If filter/exclude/data nodes exists the filter/@vocab must be a static
        vocab group
     10) Attributes tc/render/@value must reference a valid vocabulary group if
        tc/render/@type is vocabulary.
     11) Attributes quick/@screen must reference an IMT screen file of the same
        name, or a name that matches if a trailing _Screen is removed.
     12) Attributes tc/@searchable must be there and have its value of 'true' or 'false'.
     13) Attributes tc/@locked. if locked='true', they must be at the bigins of the list of cols.

-->
<xsl:param name="jtlshome" select="'/home/jtlsdev'"/>
<xsl:param name="filename"/>

<xsl:output method="text"/>

<!-- directory structure variables -->
<xsl:variable name="gdata_home" select="concat($jtlshome, '/game/data/')"/>
<xsl:variable name="imt_home" select="concat($jtlshome, '/game/data/imt/')"/>
<xsl:variable name="jdsp_home" select="concat($jtlshome, '/include/jdsp/')"/>

<!-- Tree fragments from other files -->
<xsl:variable name="jdsp_file" select="concat($jdsp_home, '/jds_protocol.xml')"/>
<xsl:variable name="jdsp_fragment" select="document($jdsp_file)"/>
<xsl:variable name="jdsp_persistent_nodes" select="$jdsp_fragment//simulation-data/persistent/*"/>
<xsl:variable name="static_file" select="concat($gdata_home, '/static_voc.xml')"/>
<xsl:variable name="static_fragment" select="document($static_file)"/>
<xsl:variable name="dynamic_file" select="concat($gdata_home, '/dynamic_voc.xml')"/>
<xsl:variable name="dynamic_fragment" select="document($dynamic_file)"/>
<xsl:variable name="vocab_nodes" select="$static_fragment/static.voc/* | $dynamic_fragment/dynamic.voc/*"/>
<xsl:variable name="static_nodes" select="$static_fragment/static.voc/*"/>

<!-- Node segments from this file -->
<xsl:variable name="datatypes" select="/table/types/data"/>

<!-- new line text variables -->
<xsl:variable name="cr">
<xsl:text>
</xsl:text>
</xsl:variable>

<!--
!! TEMPLATE:    match /table
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template checks the XML file from the top level. All
!!              other checks are invoked from here.
-->
<xsl:template match="/table">

  <!-- 1 - table/@id attribute matches the name of the file, which is passed
       in. The attribute is permitted to have an additional _Screen appended
       to it. -->
  <xsl:variable name="table_name" select="@id"/>
  <xsl:variable name="table_short">
    <xsl:choose>
      <xsl:when test="contains($table_name, '_Screen')">
        <xsl:value-of select="substring-before($table_name, '_Screen')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$table_name"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:if test="not($table_short = substring-before($filename, '.xml'))">
    <xsl:call-template name="print-error">
      <xsl:with-param name="tagname" select="'table/@id'"/>
      <xsl:with-param name="tagvalue" select="$table_name"/>
      <xsl:with-param name="errortext" select="concat('does not match filename: ', $filename)"/>
    </xsl:call-template>
  </xsl:if>

  <!-- 2 - types/data/@value attributes refer to valid JDSP persistent
       objects -->
  <xsl:for-each select="$datatypes">
    <xsl:variable name="object_type" select="@value"/>
    <xsl:variable name="object_exists">
      <xsl:call-template name="check-jdsp-type">
        <xsl:with-param name="jdsp_object" select="$object_type"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="$object_exists = 'false'">
      <xsl:call-template name="print-error">
        <xsl:with-param name="tagname" select="'types/data/@value'"/>
        <xsl:with-param name="tagvalue" select="$object_type"/>
        <xsl:with-param name="errortext" select="'references an unknown JDSP object'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:for-each>

  <!-- Create a comma separated list of JDSP object types. We will use this
       list in other checks -->
  <xsl:variable name="jdsp_object_type_list">
    <xsl:call-template name="jdsp-object-nodes-to-name-list">
      <xsl:with-param name="jdsp_object_nodes" select="$datatypes"/>
    </xsl:call-template>
  </xsl:variable>

  <!-- 3 - leading portions of the tc/@query are existing JDSP attributes for
       at least one of the types/data/@value JDSP objects.
       5 - tc/@query and filter/@name has a trailing portion, then
       the leading portion must be a JEDI attribute -->
  <xsl:for-each select="//tc">
    <xsl:variable name="attr_name" select="@query"/>
    <xsl:variable name="attr_is_used">
      <xsl:call-template name="check-jdsp-attribute-usage">
        <xsl:with-param name="jdsp_object_list" select="$jdsp_object_type_list"/>
        <xsl:with-param name="jdsp_attribute" select="$attr_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="$attr_is_used = 'false'">
      <xsl:call-template name="print-error">
        <xsl:with-param name="tagname" select="'tc/@query'"/>
        <xsl:with-param name="tagvalue" select="$attr_name"/>
        <xsl:with-param name="errortext" select="concat('references an unknown attribute for all JDSP objects ',  $jdsp_object_type_list)"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:for-each>

  <xsl:for-each select="$datatypes">
    <xsl:variable name="object_type" select="@value"/>
    <xsl:for-each select="//tc">
      <xsl:variable name="attr_name" select="@query"/>
      <xsl:variable name="attr_jedi_check">
        <xsl:call-template name="check-jdsp-jedi">
          <xsl:with-param name="jdsp_object" select="$object_type"/>
          <xsl:with-param name="jdsp_attribute" select="$attr_name"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$attr_jedi_check = 'false'">
        <xsl:call-template name="print-error">
          <xsl:with-param name="tagname" select="'tc/@query'"/>
          <xsl:with-param name="tagvalue" select="$attr_name"/>
          <xsl:with-param name="errortext" select="concat('is a compound reference but the first part is not a JEDI for JDSP object ',  $object_type)"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:for-each>
  </xsl:for-each>

  <!-- 4 - leading portions of the filter/@name attributes are existing
       JDSP attributes for each of the types/data/@value JDSP objects.
       5 - tc/@query and filter/@name has a trailing portion, then
       the leading portion must be a JEDI attribute -->
  <xsl:for-each select="$datatypes">
    <xsl:variable name="object_type" select="@value"/>
    <xsl:for-each select="//filter">
      <xsl:variable name="attr_name" select="@name"/>
      <xsl:variable name="attr_exists">
        <xsl:call-template name="check-jdsp-attribute">
          <xsl:with-param name="jdsp_object" select="$object_type"/>
          <xsl:with-param name="jdsp_attribute" select="$attr_name"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$attr_exists = 'false'">
          <xsl:call-template name="print-error">
            <xsl:with-param name="tagname" select="'filter/@name'"/>
            <xsl:with-param name="tagvalue" select="$attr_name"/>
            <xsl:with-param name="errortext" select="concat('references an unknown attribute for JDSP object ',  $object_type)"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="attr_jedi_check">
            <xsl:call-template name="check-jdsp-jedi">
              <xsl:with-param name="jdsp_object" select="$object_type"/>
              <xsl:with-param name="jdsp_attribute" select="$attr_name"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:if test="$attr_jedi_check = 'false'">
            <xsl:call-template name="print-error">
              <xsl:with-param name="tagname" select="'filter/@name'"/>
              <xsl:with-param name="tagvalue" select="$attr_name"/>
              <xsl:with-param name="errortext" select="concat('is a compound reference but the first part is not a JEDI for JDSP object ',  $object_type)"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:for-each>

  <!-- 6 - match/qb/@query attribute must also pass checks 3 & 5 -->
  <xsl:for-each select="//match/qb">
    <xsl:variable name="attr_name" select="@query"/>
    <xsl:variable name="attr_is_used">
      <xsl:call-template name="check-jdsp-attribute-usage">
        <xsl:with-param name="jdsp_object_list" select="$jdsp_object_type_list"/>
        <xsl:with-param name="jdsp_attribute" select="$attr_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="$attr_is_used = 'false'">
      <xsl:call-template name="print-error">
        <xsl:with-param name="tagname" select="'match/qb/@query'"/>
        <xsl:with-param name="tagvalue" select="$attr_name"/>
        <xsl:with-param name="errortext" select="concat('references an unknown attribute for all JDSP objects ',  $jdsp_object_type_list)"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:for-each>

  <xsl:for-each select="$datatypes">
    <xsl:variable name="object_type" select="@value"/>
    <xsl:for-each select="//match/qb">
      <xsl:variable name="attr_name" select="@query"/>
      <xsl:variable name="attr_jedi_check">
        <xsl:call-template name="check-jdsp-jedi">
          <xsl:with-param name="jdsp_object" select="$object_type"/>
          <xsl:with-param name="jdsp_attribute" select="$attr_name"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$attr_jedi_check = 'false'">
        <xsl:call-template name="print-error">
          <xsl:with-param name="tagname" select="'match/qb/@query'"/>
          <xsl:with-param name="tagvalue" select="$attr_name"/>
          <xsl:with-param name="errortext" select="concat('is a compound reference but the first part is not a JEDI for JDSP object ',  $object_type)"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:for-each>
  </xsl:for-each>

  <!-- 7 - filter/@vocab references a valid vocabulary group in either
       the static of dynamic vocabulary files
       and
       8 - filter/exclude/data/@value must be valid entries in the
       filter/@vocab group.
       and
       9 If filter/exclude/data nodes exists the filter/@vocab must be a static
       vocab group -->
  <xsl:for-each select="//filter">
    <xsl:variable name="vocab_name" select="@vocab"/>
    <xsl:variable name="vocab_exists">
      <xsl:call-template name="check-vocab">
        <xsl:with-param name="vocab_group" select="$vocab_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$vocab_exists = 'false'">
        <xsl:call-template name="print-error">
          <xsl:with-param name="tagname" select="'filter/@vocab'"/>
          <xsl:with-param name="tagvalue" select="$vocab_name"/>
          <xsl:with-param name="errortext" select="'references an unknown vocabulary group'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="count(exclude/data) &gt; 0">
          <xsl:variable name="vocab_is_static">
            <xsl:call-template name="check-static-vocab">
              <xsl:with-param name="vocab_group" select="$vocab_name"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:if test="$vocab_is_static = 'false'">
            <xsl:call-template name="print-error">
              <xsl:with-param name="tagname" select="'filter/@vocab'"/>
              <xsl:with-param name="tagvalue" select="$vocab_name"/>
              <xsl:with-param name="errortext" select="'is not a static vocabulary but has exclude/data tags'"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:if>
        <xsl:for-each select="exclude/data">
          <xsl:variable name="entry_name" select="@value"/>
          <xsl:variable name="vocab_entry_exists">
            <xsl:call-template name="check-vocab-entry">
              <xsl:with-param name="vocab_group" select="$vocab_name"/>
              <xsl:with-param name="vocab_entry" select="$entry_name"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:if test="$vocab_entry_exists = 'false'">
            <xsl:call-template name="print-error">
              <xsl:with-param name="tagname" select="'filter/exclude/data/@value'"/>
              <xsl:with-param name="tagvalue" select="$entry_name"/>
              <xsl:with-param name="errortext" select="concat('references an unknown entry in vocabulary group ', $vocab_name)"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>

  <!-- 10 - tc/render/@value must reference a valid vocabulary group if
       tc/render/@type is vocabulary. -->
  <xsl:for-each select="//tc/render[@type = 'vocabulary']">
    <xsl:variable name="vocab_name" select="@value"/>
    <xsl:variable name="vocab_exists">
      <xsl:call-template name="check-vocab">
        <xsl:with-param name="vocab_group" select="$vocab_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="$vocab_exists = 'false'">
      <xsl:call-template name="print-error">
        <xsl:with-param name="tagname" select="'tc/render/@value'"/>
        <xsl:with-param name="tagvalue" select="$vocab_name"/>
        <xsl:with-param name="errortext" select="'references an unknown vocabulary group'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:for-each>

  <!-- 11 - quick/@screen must reference an IMT screen file of the same
       name, or a name that matches if a trailing _Screen is removed. -->
  <xsl:for-each select="//quick">
    <xsl:variable name="screen_name" select="@screen"/>
    <xsl:variable name="file_exists">
      <xsl:call-template name="check-imt">
        <xsl:with-param name="screen_name" select="$screen_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="$file_exists = 'false'">
      <xsl:call-template name="print-error">
        <xsl:with-param name="tagname" select="'quick/@screen'"/>
        <xsl:with-param name="tagvalue" select="$screen_name"/>
        <xsl:with-param name="errortext" select="'references an unknown IMT screen file'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:for-each>

  <!-- 12 - cols/tc @searchable value check. -->
  <!--xsl:for-each select="//tc">   
    <xsl:if test="count(@searchable) != 0">       
	   <xsl:if test="@searchable != 'true' and @searchable != 'false'">
	     <xsl:call-template name="print-error">
           <xsl:with-param name="tagname" select="'tc/@searchable'"/>
           <xsl:with-param name="tagvalue" select="'none'"/>
           <xsl:with-param name="errortext" select="'attribute contains wrong value'"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>          
  </xsl:for-each-->

  <!-- 13 - cols/tc @locked if @locked='true', they must be at the begins of the list of cols.  
            After @locked='false' following must be @locked='false' that means
            @locked='true' 
            @locked='false'
            @locked='true' is not ok-->
  <xsl:for-each select="//tc">
      <!-- first position check-->	
    <xsl:choose>  
      <xsl:when test="position() = 1">
        <xsl:if test="@locked = 'false'">
          <xsl:call-template name="print-error">
            <xsl:with-param name="tagname" select="'tc/@locked'"/>
            <xsl:with-param name="tagvalue" select="@locked"/>
            <xsl:with-param name="errortext" select="'the first locked value must be &quot;true&quot;'"/>
          </xsl:call-template>
        </xsl:if>        
      </xsl:when>
		<xsl:otherwise>              
        <xsl:if test="@locked = 'true'">	                          
          <xsl:if test="preceding::tc/@locked = 'false'">
            <xsl:call-template name="print-error">
              <xsl:with-param name="tagname" select="'tc/@locked'"/>
              <xsl:with-param name="tagvalue" select="@locked"/>
              <xsl:with-param name="errortext" select="'&quot;true&quot; can not be after the &quot;false&quot;'"/>
            </xsl:call-template>
		    </xsl:if> 
        </xsl:if> 
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="@locked != 'false' and @locked != 'true'">
      <xsl:call-template name="print-error">
        <xsl:with-param name="tagname" select="'tc/@locked'"/>
        <xsl:with-param name="tagvalue" select="@locked"/>
        <xsl:with-param name="errortext" select="'the locked value must be &quot;true&quot; or &quot;false&quot;'"/>
      </xsl:call-template>
    </xsl:if>  
  </xsl:for-each> 
	
</xsl:template> <!-- match="/table" -->


<!--
!! TEMPLATE:    check-imt
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template checks for the existence of an IMT XML file
!!              for the specified name. If found it returns the boolean true.
!!              If not, the boolean false is returned. If the passed in name
!!              has a trailing _Screen this is removed before the check.
!!
!! PARAMETERS:
!!   screen_name The name of the IMT screen to check. The screen name
!!               corresponds directly with the XML file name
-->
<xsl:template name="check-imt">
  <xsl:param name="screen_name"/>

  <!-- The name listed in the file contains the text _Screen on its end. But
       the sceen file names do not. We are checking for the file, therefore
       remove any trailing _Screen. -->
  <xsl:variable name="short_name">
    <xsl:choose>
      <xsl:when test="contains($screen_name, '_Screen')">
        <xsl:value-of select="substring-before($screen_name, '_Screen')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$screen_name"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="full_name" select="concat($imt_home, $short_name, '.xml')"/>
  <xsl:choose>
    <xsl:when test="document($full_name)">
      <xsl:value-of select="true()"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="false()"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- check-imt -->


<!--
!! TEMPLATE:    check-vocab
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template checks for the existence of a vocabulary tag
!!              within the dynamic and static vocabulary files. If one is
!!              found the boolean true is returned. Otherwise the boolean false
!!              is returned.
!!
!! PARAMETERS:
!!   vocab_group The name of a vocabulary translation group
-->
<xsl:template name="check-vocab">
  <xsl:param name="vocab_group"/>

  <xsl:choose>
    <xsl:when test="$vocab_nodes[name() = $vocab_group]">
      <xsl:value-of select="true()"/>
    </xsl:when>
    <xsl:otherwise> <!-- the tag name was not found -->
      <xsl:value-of select="false()"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- check-vocab -->


<!--
!! TEMPLATE:    check-static-vocab
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template checks for the existence of a vocabulary tag
!!              within the static vocabulary file. If one is found the boolean
!!              true is returned. Otherwise the boolean false is returned.
!!
!! PARAMETERS:
!!   vocab_group The name of a vocabulary translation group
-->
<xsl:template name="check-static-vocab">
  <xsl:param name="vocab_group"/>

  <xsl:choose>
    <xsl:when test="$static_nodes[name() = $vocab_group]">
      <xsl:value-of select="true()"/>
    </xsl:when>
    <xsl:otherwise> <!-- the tag name was not found -->
      <xsl:value-of select="false()"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- check-static-vocab -->


<!--
!! TEMPLATE:    check-vocab-entry
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template checks for the existence of a vocabulary tag
!!              within the dynamic and static vocabulary files. If one is
!!              found the boolean true is returned. Otherwise the boolean false
!!              is returned. If the vocab group is not found a true is still
!!              returned since that is checked separately in this stylesheet.
!!
!! PARAMETERS:
!!   vocab_group The name of a vocabulary translation group
!!   entry      The name associated with an entry within the group
-->
<xsl:template name="check-vocab-entry">
  <xsl:param name="vocab_group"/>
  <xsl:param name="vocab_entry"/>

  <xsl:variable name="vocab_node" select="$static_nodes[name() = $vocab_group]"/>
  <xsl:variable name="entry_node" select="$vocab_node/entry[@name = $vocab_entry]"/>

  <xsl:choose>
    <xsl:when test="count($vocab_node) = 0">
      <xsl:value-of select="true()"/> <!-- checked elsewhere in this file -->
    </xsl:when>
    <xsl:when test="count($entry_node) = 0">
      <xsl:value-of select="false()"/> <!-- the entry was not found -->
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="true()"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- check-vocab-entry -->


<!--
!! TEMPLATE:    check-jdsp-type
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template checks for the existence of an object tag
!!              within the persistent objects of the JDSP. If one is found
!!              the boolean true is returned. Otherwise the boolean false is
!!              returned.
!!
!! PARAMETERS:
!!   jdsp_object The name of a JDSP persistent object
-->
<xsl:template name="check-jdsp-type">
  <xsl:param name="jdsp_object"/>

  <xsl:choose>
    <xsl:when test="$jdsp_persistent_nodes[name() = $jdsp_object]">
      <xsl:value-of select="true()"/>
    </xsl:when>
    <xsl:otherwise> <!-- the tag name was not found -->
      <xsl:value-of select="false()"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- check-jdsp-type -->


<!--
!! TEMPLATE:    check-jdsp-attribute
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template checks for the existence of an attribute that
!!              belongs to the object tag within the persistent objects of the
!!              JDSP. If one is found the boolean true is returned. Otherwise
!!              the boolean false is returned. A missing object returns true
!!              since that is a separate check in this stylesheet.
!!
!! PARAMETERS:
!!   jdsp_object The name of a JDSP persistent object
!!   jdsp_attribute The name of a JDSP attribute belonging to the object. This
!!               can be a compound attribute (support_unit_id.caliber) in which
!!               case only the first portion (support_unit_id) is checked.
-->
<xsl:template name="check-jdsp-attribute">
  <xsl:param name="jdsp_object"/>
  <xsl:param name="jdsp_attribute"/>

  <xsl:variable name="first_part">
    <xsl:choose>
      <xsl:when test="contains($jdsp_attribute, '.')">
        <xsl:value-of select="substring-before($jdsp_attribute,'.')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$jdsp_attribute"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="object_node" select="$jdsp_persistent_nodes[name() = $jdsp_object]"/>
  <xsl:variable name="attribute_node" select="$object_node/*/*[name() = $first_part]"/>

  <xsl:choose>
    <xsl:when test="count($object_node) = 0">
      <xsl:value-of select="true()"/> <!-- checked elsewhere in this file -->
    </xsl:when>
    <xsl:when test="count($attribute_node) = 0">
      <xsl:value-of select="false()"/>
    </xsl:when>
    <xsl:otherwise> <!-- the object and attribute were found -->
      <xsl:value-of select="true()"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- check-jdsp-attribute -->


<!--
!! TEMPLATE:    check-jdsp-attribute-usage
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template checks for that at least one of the named objects
!!              in the object list uses the specified attribute. If such a match
!!              is found true() is returned. Otherwise false is returned.
!!
!! PARAMETERS:
!!   jdsp_object_list A comma separated list of JDSP object names
!!   jdsp_attribute The name of a JDSP attribute belonging to one of the
!!               objects in the list. This can be a compound attribute
!!               (support_unit_id.caliber) in which case only the first portion
!!               (support_unit_id) is checked.
-->
<xsl:template name="check-jdsp-attribute-usage">
  <xsl:param name="jdsp_object_list"/>
  <xsl:param name="jdsp_attribute"/>

  <xsl:variable name="normalized_list" select="normalize-space($jdsp_object_list)"/>
  <xsl:variable name="first_object">
    <xsl:choose>
      <xsl:when test="contains($normalized_list, ',')">
        <xsl:value-of select="normalize-space(substring-before($normalized_list, ','))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$normalized_list"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="other_objects" select="normalize-space(substring-after($normalized_list, ','))"/>

  <xsl:variable name="check_attribute">
    <xsl:call-template name="check-jdsp-attribute">
      <xsl:with-param name="jdsp_object" select="$first_object"/>
      <xsl:with-param name="jdsp_attribute" select="$jdsp_attribute"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$check_attribute = 'true'">
      <xsl:value-of select="true()"/> <!-- first match found -->
    </xsl:when>
    <xsl:when test="$other_objects = ''">
      <xsl:value-of select="false()"/> <!-- end of the list -->
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="check-jdsp-attribute-usage">
        <xsl:with-param name="jdsp_object_list" select="$other_objects"/>
        <xsl:with-param name="jdsp_attribute" select="$jdsp_attribute"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- check-jdsp-attribute-usage -->


<!--
!! TEMPLATE:    check-jdsp-jedi
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template checks the passed in attribute to determine if
!!              it must be a JEDI and is not.
!!              1)  A missing object or attribute returns true since those
!!                  are separate checks in this stylesheet.
!!              2) if the attribute is a compound attribute (eg
!!                 support_unit_id.caliber) and the first portion
!!                 (support_unit_id)is not a JEDI false is returned.
!!              3) all other situations return true
!!
!! PARAMETERS:
!!   jdsp_object The name of a JDSP persistent object
!!   jdsp_attribute The name of a JDSP attribute belonging to the object This
!!               can be a compound attribute (support_unit_id.caliber).
-->
<xsl:template name="check-jdsp-jedi">
  <xsl:param name="jdsp_object"/>
  <xsl:param name="jdsp_attribute"/>

  <xsl:variable name="first_part">
    <xsl:choose>
      <xsl:when test="contains($jdsp_attribute, '.')">
        <xsl:value-of select="substring-before($jdsp_attribute,'.')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$jdsp_attribute"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="object_node" select="$jdsp_persistent_nodes[name() = $jdsp_object]"/>
  <xsl:variable name="attribute_node" select="$object_node/*/*[name() = $first_part]"/>
  <xsl:choose>
    <xsl:when test="not(contains($jdsp_attribute,'.'))">
      <xsl:value-of select="true()"/>
    </xsl:when>
    <xsl:when test="count($object_node) = 0">
      <xsl:value-of select="true()"/> <!-- checked elsewhere in this file -->
    </xsl:when>
    <xsl:when test="count($attribute_node) = 0">
      <xsl:value-of select="true()"/> <!-- checked elsewhere in this file -->
    </xsl:when>
    <xsl:when test="$attribute_node/@type = 'JEDI'">
      <xsl:value-of select="true()"/>
    </xsl:when>
    <xsl:otherwise>
      <!-- the object & attribute were found, it is compound and not a JEDI -->
      <xsl:value-of select="false()"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- check-jdsp-jedi -->


<!--
!! TEMPLATE:    jdsp-object-nodes-to-name-list
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template will create a comma separated list of JDSP object
!!              names based on the @value attribute of the passed in nodes.
!!              It will recursively call itself to accomplish this.
!!
!! PARAMETERS:
!!   jdsp_object_nodes The nodeset from the IMT file of the types/data nodes
!!   first_call Is this a top level call or not ?
-->
<xsl:template name="jdsp-object-nodes-to-name-list">
  <xsl:param name="jdsp_object_nodes"/>
  <xsl:param name="first_call" select="true()"/>

  <xsl:if test="count($jdsp_object_nodes) &gt; 0">
    <xsl:choose>
      <xsl:when test="$first_call = true()">
        <xsl:value-of select="$jdsp_object_nodes[position() = 1]/@value"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat(',', $jdsp_object_nodes[position() = 1]/@value)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:if>

  <xsl:if test="count($jdsp_object_nodes) &gt; 1">
    <xsl:call-template name="jdsp-object-nodes-to-name-list">
      <xsl:with-param name="jdsp_object_nodes" select="$jdsp_object_nodes[not(position() = 1)]"/>
      <xsl:with-param name="first_call" select="false()"/>
    </xsl:call-template>
  </xsl:if>

</xsl:template> <!-- jdsp-object-nodes-to-name-list -->


<!--
!! TEMPLATE:    print-error
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template prints out the associated error. The only reason
!!              to have it as a separate template vs in-line is that it uses
!!              the saxon specific line-number() function. If we move away from
!!              saxon this provides one place to change the format of the
!!              error messages.
!!
!! PARAMETERS:
!!   tagname    The tag/attribute combo to isolate the error (e.g. action/@item)
!!   tagvalue   The current value assigned to the tag/attribute
!!   errortext  The text to specify the exact problem with the tag/attribute
-->
<xsl:template name="print-error">
  <xsl:param name="tagname"/>
  <xsl:param name="tagvalue"/>
  <xsl:param name="errortext"/>

  <xsl:value-of select="concat('Error (line ', saxon:line-number(), '): ', $tagname, '=&quot;', $tagvalue, '&quot; ', $errortext, '.', $cr)"/>
</xsl:template> <!-- print-error -->

</xsl:stylesheet>
