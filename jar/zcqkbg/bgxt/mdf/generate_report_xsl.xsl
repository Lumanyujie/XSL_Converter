<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 >
<!--
!! FILE:        $JXSL/generate_report_xsl.xsl
!! DESCRIPTION: This stylesheet is designed to take an XML properties file
!!              and create a stylesheet where each property name is a variable
!!              and the properties value is the variable's value. This is used
!!              in the generation of language specific variable stylesheets for
!!              the reports.
!!
!!              This should be run with two parameters passed in:
!!              baseline - the full path name of a file that contains all the
!!                         variables and a baseline definition (by convention
!!                         the english version is normally the baseline)
!!              outfile  - The name of a file where the output will be written
!!
!!              This stylesheet can be run with the following command:
!!              saxon <xml> generate_report_xsl.xsl baseline=\"<file>\" outfile=\"<outfile>\"
-->

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:param name="baseline"/>
<xsl:param name="outfile" select="'/home/jtlsdev/game/data/reports/stylesheets/languages/output'"/>

<xsl:variable name="baseline_tf" select="document($baseline)"/>

<xsl:variable name="cr" select="'&#xA;'"/>


<!--
!! TEMPLATE:    match /
!! DESCRIPTION: This template is the main driver for the generation of the
!!              variable stylesheet. It will loop through all /properties/entry
!!              tags and create individual XSL variables from them.
-->
<xsl:template match="/">

  <xsl:variable name="entry_nodes" select="properties/entry"/>

  <!-- Create an output stylesheet -->
  <xsl:result-document method="xml" href="{$outfile}">

    <xsl:element name="xsl:stylesheet">
      <xsl:attribute name="version">1.0</xsl:attribute>

      <!-- Go through each variable in the baseline and ensure it exists as
           a property within our input file. If not, then we use the baseline
           value to generate a variable -->
      <xsl:for-each select="$baseline_tf/*/xsl:variable">
        <xsl:variable name="name" select="@name"/>
        <xsl:variable name="value" select="."/>

        <xsl:if test="count($entry_nodes[@key = $name]) = 0">
          <xsl:element name="xsl:variable">
            <xsl:attribute name="name" select="$name"/>
            <xsl:value-of select="$value"/>
          </xsl:element>
        </xsl:if>
      </xsl:for-each> <!-- baseline variable -->

      <!-- Go through each property within the input file and create a variable
           from it -->
      <xsl:for-each select="$entry_nodes">
        <xsl:element name="xsl:variable">
          <xsl:attribute name="name" select="@key"/>
          <xsl:value-of select="."/>
        </xsl:element>
      </xsl:for-each> <!-- properties/entry -->

    </xsl:element> <!-- xsl:stylesheet -->
  </xsl:result-document>

</xsl:template> <!-- end of template match /msgs -->

</xsl:stylesheet>
