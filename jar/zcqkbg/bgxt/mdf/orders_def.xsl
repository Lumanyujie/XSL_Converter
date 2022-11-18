<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
file_name : $JTLSHOME/script/xsl/orders_def.xsl
author    : E. Lippi
program description : 
            This stylesheet processes ordersdef.xml and regenerates orders.def file.
created   : 1-15-04

modified  : 2-2-04
            Added field name to field number conversion.
            H. Yeverino 
-->

<!-- To run:
xalan -xsl orders_def.xsl -in ordersdef.xml -out orders_test.def
-->

<xsl:output method="text"/>

<xsl:include href="check_words_list.xsl"/>

<!-- new line text variables -->
<xsl:variable name="cr">
<xsl:text>
</xsl:text>
</xsl:variable>

<!-- one space -->
<xsl:variable name="space">
  <xsl:text> </xsl:text>
</xsl:variable>
<!-- space before -->
<xsl:variable name="pre-space-3">
  <xsl:text>   </xsl:text>
</xsl:variable>
<xsl:variable name="pre-space-4">
  <xsl:text>    </xsl:text>
</xsl:variable>
<xsl:variable name="pre-space-6">
  <xsl:text>      </xsl:text>
</xsl:variable>
<xsl:variable name="pre-space-9">
  <xsl:text>         </xsl:text>
</xsl:variable>

<xsl:template match="/orders-def">
  <xsl:call-template name="write-illegal-characters"/>
  <!-- get a largest number of utility and orders -->
  <xsl:for-each select="utility/order | orders/order">
    <xsl:sort select="@number" data-type="number" order="ascending"/>
    <xsl:if test="position()=last()">
      <xsl:value-of select="@number"/>
    </xsl:if>
  </xsl:for-each>
  <xsl:value-of select="concat($cr,$cr)"/>
  <!-- write UTILITY -->
  <xsl:call-template name="utility-order-loop">
    <xsl:with-param name="select-node"   select="utility/order"/>
    <xsl:with-param name="utility-order" select="'utility'"/>
  </xsl:call-template>
  <!-- write ORDER -->
  <xsl:call-template name="utility-order-loop">
    <xsl:with-param name="select-node"   select="orders/order"/>
    <xsl:with-param name="utility-order" select="'order'"/>
  </xsl:call-template>
  <!-- end -->
  <xsl:value-of select="concat('*',$cr)"/>
</xsl:template>  


<xsl:template name="utility-order-loop">
  <xsl:param name="select-node"/>
  <xsl:param name="utility-order"/>
  <xsl:for-each select="$select-node">
    <xsl:choose>
      <xsl:when test="$utility-order = 'utility'">
        <xsl:call-template name="write-utility"/>
      </xsl:when>
      <xsl:when test="$utility-order = 'order'">
        <xsl:call-template name="write-order"/>
      </xsl:when>
    </xsl:choose>
    <xsl:value-of select="concat($cr,$cr)"/>
    <!-- help description -->
    <xsl:call-template name="write-help">
      <xsl:with-param name="pre-space" select="$pre-space-3"/>
    </xsl:call-template>
    <xsl:value-of select="concat($cr, '')"/>
    <!-- number of fields -->
    <xsl:text>   </xsl:text>
    <xsl:variable name="field-count" select="count(fields/field)"/>
    <xsl:value-of select="$field-count"/>
    <xsl:value-of select="concat($cr,'')"/>
    <!-- fields description -->
    <xsl:if test="$field-count &gt; 0">
      <xsl:value-of select="concat($cr,'')"/>
      <xsl:call-template name="write-field">
        <xsl:with-param name="select-node" select="fields/field"/>
        <xsl:with-param name="field-silent" select="'field'"/>
      </xsl:call-template>
    </xsl:if> 
    <!-- number of silent fields -->
    <xsl:value-of select="concat($cr,'')"/>
    <xsl:variable name="silent-field-count" select="count(silent-fields/silent-field)"/>
    <xsl:text>   </xsl:text>
    <xsl:value-of select="$silent-field-count"/>
    <xsl:value-of select="concat($cr,$cr)"/>
    <!-- silent fields description -->
    <!-- Put out silent fields for both Orders and Utilities. -->
    <!--xsl:if test="$utility-order = 'order'"-->
      <xsl:if test="$silent-field-count &gt; 0"> 
        <xsl:call-template name="write-silent-field"/>
        <xsl:value-of select="concat($cr, '')"/>
      </xsl:if>
    <!--/xsl:if-->
    
    <!-- number of group -->
    <xsl:text>   GROUPS </xsl:text>
    <xsl:variable name="groups-count" select="count(groups/group)"/>
    <xsl:value-of select="$groups-count"/>
    <xsl:value-of select="concat($cr,$cr)"/>
    <!-- group description -->
    <xsl:call-template name="write-groups"/>
    <!-- queue description -->
    <xsl:call-template name="write-queue"/>
    <!-- quick description -->
    <xsl:call-template name="write-quick"/>
    <!-- msend description -->
    <xsl:call-template name="write-msend"/>
    <!-- number of constrainst -->
    <xsl:variable name="constrains-count" select="count(constraints/constraint)"/>
    <xsl:text>   </xsl:text>
    <xsl:value-of select="$constrains-count"/>
    <xsl:value-of select="concat($cr,$cr)"/>
    <!-- constrainst description -->
    <xsl:call-template name="write-constraint"/>
    <xsl:if test="$constrains-count &gt; 0">
      <xsl:value-of select="concat($cr,'')"/>
    </xsl:if>
    <!-- number of graphic specification(not used)-->
    <xsl:text>   0</xsl:text>
    <xsl:value-of select="concat($cr, $cr)"/>   
  </xsl:for-each>
</xsl:template>


<xsl:template name="write-illegal-characters">
  <xsl:value-of select="string-length(common/illegal-characters)"/>
  <xsl:text>  </xsl:text>
  <xsl:call-template name="illegal_char_loop"/>
  <xsl:value-of select="concat($cr,$cr)"/>
</xsl:template>


<!-- This template works like the following for loop:
     for (int index=1; index-1 LESS_THAN 6; index++) {
        print illegal_chars[index] + " "
     }
-->
<xsl:template name="illegal_char_loop">
  <xsl:param name="index" select="1"/>

  <!-- Inside Loop -->
  <xsl:text>\</xsl:text>
  <xsl:value-of select="substring(common/illegal-characters,$index,1)"/>

  <!-- increment and continue -->
  <xsl:if test="$index &lt; string-length(common/illegal-characters)">
    <xsl:text> </xsl:text>
    <xsl:call-template name="illegal_char_loop">
      <xsl:with-param name="index" select="$index + 1"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>


<xsl:template name="write-utility">
   <xsl:text>UTILITY </xsl:text>
   <xsl:value-of select="@name"/>
   <xsl:text> </xsl:text>
   <xsl:value-of select="@short-name"/>
   <xsl:text> </xsl:text>
   <!-- constant number -->
   <xsl:text>1 </xsl:text>
   <xsl:value-of select="@number"/>
   <xsl:text> </xsl:text>
   <xsl:value-of select="@max-entries"/>
   <xsl:text> </xsl:text> 
   <xsl:choose>
     <xsl:when test="@unique-entries = 'true'">
       <xsl:text>1</xsl:text>
     </xsl:when>
     <xsl:otherwise>
       <xsl:text>0</xsl:text>
     </xsl:otherwise>
   </xsl:choose>
   <xsl:text> </xsl:text>
   <!-- initialized -->
   <xsl:choose>
     <xsl:when test="@initialized = 'true'">
       <xsl:text>1</xsl:text>
     </xsl:when>
     <xsl:otherwise>
       <xsl:text>0</xsl:text>
     </xsl:otherwise>
   </xsl:choose>
</xsl:template>


<xsl:template name="write-order">
   <xsl:text>ORDER </xsl:text>
   <xsl:value-of select="@name"/>
   <xsl:text> </xsl:text>
   <xsl:value-of select="@short-name"/>
   <xsl:text> </xsl:text>
   <xsl:choose>
     <xsl:when test="@create-for = 'controller'">
       <xsl:text>1 </xsl:text>
     </xsl:when>
     <xsl:when test="@create-for = 'player'">
       <xsl:text>2 </xsl:text>
     </xsl:when>
     <xsl:otherwise>
       <xsl:text>3 </xsl:text>
     </xsl:otherwise>
   </xsl:choose>
   <xsl:value-of select="@number"/>
   <xsl:text> </xsl:text>
   <xsl:choose>
     <xsl:when test="@delay = 'none'">
       <xsl:text>1 </xsl:text>
     </xsl:when>
     <xsl:when test="@delay = 'hhq'">
       <xsl:text>2 </xsl:text>
     </xsl:when>
     <xsl:otherwise>
       <xsl:text>3 </xsl:text>
     </xsl:otherwise>
   </xsl:choose>
   <xsl:call-template name="true-false-to-one-zero">
     <xsl:with-param name="true-false" select="@acquirable"/>
   </xsl:call-template>
   <xsl:text> </xsl:text>
   <xsl:call-template name="true-false-to-one-zero">
     <xsl:with-param name="true-false" select="@critical-order"/>
   </xsl:call-template>
     <xsl:text> </xsl:text>
   <xsl:call-template name="true-false-to-one-zero">
     <xsl:with-param name="true-false" select="@initialize"/>
   </xsl:call-template>
</xsl:template>


<xsl:template name="write-silent-field">
  <xsl:call-template name="write-field">
    <xsl:with-param name="select-node"  select="silent-fields/silent-field"/>
    <xsl:with-param name="field-silent" select="'silent-field'"/>
  </xsl:call-template>
</xsl:template>
 

<xsl:template name="write-field">
   <xsl:param name="select-node"/>
   <xsl:param name="field-silent"/>
   <xsl:for-each select="$select-node">
     <!-- this variable will be used to count length of a line for UT -->
     <xsl:variable name="ut-label">
       <xsl:value-of select="@label"/>
     </xsl:variable>
     
     <xsl:variable name="field-class">
        <!-- transform various class names from WHIP
        names to orders.def names. There are order fields
        that are specified as TEXT in the old orders.def
        but are now specified are a 'JXSR' data field that
        allows the user to select from a ComboBox. These
        'JXSR' data fields need to be written out as the old TEXT
        fields for the OPP and CEP to read. -->
        <xsl:choose>
           <xsl:when test="class/@is = 'GENERIC_OBJECT'">
               <xsl:value-of select="'TEXT'"/>
           </xsl:when>
           <xsl:when test="class/@is = 'PLAYER_MIP'">
               <xsl:value-of select="'TEXT'"/>
           </xsl:when>
           <xsl:when test="class/@is = 'OP_AREA'">
               <xsl:value-of select="'TEXT'"/>
           </xsl:when>
           <xsl:otherwise>
              <xsl:value-of select="class/@is"/>
           </xsl:otherwise>
        </xsl:choose>
     </xsl:variable>
     
     <!-- Write the field label --> 
     <xsl:text>   "</xsl:text>
     <xsl:value-of select="@label"/>
     <xsl:text>" </xsl:text>
     
     <!-- If this is regular field, write out MANDATORY, ALTMAN etc. -->
     <xsl:if test="$field-silent = 'field'">
       <xsl:value-of select="@require"/>
       <xsl:text> </xsl:text>
     </xsl:if>
     
     <!-- Put out the field class followed by a space. -->
     <xsl:value-of select="concat($field-class,' ')"/>
     
     <!-- select field type -->
     <!-- Handle type specific attributes. -->
     <xsl:choose>
     
       <!-- **** BEARING **** -->
       <!-- BEARING has no custom attributes. -->
              
       <!-- **** BE_FACILITY **** -->
       <!-- The BE checks are yet to be defined and are always put out
            as 0000.
            
            The allowable input methods is converted from the input-words
            list map,list,keyboard.
         -->
       <xsl:when test="$field-class = 'BE_FACILITY'">
         <!-- BE check digits are currently not used -->
         <!-- USE THIS CODE after BE check bits are defined 
         <xsl:call-template name="list-to-bits">
           <xsl:with-param name="list" select="class/@be-checks"/>
           <xsl:with-param name="words" select="$dmpi-check-words"/>
         </xsl:call-template>   
           -->
         <xsl:text>0000 </xsl:text>
       
         <!-- BE Facility input check -->
         <xsl:call-template name="list-to-bits">
           <xsl:with-param name="list" select="class/@input"/>
           <xsl:with-param name="words" select="$input-words"/>
         </xsl:call-template> 
         <xsl:text> </xsl:text>
       </xsl:when>
 
       <!-- **** DATA_V **** -->
       <!-- class/@sort is the sort bit.
            
            class/@name is the Vocabulary name. 
         -->
       <xsl:when test="$field-class = 'DATA_V'">
         <!-- Write the sort bit. -->
         <xsl:call-template name="true-false-to-bit">
           <xsl:with-param name="value" select="class/@sort"/>
         </xsl:call-template>
         <xsl:text> </xsl:text>
         
         <!-- Write the Vocabulary name. -->
         <xsl:value-of select="concat(class/@name,' ')"/>
       </xsl:when>
       
       
       <!-- **** DMPI **** -->
       <!-- The allowable target category bits is derived from the fill 
            condition that checks the category.
            <equal a="DMPI.category" b="sam_aaa,bridge"/>
            
            The DMPI checks are yet to be defined and are always put out
            as 1000.
            
            The allowable input methods is converted from the input-words
            list map,list,keyboard.
         -->
       <xsl:when test="$field-class = 'DMPI'">
         <!-- dmpi type check -->
         <xsl:call-template name="process-tg-category-check"/>
         <xsl:text> </xsl:text>
       
         <!-- dmpi check digits are currently not used -->
         <!-- USE THIS CODE after DMPI check bits are defined 
         <xsl:call-template name="list-to-bits">
           <xsl:with-param name="list" select="class/@dmpi-checks"/>
           <xsl:with-param name="words" select="$dmpi-check-words"/>
         </xsl:call-template>   
           -->
         <xsl:text>1000 </xsl:text>
       
         <!-- dmpi input check -->
         <xsl:call-template name="list-to-bits">
           <xsl:with-param name="list" select="class/@input"/>
           <xsl:with-param name="words" select="$input-words"/>
         </xsl:call-template> 
         <xsl:text> </xsl:text>
       </xsl:when>
       
       
       <!-- **** DURATION **** -->
       <!-- class/@min is the minimum duration
            class/@max is the maximum duration
         -->
       <xsl:when test="$field-class = 'DURATION'">
         <!-- Write the minimum duration -->
         <xsl:value-of select="class/@min"/>
         <xsl:text> </xsl:text>
         
         <!-- Write the maximum duration -->
         <xsl:value-of select="class/@max"/>
         <xsl:text> </xsl:text>
       </xsl:when>
       
       
       <!-- **** FACTION **** -->
       <!-- The side check bit is determined from the fill condition that
            compares the faction side to the THIS_SIDE variable. If that
            condition exists, a 1 is put out, otherwise a 0 is put out.
            
            <equal a="FACTION.side" b="THIS_SIDE"/>
         -->
       <xsl:when test="$field-class = 'FACTION'">
         <xsl:call-template name="process-same-side-check"/>
         <xsl:text> </xsl:text>
       </xsl:when>
       
       
       <!-- **** FLAG **** -->
       <!-- FLAG has no custom attributes. -->
       
       
       <!-- **** FORM **** -->
       <!-- The Side-Relation bits are pulled from the fill condition that
            does the search on SIDE_RELATION objects.
         -->
       <xsl:when test="$field-class = 'FORM'">
         <!-- relationship check -->
         <xsl:call-template name="process-side-relation-check"/>
         <xsl:text> </xsl:text> 
       </xsl:when>
       
       
       <!-- **** FRACTION **** -->
       <!-- class/@precision is the precision.
         -->
       <xsl:when test="$field-class = 'FRACTION'">
         <xsl:value-of select="concat(class/@precision,' ')"/>
       </xsl:when>
       
       
       <!-- field type INTEGER-->
       <!-- class/@min is the minimum value
            class/@max is the maximum value
            class/@uom is the unit of measure that the CEP expects.
         -->
       <xsl:when test="$field-class = 'INTEGER'">
       
         <xsl:value-of select="concat(class/@min,' ')"/>
         
         <xsl:value-of select="concat(class/@max,' ')"/>
         
         <xsl:value-of select="concat(class/@uom,' ')"/>
       </xsl:when>
       
       
       <!-- **** LOCATION **** -->
       <!-- class/@on-game-board is the on game board condition.
            class/@hex-type is the hex type condition.
         -->
       <xsl:when test="$field-class = 'LOCATION'">
       
         <xsl:value-of select="concat(class/@on-game-board,' ')"/>

         <xsl:value-of select="concat(class/@hex-type,' ')"/>
       </xsl:when>
       
       
       <!-- **** MSN **** -->
       <!-- The first enumeration is translated as follows:
            1 - Must be an AIRMISSION
            2 - Must be a  AIRMISSION, CRUISE_MISSILE
            3 - Must be a  CRUISE_MISSILE.
            
            The Mission Type bits are translated from the mission-type-words
            
            The Side checks are as follows:
            01 : NOT THIS_SIDE
            10 : ONLY THIS SIDE
            11 : ALL SIDES
            00 : NO SIDES (INVALID COMBINATION)
         -->
       <xsl:when test="$field-class = 'MSN'">
         <xsl:choose>
           <xsl:when test="$field-silent = 'field'">
             <!-- OBJECT CLASS Check -->
             <!-- Use the fill node -->
             <xsl:call-template name="process-mission-type-check"/>
             <xsl:text> </xsl:text>
 
             <!-- mission_type -->
             <!-- mission_type 'airmission', or 'airmission, cruise_missile'
                  entry should be checked the word(s) exactly it should bshould be.-->
             <xsl:variable name="mission-var">
               <xsl:call-template name="list-to-bits">
                 <xsl:with-param name="list" select="fill/with/@types"/>
                 <xsl:with-param name="words" select="$mission-fill-with"/>
               </xsl:call-template> 
             </xsl:variable>



             <xsl:variable name="mission-type-list">
               <!--$mission-var: airmission = 10, airmission, cruise_missile = 11 -->
               <xsl:if test="$mission-var = 10 or  $mission-var = 11">
                 <xsl:call-template name="get-ac-mission-type-list"/>
               </xsl:if>
             </xsl:variable>
             <xsl:call-template name="list-to-bits">
               <xsl:with-param name="list" select="$mission-type-list"/>
               <xsl:with-param name="words" select="$mission-type-words"/>
             </xsl:call-template> 
             <xsl:text> </xsl:text>
             
             <!-- Side check -->
             <xsl:call-template name="process-msn-same-side-check"/>
             <xsl:text> </xsl:text>
           </xsl:when>

           <!-- Silent Mission field. -->
           <xsl:otherwise>
             <!-- OBJECT CLASS Check -->
             <!-- Use the class/@type -->
             <xsl:choose>
               <xsl:when test="class/@type = 'airmission'">1</xsl:when> 
               <xsl:when test="class/@type = 'air_track'">2</xsl:when> 
               <xsl:otherwise>3</xsl:otherwise> 
             </xsl:choose>
             <xsl:text> </xsl:text>
             
             <!-- mission_type -->
             <xsl:variable name="mission-type-list"
                select="class/@mission_type"/>
             <xsl:call-template name="list-to-bits">
               <xsl:with-param name="list" select="$mission-type-list"/>
               <xsl:with-param name="words" select="$mission-type-words"/>
             </xsl:call-template>
             <xsl:text> </xsl:text>
             
             <!-- Side check -->
             <xsl:choose>
               <xsl:when test="class/@side = 'not-equal'"> 
                 <xsl:text>01 </xsl:text>
               </xsl:when>
               <xsl:when test="class/@side = 'equal'"> 
                 <xsl:text>10 </xsl:text>
               </xsl:when>
               <xsl:otherwise>
                 <xsl:text>11 </xsl:text>
               </xsl:otherwise>
             </xsl:choose>
           </xsl:otherwise>
         </xsl:choose>
       </xsl:when>
       
       
       <!-- **** MSN_NAME **** -->
       <!-- class/@max-length is the maximum length of the field.
         -->
       <xsl:when test="$field-class = 'MSN_NAME'">
         <xsl:value-of select="concat(class/@max-length,' ')"/>
       </xsl:when>


       <!-- **** PIPE **** -->
       <!-- The Side-Relation bits are pulled from the fill condition that
            does the search on SIDE_RELATION objects.
         -->
       <xsl:when test="$field-class = 'PIPE'">
         <!-- relationship check -->
         <xsl:call-template name="process-side-relation-check"/>
         <xsl:text> </xsl:text>
       </xsl:when>
       
       
       <!-- **** POLYGON **** -->
       <!-- class/@max-vertices are the maximum vertices allowed
            class/@polygon-type
               0 : polyline
               1 : polygon
         -->
       <xsl:when test="$field-class = 'POLYGON'">
         <xsl:value-of select="concat(class/@max-vertices,' ')"/>
         <xsl:choose>
           <xsl:when test="class/@polygon-type = 'polygon'">1</xsl:when>
           <xsl:otherwise>0</xsl:otherwise>
         </xsl:choose>
         <xsl:text> </xsl:text>
       </xsl:when>
       
       
       <!-- **** REAL **** -->
       <!-- class/@min is the minimum value
            class/@max is the maximum value
            class/@precision is the precision
            class/@uom is the unit of measure
         -->
       <xsl:when test="$field-class = 'REAL'">
         <xsl:value-of select="concat(class/@min,' ')"/>
         <xsl:value-of select="concat(class/@max,' ')"/>
         <xsl:value-of select="concat(class/@precision,' ')"/>
         <xsl:value-of select="concat(class/@uom,' ')"/>
       </xsl:when>
       
       
       <!-- **** RECTANGLE **** -->
       <!--  RECTANGLE has no custom attributes -->
       
       
       <!-- **** STATIC_V **** -->
       <!-- class/@sort
              true  : sort the values
              false : do not sort
            class/@name is the vocabulary name.
         -->
       <xsl:when test="$field-class = 'STATIC_V'">
         <xsl:call-template name="true-false-to-bit">
           <xsl:with-param name="value" select="class/@sort"/>
         </xsl:call-template>
         <xsl:text> </xsl:text>
         <xsl:value-of select="class/@name"/>
         <xsl:text> </xsl:text>
       </xsl:when>
       
       
       <!-- **** TEXT **** -->
       <!-- class/@allow-spaces boolean to allow spaces in the field
            class/@case 'upper_and_lower' or 'upper'
            class/@max-length is the maximum length of the field
            These 3 attributes are required for genuine text fields but are not
            required for GENERIC_OBJECT, PLAYER_MIP, or OP_AREA fields which
            we have cast as text fields
         -->
       <xsl:when test="$field-class = 'TEXT'">
         <xsl:variable name="allow_spaces">
           <xsl:choose>
             <xsl:when test="class/@allow-spaces">
                <xsl:value-of select="class/@allow-spaces"/>
             </xsl:when>
             <xsl:otherwise>false</xsl:otherwise>
           </xsl:choose>
         </xsl:variable>
         <xsl:call-template name="true-false-to-one-zero">
           <xsl:with-param name="true-false" select="$allow_spaces"/>
         </xsl:call-template>
         <xsl:text> </xsl:text>

         <xsl:choose>
           <xsl:when test="not(class/@case)">0</xsl:when>
           <xsl:when test="class/@case = 'upper'">0</xsl:when>
           <xsl:otherwise>1</xsl:otherwise>
         </xsl:choose>
         <xsl:text> </xsl:text>

         <xsl:choose>
           <xsl:when test="class/@max-length">
              <xsl:value-of select="class/@max-length"/>
           </xsl:when>
           <xsl:otherwise>15</xsl:otherwise>
         </xsl:choose>
         <xsl:text> </xsl:text>
       </xsl:when>
       
       
       <!-- **** TG **** -->
       <!-- Same side check:
              1 : <equal a="TG.side" b="THIS_SIDE"/>
              0 : NO TAG
            
            Target Active check:
              1 : <is-true a="TG.is_active"/>
              2 : <is-false a="TG.is_active"/>
              3 : NO TAG
              
            Available Categories: bit list from TG.category condition  
         -->
       <xsl:when test="$field-class = 'TG'">
         <!-- active-target -->
         <xsl:variable name="tg-name" select="@name"/>
         
         <!-- side check -->
         <xsl:call-template name="process-same-side-check"/>
         <xsl:text> </xsl:text>
         
         <!-- active-target check -->
         <xsl:call-template name="process-active-check"/>
         <xsl:text> </xsl:text>
         
         <!-- category -->
         <xsl:call-template name="process-tg-category-check"/>
         <xsl:text> </xsl:text>
         
         <!-- un-identified-target -->
         <xsl:call-template name="list-to-bits">
           <xsl:with-param name="list" select="fill/with/@types"/>
           <xsl:with-param name="words" select="'target,unidentified_target'"/>
         </xsl:call-template>         
         <xsl:text> </xsl:text>
         
         <!-- ghosted-targets-->
         <xsl:call-template name="process-ghost-check"/>
         <xsl:text> </xsl:text>

         
         <!-- tg-checks -->
         <xsl:choose>
           <xsl:when test="class/@tg-checks = 'off_board'">1000</xsl:when>
           <xsl:when test="class/@tg-checks = ''">0000</xsl:when>
         </xsl:choose>
         <xsl:text> </xsl:text>
         
         <!-- input check -->
         <xsl:call-template name="list-to-bits">
           <xsl:with-param name="list" select="class/@input"/>
           <xsl:with-param name="words" select="$input-words"/>
         </xsl:call-template> 
         <xsl:text> </xsl:text>
       </xsl:when>
       
       
       <!-- **** TIME **** -->
       <!--  TIME has no custom attributes -->
       
       
       <!-- **** UT **** -->
       <xsl:when test="$field-class = 'UT'">
         <xsl:variable name="unit-name" select="@name"/>
         
         <!-- Allow NONE as a valid entry. -->
         <xsl:choose>
           <xsl:when test="class/@allow-none = 'true'">NONE</xsl:when>
           <xsl:otherwise>NN</xsl:otherwise>
         </xsl:choose>
         <xsl:text> </xsl:text>
         
         <!-- side check -->
         <xsl:call-template name="process-same-side-check"/>
         <xsl:text> </xsl:text>

         <!-- relationship check -->
         <xsl:call-template name="process-side-relation-check"/>
         <xsl:text> </xsl:text> 

         <!-- command-authority check -->
         <xsl:call-template name="process-command-authority-check"/>
         <xsl:text> </xsl:text>
                  
         <!-- types check-->
         <xsl:call-template name="list-to-bits">
           <xsl:with-param name="list" select="fill/with/@types"/>
           <xsl:with-param name="words" select="$unit-type-words"/>
         </xsl:call-template> 
         <xsl:text> </xsl:text>
         
         <!-- active-unit check -->
         <xsl:call-template name="process-active-check"/>
         <xsl:text> </xsl:text>
         
         <!-- ghost check -->
         <xsl:call-template name="process-ghost-check"/>
         
         <!-- if UT line is over 80 column it needs to go next line -->
         <xsl:choose>
           <xsl:when test="string-length($ut-label) &gt; 16">
             <xsl:value-of select="concat($cr,'    ')"/>
           </xsl:when>
           <xsl:otherwise>
             <xsl:text> </xsl:text>
           </xsl:otherwise>
         </xsl:choose>
         
         <!-- unit-checks check -->
         <xsl:call-template name="list-to-bits">
           <xsl:with-param name="list" select="class/@unit-checks"/>
           <xsl:with-param name="words" select="$unit-check-words"/>
         </xsl:call-template>         
         <xsl:text> </xsl:text>
         
         <!-- input check -->
         <xsl:call-template name="list-to-bits">
           <xsl:with-param name="list" select="class/@input"/>
           <xsl:with-param name="words" select="$input-words"/>
         </xsl:call-template> 
         <xsl:text> </xsl:text>
       </xsl:when>
       
       
       <!-- **** UTILITY **** -->
       <xsl:when test="$field-class = 'UTILITY'">
         <xsl:value-of select="class/@name"/>
         <xsl:text> </xsl:text>
       </xsl:when>
       
    </xsl:choose>
    
    <!-- Put out the default value and a newline -->
    <xsl:value-of select="concat(class/@default,$cr)"/>
    
    <!-- Write the field name and the Player Order Word -->
    <xsl:choose>
      <xsl:when test="$field-silent = 'field'">
        <xsl:call-template name="write-help">
          <xsl:with-param name="pre-space" select="$pre-space-6"/>
        </xsl:call-template>
        <xsl:text>      </xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="@pow"/>
        <xsl:if test="string-length(@pow2) &gt; 0">
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:value-of select="@pow2"/>
        <xsl:value-of select="concat($cr,'')"/>
      </xsl:when>
      <xsl:when test="$field-silent = 'silent-field'">
        <xsl:text>      </xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text> </xsl:text>
        <xsl:value-of select="@pow"/>
        <xsl:if test="string-length(@pow2) &gt; 0">
          <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:value-of select="@pow2"/>
        <xsl:value-of select="concat($cr,'')"/>
      </xsl:when>
    </xsl:choose>
   
  </xsl:for-each>
</xsl:template>


<!-- converts a list of words to bits 
     where the words parameter is the list of words that can appear
     list is the string that will be converted
     delimiter is the separator (comma by default)
-->
<xsl:template name="list-to-bits">
  <xsl:param name="words"/>
  <xsl:param name="delimiter" select="','"/>
  <xsl:param name="list"/>
  <xsl:variable name="temp-list"
       select="concat(' ', translate($list, $delimiter, ' '), ' ')"/>
  <xsl:call-template name="list-to-bits-helper">
    <xsl:with-param name="remaining-words" select="concat($words, ',')"/>
    <xsl:with-param name="list" select="$temp-list"/>
  </xsl:call-template>
</xsl:template>


<xsl:template name="list-to-bits-helper">
  <xsl:param name="remaining-words"/>
  <xsl:param name="list"/>
    <xsl:if test="string-length($remaining-words) != 0">
      <xsl:variable name="current-word"
                    select="substring-before($remaining-words, ',')"/>
      <xsl:choose>
        <xsl:when test="contains($list, concat(' ', $current-word, ' '))">
          <xsl:text>1</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>0</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="list-to-bits-helper">
        <xsl:with-param name="list" select="$list"/>
        <xsl:with-param name="remaining-words" 
              select="substring-after($remaining-words, concat($current-word, ','))"/>
      </xsl:call-template>
    </xsl:if>
</xsl:template>


<xsl:template name="true-false-to-one-zero">
  <xsl:param name="true-false"/>
  <xsl:choose>
    <xsl:when test="$true-false = 'true'">
      <xsl:text>1</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>0</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>



<xsl:template name="true-false-to-bit">
  <xsl:param name="value"/>
  <xsl:choose>
    <xsl:when test="$value = 'true'">1</xsl:when>
    <xsl:otherwise>0</xsl:otherwise>
  </xsl:choose>
</xsl:template>






<xsl:template name="write-help">
  <xsl:param name="pre-space"/>
  <xsl:value-of select="$pre-space"/>
  <xsl:text>"</xsl:text>
  <xsl:for-each select="help/line">
    <xsl:variable name="line" select="."/>
    <xsl:if test="position() != 1">
      <xsl:value-of select="concat($pre-space, ' ')"/>
    </xsl:if>
    <xsl:choose> 
      <xsl:when test="position() = last()">
         <xsl:if test="starts-with($line, ' ') = true">
           <xsl:text>|</xsl:text>
         </xsl:if> 
         <xsl:value-of select="."/>
         <xsl:value-of select="concat('&quot;',$cr,'')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="string-length($line)=0">  
            <xsl:text>|\n</xsl:text>
          </xsl:when>
          <xsl:when test="starts-with($line, ' ') = true"> 
            <xsl:text>|</xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>\n</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="."/>
            <xsl:text>\n</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="concat($cr,'')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
</xsl:template>


<xsl:template name="write-groups">
  <xsl:param name="group-count"/>

  <xsl:variable name="field-nodes" select="fields/field"/>
  <xsl:for-each select="groups/group">
    <xsl:text>      "</xsl:text>
    <xsl:value-of select="@label"/>
    <xsl:text>" </xsl:text>
    <xsl:value-of select="@require"/>
    <xsl:text> </xsl:text>
    <xsl:variable name="entry-count">
      <xsl:value-of select="count(entries/entry)"/>
    </xsl:variable>
    <xsl:value-of select="$entry-count"/>
    <xsl:value-of select="concat($cr,'')"/>
    <xsl:call-template name="write-help">
      <xsl:with-param name="pre-space" select="$pre-space-9"/>
    </xsl:call-template>

    <xsl:for-each select="entries/entry">
      <xsl:text>        "</xsl:text>
      <xsl:value-of select="@label"/>
      <xsl:text>" </xsl:text>
      <!-- Translate the field names to the field numbers. -->
      <!-- Separate the field number by spaces and terminate with a * -->
      <xsl:call-template name="field-name-list-to-number-list">
        <xsl:with-param name="order-field-nodes" select="$field-nodes"/>
        <xsl:with-param name="names" select="@field"/>
      </xsl:call-template>

      <!--
      <xsl:choose>
        <xsl:when test="@field = ''">
          <xsl:text>*</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="translate(@field,', ',' ')"/>
          <xsl:text> *</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      -->
      <xsl:value-of select="$cr"/>
    </xsl:for-each>
    <xsl:value-of select="$cr"/>
  </xsl:for-each>
</xsl:template>
 

<xsl:template name="write-queue">
  <xsl:choose>
    <xsl:when test="count(queue/@entry)!=0">
      <xsl:text>   QUEUE </xsl:text>
      <!-- Translate the field names to the field numbers. -->
      <!-- Separate the field number by spaces and terminate with a * -->
      <xsl:call-template name="field-name-list-to-number-list">
        <xsl:with-param name="order-field-nodes" select="fields/field"/>
        <xsl:with-param name="names" select="queue/@entry"/>
      </xsl:call-template>
      <!--
      <xsl:value-of select="translate(queue/@entry, ', ', ' ')"/>
      <xsl:text> *</xsl:text>-->
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>   NO_QUEUE</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="concat($cr, '')"/>
</xsl:template>


<xsl:template name="write-quick">
  <xsl:choose>
    <xsl:when test="count(quick/@entry)!=0">
      <xsl:text>   QUICK </xsl:text>
      <!-- Translate the field names to the field numbers. -->
      <!-- Separate the field number by spaces and terminate with no * -->
      <xsl:call-template name="field-name-list-to-number-list">
        <xsl:with-param name="order-field-nodes" select="fields/field"/>
        <xsl:with-param name="names" select="quick/@entry"/>
        <xsl:with-param name="term-char" select="''"/>
      </xsl:call-template>
      <!--
      <xsl:value-of select="translate(quick/@entry, ', ', ' ')"/>
      -->
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>   NO_QUICK</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="$cr"/>
</xsl:template>


<xsl:template name="write-msend">
  <xsl:choose>
    <xsl:when test="count(msend/@entry)!=0">
      <xsl:text>   MSEND </xsl:text>
      <xsl:value-of select="concat(msend/@name,' ')"/>
      <!-- Translate the field names to the field numbers. -->
      <!-- Separate the field number by spaces and terminate with a * -->
      <xsl:call-template name="field-name-list-to-number-list">
        <xsl:with-param name="order-field-nodes" select="fields/field"/>
        <xsl:with-param name="names" select="msend/@entry"/>
      </xsl:call-template>
      <!--
      <xsl:value-of select="translate(msend/@entry, ', ', ' ')"/>
      <xsl:text> *</xsl:text>
      -->
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>   NO_MSEND</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="concat($cr, $cr)"/>
</xsl:template>




<xsl:template name="write-constraint-message">
  <xsl:param name="message-path" select="../message/line"/>
    <xsl:for-each select="$message-path">
      <xsl:variable name="line" select="."/>
      <xsl:choose> 
        <xsl:when test="position() = 1">
          <xsl:text>      "</xsl:text>
          <xsl:value-of select="."/>
          <xsl:choose>
            <xsl:when test="position() = last()">
              <xsl:text>"</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>\n</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:value-of select="concat($cr,'')"/>
        </xsl:when>
        <xsl:when test="position() = last()">
          <xsl:choose>
            <xsl:when test="starts-with($line, ' ') = true">
              <xsl:text>       |</xsl:text>
              <xsl:value-of select="."/>
              <xsl:value-of select="concat('&quot;', $cr, '')"/>
            </xsl:when> 
            <xsl:otherwise>
              <xsl:text>       </xsl:text>
              <xsl:value-of select="."/>
              <xsl:value-of select="concat('&quot;', $cr, '')"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test="string-length($line)=0">  
              <xsl:text>       |\n</xsl:text>
            </xsl:when>
            <xsl:when test="starts-with($line, ' ') = true"> 
              <xsl:text>       |</xsl:text>
              <xsl:value-of select="."/>
              <xsl:text>\n</xsl:text>
            </xsl:when>
            <xsl:otherwise> 
              <xsl:text>       </xsl:text>
              <xsl:value-of select="."/>
              <xsl:text>\n</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:value-of select="concat($cr,'')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
</xsl:template>


<!--
Write out the FIELD Constraints.
  -->
<xsl:template name="write-constraint">
  <!-- Save the order field nodes for conversion of field names. -->
  <xsl:variable name="order-fields" select="fields/field"/>

  <!-- For each constraint -->
  <xsl:for-each select="constraints/constraint">
    <!-- FILL_ATLEAST_ONE -->
    <xsl:for-each select="FILL_ATLEAST_ONE">
      <xsl:text>   FILL_ATLEAST_ONE </xsl:text>
      <xsl:call-template name="write-constraint-field">
        <xsl:with-param name="order-field-nodes" select="$order-fields"/>
      </xsl:call-template>
      <xsl:value-of select="$cr"/>
      <xsl:call-template name="write-constraint-message"/>
    </xsl:for-each>

    <!-- FILL_ONLY_ONE -->
    <xsl:for-each select="FILL_ONLY_ONE">
      <xsl:text>   FILL_ONLY_ONE </xsl:text>
      <xsl:call-template name="write-constraint-field">
        <xsl:with-param name="order-field-nodes" select="$order-fields"/>
      </xsl:call-template>
      <xsl:value-of select="$cr"/>
      <xsl:call-template name="write-constraint-message"/>
    </xsl:for-each>

    <!-- EQUAL -->
    <xsl:for-each select="EQUAL">
      <xsl:text>   EQUAL </xsl:text>
      <xsl:call-template name="write-constraint-field">
        <xsl:with-param name="order-field-nodes" select="$order-fields"/>
      </xsl:call-template>
      <xsl:value-of select="$cr"/>
      <xsl:call-template name="write-constraint-message"/>
    </xsl:for-each>

    <!-- NOT_EQUAL -->
    <xsl:for-each select="NOT_EQUAL">
      <xsl:text>   NOT_EQUAL </xsl:text>
      <xsl:call-template name="write-constraint-field">
        <xsl:with-param name="order-field-nodes" select="$order-fields"/>
      </xsl:call-template>
      <xsl:value-of select="$cr"/>
      <xsl:call-template name="write-constraint-message"/>
    </xsl:for-each>

    <!-- GREATER_THAN -->
    <xsl:for-each select="GREATER_THAN">
      <xsl:text>   GREATER_THAN </xsl:text>
      <xsl:call-template name="write-constraint-field">
        <xsl:with-param name="order-field-nodes" select="$order-fields"/>
      </xsl:call-template>
      <xsl:value-of select="$cr"/>
      <xsl:call-template name="write-constraint-message"/>
    </xsl:for-each>

    <!-- LESS_THAN -->
    <xsl:for-each select="LESS_THAN">
      <xsl:text>   LESS_THAN </xsl:text>
      <xsl:call-template name="write-constraint-field">
        <xsl:with-param name="order-field-nodes" select="$order-fields"/>
      </xsl:call-template>
      <xsl:value-of select="$cr"/>
      <xsl:call-template name="write-constraint-message"/>
    </xsl:for-each>

    <!-- IF_FIELD -->
    <xsl:for-each select="IF_FIELD">
      <xsl:text>   IF_FIELD </xsl:text>
      <xsl:call-template name="write-constraint-field">
        <xsl:with-param name="order-field-nodes" select="$order-fields"/>
      </xsl:call-template>
      <xsl:call-template name="write-constraint-then-field">
        <xsl:with-param name="order-field-nodes" select="$order-fields"/>
      </xsl:call-template>
      <xsl:value-of select="$cr"/>
      <xsl:call-template name="write-constraint-message"/>
    </xsl:for-each>

    <!-- IF_VALUE -->
    <xsl:for-each select="IF_VALUE">
      <xsl:text>   IF_VALUE </xsl:text>
      <xsl:call-template name="write-constraint-field">
        <xsl:with-param name="order-field-nodes" select="$order-fields"/>
      </xsl:call-template>
      <xsl:call-template name="write-constraint-then-field">
        <xsl:with-param name="order-field-nodes" select="$order-fields"/>
      </xsl:call-template>
      <xsl:value-of select="$cr"/>
      <xsl:call-template name="write-constraint-message"/>
    </xsl:for-each>

    <!-- IF_ATTRIBUTE -->
    <xsl:for-each select="IF_ATTRIBUTE">
      <xsl:text>   IF_ATTRIBUTE </xsl:text>
      <xsl:call-template name="write-constraint-field">
        <xsl:with-param name="order-field-nodes" select="$order-fields"/>
      </xsl:call-template>
      <xsl:call-template name="write-constraint-then-field">
        <xsl:with-param name="order-field-nodes" select="$order-fields"/>
      </xsl:call-template>
      <xsl:value-of select="$cr"/>
      <xsl:call-template name="write-constraint-message"/>
    </xsl:for-each>
  </xsl:for-each>
</xsl:template>



<!--
  Convert from the field name to the field number when writing the contraint
  field.
  -->
<xsl:template name="write-constraint-field">
  <xsl:param name="field-nodes" select="field"/>
  <xsl:param name="constraint-name" select="name()"/>
  <xsl:param name="order-field-nodes"/>
  <xsl:choose>
    
    <!-- Expect Field#, Field# ... -->
    <xsl:when 
       test="$constraint-name = 'FILL_ATLEAST_ONE' or
             $constraint-name = 'FILL_ONLY_ONE' or
             $constraint-name = 'IF_FIELD' or
             $constraint-name = 'THEN_FIELD' or 
             $constraint-name = 'THEN_NOT_FIELD'">
      <xsl:for-each select="$field-nodes">
        <xsl:call-template name="field-name-to-number">
          <xsl:with-param name="order-field-nodes"
             select="$order-field-nodes"/>
          <xsl:with-param name="name" select="."/>
        </xsl:call-template>
        <!-- if the line is too long, start a new one and indent. -->
        <xsl:if test="position() mod 20 = 0 and position() != last()">
          <xsl:value-of select="concat($cr,'')"/>
          <xsl:text>                   </xsl:text>
        </xsl:if>
        <xsl:text> </xsl:text>
      </xsl:for-each>
      <xsl:text>*</xsl:text>
    </xsl:when>

    <!-- Expect Field#, Value -->
    <xsl:when 
       test="$constraint-name = 'IF_VALUE' or
             $constraint-name = 'THEN_VALUE'">
      <xsl:call-template name="field-name-to-number">
        <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
        <xsl:with-param name="name" select="$field-nodes[1]"/>
      </xsl:call-template>
      <xsl:value-of select="concat(' ',$field-nodes[2])"/>
    </xsl:when>

    <!-- Expect Field(), Value -->
    <xsl:when 
       test="$constraint-name = 'IF_ATTRIBUTE' or
             $constraint-name = 'THEN_ATTRIBUTE'">
      <xsl:call-template name="convert-field-arg-to-number">
        <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
        <xsl:with-param name="argument" select="$field-nodes[1]"/>
      </xsl:call-template>
      <xsl:value-of select="concat(' ',$field-nodes[2])"/>
    </xsl:when>

    <!-- Expect Field(), Field() -->
    <xsl:when 
       test="$constraint-name = 'EQUAL' or
             $constraint-name = 'NOT_EQUAL' or
             $constraint-name = 'GREATER_THAN' or
             $constraint-name = 'LESS_THAN'">
      <xsl:for-each select="$field-nodes"> 
        <xsl:call-template name="convert-field-arg-to-number">
          <xsl:with-param name="order-field-nodes" 
             select="$order-field-nodes"/>
          <xsl:with-param name="argument" select="."/>
        </xsl:call-template>
        <xsl:if test="position() = 1">
          <xsl:text> </xsl:text>
        </xsl:if>
      </xsl:for-each>
    </xsl:when>

    <!-- Expect Array[Field(), Field()...] -->
    <xsl:when 
       test="$constraint-name = 'THEN_ARRAY'">
      <xsl:call-template name="convert-array-arg-to-numbers">
        <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
        <xsl:with-param name="array-arg" select="$field-nodes[1]"/>
      </xsl:call-template>
      <xsl:value-of select="concat(' Answer ',@answer)"/>
    </xsl:when>
      
  </xsl:choose>
</xsl:template>




<xsl:template name="write-constraint-then-field">
  <xsl:param name="if-path" select="."/>
  <xsl:param name="order-field-nodes"/>
  
  <!-- IF_* THEN_FIELD -->
  <xsl:for-each select="$if-path/THEN_FIELD">
    <xsl:text> THEN_FIELD </xsl:text>
    <xsl:call-template name="write-constraint-field">
      <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
    </xsl:call-template>
  </xsl:for-each>
  
  <!-- IF_* THEN_NOT_FIELD -->
  <xsl:for-each select="$if-path/THEN_NOT_FIELD">
    <xsl:text> THEN_NOT_FIELD </xsl:text>
    <xsl:call-template name="write-constraint-field">
      <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
    </xsl:call-template>
  </xsl:for-each>
  
  <!-- IF_* THEN_VALUE -->
  <xsl:for-each select="$if-path/THEN_VALUE">
    <xsl:text> THEN_VALUE </xsl:text>
    <xsl:call-template name="write-constraint-field">
      <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
    </xsl:call-template>
  </xsl:for-each>
  
  <!-- IF_* THEN_ATTRIBUTE -->
  <xsl:for-each select="$if-path/THEN_ATTRIBUTE">
    <xsl:text> THEN_ATTRIBUTE </xsl:text>
    <xsl:call-template name="write-constraint-field">
      <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
    </xsl:call-template>
  </xsl:for-each>
  
  <!-- IF_* THEN_ARRAY -->
  <xsl:for-each select="$if-path/THEN_ARRAY">
    <xsl:text> THEN_ARRAY </xsl:text>
    <xsl:call-template name="write-constraint-field">
      <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
    </xsl:call-template>
  </xsl:for-each>

</xsl:template>


<!-- 
These templates are used for converting field names to field numbers.
They are used by groups, queues, quicks, msends, and field constraints.
  -->



<!--
  Takes
    Field_Name
  and writes
    Field#
  -->
<xsl:template name="field-name-to-number">
  <xsl:param name="order-field-nodes"/>
  <xsl:param name="name"/>
  <!-- check for invalid field names. -->
  <!--<xsl:if test="count($order-field-nodes/@name[. = $name]) = 0">
    <xsl:value-of select="concat('No field named ',$name,'!')"/>
  </xsl:if>-->
  <xsl:if test="$name = 'NULL'">
    <xsl:text>0</xsl:text>
  </xsl:if>
  <xsl:if test="count($order-field-nodes[@name = $name]) != 1 and
                $name != 'NULL'">
    <xsl:text>!INVALID_FIELD_NAME!</xsl:text>
  </xsl:if>
  <xsl:for-each select="$order-field-nodes">
    <xsl:if test="@name = $name">
      <xsl:value-of select="position()"/>
    </xsl:if>
  </xsl:for-each>
</xsl:template>



<!--
  Takes
    Field_Name, Field_Name ...
  and writes
    Field# Field# $term-char
  -->
<xsl:template name="field-name-list-to-number-list">
  <xsl:param name="order-field-nodes"/>
  <xsl:param name="names"/>
  <xsl:param name="term-char" select="'*'"/>
  <!-- remove any extra spaces and invoke the loop template -->
  <xsl:call-template name="field-name-list-to-number-list-loop">
    <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
    <xsl:with-param name="names"
       select="concat(translate($names,' ',''),',')"/>
    <xsl:with-param name="term-char" select="$term-char"/>
  </xsl:call-template>
</xsl:template>
<!-- The Loop Template. -->
<xsl:template name="field-name-list-to-number-list-loop">
  <xsl:param name="order-field-nodes"/>
  <xsl:param name="names"/>
  <xsl:param name="term-char" select="'*'"/>
  <xsl:choose>
    <xsl:when test="string-length($names) &lt; 2">
      <xsl:value-of select="$term-char"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="next-name" select="substring-before($names,',')"/>
      <xsl:variable name="next-names" 
         select="substring-after($names,concat($next-name,','))"/>
      <xsl:call-template name="field-name-to-number">
        <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
        <xsl:with-param name="name" select="$next-name"/>
      </xsl:call-template>
      <xsl:if test="string-length($term-char) != 0 or
                    string-length($next-names) != 0">
        <xsl:text> </xsl:text>
      </xsl:if>
      <!-- Iterate through the loop. -->
      <xsl:call-template name="field-name-list-to-number-list-loop">
        <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
        <xsl:with-param name="names" select="$next-names"/>
        <xsl:with-param name="term-char" select="$term-char"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>



<!--
  Takes 
    Some_Function(Field_Name) 
  and writes
    Some_Function(Field#)
  -->
<xsl:template name="convert-field-arg-to-number">
  <xsl:param name="order-field-nodes"/>
  <xsl:param name="argument"/>
  <xsl:variable name="func-name" select="substring-before($argument,'(')"/>
  <xsl:variable name="field-name" 
     select="substring-before(substring-after($argument,'('),')')"/>
  <xsl:value-of select="$func-name"/>
  <xsl:text>(</xsl:text>
  <xsl:call-template name="field-name-to-number">
    <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
    <xsl:with-param name="name" select="$field-name"/>
  </xsl:call-template>
  <xsl:text>)</xsl:text>
</xsl:template>



<!--
  Takes 
    Some_Function(Field_Name),Other_Function(Field_Name),2,.. 
  and writes 
    Some_Function(Field#),Other_Function(Field#),2 
  -->
<xsl:template name="convert-field-arg-list-to-numbers">
  <xsl:param name="order-field-nodes"/>
  <xsl:param name="arguments"/>
  <!-- Add a comma and call loop -->
  <xsl:call-template name="convert-field-arg-list-to-numbers-loop">
    <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
    <xsl:with-param name="arguments" select="concat($arguments,',')"/>
  </xsl:call-template>
</xsl:template>
<!-- The Loop Template -->
<xsl:template name="convert-field-arg-list-to-numbers-loop">
  <xsl:param name="order-field-nodes"/>
  <xsl:param name="arguments"/>
  <xsl:if test="string-length($arguments) != 0">
    <xsl:variable name="next-arg" select="substring-before($arguments,',')"/>
    <xsl:variable name="next-args" 
       select="substring-after($arguments,concat($next-arg,','))"/>
    <!-- Write out the conversion -->
    <xsl:choose>
      <xsl:when test="contains($next-arg,'(')">
        <xsl:call-template name="convert-field-arg-to-number">
          <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
          <xsl:with-param name="argument" select="$next-arg"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$next-arg"/>
      </xsl:otherwise>
    </xsl:choose>
    <!-- Write a comma if this is not the last conversion. -->
    <xsl:if test="string-length($next-args) != 0">,</xsl:if>
    <!-- Iterate through the loop. -->
    <xsl:call-template name="convert-field-arg-list-to-numbers-loop">
      <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
      <xsl:with-param name="arguments" select="$next-args"/>
    </xsl:call-template>
  </xsl:if> 
</xsl:template>



<!--
  Takes 
    Some_Array[Some_Function(Field_Name),Other_Function(Field_Name)]
  and writes 
    Some_Array[Some_Function(Field#),Other_Function(Field#)]
    
  If Some_Function(Field_Name) is just an integer, no translation is done.
  Ex:
    Some_Array[2,Other_Function(Field_Name)]
  writes:
    Some_Array[2,Other_Function(Field#)]
  -->
<xsl:template name="convert-array-arg-to-numbers">
  <xsl:param name="order-field-nodes"/>
  <xsl:param name="array-arg"/>
  <xsl:variable name="array-name" select="substring-before($array-arg,'[')"/>
  <xsl:variable name="array-args" 
     select="substring-before(substring-after($array-arg,'['),']')"/>
  <xsl:value-of select="$array-name"/>
  <xsl:text>[</xsl:text>
  <!--Convert the arguments. -->
  <xsl:call-template name="convert-field-arg-list-to-numbers">
    <xsl:with-param name="order-field-nodes" select="$order-field-nodes"/>
    <xsl:with-param name="arguments" select="$array-args"/>
  </xsl:call-template>
  <xsl:text>]</xsl:text>
</xsl:template>




<!-- *NESTING*
     These templates process common bit checks done on order fields that
     must examine the FILL NODE. This keeps any possible translation errors
     in one place. -->
     
<!-- This template puts out a same side check 1 means that the side must be the
     same, 0 means any side is valid. --> 

<xsl:template name="process-same-side-check">
  <xsl:param name="field-name" select="@name"/>
  <xsl:param name="fill-node" select="fill"/>
  <xsl:variable name="authority-check" 
     select="concat($field-name,'.command_authority')"/>
  <xsl:variable name="side-check"
     select="concat($field-name,'.side')"/>
  
  <!-- The Side check may be nested 3 deep in an all tag to also check 
       the CONT_SIDE. -->
  <xsl:variable name="equal-node"
     select="$fill-node/with/equal[@a = $side-check][@b = 'THIS_SIDE'] |
             $fill-node/with/all/equal[@a = $side-check][@b = 'THIS_SIDE'] |
             $fill-node/with/all/all/equal[@a = $side-check][@b = 'THIS_SIDE']"/>
             
  <!-- A command authority check implies a side check. -->
  <xsl:variable name="authority-check">
    <xsl:call-template name="process-command-authority-check">
      <xsl:with-param name="field-name" select="$field-name"/>
      <xsl:with-param name="fill-node" select="$fill-node"/>
    </xsl:call-template>
  </xsl:variable>
  
  <xsl:choose>
    <xsl:when test="count($equal-node) = 1 or number($authority-check) = 1">
      <xsl:text>1</xsl:text>
    </xsl:when>
    <xsl:otherwise>0</xsl:otherwise>
  </xsl:choose>
</xsl:template>



<!-- This template puts out a same side check. *NESTING*
     10 means that the side must be THIS_SIDE
     01 means that the side must not be THIS_SIDE
     11 means that any side is valid. 
  -->    
<xsl:template name="process-msn-same-side-check">
  <xsl:param name="field-name" select="@name"/>
  <xsl:param name="fill-node" select="fill"/>
  <xsl:variable name="side-check" select="concat($field-name,'.side')"/>
  
  <xsl:variable name="is-this-side">
    <xsl:call-template name="process-same-side-check">
      <xsl:with-param name="field-name" select="$field-name"/>
      <xsl:with-param name="fill-node" select="$fill-node"/>
    </xsl:call-template>
  </xsl:variable>
  
  <!-- The Side check may be nested in an all tag to also check the CONT_SIDE. -->
  <xsl:variable name="not-equal-node"
     select="$fill-node/with/not-equal[@a = $side-check][@b = 'THIS_SIDE'] |
             $fill-node/with/all/not-equal[@a = $side-check][@b = 'THIS_SIDE'] |
             $fill-node/with/all/all/not-equal[@a = $side-check][@b = 'THIS_SIDE']"/> 
  <xsl:choose>
    <xsl:when test="number($is-this-side) = 1">10</xsl:when>
    <xsl:when test="count($not-equal-node) = 1">01</xsl:when>
    <xsl:otherwise>11</xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- Process the DMPI category check and put out the bits using the target
     category words -->
<xsl:template name="process-tg-category-check">
  <xsl:param name="field-name" select="@name"/>
  <xsl:param name="fill-node" select="fill"/>
  <xsl:variable name="category-check" select="concat($field-name,'.category')"/>
  <!-- get the proper fill condition. -->
  <xsl:variable name="fill-condition"
     select="$fill-node/with/equal[@a = $category-check]"/>
  <!-- If there is not check, set all target category bits. -->
  <xsl:variable name="the-categories">
    <xsl:choose>
      <xsl:when test="count($fill-condition) = 1">
        <xsl:value-of select="$fill-condition/@b"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$target-category-words"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:call-template name="list-to-bits">
    <xsl:with-param name="list" select="$the-categories"/>
    <xsl:with-param name="words" select="$target-category-words"/>
  </xsl:call-template> 
</xsl:template>



<!-- Process the Mission object class enumeration 
     1 = AIRMISSION, 2 = AIRMISSION, CRUISE_MISSILE, 3 = CRUISE_MISSILE -->
<xsl:template name="process-mission-type-check">
  <xsl:param name="field-name" select="@name"/>
  <xsl:param name="fill-node" select="fill"/>
  <xsl:variable name="class-name" select="$fill-node/with/@types"/>
            
  <!-- mission_type -->
  <!-- mission_type 'airmission, cruise_missile'
       entries should be checked the word(s) exactly it should bs.-->

  <xsl:variable name="mission-var">
    <xsl:call-template name="list-to-bits">
      <xsl:with-param name="list"  select="$class-name"/>
      <xsl:with-param name="words" select="$mission-fill-with"/>
    </xsl:call-template> 
  </xsl:variable>

  <!--$mission-var: 'airmission, cruise_missile' = 11 -->
  <xsl:choose>
    <!--xsl:when test="$mission-var = 10">1</xsl:when>
    <xsl:when test="$mission-var = 11">2</xsl:when>
    <xsl:when test="$mission-var = 00">3</xsl:when>
    <xsl:otherwise>BAD_OBJECT_CLASS$</xsl:otherwise-->

    <xsl:when test="$class-name = 'airmission'">1</xsl:when>
    <xsl:when test="$class-name = 'airmission, cruise_missile' or
                    $mission-var = 11" >2</xsl:when>
    <xsl:when test="$class-name = 'cruise_missile'">3</xsl:when>
    <xsl:otherwise>BAD_OBJECT_CLASS</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!--
Target Active check:
  1 : <is-true a="TG.is_active"/>
  2 : <is-false a="TG.is_active"/>
  3 : NO TAG
  -->
<xsl:template name="process-active-check">
  <xsl:param name="field-name" select="@name"/>
  <xsl:param name="fill-node" select="fill"/>
  <xsl:variable name="active-check" select="concat($field-name,'.is_active')"/>
  <xsl:variable name="true-tag"
     select="$fill-node/with/is-true[@a = $active-check]"/>
  <xsl:variable name="false-tag"
     select="$fill-node/with/is-false[@a = $active-check]"/>
  <xsl:choose>
    <xsl:when test="count($true-tag) = 1">1</xsl:when>
    <xsl:when test="count($false-tag) = 1">2</xsl:when>
    <xsl:otherwise>3</xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="process-ghost-check">
  <xsl:param name="field-name" select="@name"/>
  <xsl:param name="fill-node" select="fill"/>

  <xsl:variable name="ghost-check" 
     select="concat($field-name,'.external_model')"/>
  <xsl:variable name="equal-tag"
     select="$fill-node/with/equal[@a = $ghost-check]"/>

    <xsl:choose>
      <xsl:when test="count($equal-tag) = 1">  
      <!-- Get the proper equal condition. -->        
         <xsl:value-of select="$equal-tag"/>
         <xsl:call-template name="list-to-bits">          
           <xsl:with-param name="list" select="$equal-tag/@b"/>           
           <xsl:with-param name="words" select="$external-model-words"/>
         </xsl:call-template> 
      </xsl:when>
      <xsl:otherwise>
         <xsl:text>111111</xsl:text>
      </xsl:otherwise>
    </xsl:choose>

  <!-- Old GHOST flag check -->
  <!-- xsl:variable name="ghost-check" 
     select="concat($field-name,'.external_model')"/>
  <xsl:variable name="equal-tag"
     select="$fill-node/with/equal[@a = $ghost-check]"/>
  <xsl:variable name="not-equal-tag"
     select="$fill-node/with/not-equal[@a = $ghost-check]"/>
  <xsl:choose>
    <xsl:when test="
     count($not-equal-tag) = 1">01</xsl:when>
    <xsl:when test="
     count($equal-tag) = 1 and $equal-tag/@b != 'NONE'">01</xsl:when>
    <xsl:when test="
     count($equal-tag) = 1 and $equal-tag/@b = 'NONE'">10</xsl:when>
    <xsl:otherwise>11</xsl:otherwise>
  </xsl:choose-->

</xsl:template>
         

<!-- Process the side relation check and put out the bits using the relationship
     words 
     If a UT.side = THIS_SIDE check is present, there will be no
     relation search, and the output will be 1000 (friendly) 
  -->
     
<xsl:template name="process-side-relation-check">
  <xsl:param name="field-name" select="@name"/>
  <xsl:param name="fill-node" select="fill"/>
  <xsl:variable name="relation-list">
    <xsl:call-template name="get-side-relation-list">
      <xsl:with-param name="field-name" select="$field-name"/>
      <xsl:with-param name="fill-node" select="$fill-node"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:call-template name="list-to-bits">
    <xsl:with-param name="list" select="$relation-list"/>
    <xsl:with-param name="words" select="$relationship-words"/>
  </xsl:call-template>
</xsl:template>


<!--
Command Authority Check: *NESTING*
  0 : NO TAG
  1 : <not-equal a="UT.command_authority" b="NONE"/>  *NESTING*
  -->
<xsl:template name="process-command-authority-check">
  <xsl:param name="field-name" select="@name"/>
  <xsl:param name="fill-node" select="fill"/>
  <xsl:variable name="ca-check"
     select="concat($field-name,'.command_authority')"/>
  <xsl:variable name="ne-tag" 
     select="$fill-node/with/not-equal[@a = $ca-check][@b = 'NONE'] |
             $fill-node/with/all/not-equal[@a = $ca-check][@b = 'NONE'] |
             $fill-node/with/all/all/not-equal[@a = $ca-check][@b = 'NONE']"/>
  <xsl:choose>
    <xsl:when test="count($ne-tag) = 1">1</xsl:when>
    <xsl:otherwise>0</xsl:otherwise>
  </xsl:choose>  
</xsl:template>
         

<!-- Get the mission_type word list for a given field for AIRMISSION or
     AIRMISSION, CRUISE_MISSILE. -->
<xsl:template name="get-ac-mission-type-list">
  <xsl:param name="field-name" select="@name"/>
  <xsl:param name="fill-node" select="fill"/>
  <xsl:variable name="msn-check" select="concat($field-name,'.mission_type')"/> 
  <!-- get the proper equal node. -->
  <xsl:variable name="equal-cond"
     select="$fill-node/with/equal[@a = $msn-check]"/> 
  <xsl:choose>
    <xsl:when test="count($equal-cond) = 1">
      <xsl:value-of select="$equal-cond/@b"/> 
    </xsl:when>
    <xsl:otherwise>
      <!-- Return all mission types. 
           We don't filter in tyhe JXSR so we don't restrict in orders.def -->
      <xsl:value-of select="$mission-type-words"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- Get the side relation word list for a given field. -->
<xsl:template name="get-side-relation-list">
  <xsl:param name="field-name" select="@name"/>
  <xsl:param name="fill-node" select="fill"/>
  <!-- The exists node may be nested in an all tag to also check the CONT_SIDE. -->

  <!--get proper relationship attribute-->
  <xsl:variable name="relationship-att" 
       select="concat($field-name, '.', 'side_id', '.', 'relationship')"/>
  <xsl:variable name="equal-node"
     select="$fill-node/with/all/equal[@a = $relationship-att] |
             $fill-node/with/equal[@a = $relationship-att]"/>

  <!-- Check the side bit, if true, we use friendly -->
  <xsl:variable name="is-this-side">
    <xsl:call-template name="process-same-side-check">
      <xsl:with-param name="field-name" select="$field-name"/>
      <xsl:with-param name="fill-node" select="$fill-node"/>
    </xsl:call-template>
  </xsl:variable>
  
  <xsl:choose>
    <!-- If the unit must be on this side, set only the firendly bit. -->
    <xsl:when test="number($is-this-side) = 1">
      <xsl:text>friendly</xsl:text>
    </xsl:when>
    
    <!-- extract the enum bits from the exists node -->
    <xsl:when test="count($equal-node) = 1">
      <!-- Get the proper equal condition. -->
      <xsl:value-of select="$equal-node/@b"/>  
    </xsl:when>
    
    <!-- Neither this side nor relationship are present. 
         Therefore all are valid -->
    <xsl:otherwise>
      <xsl:text>friendly neutral suspect enemy</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
