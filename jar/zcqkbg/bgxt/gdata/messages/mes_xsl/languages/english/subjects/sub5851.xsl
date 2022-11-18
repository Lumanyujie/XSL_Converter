<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:import href="../../../mes-util.xsl"/>
   <xsl:output method="text"/>
   <xsl:variable name="NL" select="$cr"/>
   <xsl:template match="/M">
      <xsl:text>删除情报搜索区命令（编号：</xsl:text>
      <xsl:value-of select="/M/D/@B"/>
      <xsl:text>）执行情况报告</xsl:text>
   </xsl:template>
</xsl:stylesheet>