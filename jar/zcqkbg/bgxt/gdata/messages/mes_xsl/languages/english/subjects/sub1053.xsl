<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:import href="../../../mes-util.xsl"/>
   <xsl:output method="text"/>
   <xsl:variable name="NL" select="$cr"/>
   <xsl:template match="/M">
      <xsl:text>改变雷场</xsl:text>
      <xsl:value-of select="/M/D/@B"/>
      <xsl:text>效能百分比 </xsl:text>
   </xsl:template>
</xsl:stylesheet>