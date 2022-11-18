<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:import href="../../../mes-util.xsl"/>
   <xsl:output method="text"/>
   <xsl:variable name="NL" select="$cr"/>
   <xsl:template match="/M">
      <xsl:call-template name="unit_name_transform_FUN">
         <xsl:with-param name="arg1">
            <xsl:value-of select="/M/D/@C"/>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:text>（编队）无法执行命令（</xsl:text>
      <xsl:call-template name="trans_word_FUN">
         <xsl:with-param name="arg1">
            <xsl:text>Order</xsl:text>
         </xsl:with-param>
         <xsl:with-param name="arg2">
            <xsl:value-of select="/M/D/@B"/>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:text>）情况报告</xsl:text>
   </xsl:template>
</xsl:stylesheet>