<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:import href="../../../mes-util.xsl"/>
   <xsl:output method="text"/>
   <xsl:variable name="NL" select="$cr"/>
   <xsl:template match="/M">
      <xsl:text>巡航导弹</xsl:text>
      <xsl:value-of select="/M/D/@B"/>
      <xsl:text>重新锁定目标情况报告</xsl:text>
   </xsl:template>
</xsl:stylesheet>