<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:import href="../../../mes-util.xsl"/>
   <xsl:output method="text"/>
   <xsl:variable name="NL" select="$cr"/>
   <xsl:template match="/M">
      <xsl:text>空中</xsl:text>
      <xsl:value-of select="/M/D/@B"/>
      <xsl:text>编队关于情报搜索区情况报告</xsl:text>
   </xsl:template>
</xsl:stylesheet>