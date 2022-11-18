<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- 
!! File:        $JTLSHOME/script/xsl/aarc_documentation.xsl
!! Description: This stylesheet is responsible for generating the on-line
!!              documentation for the AAR. It uses the data from the
!!              JDS Protocol and the static vocabulary file to gather and
!!              format the documentation.
!!
!!              To run this stylesheet on the jds_protocol.xml file type:
!!              saxon jds_protocol.xml aar_documentation.xsl jtlshome=$JTLSHOME
-->
<xsl:param name="jtlshome" select="'/home/jtlsdev'"/>

<xsl:output method="text"/>

<xsl:variable name="jgame" select="concat($jtlshome, '/game')"/>
<xsl:variable name="jdsphome" select="concat($jtlshome, '/src/lib/jds_protocol')"/>
<xsl:variable name="dochome" select="concat($jtlshome, '/documents/sdr')"/>


<!-- Assign variables for frequently used ASCII characters -->
<xsl:variable name="cr" select="'&#xA;'"/>
<xsl:variable name="tab" select="'&#x9;'"/>
<xsl:variable name="apos" select='"&apos;"'/>

<xsl:output method="text"/>

<!-- Create a tree fragment definition of the AAR_OBJECT_LOOKUP table which
     matches the format for other tables in the JDSP -->
<xsl:variable name="object_lookup_node">
  <AAR_OBJECT_LOOKUP  routed="true">
    <description>
    This table allows the matching of an object's ID to its name and object
    type. It is filled by automatic triggers whenever a new object is inserted
    into any of the standard object tables (AAR_UNIT, AAR_AIR_MISSION, etc).
    </description>
    <common_knowledge>
      <object_id   type="JEDI" db-is-foreign-key="true" desc="The unique ID of the object."/>
      <object_type type="UINT_16" desc="The type of the object as an integer. These integers are assigned automatically and may change. Programmers should use the AAR_OBJECT enumerations from the C include file or the constants defined in the java jar file."/>
      <type        type="STRING"  db-column-width="MAX_EVENT_TEXT_LENGTH" desc="The name of the object type. This column has a direct relationship to the object_type column."/>
      <name        type="STRING"  db-column-width="MAX_EVENT_TEXT_LENGTH" desc="The name of the object. In general the CEP provides the short name which is filed in this column. Non-CEP objects, such as engagements and detections do not have an associated name so their object_id is filed in this column."/>
    </common_knowledge>
  </AAR_OBJECT_LOOKUP>
</xsl:variable>

<xsl:variable name="jdsp_file" select="concat($jdsphome, '/jds_protocol.xml')"/>
<xsl:variable name="jdsp_fragment" select="document($jdsp_file)"/>
<xsl:variable name="static_file" select="concat($jtlshome, '/game/data/static_voc.xml')"/>
<xsl:variable name="static_fragment" select="document($static_file)"/>
<xsl:variable name="jdsp_enumerated_nodes" select="$jdsp_fragment/JTLS-Data-System-Protocol/enumerations/*"/>
<xsl:variable name="jdsp_typedef_nodes" select="$jdsp_fragment/JTLS-Data-System-Protocol/typedefs/*[name() != 'description']"/>

<!--
!! TEMPLATE:     match /AAR-System-Data
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 02 October 2006
!! DESCRIPTION:  This is the main driver template for generating the AAR
!!               include file.
-->
<xsl:template match="/AAR-System-Data">

  <!-- Generate documentation -->
  <xsl:variable name="docname" select="concat($dochome, '/aar_tables.html')"/>
  <xsl:result-document method="text" href="{$docname}">
    <xsl:call-template name="generate-doc-header"/>
    <xsl:call-template name="generate-doc-tables"/>
    <xsl:call-template name="generate-doc-events"/>
    <xsl:call-template name="generate-doc-orders"/>
    <xsl:call-template name="generate-doc-footer"/>
  </xsl:result-document>

</xsl:template> <!-- match /AAR-System-Data -->


<!--
!! TEMPLATE:     generate-doc-header
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 12 March 2007
!! DESCRIPTION:  This template starts an HTML document
-->
<xsl:template name="generate-doc-header">

  <!-- Print out the header information for the document -->
  <xsl:value-of select="concat('&lt;!DOCTYPE HTML PUBLIC &quot;-//W3C//DTD HTML 4.0 Transitional//EN&quot;&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;HTML&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;HEAD&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;META HTTP-EQUIV=&quot;CONTENT-TYPE&quot; CONTENT=&quot;text/html; charset=utf-8&quot;&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;TITLE&gt;AAR Oracle Table Definitions&lt;/TITLE&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;META NAME=&quot;GENERATOR&quot; CONTENT=&quot;AAR Stylehseet&quot;&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;META NAME=&quot;CREATED&quot; CONTENT=&quot;&quot;&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;META NAME=&quot;CHANGED&quot; CONTENT=&quot;&quot;&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;META NAME=&quot;SDFOOTNOTE&quot; CONTENT=&quot;&quot;&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;META NAME=&quot;SDENDNOTE&quot; CONTENT=&quot;ENGLISH&quot;&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;STYLE&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;!--', $cr)"/>
  <xsl:value-of select="concat('  @page { size: 8.5in 11in; margin: 0.79in }', $cr)"/>
  <xsl:value-of select="concat('  P { margin-bottom: 0.08in }', $cr)"/>
  <xsl:value-of select="concat(' --&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;/STYLE&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;/HEAD&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;BODY LANG=&quot;en-US&quot; DIR=&quot;LTR&quot; STYLE=&quot;border: none; padding: 0in&quot;&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;P ALIGN=CENTER&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;AAR Oracle Table Definitions&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>

  <!-- Table of Contents Information -->
  <xsl:value-of select="concat('&lt;HR&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;&lt;A NAME=&quot;Section1&quot;&gt;1.0 Overview&lt;/A&gt;&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('&lt;P&gt;This document consists of the following sections:&lt;/P&gt;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('&lt;UL&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;LI&gt;&lt;A HREF = &quot;#Section1&quot;&gt; 1.0 Overview&lt;/A&gt;&lt;/LI&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;LI&gt;&lt;A HREF = &quot;#Section2&quot;&gt; 2.0 AAR Tables&lt;/A&gt;&lt;/LI&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;LI&gt;&lt;A HREF = &quot;#Section3&quot;&gt; 3.0 Object Event History&lt;/A&gt;&lt;/LI&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;LI&gt;&lt;A HREF = &quot;#Section4&quot;&gt; 4.0 Order Status&lt;/A&gt;&lt;/LI&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;/UL&gt;', $cr)"/>


</xsl:template> <!-- generate-doc-header -->


<!--
!! TEMPLATE:     generate-doc-footer
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 12 March 2007
!! DESCRIPTION:  This template completes an HTML document
-->
<xsl:template name="generate-doc-footer">

  <xsl:value-of select="concat('&lt;/BODY&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;/HTML&gt;', $cr)"/>

</xsl:template> <!-- generate-doc-footer -->


<!--
!! TEMPLATE:     generate-doc-tables
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 12 March 2007
!! DESCRIPTION:  This template creates an HTML document for the AAR tables.
!!               AN index of hotlinks to the tables is first printed, then
!!               a description of the table, followed by description of each
!!               table column.
-->
<xsl:template name="generate-doc-tables">

  <!-- Create a list of all tables. This includes the tables in the JDSP and
       also the AAR_OBJECT_LOOKUP table -->
  <xsl:variable name="all_tables" select="$object_lookup_node/*|$jdsp_fragment/JTLS-Data-System-Protocol/protocol/post-processing-data/transient/*"/>

  <!-- Create a list of hyperlinks to the individual tables -->
  <xsl:value-of select="concat('&lt;HR&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;&lt;A NAME=&quot;Section2&quot;&gt;2.0 AAR Tables&lt;/A&gt;&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('&lt;P&gt;The following tables are filled by the AAR Client:&lt;/P&gt;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('&lt;UL&gt;', $cr)"/>
  <xsl:for-each select="$all_tables">
    <xsl:variable name="table_name" select="name()"/>
    <xsl:value-of select="concat('&lt;LI&gt;&lt;A HREF = &quot;#', $table_name, '&quot;&gt;', $table_name, '&lt;/A&gt;&lt;/LI&gt;', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="concat('&lt;/UL&gt;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Create a section header and description for each of the tables -->
  <xsl:for-each select="$all_tables">

    <xsl:variable name="table_name" select="name()"/>
    <xsl:value-of select="concat('&lt;P&gt;&lt;FONT&gt;&lt;B&gt;&lt;A NAME=', $table_name,'&gt;2.', position(), ' ', $table_name, ' Table&lt;/A&gt;&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
    <xsl:value-of select="$cr"/>

    <xsl:value-of select="concat('&lt;P&gt;', description, '&lt;/P&gt;', $cr)"/>
    <xsl:value-of select="$cr"/>

    <!-- If the object has an object_id column it is assumed to be an event
         history object and therefore we should have a link to the actual
         event definitions -->
    <xsl:if test="name() != 'AAR_OBJECT_LOOKUP'">
      <xsl:for-each select="common_knowledge/*[name() = 'object_id']">
        <xsl:variable name="object_name">
          <xsl:call-template name="get-event-object-name">
            <xsl:with-param name="base_name" select="$table_name"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:value-of select="concat('&lt;P&gt;The actual meaning of each of the events and their corresponding parameters can be found in &lt;A HREF=#', $table_name, '_EVENTDEF&gt;', $object_name, ' Event History Definition&lt;/A&gt;.&lt;/P&gt;', $cr)"/>
      </xsl:for-each> <!-- unique_id attribute -->
    </xsl:if>

    <!-- Print out column information for this table (in a tabular format).
         Start with the table title and header row -->
    <xsl:variable name="table_width" select="'1000'"/>
    <xsl:variable name="column1_width" select="'100'"/>
    <xsl:variable name="column2_width" select="'100'"/>
    <xsl:variable name="column3_width" select="'800'"/>

    <xsl:value-of select="concat('&lt;/P&gt;', $cr)"/>
    <xsl:value-of select="concat('&lt;P ALIGN=CENTER STYLE=&quot;background: transparent&quot;&gt;&lt;FONT&gt;&lt;B&gt;Table 2.', position(), ' ', $table_name, ' Description&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
    <xsl:value-of select="concat('&lt;TABLE WIDTH=', $table_width, ' BORDER=1 BORDERCOLOR=&quot;#000000&quot; CELLPADDING=4 CELLSPACING=0&gt;', $cr)"/>
    <xsl:value-of select="concat(' &lt;COL WIDTH=', $column1_width, '&gt;', $cr)"/>
    <xsl:value-of select="concat(' &lt;COL WIDTH=', $column2_width, '&gt;', $cr)"/>
    <xsl:value-of select="concat(' &lt;COL WIDTH=', $column3_width, '&gt;', $cr)"/>
    <xsl:value-of select="concat(' &lt;TR VALIGN=TOP&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;TD WIDTH=', $column1_width, '&gt;', $cr)"/>
    <xsl:value-of select="concat('   &lt;P ALIGN=CENTER&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;Column&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;TD WIDTH=', $column2_width, '&gt;', $cr)"/>
    <xsl:value-of select="concat('   &lt;P ALIGN=CENTER&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;Format&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;TD WIDTH=', $column3_width, '&gt;', $cr)"/>
    <xsl:value-of select="concat('   &lt;P ALIGN=CENTER&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;Description&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
    <xsl:value-of select="concat(' &lt;/TR&gt;', $cr)"/>

    <!-- if the table has an object_id attribute then it is assumed to be an
         event history table and automatically gets a sequence number column
         to track the order of inserts -->
    <xsl:if test="name() != 'AAR_OBJECT_LOOKUP'">
      <xsl:for-each select="common_knowledge/*[name() = 'object_id']">

        <xsl:variable name="column_name" select="'sequence_nbr'"/>
        <xsl:variable name="column_format" select="'NUMBER(10)'"/>
        <xsl:variable name="column_description" select="'Sequential numerical index to identify the order of events that occur at the same game time.'"/>

        <xsl:value-of select="concat(' &lt;TR VALIGN=TOP&gt;', $cr)"/>
        <xsl:value-of select="concat('  &lt;TD WIDTH=', $column1_width, '&gt;', $cr)"/>
        <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $column_name, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
        <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
        <xsl:value-of select="concat('  &lt;TD WIDTH=', $column2_width, '&gt;', $cr)"/>
        <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $column_format, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
        <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
        <xsl:value-of select="concat('  &lt;TD WIDTH=', $column3_width, '&gt;', $cr)"/>
        <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $column_description, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
        <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
        <xsl:value-of select="concat(' &lt;/TR&gt;', $cr)"/>

      </xsl:for-each> <!-- unique_id attribute -->
    </xsl:if>

    <!-- Go through every attribute of the object that will result in a column
         within the Oracle table -->
    <xsl:for-each select="common_knowledge/*[not(name() = 'destination')]">

      <xsl:variable name="column_name" select="name()"/>
      <xsl:variable name="column_format">
        <xsl:call-template name="node-to-database-type">
          <xsl:with-param name="jdsp_tree" select="$jdsp_fragment"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="column_description" select="@desc"/>
      <xsl:variable name="vocabulary">
        <xsl:call-template name="find-vocabulary-name"/>
      </xsl:variable>
      <xsl:variable name="vocab_node" select="$static_fragment/static.voc/*[name() = $vocabulary]"/>

      <xsl:value-of select="concat(' &lt;TR VALIGN=TOP&gt;', $cr)"/>
      <xsl:value-of select="concat('  &lt;TD WIDTH=', $column1_width, '&gt;', $cr)"/>
      <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $column_name, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
      <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
      <xsl:value-of select="concat('  &lt;TD WIDTH=', $column2_width, '&gt;', $cr)"/>
      <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $column_format, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
      <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
      <xsl:value-of select="concat('  &lt;TD WIDTH=', $column3_width, '&gt;', $cr)"/>
      <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $column_description, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>

      <!-- If this is a static vocabulary field then we should also list the
           possible entries for the field -->
      <xsl:choose>
        <xsl:when test="string-length($vocabulary) > 0 and not($vocab_node)">
          <xsl:value-of select="concat('&lt;P&gt;Values for this column are derived from the scenario vocabulary item ', $vocabulary, '.', $cr)"/>
        </xsl:when>
        <xsl:when test="$vocab_node">
          <xsl:value-of select="concat('&lt;P&gt;Values for this column are derived from the static vocabulary item ', $vocabulary, '. Allowed Values Are:', $cr)"/>
          <xsl:value-of select="concat('&lt;UL&gt;', $cr)"/>
          <xsl:for-each select="$vocab_node/entry">
            <xsl:value-of select="concat('&lt;LI&gt;', @name, '&lt;/LI&gt;', $cr)"/>
          </xsl:for-each>
          <xsl:value-of select="concat('&lt;UL&gt;', $cr)"/>
        </xsl:when>
      </xsl:choose>

      <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
      <xsl:value-of select="concat(' &lt;/TR&gt;', $cr)"/>

    </xsl:for-each> <!-- common_knowledge or column name -->

    <!-- Close  out the HTML table -->
    <xsl:value-of select="concat('&lt;/TABLE&gt;', $cr)"/>
    <xsl:value-of select="concat('&lt;P STYLE=&quot;margin-bottom: 0in&quot;&gt;&lt;BR&gt;', $cr)"/>

  </xsl:for-each> <!-- transient AAR table -->
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- generate-doc-tables -->


<!--
!! TEMPLATE:     generate-doc-events
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 16 February 2007
!! DESCRIPTION:  This template creates an HTML document for the object events.
!!               Each object type is assigned its own table and the events
!!               for that object type are placed in the table along with a
!!               description of each Parameter.
-->
<xsl:template name="generate-doc-events">

  <!-- Get a listing of the event nodes -->
  <xsl:variable name="event_nodes" select="/AAR-System-Data/Object-Events/*"/>

  <!-- Create a list of hyperlinks to the individual event definitions -->
  <xsl:value-of select="concat('&lt;HR&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;&lt;A NAME=&quot;Section3&quot;&gt;3.0 Object Event History&lt;/A&gt;&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('&lt;P&gt;', $cr)"/>
  <xsl:value-of select="concat('Object events are assigned an event number by the CEP. ', $cr)"/>
  <xsl:value-of select="concat('For coding purposes these event numbers exist as ', $cr)"/>
  <xsl:value-of select="concat('AAR_EVENT enumerations in the $JTLSHOME/include/aar/aar.h file. ', $cr)"/>
  <xsl:value-of select="concat('This is a C header file which can be included in other source code. ', $cr)"/>
  <xsl:value-of select="concat('The following tables constitute event history tables and ', $cr)"/>
  <xsl:value-of select="concat('this section contains a complete description of their ', $cr)"/>
  <xsl:value-of select="concat('corresponding event definitions:', $cr)"/>
  <xsl:value-of select="concat('&lt;/P&gt;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('&lt;UL&gt;', $cr)"/>

  <xsl:for-each select="$jdsp_fragment/JTLS-Data-System-Protocol/protocol/post-processing-data/transient/*">
    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="hyperlink_name" select="concat($table_name, '_EVENTDEF')"/>
    <xsl:for-each select="common_knowledge/*[name() = 'object_id']">
      <xsl:value-of select="concat('&lt;LI&gt;&lt;A HREF = &quot;#', $hyperlink_name, '&quot;&gt;', $table_name, '&lt;/A&gt;&lt;/LI&gt;', $cr)"/>
    </xsl:for-each>
  </xsl:for-each>
  <xsl:value-of select="concat('&lt;/UL&gt;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Create a section header and description for each of the event history
       tables -->
  <xsl:for-each select="$jdsp_fragment/JTLS-Data-System-Protocol/protocol/post-processing-data/transient/*">

    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="object_nbr" select="position()"/>

    <xsl:for-each select="common_knowledge/*[name() = 'object_id']">

      <xsl:variable name="hyperlink_name" select="concat($table_name, '_EVENTDEF')"/>
      <xsl:variable name="object_name">
        <xsl:call-template name="get-event-object-name">
          <xsl:with-param name="base_name" select="$table_name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:value-of select="concat('&lt;P&gt;&lt;FONT&gt;&lt;B&gt;&lt;A NAME=&quot;', $hyperlink_name, '&quot;&gt;3.', $object_nbr, ' ', $object_name, ' Event History Definition&lt;/A&gt;&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
      <xsl:value-of select="$cr"/>
      <xsl:value-of select="concat('&lt;P&gt;The following table describes the meaning of the events and associated parameters used by the ', $object_name, ' object in the ', $table_name, ' table.&lt;/P&gt;', $cr)"/>
      <xsl:value-of select="concat('&lt;/P&gt;', $cr)"/>
      <xsl:value-of select="concat('&lt;P ALIGN=CENTER STYLE=&quot;background: transparent&quot;&gt;&lt;FONT&gt;&lt;B&gt;Table 3.', $object_nbr, ' ', $object_name, ' Events&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>

      <!-- Print out information for this table -->
      <xsl:variable name="table_width" select="'700'"/>
      <xsl:variable name="column1_width" select="'30'"/>
      <xsl:variable name="column2_width" select="'220'"/>
      <xsl:variable name="column3_width" select="'450'"/>

      <xsl:value-of select="concat('&lt;TABLE WIDTH=', $table_width, ' BORDER=1 BORDERCOLOR=&quot;#000000&quot; CELLPADDING=4 CELLSPACING=0&gt;', $cr)"/>
      <xsl:value-of select="concat(' &lt;COL WIDTH=', $column1_width, '&gt;', $cr)"/>
      <xsl:value-of select="concat(' &lt;COL WIDTH=', $column2_width, '&gt;', $cr)"/>
      <xsl:value-of select="concat(' &lt;COL WIDTH=', $column3_width, '&gt;', $cr)"/>
      <xsl:value-of select="concat(' &lt;TR VALIGN=TOP&gt;', $cr)"/>
      <xsl:value-of select="concat('  &lt;TD WIDTH=', $column1_width, '&gt;', $cr)"/>
      <xsl:value-of select="concat('   &lt;P ALIGN=CENTER STYLE=&quot;font-style: normal&quot;&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;#&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
      <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
      <xsl:value-of select="concat('  &lt;TD WIDTH=', $column2_width, '&gt;', $cr)"/>
      <xsl:value-of select="concat('   &lt;P ALIGN=CENTER&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;Name&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
      <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
      <xsl:value-of select="concat('  &lt;TD WIDTH=', $column3_width, '&gt;', $cr)"/>
      <xsl:value-of select="concat('   &lt;P ALIGN=CENTER&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;Description&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
      <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
      <xsl:value-of select="concat(' &lt;/TR&gt;', $cr)"/>

      <xsl:for-each select="$event_nodes">

        <xsl:if test="contains(@Object, $object_name)">

          <xsl:variable name="event_name" select="@Name"/>
          <xsl:variable name="event_index" select="@Number"/>
          <xsl:variable name="event_description" select="Description"/>
          <xsl:variable name="data1">
            <xsl:call-template name="generate-doc-parameter">
              <xsl:with-param name="parameter_node" select="Parameter[1]"/>
              <xsl:with-param name="static_node" select="$static_fragment"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="data2">
            <xsl:call-template name="generate-doc-parameter">
              <xsl:with-param name="parameter_node" select="Parameter[2]"/>
              <xsl:with-param name="static_node" select="$static_fragment"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="data3">
            <xsl:call-template name="generate-doc-parameter">
              <xsl:with-param name="parameter_node" select="Parameter[3]"/>
              <xsl:with-param name="static_node" select="$static_fragment"/>
            </xsl:call-template>
          </xsl:variable>

          <xsl:value-of select="concat(' &lt;TR VALIGN=TOP&gt;', $cr)"/>
          <xsl:value-of select="concat('  &lt;TD ROWSPAN=4 WIDTH=', $column1_width, '&gt;', $cr)"/>
          <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $event_index, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
          <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
          <xsl:value-of select="concat('  &lt;TD WIDTH=', $column2_width, '&gt;', $cr)"/>
          <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $event_name, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
          <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
          <xsl:value-of select="concat('  &lt;TD WIDTH=', $column3_width, '&gt;', $cr)"/>
          <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $event_description, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
          <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
          <xsl:value-of select="concat(' &lt;/TR&gt;', $cr)"/>
          <xsl:value-of select="concat(' &lt;TR&gt;', $cr)"/>
          <xsl:value-of select="concat('  &lt;TD COLSPAN=2 WIDTH=', $table_width, ' VALIGN=TOP&gt;', $cr)"/>
          <xsl:value-of select="concat('      ', $data1, $cr)"/>
          <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
          <xsl:value-of select="concat(' &lt;/TR&gt;', $cr)"/>
          <xsl:value-of select="concat(' &lt;TR&gt;', $cr)"/>
          <xsl:value-of select="concat('  &lt;TD COLSPAN=2 WIDTH=', $table_width, ' VALIGN=TOP&gt;', $cr)"/>
          <xsl:value-of select="concat('       ', $data2, $cr)"/>
          <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
          <xsl:value-of select="concat(' &lt;/TR&gt;', $cr)"/>
          <xsl:value-of select="concat(' &lt;TR&gt;', $cr)"/>
          <xsl:value-of select="concat('  &lt;TD COLSPAN=2 WIDTH=', $table_width, ' VALIGN=TOP&gt;', $cr)"/>
          <xsl:value-of select="concat('      ', $data3, $cr)"/>
          <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
          <xsl:value-of select="concat(' &lt;/TR&gt;', $cr)"/>

        </xsl:if>

      </xsl:for-each> <!--/AAR-System-Data/Object-Events/Event  -->

      <xsl:value-of select="concat('&lt;/TABLE&gt;', $cr)"/>
      <xsl:value-of select="concat('&lt;P STYLE=&quot;margin-bottom: 0in&quot;&gt;&lt;BR&gt;', $cr)"/>

    </xsl:for-each> <!-- table that is an event history table -->

  </xsl:for-each> <!-- AAR Table -->

</xsl:template> <!-- generate-doc-events -->


<!--
!! TEMPLATE:     generate-doc-orders
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 22 March 2007
!! DESCRIPTION:  This template creates the HTML documentation for the order
!!               status. The order status is a section of the main document,
!!               and the actual statuses are presented in two tables, success/
!!               information codes and failure codes.
-->
<xsl:template name="generate-doc-orders">

  <!-- Create the section header information and description -->
  <xsl:value-of select="concat('&lt;HR&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;&lt;A NAME=&quot;Section4&quot;&gt;4.0 Order Status&lt;/A&gt;&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="'&lt;P&gt;'"/>
  <xsl:value-of select="concat('When an order is complete, either due to implementation or failure ', $cr)"/>
  <xsl:value-of select="concat('it generates an ORDER_COMPLETE AAR event. One of the paramaters of this ', $cr)"/>
  <xsl:value-of select="concat('event indicates whether the order completed successfully, or was ', $cr)"/>
  <xsl:value-of select="concat('rejected for some specific reason. This section of the AAR documentation ', $cr)"/>
  <xsl:value-of select="concat('discusses these various status codes.', $cr)"/>
  <xsl:value-of select="concat('&lt;/P&gt;', $cr)"/>

  <xsl:value-of select="'&lt;P&gt;'"/>
  <xsl:value-of select="concat('Order status codes are broken into two categories, success ', $cr)"/>
  <xsl:value-of select="concat('and failure. Successful status codes are always even numbered, ', $cr)"/>
  <xsl:value-of select="concat('where 0 is considered an even number. Failure codes in ', $cr)"/>
  <xsl:value-of select="concat('contrast are always odd numbered. For programming purposes ', $cr)"/>
  <xsl:value-of select="concat('these code exist as AAR_ORDER_STATUS enumerations in the ', $cr)"/>
  <xsl:value-of select="concat('$JTLSHOME/include/aar/aar.h C header file. This header file ', $cr)"/>
  <xsl:value-of select="concat('also includes a macro to determine if the status code indicates ', $cr)"/>
  <xsl:value-of select="concat('success or failure. The following two tables ', $cr)"/>
  <xsl:value-of select="concat('describe the two categories of codes.', $cr)"/>
  <xsl:value-of select="concat('&lt;/P&gt;', $cr)"/>

  <!-- Define table sizes -->
  <xsl:variable name="table_width" select="'700'"/>
  <xsl:variable name="column1_width" select="'30'"/>
  <xsl:variable name="column2_width" select="'220'"/>
  <xsl:variable name="column3_width" select="'450'"/>

  <!-- Write out the first table of success codes -->
  <xsl:value-of select="concat('&lt;P ALIGN=CENTER STYLE=&quot;background: transparent&quot;&gt;&lt;FONT&gt;&lt;B&gt;Table 4.1 Order Status Success Codes&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>

  <xsl:value-of select="concat('&lt;TABLE WIDTH=', $table_width, ' BORDER=1 BORDERCOLOR=&quot;#000000&quot; CELLPADDING=4 CELLSPACING=0&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;COL WIDTH=', $column1_width, '&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;COL WIDTH=', $column2_width, '&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;COL WIDTH=', $column3_width, '&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;TR VALIGN=TOP&gt;', $cr)"/>
  <xsl:value-of select="concat('  &lt;TD WIDTH=', $column1_width, '&gt;', $cr)"/>
  <xsl:value-of select="concat('   &lt;P ALIGN=CENTER STYLE=&quot;font-style: normal&quot;&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;#&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
  <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
  <xsl:value-of select="concat('  &lt;TD WIDTH=', $column2_width, '&gt;', $cr)"/>
  <xsl:value-of select="concat('   &lt;P ALIGN=CENTER&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;Name&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
  <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
  <xsl:value-of select="concat('  &lt;TD WIDTH=', $column3_width, '&gt;', $cr)"/>
  <xsl:value-of select="concat('   &lt;P ALIGN=CENTER&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;Description&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
  <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;/TR&gt;', $cr)"/>

  <xsl:for-each select="Order-Status/Success-Codes/Status">

    <xsl:variable name="status_code" select="@Number"/>
    <xsl:variable name="status_name" select="@Name"/>
    <xsl:variable name="status_description" select="@Description"/>

    <xsl:value-of select="concat(' &lt;TR VALIGN=TOP&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;TD ROWSPAN=1 WIDTH=', $column1_width, '&gt;', $cr)"/>
    <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $status_code, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;TD WIDTH=', $column2_width, '&gt;', $cr)"/>
    <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $status_name, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;TD WIDTH=', $column3_width, '&gt;', $cr)"/>
    <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $status_description, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
    <xsl:value-of select="concat(' &lt;/TR&gt;', $cr)"/>

  </xsl:for-each> <!--/AAR-System-Data/Order-Status/Success-Codes/Status  -->
  <xsl:value-of select="concat('&lt;/TABLE&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;P STYLE=&quot;margin-bottom: 0in&quot;&gt;&lt;BR&gt;', $cr)"/>

  <!-- Write out the failure codes table -->
  <xsl:value-of select="concat('&lt;P ALIGN=CENTER STYLE=&quot;background: transparent&quot;&gt;&lt;FONT&gt;&lt;B&gt;Table 4.2 Order Status Failure Codes&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>

  <xsl:value-of select="concat('&lt;TABLE WIDTH=', $table_width, ' BORDER=1 BORDERCOLOR=&quot;#000000&quot; CELLPADDING=4 CELLSPACING=0&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;COL WIDTH=', $column1_width, '&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;COL WIDTH=', $column2_width, '&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;COL WIDTH=', $column3_width, '&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;TR VALIGN=TOP&gt;', $cr)"/>
  <xsl:value-of select="concat('  &lt;TD WIDTH=', $column1_width, '&gt;', $cr)"/>
  <xsl:value-of select="concat('   &lt;P ALIGN=CENTER STYLE=&quot;font-style: normal&quot;&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;#&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
  <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
  <xsl:value-of select="concat('  &lt;TD WIDTH=', $column2_width, '&gt;', $cr)"/>
  <xsl:value-of select="concat('   &lt;P ALIGN=CENTER&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;Name&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
  <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
  <xsl:value-of select="concat('  &lt;TD WIDTH=', $column3_width, '&gt;', $cr)"/>
  <xsl:value-of select="concat('   &lt;P ALIGN=CENTER&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;&lt;B&gt;Description&lt;/B&gt;&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
  <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
  <xsl:value-of select="concat(' &lt;/TR&gt;', $cr)"/>

  <xsl:for-each select="Order-Status/Failure-Codes/Status">

    <xsl:variable name="status_code" select="@Number"/>
    <xsl:variable name="status_name" select="@Name"/>
    <xsl:variable name="status_description" select="@Description"/>

    <xsl:value-of select="concat(' &lt;TR VALIGN=TOP&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;TD ROWSPAN=1 WIDTH=', $column1_width, '&gt;', $cr)"/>
    <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $status_code, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;TD WIDTH=', $column2_width, '&gt;', $cr)"/>
    <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $status_name, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;TD WIDTH=', $column3_width, '&gt;', $cr)"/>
    <xsl:value-of select="concat('   &lt;P&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $status_description, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
    <xsl:value-of select="concat('  &lt;/TD&gt;', $cr)"/>
    <xsl:value-of select="concat(' &lt;/TR&gt;', $cr)"/>

  </xsl:for-each> <!--/AAR-System-Data/Order-Status/Success-Codes/Status  -->
  <xsl:value-of select="concat('&lt;/TABLE&gt;', $cr)"/>
  <xsl:value-of select="concat('&lt;P STYLE=&quot;margin-bottom: 0in&quot;&gt;&lt;BR&gt;', $cr)"/>

</xsl:template> <!-- generate-doc-orders -->


<!--
!! TEMPLATE:     generate-doc-parameter
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 22 February 2007
!! DESCRIPTION:  This template generates the descriptive text for a Parameter
!!               node within an HTML document. This consists of the description,
!!               and if the Parameter is a static vocabulary item, the
!!               associated values.
-->
<xsl:template name="generate-doc-parameter">
  <xsl:param name="parameter_node"/>
  <xsl:param name="static_node"/>

  <xsl:choose>
    <!-- Check for non-existent node -->
    <xsl:when test="not($parameter_node)">
      <xsl:value-of select="'&lt;P STYLE=&quot;margin-bottom: 0in&quot;&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;Not Used&lt;/FONT&gt;&lt;/P&gt;'"/>
    </xsl:when>

    <!-- Node exists but has no descriptive data -->
    <xsl:when test="$parameter_node/@Description = ''">
      <xsl:value-of select="'&lt;P STYLE=&quot;margin-bottom: 0in&quot;&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;Not Used&lt;/FONT&gt;&lt;/P&gt;'"/>
    </xsl:when>

    <!-- Node is a vocabulary item -->
    <xsl:when test="$parameter_node/@Renderer = 'Vocabulary'">
      <xsl:value-of select="concat('&lt;P STYLE=&quot;margin-bottom: 0in&quot;&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $parameter_node/@Description, '&lt;/FONT&gt;&lt;/P&gt;')"/>

      <!-- If this is a static vocabulary item, list the options -->
      <xsl:variable name="vocab" select="$parameter_node/@Argument"/>
      <xsl:variable name="vocab_node" select="$static_node/static.voc/*[name() = $vocab]"/>
      <xsl:if test="$vocab_node">
        <xsl:value-of select="concat('&lt;P STYLE=&quot;margin-bottom: 0in&quot;&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;Allowed Values Are:&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
        <xsl:value-of select="concat('&lt;UL&gt;', $cr)"/>
        <xsl:for-each select="$vocab_node/entry">
          <xsl:value-of select="concat('&lt;LI&gt;', @value, ' - ', @name, '&lt;/LI&gt;', $cr)"/>
        </xsl:for-each>
        <xsl:value-of select="concat('&lt;UL&gt;', $cr)"/>
      </xsl:if>
    </xsl:when>

    <!-- just use the description for the text -->
    <xsl:otherwise>
      <xsl:value-of select="concat('&lt;P STYLE=&quot;margin-bottom: 0in&quot;&gt;&lt;FONT COLOR=&quot;#000000&quot;&gt;', $parameter_node/@Description, '&lt;/FONT&gt;&lt;/P&gt;', $cr)"/>
    </xsl:otherwise>

  </xsl:choose>

</xsl:template> <!-- generate-doc-parameter -->


<!--
!! TEMPLATE:     node-to-database-type
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 21 March 2007
!! DESCRIPTION:  This template expects a common knowledge node and will
!!               determine the Oracle database type from it. The type is
!!               returned as a value-of. The parameter should be the JDSP
!!               XML file (as a tree fragment).
-->
<xsl:template name="node-to-database-type">
  <xsl:param name="jdsp_tree"/>

  <!-- If the attribute has a maximum length it is a string; Otherwise, if its
       a real we assign it as a float, anything else must be an integer -->
  <xsl:choose>
    <xsl:when test="not(@db-column-width)">
      <xsl:choose>
        <xsl:when test="@uom = 'days'">
          <xsl:value-of select="'DATE'"/>
        </xsl:when>
        <xsl:when test="@type='JEDI'">
          <xsl:value-of select="'NUMBER(20)'"/>
        </xsl:when>
        <xsl:when test="@type='REAL_32'">
          <xsl:value-of select="'FLOAT'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'NUMBER(10)'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <!-- Translate the max length from a macro name to an integer -->
      <xsl:variable name="max_length" select="@db-column-width"/>
      <xsl:variable name="integer_length">
        <xsl:for-each select="$jdsp_tree/JTLS-Data-System-Protocol/constants/*[name() = $max_length]">
          <xsl:value-of select="@value"/>
        </xsl:for-each>
      </xsl:variable>
      <xsl:value-of select="concat('VARCHAR2(', $integer_length, ')')"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- node-to-database-type -->


<!--
!! TEMPLATE:     get-event-object-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 22 March 2007
!! DESCRIPTION:  This template gets the name used within the code to specify an
!!               object from an object event table name. This consists of the
!!               object name in upper case minus any "aar_" prefix and "_event"
!!               suffix.
-->
<xsl:template name="get-event-object-name">
  <xsl:param name="base_name"/>

  <xsl:variable name="macro_name">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="$base_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="contains($macro_name, '_EVENT')">
      <xsl:value-of select="substring-before($macro_name, '_EVENT')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$macro_name"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- get-event-object-name -->


<!--
!! TEMPLATE:     get-macro-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This template gets the macro name used with the AAR object.
!!               It expects the full object name and removes any "AAR_" prefix.
-->
<xsl:template name="get-macro-name">
  <xsl:param name="base_name"/>

  <xsl:choose>
    <xsl:when test="contains($base_name, 'AAR_')">
      <xsl:value-of select="substring-after($base_name, 'AAR_')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$base_name"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template> <!-- get-macro-name -->


<!--
!! TEMPLATE:     find-vocabulary-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 29 September 2006
!! DESCRIPTION:  This template expects the current path to be pointing to a
!!               common knowledge subitem (an attribute) of an object. The
!!               template determines the vocabulary that might be associated
!!               with the attribute. If there is no associated template then
!!               the value is "". Otherwise, it will be the vocabulary name.
!!               Vocabularies may be a variable of the attribute or may be
!!               a variable of the attribute's type (enumeration or typedef).
!!               All places must be checked.
-->
<xsl:template name="find-vocabulary-name">

  <xsl:choose>
    <xsl:when test="not(string-length(@vocab) = 0)">
      <xsl:value-of select="@vocab"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="type" select="@type"/>
      <xsl:variable name="enum_count" select="count($jdsp_enumerated_nodes[name()=$type])"/>
      <xsl:choose>
        <xsl:when test="$enum_count != 0">
          <xsl:value-of select="$jdsp_enumerated_nodes[name()=$type]/@vocab"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$jdsp_typedef_nodes[name() = $type]/@vocab"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- find-vocabulary-name -->

</xsl:stylesheet>
