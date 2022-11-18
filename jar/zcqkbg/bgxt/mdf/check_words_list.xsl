<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
file_name : $JTLSHOME/script/xsl/orders_def.xsl
program description : 
            This stylesheet will be included in orders_def.xsl and 
            verify_order.xsl

create    : 8-14-07
-->

<!-- BE Facility check words (UNDEFINED) -->
<xsl:variable name="be-check-words">
  <xsl:text>NOT,DEFINED</xsl:text>
</xsl:variable>

<!-- DMPI check words (UNDEFINED) -->
<xsl:variable name="dmpi-check-words">
  <xsl:text>NOT,DEFINED</xsl:text>
</xsl:variable>

<!-- Input Type words variable -->
<xsl:variable name="input-words">
  <xsl:text>map,list,keyboard</xsl:text>
</xsl:variable>

<!-- require Type words variable -->
<xsl:variable name="require-words">
  <xsl:text>MANDATORY,OPTIONAL,ALTMAN,ALTOPT</xsl:text>
</xsl:variable>

<!-- Mission_Type digits words variable -->
<xsl:variable name="mission-type-words">
  <xsl:text>airlift,transport,awacs,airref,cas,escort,recce,armed_recce,</xsl:text>
  <xsl:text>ec,air_attack,wild_weasel,transfer,cap,mine_warfare,</xsl:text>
  <xsl:text>orbiting_oas,patrol,insert_extract,strategic_lift</xsl:text>
</xsl:variable>

<!-- Mission fill/with/types -->
<xsl:variable name="mission-fill-with">
  <xsl:text>airmission,cruise_missile</xsl:text>
</xsl:variable>

<!-- relationship words variable -->
<xsl:variable name="relationship-words">
  <xsl:text>friendly,neutral,suspect,enemy</xsl:text>
</xsl:variable>

<!-- side check words variable -->
<xsl:variable name="side-check-words">
  <xsl:text>this_side,other_side,any</xsl:text>
</xsl:variable>

<!-- type of target category words variable -->
<xsl:variable name="target-category-words">
  <xsl:text>sam_aaa,bridge,tunnel,sensor_site,runway,interdiction_pt,</xsl:text>
  <xsl:text>supply_storage,ssm,facility,aircraft_shelters,mhe,minefield,</xsl:text>
  <xsl:text>pumping_station,jammer,comm_site,ship,combat_arms,vehicles,</xsl:text>
  <xsl:text>aircraft,small_boat,supply_type</xsl:text>
</xsl:variable>

<!-- unit checks words variable -->
<xsl:variable name="unit-check-words">
  <xsl:text>on_the_same_side,not_in_the_theater,acknowledge_the_receipt,</xsl:text>
  <xsl:text>dead,inactive,out_of_the_game,embarked,amphibious_operation,</xsl:text>
  <xsl:text>split,current_child,forward_detachment,cancel_orders,</xsl:text>
  <xsl:text>order_is_accepted,resting_status,on_the_same_side_rejected,</xsl:text>
  <xsl:text>off_the_game_board,transported</xsl:text>
</xsl:variable>

<!-- unit type words variable -->
<xsl:variable name="unit-type-words">
  <xsl:text>airbase,ground,squadron,support,naval,farp,hru,unidentified_unit</xsl:text>
</xsl:variable>

<!-- external model words variable -->
<xsl:variable name="external-model-words">
  <xsl:text>JTLS_ONLY,JTLS,JCATS,JDLM,PIOVRA,MUSE</xsl:text>
</xsl:variable>

<!-- Reserved Oracle keywords that can not be used as field labels -->
<xsl:variable name="oracle-keywords">
  <keywords>
    <keyword name="access"/>
    <keyword name="add"/>
    <keyword name="all"/>
    <keyword name="alter"/>
    <keyword name="and"/>
    <keyword name="any"/>
    <keyword name="arraylen"/>
    <keyword name="as"/>
    <keyword name="asc"/>
    <keyword name="audit"/>
    <keyword name="between"/>
    <keyword name="by"/>
    <keyword name="char"/>
    <keyword name="check"/>
    <keyword name="cluster"/>
    <keyword name="column"/>
    <keyword name="comment"/>
    <keyword name="compress"/>
    <keyword name="connect"/>
    <keyword name="create"/>
    <keyword name="current"/>
    <keyword name="date"/>
    <keyword name="decimal"/>
    <keyword name="default"/>
    <keyword name="delete"/>
    <keyword name="desc"/>
    <keyword name="distinct"/>
    <keyword name="drop"/>
    <keyword name="else"/>
    <keyword name="exclusive"/>
    <keyword name="exists"/>
    <keyword name="file"/>
    <keyword name="float"/>
    <keyword name="for"/>
    <keyword name="from"/>
    <keyword name="grant"/>
    <keyword name="group"/>
    <keyword name="having"/>
    <keyword name="identified"/>
    <keyword name="immediate"/>
    <keyword name="in"/>
    <keyword name="increment"/>
    <keyword name="index"/>
    <keyword name="initial"/>
    <keyword name="insert"/>
    <keyword name="integer"/>
    <keyword name="intersect"/>
    <keyword name="into"/>
    <keyword name="is"/>
    <keyword name="level"/>
    <keyword name="like"/>
    <keyword name="lock"/>
    <keyword name="long"/>
    <keyword name="maxextents"/>
    <keyword name="minus"/>
    <keyword name="mode"/>
    <keyword name="modify"/>
    <keyword name="noaudit"/>
    <keyword name="nocompress"/>
    <keyword name="not"/>
    <keyword name="notfound"/>
    <keyword name="nowait"/>
    <keyword name="null"/>
    <keyword name="number"/>
    <keyword name="of"/>
    <keyword name="offline"/>
    <keyword name="on"/>
    <keyword name="online"/>
    <keyword name="option"/>
    <keyword name="or"/>
    <keyword name="order"/>
    <keyword name="pctfree"/>
    <keyword name="prior"/>
    <keyword name="privileges"/>
    <keyword name="public"/>
    <keyword name="raw"/>
    <keyword name="rename"/>
    <keyword name="resource"/>
    <keyword name="revoke"/>
    <keyword name="row"/>
    <keyword name="rowid"/>
    <keyword name="rowlabel"/>
    <keyword name="rownum"/>
    <keyword name="rows"/>
    <keyword name="select"/>
    <keyword name="session"/>
    <keyword name="set"/>
    <keyword name="share"/>
    <keyword name="size"/>
    <keyword name="smallint"/>
    <keyword name="sqlbuf"/>
    <keyword name="start"/>
    <keyword name="successful"/>
    <keyword name="synonym"/>
    <keyword name="sysdate"/>
    <keyword name="table"/>
    <keyword name="then"/>
    <keyword name="to"/>
    <keyword name="trigger"/>
    <keyword name="uid"/>
    <keyword name="union"/>
    <keyword name="unique"/>
    <keyword name="update"/>
    <keyword name="user"/>
    <keyword name="validate"/>
    <keyword name="values"/>
    <keyword name="varchar"/>
    <keyword name="varchar2"/>
    <keyword name="view"/>
    <keyword name="whenever"/>
    <keyword name="where"/>
    <keyword name="with"/>
  </keywords>
</xsl:variable>

<!-- Reserved OEC keywords that can not be used as field labels -->
<xsl:variable name="oec-keywords">
  <keywords>
    <keyword name="client_name"/>
    <keyword name="sequence_number"/>
  </keywords>
</xsl:variable>

</xsl:stylesheet>
