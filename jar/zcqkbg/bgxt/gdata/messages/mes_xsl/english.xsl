<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="mes-util.xsl"/>
	<xsl:output method="text"/>
	<xsl:param name="output-mode" select="'header'"/>
	<xsl:variable name="NL" select="$cr"/>
	<xsl:template match="/M">
		<xsl:choose>
			<xsl:when test="$output-mode = 'header'">
				<xsl:call-template name="render-header"/>
			</xsl:when>
			<xsl:when test="$output-mode = 'footer'">
				<xsl:call-template name="render-footer"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="render-header">
		<xsl:text>&lt;div class='headDiv'&gt;</xsl:text>
		<xsl:call-template name="parse-col">
			<xsl:with-param name="target-string">&lt;div class='headDiv'&gt; </xsl:with-param>
			<xsl:with-param name="is-begin-with-slide">
                  	0
                  </xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="GTIME_FUN">
			<xsl:with-param name="arg1">
				<xsl:value-of select="/M/D/@A"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:text> (</xsl:text>
		<xsl:call-template name="GTIME_FUN">
			<xsl:with-param name="arg1">
				<xsl:value-of select="/M/D/@A"/>
			</xsl:with-param>
			<xsl:with-param name="arg2">
				<xsl:text>%f</xsl:text>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:text>)</xsl:text>
		<xsl:value-of select="$NL"/>
		<xsl:text>&lt;br/&gt;</xsl:text>
		<xsl:text>演习课题：边境西中段反击作战 </xsl:text>
		<xsl:text>&lt;br/&gt;</xsl:text>
		<xsl:value-of select="$NL"/>
		<xsl:value-of select="$NL"/>
		<xsl:text>密 级：</xsl:text>
		<xsl:value-of select="$NL"/>
		<xsl:value-of select="$NL"/>
	</xsl:template>
	<xsl:template name="render-footer">
		<xsl:value-of select="$NL"/>
		<xsl:text>       </xsl:text>
		<xsl:value-of select="$NL"/>
	</xsl:template>
</xsl:stylesheet>
