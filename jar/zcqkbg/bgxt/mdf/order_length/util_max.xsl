<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xt="http://www.jclark.com/xt"
  extension-element-prefixes="xt"
  exclude-result-prefixes="xt">

<!--to run this style sheet
    xt ordersdef.xml util_max.xsl util-max-list.xml 
-->
<xsl:output method="xml" indent="yes"/>

<!-- new line text variables -->
<xsl:variable name="cr">
<xsl:text>
</xsl:text>
</xsl:variable>


<!-- Check each order/utility -->
<xsl:template match="/orders-def">
  <xsl:element name="temp">  
    <xsl:call-template name="write-utilities"/>
  </xsl:element>
</xsl:template>

<!-- Utility -->
<xsl:template name="write-utilities">
  <xsl:element name="utilities">
     <xsl:for-each select="utility/order">
       <xsl:sort select="@name" data-type="text" order="ascending"/>
       <xsl:element name="utility">
          <xsl:attribute name="name">
            <xsl:value-of select="@short-name" />
          </xsl:attribute> 
          <xsl:attribute name="max-entries">
   <!--test to change max-entries-->
            <xsl:value-of select="@max-entries" />
            <!--xsl:value-of select="25" /-->
   <!--test end -->
          </xsl:attribute> 
       </xsl:element>
       <xsl:value-of select="$cr"/>
     </xsl:for-each>
  </xsl:element>
</xsl:template>


</xsl:stylesheet>
