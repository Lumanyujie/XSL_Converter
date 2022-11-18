<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://saxon.sf.net/">
<!-- This stylesheet procedure is used to verify the structure of a player menu
     file. The following checks are made:
     1) Under basic-menu//item and quick-menu//item the tag must have an order
        attribute that references an existing order XML file
     2) Under imt-menu//item the tag must have a screen attribute that
        references an existing IMT XML file
     3) Under context-menu//item/action tags with a type attribute of "Order"
        must have an order attribute that references an existing order XML file
     4) Under context-menu//item/action tags if an assign-name attribute exists
        it must be a reference to valid field in the corresponding order XML
        file
     5) Under context-menu//item/action tags with a type attribute of "Imt"
        must have a screen attribute that references an existing IMT XML file
     6) Under context-menu//item/constraint for non-map actions the type
        attribute must exist and reference valid JDSP object types
     7) Under context-menu//item with action/@type of Imt, the action/@using
        attribute must exist and be a valid JDSP attribute for every JDSP
        object type in the constraint/@type attribute

     The parser also ensures the file is syntactically correct.

     To run this stylesheet from the command line:
     saxon jds_protocol.xml verify_menu.xsl jtlshome=$JTLSHOME
     providing the required path names for both files. If the XML file being
     checked if for reports add the argument orderhome=$JGAME/data/reports/
-->
<xsl:param name="jtlshome" select="'/home/jtlsdev'"/>
<xsl:param name="orderhome" select="concat($jtlshome, '/game/data/orders')"/>

<xsl:output method="text"/>

<!-- directory structure variables. Where we look for order files is going
     to depend on if this is a WHIP menu with standard orders, or a TRIPP
     menu with reports. It is up to the caller to specify which it is -->
<xsl:variable name="imt_home" select="concat($jtlshome, '/game/data/imt/')"/>
<xsl:variable name="jdsp_home" select="concat($jtlshome, '/include/jdsp/')"/>

<!-- Tree fragments from other files -->
<xsl:variable name="jdsp_file" select="concat($jdsp_home, '/jds_protocol.xml')"/>
<xsl:variable name="jdsp_fragment" select="document($jdsp_file)"/>
<xsl:variable name="jdsp_persistent_nodes" select="$jdsp_fragment//simulation-data/persistent/*"/>

<!-- new line text variables -->
<xsl:variable name="cr">
<xsl:text>
</xsl:text>
</xsl:variable>

<!--
!! TEMPLATE:    match /menu-definition
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template checks the XML file from the top level. All
!!              other checks are invoked from here.
-->
<xsl:template match="/menu-definition">

  <!-- Check 1 - basic-menu and quick-menu item tags must contain a valid 
       order attribute that references an existing order XML file -->
  <xsl:for-each select="//basic-menu//item | //quick-menu//item">
    <xsl:variable name="item_name" select="@label"/>
    <xsl:variable name="order" select="@order"/>
    <xsl:choose>
      <xsl:when test="count($order) = 0">
        <xsl:call-template name="print-error">
          <xsl:with-param name="tagname" select="'item/@label'"/>
          <xsl:with-param name="tagvalue" select="$item_name"/>
          <xsl:with-param name="errortext" select="'does not have a matching @order'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise> <!-- the order name field was present -->
        <xsl:variable name="order_exists">
          <xsl:call-template name="check-order">
            <xsl:with-param name="order_name" select="$order"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$order_exists = 'false'">
          <xsl:call-template name="print-error">
            <xsl:with-param name="tagname" select="'item/@order'"/>
            <xsl:with-param name="tagvalue" select="$order"/>
            <xsl:with-param name="errortext" select="'references an invalid order'"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each> <!-- item tag under the menu options -->

  <!-- Check 2 - imt-menu//item tag must have a screen attribute that
       references an existing IMT XML file -->
  <xsl:for-each select="//imt-menu//item">
    <xsl:variable name="item_name" select="@label"/>
    <xsl:variable name="screen" select="@screen"/>
    <xsl:choose>
      <xsl:when test="count($screen) = 0">
        <xsl:call-template name="print-error">
          <xsl:with-param name="tagname" select="'item/@label'"/>
          <xsl:with-param name="tagvalue" select="$item_name"/>
          <xsl:with-param name="errortext" select="'does not have a matching @screen'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise> <!-- the screen name field was present -->
        <xsl:variable name="screen_exists">
          <xsl:call-template name="check-imt">
            <xsl:with-param name="screen_name" select="$screen"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$screen_exists = 'false'">
          <xsl:call-template name="print-error">
            <xsl:with-param name="tagname" select="'item/@screen'"/>
            <xsl:with-param name="tagvalue" select="$screen"/>
            <xsl:with-param name="errortext" select="'references an invalid IMT screen'"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each> <!-- item tag under the menu options -->

  <!-- Check 3 - context-menu//item/action tags with a type attribute of
       "Order" must have an order attribute that references an existing order
       XML file -->
  <xsl:for-each select="//context-menu//item[action[@type = 'Order']]">
    <xsl:variable name="item_name" select="@label"/>
    <xsl:variable name="order" select="action/@order"/>
    <xsl:choose>
      <xsl:when test="count($order) = 0">
        <xsl:call-template name="print-error">
          <xsl:with-param name="tagname" select="'item/@label'"/>
          <xsl:with-param name="tagvalue" select="$item_name"/>
          <xsl:with-param name="errortext" select="'does not have a matching action/@order specified'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise> <!-- the order name field was present -->
        <xsl:variable name="order_exists">
          <xsl:call-template name="check-order">
            <xsl:with-param name="order_name" select="$order"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$order_exists = 'false'">
          <xsl:call-template name="print-error">
            <xsl:with-param name="tagname" select="'action/@order'"/>
            <xsl:with-param name="tagvalue" select="$order"/>
            <xsl:with-param name="errortext" select="'references an invalid order'"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each> <!-- item tag under the context menu options -->

  <!-- Check 4 - context-menu//item/action tags with an assign-name attribute
        must reference a valid field in the corresponding order XML file -->
  <xsl:for-each select="//context-menu//item[action[@assign-name]]">
    <xsl:variable name="item_name" select="@label"/>
    <xsl:variable name="order" select="action/@order"/>
    <xsl:variable name="field" select="action/@assign-name"/>
    <xsl:choose>
      <xsl:when test="count($field) = 0"/> <!-- field not required -->
      <xsl:when test="count($order) = 0"/> <!-- missing order caught above -->
      <xsl:otherwise> <!-- the field and order names were present -->
        <xsl:variable name="field_exists">
          <xsl:call-template name="check-order-field">
            <xsl:with-param name="order_name" select="$order"/>
            <xsl:with-param name="field_name" select="$field"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$field_exists = 'false'">
          <xsl:call-template name="print-error">
            <xsl:with-param name="tagname" select="'action/@assign-name'"/>
            <xsl:with-param name="tagvalue" select="$field"/>
            <xsl:with-param name="errortext" select="'references an invalid order field'"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each> <!-- item tag under the context menu options -->

  <!-- Check 5 - context-menu//item/action tags with a type attribute of
       "Imt" must have a screen attribute that references an existing IMT
       XML file -->
  <xsl:for-each select="//context-menu//item[action[@type = 'Imt']]">
    <xsl:variable name="item_name" select="@label"/>
    <xsl:variable name="screen" select="action/@screen"/>
    <xsl:choose>
      <xsl:when test="count($screen) = 0">
        <xsl:call-template name="print-error">
          <xsl:with-param name="tagname" select="'item/@label'"/>
          <xsl:with-param name="tagvalue" select="$item_name"/>
          <xsl:with-param name="errortext" select="'does not have a item/action/@screen specified'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise> <!-- the screen name field was present -->
        <xsl:variable name="screen_exists">
          <xsl:call-template name="check-imt">
            <xsl:with-param name="screen_name" select="$screen"/>
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$screen_exists = 'false'">
          <xsl:call-template name="print-error">
            <xsl:with-param name="tagname" select="'action/@screen'"/>
            <xsl:with-param name="tagvalue" select="$screen"/>
            <xsl:with-param name="errortext" select="'references an invalid IMT screen'"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each> <!-- item tag under the context menu options -->

  <!-- Check 6 - context-menu//item/constraint the type attribute must exist
       and reference valid JDSP object types. This applies to items that have
       an action/@type attribute other than Map -->
  <xsl:for-each select="//context-menu//item[action[not(@type = 'Map')]]">
    <xsl:variable name="item_name" select="@label"/>
    <xsl:variable name="type_list" select="constraint/@type"/>

    <xsl:choose>
      <xsl:when test="count($type_list) = 0">
        <xsl:call-template name="print-error">
          <xsl:with-param name="tagname" select="'item/@label'"/>
          <xsl:with-param name="tagvalue" select="$item_name"/>
          <xsl:with-param name="errortext" select="'does not have a item/constraint/@type specified'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <!-- type_list is a comma separated list of JDSP persistent object
             names. Peel items off the list and check them individually -->
        <xsl:call-template name="check-type-list">
          <xsl:with-param name="type_list" select="$type_list"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:for-each> <!-- item tag under the context menu options -->

  <!-- Check 7 - context-menu//item tags with action/@type of Imt, the
       action/@using attribute must exist and be a valid JDSP attribute for
       every JDSP object type in the constraint/@type attribute -->
  <xsl:for-each select="//context-menu//item[action[@type = 'Imt']]">
    <xsl:variable name="item_name" select="@label"/>
    <xsl:variable name="type_list" select="constraint/@type"/>
    <xsl:variable name="using_attr" select="action/@using"/>

    <xsl:choose>
      <xsl:when test="count($using_attr) = 0">
        <xsl:call-template name="print-error">
          <xsl:with-param name="tagname" select="'item/@label'"/>
          <xsl:with-param name="tagvalue" select="$item_name"/>
          <xsl:with-param name="errortext" select="'does not have an action/@using specified'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="count($type_list) = 0"/> <!-- checked elsewhere -->
      <xsl:otherwise>
        <!-- type_list is a comma separated list of JDSP persistent object
             names. Peel items off the list and check them individually -->
        <xsl:call-template name="check-type-attr-list">
          <xsl:with-param name="type_list" select="$type_list"/>
          <xsl:with-param name="attribute" select="$using_attr"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:for-each> <!-- item tag under the context menu options -->

</xsl:template> <!-- match /menu-definition -->


<!--
!! TEMPLATE:    check-type-list
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template peels off a single name from the type_list and
!!              checks to verify it is a valid JDSP persistent object name.
!!              If it is not an error message is written. In either case, the
!!              template recursively calls itself for the remaining items in
!!              the list.
!!
!! PARAMETERS:
!!   item_name  The label name associated with the item tag
!!   type_list  A comma separated list of JDSP persistent object names
-->
<xsl:template name="check-type-list">
  <xsl:param name="type_list"/>

  <xsl:variable name="normalized_list" select="normalize-space($type_list)"/>
  <xsl:variable name="first_type">
    <xsl:choose>
      <xsl:when test="contains($normalized_list, ',')">
        <xsl:value-of select="normalize-space(substring-before($normalized_list, ','))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$normalized_list"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="other_types" select="normalize-space(substring-after($normalized_list, ','))"/>

  <xsl:variable name="check_type">
    <xsl:call-template name="check-jdsp-type">
      <xsl:with-param name="jdsp_object" select="$first_type"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:if test="$check_type = 'false'">
    <xsl:call-template name="print-error">
      <xsl:with-param name="tagname" select="'constraint/@type'"/>
      <xsl:with-param name="tagvalue" select="$first_type"/>
      <xsl:with-param name="errortext" select="'references an invalid JDSP type'"/>
    </xsl:call-template>
  </xsl:if>

  <xsl:if test="not($other_types = '')">
    <xsl:call-template name="check-type-list">
      <xsl:with-param name="type_list" select="$other_types"/>
    </xsl:call-template>
  </xsl:if>

</xsl:template> <!-- check-type-list -->


<!--
!! TEMPLATE:    check-type-attr-list
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template peels off a single name from the type_list and
!!              checks to verify it is a valid JDSP persistent object name and
!!              that the attribute is an attribute of that object. An error
!!              message for a bad attribute but not a bad object. The template
!!              recursively calls itself for the remaining items in the list.
!!
!! PARAMETERS:
!!   item_name  The label name associated with the item tag
!!   type_list  A comma separated list of JDSP persistent object names
!!   attribute  Name of a JDSP attribute that should exist for each JDSP object
-->
<xsl:template name="check-type-attr-list">
  <xsl:param name="type_list"/>
  <xsl:param name="attribute"/>

  <xsl:variable name="normalized_list" select="normalize-space($type_list)"/>
  <xsl:variable name="first_type">
    <xsl:choose>
      <xsl:when test="contains($normalized_list, ',')">
        <xsl:value-of select="normalize-space(substring-before($normalized_list, ','))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$normalized_list"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="other_types" select="normalize-space(substring-after($normalized_list, ','))"/>

  <xsl:variable name="check_attribute">
    <xsl:call-template name="check-jdsp-attribute">
      <xsl:with-param name="jdsp_object" select="$first_type"/>
      <xsl:with-param name="jdsp_attribute" select="$attribute"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:if test="$check_attribute = 'false'">
    <xsl:call-template name="print-error">
      <xsl:with-param name="tagname" select="'action/@using'"/>
      <xsl:with-param name="tagvalue" select="$attribute"/>
      <xsl:with-param name="errortext" select="concat('does not exist as an attribuite for JDSP type: ', $first_type)"/>
    </xsl:call-template>
  </xsl:if>

  <xsl:if test="not($other_types = '')">
    <xsl:call-template name="check-type-attr-list">
      <xsl:with-param name="type_list" select="$other_types"/>
      <xsl:with-param name="attribute" select="$attribute"/>
    </xsl:call-template>
  </xsl:if>

</xsl:template> <!-- check-type-attr-list -->


<!--
!! TEMPLATE:    check-order
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template checks for the existence of an order XML file
!!              for the specified name. If found it returns the boolean true.
!!              If not, the boolean false is returned. This does not check the
!!              order file itself, only the existence of it.
!!
!! PARAMETERS:
!!   order_name The name of the order to check. The order name corresponds
!!              directly with the order XML file name
-->
<xsl:template name="check-order">
  <xsl:param name="order_name"/>

  <xsl:variable name="full_name" select="concat($orderhome, $order_name, '.xml')"/>
  <xsl:choose>
    <xsl:when test="document($full_name)">
      <xsl:value-of select="true()"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="false()"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- check-order -->


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
  <xsl:variable name="short_name" select="substring-before($screen_name, '_Screen')"/>

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
!! TEMPLATE:    check-order-field
!! PROGRAMMER:  Rick Kalinyak
!! DESCRIPTION: This template checks for the existence of a field in an order
!!              XML file of the specified name. If both the file exists and
!!              field exists it returns the boolean true. If either condition
!!              fails the boolean false is returned.
!!
!! PARAMETERS:
!!   order_name The name of the order to check. The order name corresponds
!!              directly with the order XML file name
!!   field_name The name of the field within the order to check
-->
<xsl:template name="check-order-field">
  <xsl:param name="order_name"/>
  <xsl:param name="field_name"/>

  <xsl:variable name="full_name" select="concat($orderhome, $order_name, '.xml')"/>
  <xsl:variable name="order_fragment" select="document($full_name)"/>
  <xsl:choose>
    <xsl:when test="$order_fragment">
      <!-- The file exists. Check for the field name  -->
      <xsl:choose>
        <xsl:when test="$order_fragment/*/fields/field[@name=$field_name]">
          <xsl:value-of select="true()"/>
        </xsl:when>
        <xsl:otherwise> <!-- the field does not exist -->
          <xsl:value-of select="false()"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise> <!-- the file does not exist (or failed to open) -->
      <xsl:value-of select="false()"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- check-order-field -->


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
!!              the boolean false is returned.
!!
!! PARAMETERS:
!!   jdsp_object The name of a JDSP persistent object
!!   jdsp_attribute The name of a JDSP attribute belonging to the object
-->
<xsl:template name="check-jdsp-attribute">
  <xsl:param name="jdsp_object"/>
  <xsl:param name="jdsp_attribute"/>

  <xsl:variable name="object_node" select="$jdsp_persistent_nodes[name() = $jdsp_object]"/>
  <xsl:variable name="attribute_node" select="$object_node/*/*[name() = $jdsp_attribute]"/>
  <xsl:choose>
    <xsl:when test="count($object_node) = 0">
      <xsl:value-of select="false()"/>
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
