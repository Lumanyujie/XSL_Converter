<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:import href="../../../mes-util.xsl"/>
   <xsl:output method="text"/>
   <xsl:variable name="NL" select="$cr"/>
   <xsl:template match="/M">
      <xsl:call-template name="get-vocab-value">
         <xsl:with-param name="vocab">No_Force_Side</xsl:with-param>
         <xsl:with-param name="arg1">
            <xsl:value-of select="/M/D/@B"/>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:text>获取其他方战场目标情报</xsl:text>
      <xsl:call-template name="get-vocab-value">
         <xsl:with-param name="vocab">Periodic_or_Summary</xsl:with-param>
         <xsl:with-param name="arg1">
            <xsl:value-of select="/M/D/@E"/>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:text>报告</xsl:text>
   </xsl:template>
</xsl:stylesheet>