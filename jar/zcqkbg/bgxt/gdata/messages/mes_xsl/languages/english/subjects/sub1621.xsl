<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:import href="../../../mes-util.xsl"/>
   <xsl:output method="text"/>
   <xsl:variable name="NL" select="$cr"/>
   <xsl:template match="/M">
      <xsl:call-template name="get-vocab-value">
         <xsl:with-param name="vocab">Supply_Shipment_Method</xsl:with-param>
         <xsl:with-param name="arg1">
            <xsl:value-of select="/M/D/@C"/>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:text>（</xsl:text>
      <xsl:call-template name="get-vocab-value">
         <xsl:with-param name="vocab">Sustainment_Log_Prototype</xsl:with-param>
         <xsl:with-param name="arg1">
            <xsl:value-of select="/M/D/@B"/>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:text>）后勤补给原型</xsl:text>
      <xsl:value-of select="/M/D/@B"/>
      <xsl:text>中补给输送限制属性</xsl:text>
   </xsl:template>
</xsl:stylesheet>