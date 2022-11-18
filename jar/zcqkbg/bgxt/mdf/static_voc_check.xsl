<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
file_name : $JTLSHOME/script/xsl/static_voc.xsl
author    : David J. Ward
program description : 
            This stylesheet checks the static_voc.xml for
            invalid space characters and prints out errors.

date      : 3-23-04

-->

<xsl:output method="text"/>

<!-- new line text variables -->
<xsl:variable name="cr">
<xsl:text>
</xsl:text>
</xsl:variable>
<xsl:variable name="sp">
<xsl:text> </xsl:text>
</xsl:variable>

<xsl:template match="/static.voc">

  <xsl:for-each select="*">
      <xsl:variable name="vocab" select="name()"/>
  
    <xsl:for-each select="entry">
    
    <xsl:if test="contains(@name, $sp)">
      <xsl:value-of select="concat('Error: &quot;',$vocab,'&quot; entry &quot;', @name, '&quot;',$cr)"/>
      <xsl:value-of select="concat('     Has invalid space character in name: &quot;', @name, '&quot;',$cr)"/>
      <xsl:value-of select="concat('     No space characters are allowed in the name attribute.',$cr)"/>
    </xsl:if>

    <xsl:if test="contains(@value, $sp)">
      <xsl:value-of select="concat('Error: &quot;', $vocab,'&quot; entry &quot;', @name, '&quot;',$cr)"/>
      <xsl:value-of select="concat('     Has invalid space character in value attribute: &quot;', @value, '&quot;',$cr)"/>
      <xsl:value-of select="concat('     No space characters are allowed in the value attribute.',$cr)"/>
    </xsl:if>

    <xsl:if test="string(number(@value)) = 'NaN'">
      <xsl:value-of select="concat('Error: &quot;', $vocab,'&quot; entry &quot;', @name, '&quot;',$cr)"/>
      <xsl:value-of select="concat('     Has invalid value attribute: &quot;', @value, '&quot;',$cr)"/>
      <xsl:value-of select="concat('     The value attribute must be an integer value..',$cr)"/>
    </xsl:if>

    </xsl:for-each>
  </xsl:for-each>
</xsl:template>


</xsl:stylesheet>
