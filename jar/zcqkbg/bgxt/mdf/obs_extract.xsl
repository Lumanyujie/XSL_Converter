<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
!! FILE:         obs_extract.xsl
!! DESCRIPTION:  This stylesheet extracts information from an OBS file for
!!               use by the ELS, JHIP, and JTB programs. The extracted data
!!               is written into data files. The files consist of:
!!               1) <scenario>.eh a listing of combat system entity IDS and
!!                  owners
!!               2) <scenario>.uh a listing of unit ids, hierarchy, and
!!                  templates
!!
!!               Run with
!!               saxon <OBS_file>.xml obs_extract.xsl jtlshome=$JTLSHOME
!!                     scenario=<scenario_name>
!!
!!
-->
<xsl:param name="jtlshome" select="'/home/jtlsdev'"/>
<xsl:param name="scenario" select="'fubar'"/>
<xsl:output method="text"/>

<!-- Variable definitions. -->

<xsl:variable name="els_dir" select="concat($jtlshome, '/data/scenario/', $scenario, '/els')"/>

<!-- useful text variables -->
<xsl:variable name="cr">
<xsl:text>
</xsl:text>
</xsl:variable>

<xsl:variable name="tab">
<xsl:text>	</xsl:text>
</xsl:variable>

<xsl:variable name="apos">
<xsl:text>'</xsl:text>
</xsl:variable>


<!--
!! TEMPLATE:     match /UGUdata
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 02 November 2007
!! DESCRIPTION:  This is the single top-level template for the data parsing.
!!               it calls the individual templates that perform each of the
!!               output tasks.
-->
<xsl:template match="/UGUdata">

  <!-- Create the output file that will contain commandable unit names and ID data -->
  <xsl:variable name="filename_hip_names" select="concat($els_dir, '/', $scenario, '.hip_names')"/>
  <xsl:document method="text" href="{$filename_hip_names}">
    <xsl:call-template name="gen-hipnames-file"/>
  </xsl:document>

  <!-- Create the output file that will contain entity hierarchy and ID data -->
  <xsl:variable name="filename_eh" select="concat($els_dir, '/', $scenario, '.eh')"/>
  <xsl:document method="text" href="{$filename_eh}">
    <xsl:call-template name="gen-entity-file"/>
  </xsl:document>

  <!-- Create the output file that will contain unit hierarchy and ID data -->
  <xsl:variable name="filename_uh" select="concat($els_dir, '/', $scenario, '.uh')"/>
  <xsl:document method="text" href="{$filename_uh}">
    <xsl:call-template name="gen-unit-file"/>
  </xsl:document>

</xsl:template> <!-- match /UGUdata -->


<!--
!! TEMPLATE:     gen-hipnames-file
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 05 April 2006
!! DESCRIPTION:  This template extracts a list of unit names and IDs
!!               from the OBS data and writes it in the following format:
!!               unit_name object_id
-->
<xsl:template name="gen-hipnames-file">

   <!-- Go through all the units and determine which ones are JTLS owned
        units and are commandable units.  Produce a list of unit names
        and their entity IDs.  -->
   <xsl:for-each select="UnitList/Unit[ELSData/@CommandableFlag = 'true']">
      <xsl:value-of select="concat(@InstanceName, $tab, EntityID, $cr)"/>
   </xsl:for-each>

</xsl:template> <!-- gen-hipnames-file -->

<!--
!! TEMPLATE:     gen-unit-file
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 02 November 2007
!! DESCRIPTION:  This template extarcts the unit name, parent unit, template
!!               name and ID from the OBS data and writes it in the following
!!               format:
!!               parent_unit unit template object_id
-->
<xsl:template name="gen-unit-file">

  <xsl:for-each select="UnitList/Unit">
    <xsl:variable name="unit_name" select="@InstanceName"/>
    <xsl:variable name="superior_id" select="TOESuperior"/>

    <xsl:variable name="superior_name">
      <xsl:choose>
        <xsl:when test="string-length($superior_id) != 0">
          <xsl:for-each select="/UGUdata/UnitList/Unit[EntityID = $superior_id]">
            <xsl:value-of select="@InstanceName"/>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'NONE'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="template">
      <xsl:choose>
        <xsl:when test="string-length(ELSData/@PrototypeName) != 0">
          <xsl:value-of select="ELSData/@PrototypeName"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="ELSData/@TargetSubcategory"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="objtype">
      <xsl:choose>
        <xsl:when test="string-length(ELSData/@PrototypeName) != 0">
          <xsl:choose>
             <xsl:when test="ELSData/@UnitType = 'HRU'">
               <xsl:value-of select="'HRU'"/>
             </xsl:when>
             <xsl:otherwise>
               <xsl:value-of select="'UT'"/>
             </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'TG'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:value-of select="concat($superior_name, $tab, $unit_name, $tab, $objtype, $tab, $template, $tab, EntityID, $cr)"/>
  </xsl:for-each>

</xsl:template> <!-- gen-unit-file -->

<!--
!! TEMPLATE:     gen-entity-file
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 02 November 2007
!! DESCRIPTION:  This template extracts the entity system name, owner, and ID
!!               from the OBS data and writes it in the following format:
!!               owning_unit object_name object_id
-->
<xsl:template name="gen-entity-file">

  <xsl:for-each select="UnitList/Unit">
    <xsl:variable name="unit_name" select="@InstanceName"/>

    <xsl:variable name="objtype">
      <xsl:choose>
        <xsl:when test="string-length(ELSData/@PrototypeName) != 0">
          <xsl:choose>
             <xsl:when test="ELSData/@UnitType = 'HRU'">
               <xsl:value-of select="'HRU'"/>
             </xsl:when>
             <xsl:otherwise>
               <xsl:value-of select="'UT'"/>
             </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'TG'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:for-each select="CombatSystemsList/CombatSystem">
      <xsl:value-of select="concat($unit_name, $tab, $objtype, $tab, @JTLSCSName, $tab, EntityID, $cr)"/>
    </xsl:for-each>
  </xsl:for-each>

</xsl:template> <!-- gen-entity-file -->

</xsl:stylesheet> <!-- gen-entity-file -->
