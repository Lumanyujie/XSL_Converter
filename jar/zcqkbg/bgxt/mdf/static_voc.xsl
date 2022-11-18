<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
file_name : $JTLSHOME/script/xsl/static_voc.xsl
author    : E. Lippi
program description : 
            This stylesheet precesses static_voc.xml and regenerates 
            static.voc.
date      : 3-23-04

-->

<xsl:output method="text"/>

<!-- new line text variables -->
<xsl:variable name="cr">
<xsl:text>
</xsl:text>
</xsl:variable>

<xsl:template match="/static.voc">
  <xsl:for-each select="*">
    <xsl:variable name="parent">
      <xsl:value-of select="name()"/>
    </xsl:variable>
    <xsl:value-of select="$parent"/>
    <xsl:value-of select="concat($cr, '   ')"/>
    <xsl:value-of select="count(entry)"/>
    <xsl:value-of select="concat($cr, '   ')"/>

    <xsl:variable name="longest-name">
    <xsl:for-each select="entry">
      <xsl:sort select="string-length(@name)" data-type="number" order="ascending"/>
      <xsl:if test="position()=last()">
        <xsl:value-of select="@name"/>
      </xsl:if>
    </xsl:for-each>
    </xsl:variable>
   
    <xsl:for-each select="entry">
      <xsl:value-of select="string(@name)"/>
      <!-- find out number of space in between @name and @value. -->
      <xsl:variable name="space-between">
        <xsl:call-template name="space-length">
          <xsl:with-param name="long-name" select="$longest-name"/>
          <xsl:with-param name="name" select="@name"/>
          <xsl:with-param name="parent" select="$parent"/>
          <xsl:with-param name="value"  select="@value"/>
        </xsl:call-template>
      </xsl:variable> 
     
      <xsl:value-of select="$space-between"/>
      <xsl:value-of select="@value"/>
      <xsl:value-of select="concat($cr, '   ')"/>
    </xsl:for-each>

    <xsl:value-of select="concat($cr, '')"/>
  </xsl:for-each>
  <xsl:text>*</xsl:text>
  <xsl:value-of select="$cr"/>
</xsl:template>


<!-- param 'name'   static name.
     param 'parent' static type name.
     param 'value'  static value
     This template finds out number of space by giving params. -->
<xsl:template name="space-length">
  <xsl:param name="long-name"/>
  <xsl:param name="name"/>
  <xsl:param name="parent"/>
  <xsl:param name="value"/>
  <xsl:variable name="number-of-space">
    <xsl:choose>
      <xsl:when test="string-length($value) = 3">
        <xsl:value-of select="string-length($long-name) + 1 - string-length($name)"/>
      </xsl:when>
      <xsl:when test="string-length($value) = 1">
        <xsl:value-of select="string-length($long-name) + 3 - string-length($name)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="string-length($long-name) + 2 - string-length($name)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:call-template name="convert-number-to-space">
    <xsl:with-param name="number" select="$number-of-space"/>
  </xsl:call-template>
</xsl:template>


<!-- param 'numuber' number of space.
     This template procedure is to convert number to number of space.
     It loops until number becomes 0.  -->
<xsl:template name="convert-number-to-space">
  <xsl:param name="number"/>
  <xsl:variable name="space">
    <xsl:if test="$number &gt; 0">
      <xsl:text> </xsl:text>
      <xsl:call-template name="convert-number-to-space">
        <xsl:with-param name="number" select="$number - 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:variable>
  <xsl:value-of select="$space"/>
</xsl:template>




</xsl:stylesheet>
