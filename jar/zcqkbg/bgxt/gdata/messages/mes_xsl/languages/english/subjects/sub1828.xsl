<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:import href="../../../mes-util.xsl"/>
   <xsl:output method="text"/>
   <xsl:variable name="NL" select="$cr"/>
   <xsl:template match="/M">
      <xsl:text>舰船部队原型</xsl:text>
      <xsl:call-template name="get-vocab-value">
         <xsl:with-param name="vocab">Ship_Unit_Prototype</xsl:with-param>
         <xsl:with-param name="arg1">
            <xsl:value-of select="/M/D/@B"/>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:text>（编号</xsl:text>
      <xsl:value-of select="/M/D/@B"/>
      <xsl:text>）参数---补给总量</xsl:text>
   </xsl:template>
</xsl:stylesheet>