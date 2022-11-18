<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:import href="../../../mes-util.xsl"/>
   <xsl:output method="text"/>
   <xsl:variable name="NL" select="$cr"/>
   <xsl:template match="/M">
      <xsl:value-of select="/M/D/@B"/>
      <xsl:text>编队</xsl:text>
      <xsl:call-template name="get-vocab-value">
         <xsl:with-param name="vocab">Acceptance_Flag</xsl:with-param>
         <xsl:with-param name="arg1">
            <xsl:value-of select="/M/D/@C"/>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="get-vocab-value">
         <xsl:with-param name="vocab">Launch_Or_Alert</xsl:with-param>
         <xsl:with-param name="arg1">
            <xsl:value-of select="/M/D/@G"/>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:text>情况报告</xsl:text>
   </xsl:template>
</xsl:stylesheet>