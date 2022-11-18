<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- This stylesheet read color value from scenario.icp_db.xml file. 
     Used by imt_progrm.
     August 01, 2007
     Etsuko
-->
     
<xsl:output method="text"/>

<xsl:param name="client-name" select="''"/>

<xsl:template match="/icp-database">  
  <xsl:call-template name="read-color">
    <xsl:with-param name="client" select="$client-name"/>
  </xsl:call-template> 
</xsl:template>

<xsl:template name="read-color">
 <xsl:param name="client"/>  
   <xsl:for-each select="whip">     
    <xsl:if test="SideName/@value = $client">
      <xsl:value-of select="$client"/>
      <xsl:text> = </xsl:text>
      <xsl:value-of select="SideColor/@value"/>
      <xsl:text>
      </xsl:text>
    </xsl:if>              
   </xsl:for-each>  
</xsl:template>
</xsl:stylesheet>
