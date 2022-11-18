<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 >
<!--
 xmlns:xalan="http://xml.apache.org/xalan"
 extension-element-prefixes="xalan"
 exclude-result-prefixes="xalan">
-->

<!-- This stylesheet procedure is used to verify the structure of an order.xml
     file.
     If the document is improperly formatted, the Stylesheet engine (XT) will
     report a line number.
     If there is a logic error with the contents, this stylesheet will print out
     a message indicating which order has the problem.
     
     The following rules are enforced:

   * Short name of the order must match the passed in name

   * Field names must be unique.

   * The field names used in groups, queues, quicks, msends, and constraints must exist.

   * If fill/with node exists, attributes: @types must exist and have values.

   * If fill/../exists node exists, attributes: @type and @named must exist and have values.

   * If fill/../equal(type) node exists, attributes: @a and @b(except is-true and
     is-false) must exist and have values.

   * If fill node exists, list must have dividers: <and/> or <or/> and the total
     number of elements in the list must be odd.

   * If fill node exists, and @help attribute exists in any under fill node,
     helps/help/@name must exist. @help and @name must use the same name.

   * If field/@require="ALTMAN" or "ALTOPT", that field name has to be show up
     in groups/ group/ entries/ entry/ @field

   * If a name is in groups/ group/ entries/ entry/ @field, that name's requirement
     declaration in fields/ field/ @require has to be "ALTMAN" or "ALTOPT" 

   * Open static_voc.xml and dynamic_voc.xml: 
     If field/class is "STATIC_V", check both files if the field name exist in them.

   * Numeric and extra space or character check for @min and @max for class/@is REAL and INTEGER. 

   * Uom, uom-type and uom-for-default check for class/@is REAL and INTEGER.

Additional sanity checks:
   * Ensure variables exist in the scope that they are used.

   * Fields/field label length must be less than 30 (for SQL table).
   
   * The mandatory nodes such as helps/ fields/ silent-fields/ queue/ quick/
     groups/ msend/ constraints/ field-restrictions/ graphic/ should exist.
  
   * The help fields need warning for illegal characters such as @#$/\&".

   * All nodes need to be verified that they are logically in order. 

   * All text  must to be inside node tags.  If an extra character is discovered,
     it will be an error.

	* If quick entry exists, except the field name(s) of the entry value,
     field default should not be "NE" if require is "MANDATORY".

Check for OEC
   * field label should not use reserved Oracle or OEC keywords

   * field labels translated to Oracle column names must be unique

   * field class "FLAG": the same label name should be the same pow

   file_name     : $JTLSHOME/script/xsl/verify_order.xsl
   programmer    : Etsuko Lippi
   date create   : 3-3-04
-->

<xsl:output method="text"/>

<xsl:param name="jtls-home" select="'/home/jtlsdev'"/>
<xsl:param name="order-name" select="''"/>

<xsl:include href="check_words_list.xsl"/>

<!-- new line text variables -->
<xsl:variable name="cr">
<xsl:text>
</xsl:text>
</xsl:variable>

<!-- these are vocaburary files -->
<xsl:variable name="static-voc-doc" 
  select="document(concat($jtls-home,'/game/data/static_voc.xml'))"/>

<xsl:variable name="dynamic-voc-doc" 
  select="document(concat($jtls-home,'/game/data/dynamic_voc.xml'))"/>

<!-- field name list variable for order -->
<xsl:variable name="field-name-list-order">
  <xsl:for-each select="/order/fields/field">
    <xsl:value-of select="@name"/>
    <xsl:text>,</xsl:text>
  </xsl:for-each>
</xsl:variable>

<!-- field name list variable for utility -->
<xsl:variable name="field-name-list-utility">
  <xsl:for-each select="/utility/fields/field">
    <xsl:value-of select="@name"/>
    <xsl:text>,</xsl:text>
  </xsl:for-each>
</xsl:variable>

<!-- pow check 
     The pow-list is formatted so that the error output is formatted so that
     it is easy on the eyes. 

     There must ve a space character on both sides of the POW name
     for the error checking to work properly. -->
<xsl:variable name="pow-list">
  <xsl:text> DIRECTIVE UNIT TIME.EFFECTIVE 
           INTEGER1 INTEGER2 INTEGER3 INTEGER4 INTEGER5 INTEGER6 
           INTEGER7 INTEGER8 INTEGER9 INTEGER10 INTEGER11 
           INTEGER12 INTEGER13 INTEGER14 INTEGER15 
           SET1 SET2 SET3 SET4 SET5 SET6 SET7 SET8 SET9 SET10 
           REAL1 REAL2 REAL3 REAL4 REAL5 REAL6 REAL7 REAL8 REAL9 REAL10 
           REAL11 REAL12 REAL13 REAL14 REAL15 
           TEXT1 TEXT2 TEXT3 TEXT4 TEXT5 TEXT6 TEXT7 TEXT8 TEXT9 TEXT10 
           TEXT11 TEXT12 TEXT13 TEXT14 TEXT15 </xsl:text>
</xsl:variable>

<xsl:variable name="all-fields"
 select="/order/fields/field | /utility/fields/field | 
 /order/silent-fields/silent-field | /utility/silent-fields/silent-field"/>

<!-- Takes an 'a' attribute. -->
<xsl:variable name="unary-conditions">
  <xsl:text> is-true is-false </xsl:text>
</xsl:variable>

<!-- Takes an 'a' and a 'b' attribute. -->
<xsl:variable name="binary-conditions">
  <xsl:text> equal not-equal greater-than greater-than-or-equal </xsl:text>
  <xsl:text> less-than less-than-or-equal </xsl:text>
</xsl:variable>

<!-- Contains nested code. -->
<xsl:variable name="nested-conditions">
  <xsl:text> exists all </xsl:text>
</xsl:variable>

<!-- Logical separators. -->
<xsl:variable name="logical-ops">
  <xsl:text> and or </xsl:text>
</xsl:variable>

<!-- Document entry point -->
<xsl:template match="/order">
  <xsl:call-template name="process-verify-order">
    <xsl:with-param name="order-node" select="."/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="/utility">
  <xsl:call-template name="process-verify-order">
    <xsl:with-param name="order-node" select="."/>
  </xsl:call-template>
</xsl:template>

<!-- Check each order first. -->
<xsl:template match="/orders-def">
  <xsl:for-each select="utility/order | orders/order">
    <xsl:call-template name="process-verify-order">
      <xsl:with-param name="order-node" select="."/>
    </xsl:call-template>
  </xsl:for-each>
</xsl:template>

<xsl:template name="process-verify-order">
  <xsl:param name="order-node"/>
  <xsl:call-template name="print-order-name">
    <xsl:with-param name="order-node" select="."/>
  </xsl:call-template>

  <xsl:variable name="error-output">
     <xsl:call-template name="verify-order-name"/>
     <xsl:call-template name="verify-order-name-space"/>
     <xsl:call-template name="verify-order-name-length"/>
     <xsl:call-template name="verify-mandatory-nodes-exist"/>
     <xsl:call-template name="verify-nodes-logical-order"/>

     <xsl:call-template name="verify-unqique-constraints"/>
     
     <xsl:call-template name="verify-field-names">
       <xsl:with-param name="field-nodes" select="fields/field | silent-fields/silent-field"/>
     </xsl:call-template>

     <xsl:call-template name="verify-field-name-in-static-dynamic-voc">
       <xsl:with-param name="field-nodes" select="fields/field"/>
     </xsl:call-template>

     <xsl:call-template name="verify-pow-exists-position-text">
       <xsl:with-param name="field-nodes" select="fields/field"/>
     </xsl:call-template>

     <xsl:call-template name="verify-text-node"/>
          
     <xsl:call-template name="verify-check-words">
       <xsl:with-param name="field-nodes" select="fields/field"/>
     </xsl:call-template>
      
<!--Comment out verify-critical-order check 06-29-07 by EL
    Right now this check call gives some errors.
    We take comment out this check after order xml files fixed.
   -->
     <!--xsl:call-template name="verify-critical-order">
       <xsl:with-param name="field-nodes" select="fields/field"/>
     </xsl:call-template-->


     <xsl:call-template name="verify-field-labels">
       <xsl:with-param name="field-nodes" select="fields/field | silent-fields/silent-field"/>
     </xsl:call-template>

     <xsl:call-template name="verify-FLAG-class">
       <xsl:with-param name="field-nodes" select="fields/field | silent-fields/silent-field"/>
     </xsl:call-template>

     <xsl:call-template name="verify-REAL-INTEGER-class">
       <xsl:with-param name="field-nodes" select="fields/field | silent-fields/silent-field"/>
     </xsl:call-template>  

     <xsl:call-template name="verify-uom-checks">
     	 <xsl:with-param name="field-nodes" select="fields/field | silent-fields/silent-field"/>
     </xsl:call-template>    

     <xsl:call-template name="verify-group-name">
       <xsl:with-param name="order-utility" select="groups/group/entries/entry"/>
     </xsl:call-template>

     <xsl:call-template name="verify-group-entry-field-subset">
       <xsl:with-param name="groups"  select="groups/group"/>
     </xsl:call-template>

     <xsl:call-template name="verify-group-entry-label-spellcheck">
       <xsl:with-param name="groups"  select="groups/group"/>
     </xsl:call-template>

     <xsl:call-template name="verify-require-alt-field-in-group-entry">
       <xsl:with-param name="field-nodes"  select="fields/field"/>
     </xsl:call-template>

     <xsl:call-template name="verify-group-entry-in-require-alt-field">
       <xsl:with-param name="group-nodes"  select="groups/group/entries/entry"/>
     </xsl:call-template>

     <xsl:call-template name="verify-queue-entry">
       <xsl:with-param name="order-utility" select="queue"/>
     </xsl:call-template>

     <xsl:call-template name="verify-quick-entry">
       <xsl:with-param name="order-utility" select="quick"/>
     </xsl:call-template>

     <xsl:call-template name="verify-msend-entry">
       <xsl:with-param name="order-utility" select="msend"/>
     </xsl:call-template>

     <xsl:call-template name="verify-constraints-name">
       <xsl:with-param name="order-utility" select="constraints/constraint"/>
     </xsl:call-template>

     <xsl:call-template name="verify-constraints-message">
       <xsl:with-param name="order-utility" select="constraints/constraint"/>
     </xsl:call-template>

     <xsl:call-template name="verify-field-variables">
       <xsl:with-param name="field-nodes" select="fields/field"/>
     </xsl:call-template>

     <xsl:call-template name="verify-field-code-structure">
       <xsl:with-param name="field-nodes" select="fields/field"/>
     </xsl:call-template>

     <xsl:call-template name="verify-restrict-code-structure">
       <xsl:with-param name="restrict-nodes" select="field-restrictions/restrict"/>
     </xsl:call-template>

     <xsl:call-template name="verify-restrict-variables">
       <xsl:with-param name="restrict-nodes" select="field-restrictions/restrict"/>
     </xsl:call-template>

     <!--added 5-6-11 by EL-->
     <xsl:call-template name="verify-restrict-fields-name"/>       

     <!--test 5-13-11 by EL-->
     <xsl:call-template name="verify-graphic-display-name">
		 <xsl:with-param name="display-nodes" select="graphic/display"/>
     </xsl:call-template>

     <!--comment out 5-9-11 by EL-->
     <!--xsl:call-template name="verify-require-and-defalut">
       <xsl:with-param name="field-nodes"  select="fields/field"/>
     </xsl:call-template--> 

     <xsl:call-template name="verify-field-nodes">
       <xsl:with-param name="field-nodes"
                       select="fields/field | silent-fields/silent-field"/>
     </xsl:call-template>

     <xsl:call-template name="verify-field-flag-nodes">
       <xsl:with-param name="field-nodes" select="fields/field"/>
     </xsl:call-template>

     <xsl:call-template name="verify-field-label-length">
       <xsl:with-param name="field-nodes" select="fields/field"/>
     </xsl:call-template>

     <xsl:call-template name="verify-help-illegal-characters">
       <xsl:with-param name="field-nodes" select="$order-node"/>
     </xsl:call-template>

     <xsl:call-template name="verify-not-equal-external-model">
       <xsl:with-param name="field-nodes" select="fields/field"/>
     </xsl:call-template>

     <xsl:call-template name="verify-default-value-and-quick-entry">
   	 <xsl:with-param name="field-nodes" select="fields/field"/>
     </xsl:call-template>

    </xsl:variable>
  <xsl:choose>
    <xsl:when test="string-length($error-output) = 0">
      <xsl:value-of select="concat(' OK',$cr)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="concat($cr,$error-output,'   End of report.',$cr,$cr)"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>



<!-- This template checks mandatory nodes such as helps/ fields/ 
     silent-fields/ queue/ quick/
     groups/ msend/ constraints/ field-restrictions/ 
     graphic/ should exist.
-->  
<xsl:template name="verify-mandatory-nodes-exist">
  <xsl:variable name="check-nodes">
    <xsl:if test="count(help) = 0">
      <xsl:text>help </xsl:text>
    </xsl:if>
    <xsl:if test="count(fields) = 0">
      <xsl:text>fields </xsl:text>
    </xsl:if>
    <xsl:if test="count(silent-fields) = 0">
      <xsl:text>silent-fields </xsl:text>
    </xsl:if>
    <xsl:if test="count(queue) = 0">
      <xsl:text>queue </xsl:text>
    </xsl:if>
    <xsl:if test="count(quick) = 0">
      <xsl:text>quick </xsl:text>
    </xsl:if>
    <xsl:if test="count(groups) = 0">
      <xsl:text>groups </xsl:text>
    </xsl:if>
    <xsl:if test="count(msend) = 0">
      <xsl:text>msend </xsl:text>
    </xsl:if>
    <xsl:if test="count(constraints) = 0">
      <xsl:text>constraints </xsl:text>
    </xsl:if>
    <xsl:if test="count(field-restrictions) = 0">
      <xsl:text>field-restrictions </xsl:text>
    </xsl:if>
    <xsl:if test="count(graphic) = 0">
      <xsl:text>graphics </xsl:text>
    </xsl:if>
  </xsl:variable>
  <xsl:if test="string-length($check-nodes) &gt; 0" >
    <xsl:call-template name="print-error">
      <xsl:with-param name="error-type" select="'Error'"/>
      <xsl:with-param name="field-info" select="$check-nodes"/>
      <xsl:with-param name="field-name" select="'syntax'"/>
      <xsl:with-param name="errormessage" 
       select="concat('The mandatory node(s) ',$check-nodes,' does not exist.')"/>
    </xsl:call-template>
  </xsl:if> 
</xsl:template>



<!-- This template verifies that all nodes are logically in order.
     Added date        18 November 2005
-->
<xsl:template name="verify-nodes-logical-order">

<!--fields node check -->
  <xsl:for-each select="fields/*">
    <xsl:choose>
      <!--this checks fields/field hirerchy -->
      <xsl:when test="name(.) != 'field'">
        <xsl:call-template name="print-error">
          <xsl:with-param name="error-type" select="'Error'"/>
          <xsl:with-param name="field-info" select="''"/>
          <xsl:with-param name="field-name" select="'syntax'"/>
          <xsl:with-param name="errormessage" 
           select="concat('The fields node ', name(.), ' is not logically in order.')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise> 
        <!--go check <field> node children -->
        <xsl:for-each select="*">
          <xsl:if test="name(.) != 'help' and
                        name(.) != 'fill' and
                        name(.) != 'class'">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="''"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
               select="concat('The fields node ', name(.), ' is not logically in order.')"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:for-each>
        <!-- fill check is done by another template -->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>

<!--silent-fileds node check-->
  <xsl:for-each select="silent-fields/*">
    <xsl:choose>
      <!--this checks silent-fields/silent-field hirerchy -->
      <xsl:when test="name(.) != 'silent-field'">
        <xsl:call-template name="print-error">
          <xsl:with-param name="error-type" select="'Error'"/>
          <xsl:with-param name="field-info" select="''"/>
          <xsl:with-param name="field-name" select="'syntax'"/>
          <xsl:with-param name="errormessage" 
           select="concat('The silent-fields node ', name(.), ' is not logically in order.')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise> 
        <!--go check <silent-field> node children -->
        <xsl:for-each select="*">
           <xsl:if test="name(.) != 'class' and
                         name(.) != 'help'">
             <xsl:call-template name="print-error">
               <xsl:with-param name="error-type" select="'Error'"/>
               <xsl:with-param name="field-info" select="''"/>
               <xsl:with-param name="field-name" select="'syntax'"/>
               <xsl:with-param name="errormessage" 
                select="concat('The silent-fields node ', name(.), ' is not logically in order.')"/>
             </xsl:call-template>
           </xsl:if>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>

<!--groups node check-->
  <xsl:for-each select="groups/*">
    <xsl:choose>
      <!--this checks groups/group hirerchy -->
      <xsl:when test="name(.) != 'group'">
        <xsl:call-template name="print-error">
          <xsl:with-param name="error-type" select="'Error'"/>
          <xsl:with-param name="field-info" select="''"/>
          <xsl:with-param name="field-name" select="'syntax'"/>
          <xsl:with-param name="errormessage" 
           select="concat('The groups node ', name(.), ' is not logically in order.')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise> 
        <!--go check <group> node children -->
        <xsl:for-each select="*">
           <xsl:if test="name(.) != 'help' and
                         name(.) != 'entries'">
             <xsl:call-template name="print-error">
               <xsl:with-param name="error-type" select="'Error'"/>
               <xsl:with-param name="field-info" select="''"/>
               <xsl:with-param name="field-name" select="'syntax'"/>
               <xsl:with-param name="errormessage" 
                select="concat('The groups node ', name(.), ' is not logically in order.')"/>
             </xsl:call-template>
           </xsl:if>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>

<!--constraints node check-->
  <xsl:for-each select="constraints/*">
    <xsl:choose>
      <!--this checks constraints/constraint hirerchy -->
      <xsl:when test="name(.) != 'constraint'">
        <xsl:call-template name="print-error">
          <xsl:with-param name="error-type" select="'Error'"/>
          <xsl:with-param name="field-info" select="''"/>
          <xsl:with-param name="field-name" select="'syntax'"/>
          <xsl:with-param name="errormessage" 
           select="concat('The constraints node ', name(.), ' is not logically in order.')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise> 
        <!--go check <constraint> node children -->
        <xsl:for-each select="*">
           <xsl:if test="name(.) != 'message'          and
                         name(.) != 'FILL_ATLEAST_ONE' and
                         name(.) != 'FILL_ONLY_ONE'    and
                         name(.) != 'EQUAL'            and
                         name(.) != 'NOT_EQUAL'        and
                         name(.) != 'GREATER_THAN'     and
                         name(.) != 'LESS_THAN'        and
                         name(.) != 'IF_FIELD'         and
                         name(.) != 'IF_VALUE'         and
                         name(.) != 'IF_ATTRIBUTE'">
             <xsl:call-template name="print-error">
               <xsl:with-param name="error-type" select="'Error'"/>
               <xsl:with-param name="field-info" select="''"/>
               <xsl:with-param name="field-name" select="'syntax'"/>
               <xsl:with-param name="errormessage" 
                select="concat('The constraint node ', name(.), ' is not logically in order.')"/>
             </xsl:call-template>
           </xsl:if>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
</xsl:template>



<xsl:template name="verify-field-names">
  <xsl:param name="field-nodes" select="$all-fields"/>
  <xsl:variable name="field-names">
    <xsl:for-each select="fields/field">
      <xsl:value-of select="concat(' ',@name,' ')"/>
    </xsl:for-each>
  </xsl:variable>
  <xsl:for-each select="fields/field">
    <xsl:variable name="padded-name" select="concat(' ',@name,' ')"/>
    <!-- check if the name occurs more than once. -->
    <xsl:if test="contains(substring-after($field-names,$padded-name),$padded-name)">
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type" select="'Error'"/>
        <xsl:with-param name="field-info" select="@name"/>
        <xsl:with-param name="field-name" select="'syntax'"/>
        <xsl:with-param name="errormessage" 
         select="concat('The field ',@name,' is not unique.')"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:for-each>
  <!-- Check for names that do not exist. -->
  <xsl:for-each
   select="groups/group/entries/entry/@field |
           queue/@entry | quick/@entry | msend/@entry">
    <xsl:call-template name="verify-field-name-list">
      <xsl:with-param name="names" select="."/>
      <xsl:with-param name="field-nodes" select="$field-nodes"/>
    </xsl:call-template>
  </xsl:for-each>
</xsl:template>


<!-- This template verifies field label name 'REFERENCE' have to exist when attribute
     @critical-order = 'true'

     Added date:   by EL    29 June 2007
-->
<xsl:template name="verify-critical-order">
 <xsl:param name="field-nodes"/>
 <xsl:if test="@critical-order = 'true' and count($field-nodes[@pow = 'DIRECTIVE']) = 0">
   <xsl:call-template name="print-error">
     <xsl:with-param name="error-type" select="'Error'"/>
     <xsl:with-param name="field-info" select="''"/>
     <xsl:with-param name="field-name" select="'DIRECTIVE'"/>
     <xsl:with-param name="errormessage" 
      select="'field attribute pow must be DIRECTIVE when @critical-order is true.'"/>
   </xsl:call-template>
 </xsl:if>
</xsl:template>


<!-- This template verifies field label name: The label should not result in an
     OEC column name that is a reserved oracle or OEC name.
     Added date:   by EL    10 January 2007
-->
<xsl:template name="verify-field-labels">
  <xsl:param name="field-nodes"/>

  <!--xsl:variable name="reserved-word-nodes" select="saxon:nodeSet($oracle-keywords)/keywords/* | saxon:nodeSet($oec-keywords)/keywords/*"/-->
  <xsl:variable name="reserved-word-nodes" select="$oracle-keywords/keywords/* | $oec-keywords/keywords/*"/>

  <!-- check each field to verify the resultant OEC column will not be a
       reserved keyword -->
  <xsl:for-each select="$field-nodes">

    <xsl:variable name="column-name">
      <xsl:call-template name="get-sql-name">
        <xsl:with-param name="base_name" select="@label"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:if test="count($reserved-word-nodes[@name = $column-name]) > 0">
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type" select="'Error'"/>
        <xsl:with-param name="field-info" select="@label"/>
        <xsl:with-param name="field-name" select="'bad label name'"/>
        <xsl:with-param name="errormessage" 
         select="concat('The field label ',@label,' results in an OEC column name that is a reserved word.')"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:for-each>

  <!-- check each field to verify the resultant OEC column name will be
       unique -->
  <xsl:for-each select="$field-nodes[class/@is != 'FLAG']">

    <xsl:variable name="column-name">
      <xsl:call-template name="get-sql-name">
        <xsl:with-param name="base_name" select="@label"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="current-position" select="position()"/>
    <xsl:variable name="previous-nodes" select="$field-nodes[position() &lt; $current-position]"/>

    <xsl:for-each select="$previous-nodes">
      <xsl:variable name="previous-name">
        <xsl:call-template name="get-sql-name">
          <xsl:with-param name="base_name" select="@label"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:if test="$column-name = $previous-name">
        <xsl:call-template name="print-error">
          <xsl:with-param name="error-type" select="'Error'"/>
          <xsl:with-param name="field-info" select="@label"/>
          <xsl:with-param name="field-name" select="'duplicate label name'"/>
          <xsl:with-param name="errormessage" 
           select="concat('The field label ',@label,' results in a duplicate OEC column name with a previous field.')"/>
        </xsl:call-template>
      </xsl:if>

    </xsl:for-each>

  </xsl:for-each>

</xsl:template> <!-- verify-field-labels -->



<!-- This template verifies the field class="FLAG": the same label name must have
     the same pow value.
     Added date:   by EL    10 January 2007
-->
<xsl:template name="verify-FLAG-class">
  <xsl:param name="field-nodes" select="$all-fields"/>
 
  <xsl:variable name="field-labels-FLAG">
    <xsl:for-each select="fields/field">
      <xsl:if test="class/@is = 'FLAG'">
        <xsl:value-of select="concat(' ',@label,' ')"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>
 
  <!--Check this order has FLAG class-->
  <xsl:if test="string-length($field-labels-FLAG) &gt; 0">
   <!--if the same labels exist-->
   <xsl:for-each select="fields/field">
     <xsl:if test="class/@is = 'FLAG'">
       <xsl:variable name="label-value" select="concat(' ',@label,' ')"/>
       <xsl:if test="contains(substring-after($field-labels-FLAG,$label-value),$label-value)">
         <!--now pow value check here-->
         <xsl:variable name="same-label" select="@label"/>
         <xsl:variable name="same-pow"   select="@pow"/>

         <xsl:for-each select="../../fields/field">
           <xsl:if test="class/@is = 'FLAG'   and  @label = $same-label">
             <xsl:if test="@pow   != $same-pow"> 
               <xsl:call-template name="print-error">
                 <xsl:with-param name="error-type" select="'Error'"/>
                 <xsl:with-param name="field-info" select="@pow"/>
                 <xsl:with-param name="field-name" select="'wrong pow'"/>
                 <xsl:with-param name="errormessage" 
                  select="concat('The field label ',@label,' must use the same pow value.')"/>
               </xsl:call-template>
             </xsl:if>
           </xsl:if>
         </xsl:for-each>
       </xsl:if>
     </xsl:if>
   </xsl:for-each>
  </xsl:if>   
</xsl:template>



<xsl:template name="verify-field-name-list">
  <xsl:param name="flag"/>
  <xsl:param name="names"/>
  <xsl:param name="field-nodes" select="$all-fields"/>
  <xsl:call-template name="verify-field-name-list-loop">
    <xsl:with-param name="flag" select="$flag"/>
    <xsl:with-param name="names"
       select="concat(translate($names,' ',''),',')"/>
    <xsl:with-param name="field-nodes" select="$field-nodes"/>
  </xsl:call-template>
</xsl:template>
<!-- The Loop Template. -->
<xsl:template name="verify-field-name-list-loop">
  <xsl:param name="flag"/>
  <xsl:param name="names"/>
  <xsl:param name="field-nodes" select="$all-fields"/>
  <xsl:if test="string-length($names) &gt; 2">
    <xsl:variable name="next-name" select="substring-before($names,',')"/>
    <xsl:variable name="next-names" 
       select="substring-after($names,concat($next-name,','))"/>

    <xsl:call-template name="verify-field-name">
      <xsl:with-param name="flag" select="$flag"/>
      <xsl:with-param name="name" select="$next-name"/>
      <xsl:with-param name="fields" select="$field-nodes"/>
    </xsl:call-template>
    <!-- Iterate through the loop. -->
    <xsl:call-template name="verify-field-name-list-loop">
      <xsl:with-param name="flag" select="$flag"/>
      <xsl:with-param name="names" select="$next-names"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>





<xsl:template name="verify-unqique-constraints">
  <xsl:param name="fields" select="$all-fields"/>
  <xsl:if test="name() = 'utility' and @unique-entries = 'true' and count($fields[@unique-key = 'true']) = 0">
    <xsl:call-template name="print-error">
      <xsl:with-param name="error-type" select="'Error'"/>
      <xsl:with-param name="field-info" select="@name"/>
      <xsl:with-param name="field-name" select="'syntax'"/>
      <xsl:with-param name="errormessage" 
       select="'The utility has unique-entries=true but no unique-key fields.'"/>
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="name() = 'utility' and count($fields[@unique-key = 'true']) &gt; 0">
    <xsl:if test="count(@unique-entries) != 1 or @unique-entries = 'false' or @unique-entries = ''">   
    <xsl:call-template name="print-error">
      <xsl:with-param name="error-type" select="'Error'"/>
      <xsl:with-param name="field-info" select="@name"/>
      <xsl:with-param name="field-name" select="'syntax'"/>
      <xsl:with-param name="errormessage" 
       select="'The utility has unique-key fields but no unique-entries=true.'"/>
    </xsl:call-template>
    </xsl:if>
  </xsl:if>

  <xsl:if test="name() = 'utility' and @unique-entries = 'false' and count($fields[@unique-key = 'true']) > 0">
    <xsl:call-template name="print-error">
      <xsl:with-param name="error-type" select="'Error'"/>
      <xsl:with-param name="field-info" select="@name"/>
      <xsl:with-param name="field-name" select="'syntax'"/>
      <xsl:with-param name="errormessage" 
       select="'The utility has unique-key fields but the unique-entries attribute of the utility tag is not set to true.'"/>
    </xsl:call-template>
  </xsl:if>
  <xsl:if test="name() = 'order' and count($fields[@unique-key = 'true']) > 0">
    <xsl:call-template name="print-error">
      <xsl:with-param name="error-type" select="'Error'"/>
      <xsl:with-param name="field-info" select="@name"/>
      <xsl:with-param name="field-name" select="'syntax'"/>
      <xsl:with-param name="errormessage" 
       select="'The order field can not have the unique-field attribute specified.'"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>

<xsl:template name="verify-field-name">
  <xsl:param name="flag"/>
  <xsl:param name="name" select="'NULL'"/>
  <xsl:param name="fields" select="$all-fields"/>
  <xsl:if test="$name != 'NULL' and count($fields[@name = $name]) = 0">
    
     <xsl:choose>
      <xsl:when test="$flag = 'graphic'">
		  <xsl:call-template name="print-error">
          <xsl:with-param name="error-type" select="'Error'"/>
          <xsl:with-param name="field-info" select="$name"/>
          <xsl:with-param name="field-name" select="''"/>
          <xsl:with-param name="errormessage"  
             select="concat('The graphic/display/@utility ', $name)"/>
          <xsl:with-param name="errormessage2" 
             select="'does not exist in the field.'"/>
	     </xsl:call-template>     
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="print-error">
          <xsl:with-param name="error-type" select="'Error'"/>
          <xsl:with-param name="field-info" select="@name"/>
          <xsl:with-param name="field-name" select="'syntax'"/>
          <xsl:with-param name="errormessage" 
            select="concat('The field ',$name,' does not exist.')"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:if>
</xsl:template>


<xsl:template name="verify-field-nodes">
  <xsl:param name="field-nodes"/>
  <xsl:for-each select="$field-nodes">
    <xsl:if test="count(class) != 1">
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type" select="'Error'"/>
        <xsl:with-param name="field-info" select="@name"/>
        <xsl:with-param name="field-name" select="'syntax'"/>
        <xsl:with-param name="errormessage" 
         select="concat('The field ',@name,' is missing a class node.')"/>
      </xsl:call-template>
    </xsl:if>
    <!-- check default attribute if class is FLAG, the value must be a number
                                                      added DEC-28-06 by EL-->
    <xsl:if test="class/@is = 'FLAG' and 
                  contains(class/@default, 'NE')">
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type" select="'Error'"/>
        <xsl:with-param name="field-info" select="class/@is"/>
        <xsl:with-param name="field-name" select="'syntax'"/>
        <xsl:with-param name="errormessage" 
         select="concat('The field class ',class/@is,' attribute default can not have the value of NE.')"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:for-each>
  <xsl:call-template name="verify-field-attributes">
    <xsl:with-param name="field-nodes" select="$field-nodes"/>
  </xsl:call-template>
</xsl:template>



<!-- This template checks the fields/field and silent-fields/silent-field 
     attributes.
-->
<xsl:template name="verify-field-attributes"> 
  <xsl:param name="field-nodes"/>
    <xsl:for-each select="$field-nodes">
      <xsl:choose>
        <xsl:when test="class/@is = 'BE_FACILITY'">
          <xsl:if test="count(class/@be-checks) != 1 or
                        count(class/@input)       != 1 or
                        count(class/@default)     != 1">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'BE_FACILITY'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For ',@name,' field class node,  the be-checks, input, and default attributes are required.')"/>
            </xsl:call-template>
          </xsl:if> 
        </xsl:when>
        <xsl:when test="class/@is = 'DMPI'">
          <xsl:if test="count(class/@dmpi-checks) != 1 or
                        count(class/@input)       != 1 or
                        count(class/@default)     != 1">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'DMPI'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For ',@name,' field class node,  the dmpi-checks, input, and default attributes are required.')"/>
            </xsl:call-template>
          </xsl:if> 
        </xsl:when>
        <xsl:when test="class/@is = 'FRACTION'">
          <xsl:if test="count(class/@precision)   != 1 or
                        count(class/@default)     != 1">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'FRACTION'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For ',@name,' field class node,  the precision and default attributes are required.')"/>
            </xsl:call-template>
          </xsl:if> 
        </xsl:when>
        <xsl:when test="class/@is = 'INTEGER'">
          <xsl:if test="count(class/@min)     != 1 or
                        count(class/@max)     != 1 or
                        count(class/@uom)     != 1 or
                        count(class/@default) != 1">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'INTEGER'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For ',@name,' field class node,  the min, max, uom, and default attributes are required.')"/>
            </xsl:call-template>
          </xsl:if> 
          <!-- check the validity of the range -->
          <xsl:if test="count(class/@min) = 1 and class/@min &lt; 0">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'INTEGER'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For field ',@name,' the min value must be greater than or equal to zero.')"/>
            </xsl:call-template>
          </xsl:if> 
          <xsl:if test="count(class/@max) = 1 and class/@max &gt; 2147483647">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'INTEGER'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For field ',@name,' the max value must be less than or equal to 2147483647.')"/>
            </xsl:call-template>
          </xsl:if> 
        </xsl:when>
        <xsl:when test="class/@is = 'LOCATION'">
          <xsl:if test="count(class/@on-game-board) != 1 or
                        count(class/@hex-type)      != 1 or
                        count(class/@default)       != 1">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'LOCATION'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For ',@name,' field class node,  the on-game-board, hex-type, and default attributes are required.')"/>
            </xsl:call-template>
          </xsl:if> 
        </xsl:when>
        <xsl:when test="class/@is = 'MSN_NAME'">
          <xsl:if test="count(class/@max-length)    != 1 or
                        count(class/@default)       != 1">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'MSN_NAME'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For ',@name,' field class node,  the max-length and default attributes are required.')"/>
            </xsl:call-template>
          </xsl:if> 
        </xsl:when>
        <xsl:when test="class/@is = 'POLYGON'">
          <xsl:if test="count(class/@max-vertices) != 1 or
                        count(class/@polygon-type) != 1 or
                        count(class/@default)      != 1">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'POLYGON'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For ',@name,' field class node,  the max-vertices, polygon-type, and default attributes are required.')"/>
            </xsl:call-template>
          </xsl:if> 
        </xsl:when>
        <xsl:when test="class/@is = 'REAL'">
          <xsl:if test="count(class/@min)        != 1 or
                        count(class/@max)        != 1 or
                        count(class/@precision)  != 1 or
                        count(class/@uom)        != 1 or
                        count(class/@default)    != 1">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'REAL'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For ',@name,' field class node,  the  min, max, precision, uom, and default attributes are required.')"/>
            </xsl:call-template>
          </xsl:if> 
        </xsl:when>
        <xsl:when test="class/@is = 'STATIC_V' or 
                        class/@is = 'DATA_V'">
          <xsl:if test="count(class/@name)     != 1 or
                        count(class/@sort)     != 1 or
                        count(class/@default)  != 1">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'STATIC_V or DATA_V'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For ',@name,' field class node, the name, sort, and default attributes are required.')"/>
            </xsl:call-template>
          </xsl:if> 
        </xsl:when>
        <!--following check is only default check-->
        <xsl:when test="class/@is = 'TIME' or 
                        class/@is = 'FLAG' or
                        class/@is = 'FORM' or
                        class/@is = 'MSN'  or
                        class/@is = 'PIPE'">
          <xsl:if test="count(class/@default)  != 1">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'TIME or FLAG or PIPE or MSN or FORM'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For ',@name,' field class node, the default attribute is required.')"/>
            </xsl:call-template>
          </xsl:if> 
          <xsl:call-template name="verify-field-attribute-values">
              <xsl:with-param name="field-node" select="."/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="class/@is = 'TEXT'">
          <xsl:if test="count(class/@allow-spaces) != 1 or
                        count(class/@case)         != 1 or
                        count(class/@max-length)   != 1 or
                        count(class/@default)      != 1">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'TEXT'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For ',@name,' field class node, the allow-spaces, case, max-length, and default attributes are required.')"/>
            </xsl:call-template>
          </xsl:if> 
        </xsl:when>
        <xsl:when test="class/@is = 'TG'">
          <xsl:if test="count(class/@tg-checks) != 1 or
                        count(class/@input)     != 1 or
                        count(class/@default)   != 1">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'TG'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For ',@name,' field class node, the tg-checks, input, and default attributes are required.')"/>
            </xsl:call-template>
          </xsl:if> 
        </xsl:when>
        <xsl:when test="class/@is = 'UT'">
          <xsl:if test="count(class/@allow-none)   != 1 or
                        count(class/@unit-checks)  != 1 or
                        count(class/@input)        != 1 or
                        count(class/@default)      != 1">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'UT'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For ',@name,' field class node, the allow-none, unit-checks, input, and default attributes are required.')"/>
            </xsl:call-template>
          </xsl:if> 
        </xsl:when>
        <xsl:when test="class/@is = 'UTILITY'">
          <xsl:if test="count(class/@name)     != 1 or
                        count(class/@default)  != 1">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="'UTILITY'"/>
              <xsl:with-param name="field-name" select="'syntax'"/>
              <xsl:with-param name="errormessage" 
                select="concat('For ',@name,' field class node, the name and default attributes are required.')"/>
            </xsl:call-template>
          </xsl:if> 
          <!--xsl:if test="count(class/@name)     = 1 and
                        count(class/@default)  = 1">
            <xsl:variable name="utilname">
                <xsl:value-of select="@name"/>
            </xsl:variable>
            <xsl:value-of select="@name"/>
            <xsl:value-of select="$cr"/>

            <xsl:for-each select="/order">
               <xsl:value-of select="@name"/>
               <xsl:value-of select="$cr"/>
               <xsl:call-template name="print-error">
                 <xsl:with-param name="error-type" select="'Error'"/>
                 <xsl:with-param name="field-info" select="'UTILITY'"/>
                 <xsl:with-param name="field-name" select="'syntax'"/>
                 <xsl:with-param name="errormessage" 
                   select="concat('For ',@name,' field class node, the name and default attributes are required.')"/>
               </xsl:call-template>
            </xsl:for-each>
          </xsl:if--> 

        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
</xsl:template>

<!-- This template checks the fields/field and silent-fields/silent-field 
     * attribute values.
     Date:       Sept 24, 2010
     Programmer: Steve Tang
-->
<xsl:template name="verify-field-attribute-values">
  <xsl:param name="field-node"/>
  <xsl:choose>
    <xsl:when test="class/@is='TIME'">
      <xsl:if test="contains(class/@hide, class/@default)">
        <xsl:call-template name="print-error">
          <xsl:with-param name="error-type" select="'Error'"/>
          <xsl:with-param name="field-info" select="class/@is"/>
          <xsl:with-param name="field-name" select="'syntax'"/>
          <xsl:with-param name="errormessage" 
            select="concat('The field class ',class/@is,' hide attribute contains ', class/@default,
                    ' thus the default attribute can not have the value of ', class/@default, '.')"/>
        </xsl:call-template>
      </xsl:if> 
    </xsl:when>
  </xsl:choose>
</xsl:template>

<!-- This template checks the tag structure for a given field 
     * Check node names and attributes
     * Check the logical structure of the code blocks
     * ensure help names exist.
     * ensure help names are unique.
     Date:       May 10, 2004
     Programmer: Humberto Yeverino
  -->
<xsl:template name="verify-field-code-structure">
  <xsl:param name="field-nodes"/> 
 
  <!-- The total number of equal, and or or shoud be odd -->
  <xsl:for-each select="$field-nodes/fill/with">
    <xsl:call-template name="verify-code-structure">
      <xsl:with-param name="src-node" select="."/>
      <xsl:with-param name="field-name" select="../../@name"/>
      <xsl:with-param name="help-nodes" select="../helps/help"/>
    </xsl:call-template>
    <xsl:call-template name="verify-field-helps-unique">
      <xsl:with-param name="helps-node" select="../helps"/>
      <xsl:with-param name="field-name" select="../../@name"/>
    </xsl:call-template>
  </xsl:for-each>
  <xsl:for-each select="$field-nodes">
     <xsl:if test="@class = 'MSN' or @class = 'UT' or @class = 'TG'">
       <xsl:if test="count(fill) = 0">
         <xsl:call-template name="print-error">
           <xsl:with-param name="error-type" select="'Error'"/>
           <xsl:with-param name="field-info" select="@class"/>
           <xsl:with-param name="field-name" select="'syntax'"/>
           <xsl:with-param name="errormessage" 
            select="concat('The field ',../@name,' is missing a &quot;fill&quot; node.')"/>
         </xsl:call-template>
       </xsl:if> 
     </xsl:if> 
  </xsl:for-each>
</xsl:template>



<!--This template checks graphic/display/@utility
    ensure name exist in the field.
    ensure @utility attribute must be "utility"
    Date:       5-13-2011
    Programmer: Etsuko Lippi
-->
<xsl:template name="verify-graphic-display-name">
  <xsl:param name="display-nodes"/>
  <xsl:variable name="check-utility">
    <xsl:for-each select="$display-nodes">    
      <xsl:value-of select="@utility"/>
      <xsl:text>,</xsl:text>   
    </xsl:for-each>  
  </xsl:variable>
  <xsl:call-template name="verify-field-name-list">
      <xsl:with-param name="flag" select="'graphic'"/>
      <xsl:with-param name="names" select="$check-utility"/>
      <xsl:with-param name="field-nodes" select="$all-fields"/>
  </xsl:call-template>
   
  <xsl:if test="count(graphic/display) &gt; 0">
	 <xsl:if test="count(graphic/display/@utility) = 0">
     <xsl:call-template name="print-error">
      <xsl:with-param name="error-type" select="'Error'"/>
      <xsl:with-param name="field-info" select="@utility"/>
      <xsl:with-param name="field-name" select="'syntax'"/>
      <xsl:with-param name="errormessage" 
           select="('The graphic/display/ attribute name must be @utility')"/> 
     </xsl:call-template>     
    </xsl:if>
  </xsl:if>
</xsl:template>



<!-- This template checks the tag structure for all field restrictions
     * Check node names and attributes
     * Check the logical structure of the code blocks
     * ensure help names exist.
     * ensure help names are unique.
     Date:       May 11, 2004
     Programmer: Humberto Yeverino
  -->
<xsl:template name="verify-restrict-code-structure">
  <xsl:param name="restrict-nodes"/>  
  <!-- The total number of equal, and or or shoud be odd -->
  <xsl:for-each select="$restrict-nodes">
    <xsl:call-template name="verify-code-structure">
      <xsl:with-param name="src-node" select="such-that"/>
      <xsl:with-param name="field-name" select="@fields"/>
      <xsl:with-param name="help-nodes" select="helps/help"/>
    </xsl:call-template>
    <xsl:call-template name="verify-field-helps-unique">
      <xsl:with-param name="helps-node" select="helps"/>
      <xsl:with-param name="field-name" select="@fields"/>
    </xsl:call-template>
  </xsl:for-each>
</xsl:template>



<!-- This template checks the tag structure for a given source node
     * Check node names and attributes
     * Check the logical structure of the code blocks
     * ensure help names exist.
     Date:       May 10, 2004
     Programmer: Humberto Yeverino
  -->
<xsl:template name="verify-code-structure">
  <xsl:param name="src-node"/> 
  <xsl:param name="field-name"/>
  <xsl:param name="help-nodes"/> 
  <xsl:choose>
    <!-- If the nodes is odd, the code structure is invalid. -->
    <xsl:when test="count($src-node/*) mod 2 = 0 and count($src-node/*) != 0">
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type" select="'Error'"/>
        <xsl:with-param name="field-info" select="$field-name"/>
        <xsl:with-param name="field-name" select="'syntax'"/>
        <xsl:with-param name="errormessage" 
         select="' The code structure is invalid.'"/>
      </xsl:call-template>
      <xsl:for-each select="$src-node/*">
        <xsl:value-of select="concat('   &lt;',name(),'&gt;',$cr)"/>
      </xsl:for-each>
      <xsl:value-of select="$cr"/>
    </xsl:when>
    <xsl:otherwise>
      <!-- Verify tag names and attributes. -->
      <xsl:for-each select="$src-node/*">
        <!-- If the position is odd, it is a condition, otherwise it is
             a separator. -->
        <xsl:choose>
          <xsl:when test="position() mod 2 = 1">
            <!-- Verify the help name if it exists. -->
            <xsl:if test="@help">
              <xsl:call-template name="verify-field-fill-helps">
                <xsl:with-param name="help-path" select="$help-nodes"/>
                <xsl:with-param name="help-name" select="@help"/>
                <xsl:with-param name="field-name" select="$field-name"/>
              </xsl:call-template>
            </xsl:if>
            <!-- Verfiy the tag name. -->
            <xsl:choose>
              <xsl:when test="contains($unary-conditions,concat(' ',name(),' '))">
                <!-- Check for an 'a' attribute. -->
                <xsl:if test="count(@a) != 1">
                  <xsl:call-template name="print-error">
                     <xsl:with-param name="error-type" select="'Error'"/>
                     <xsl:with-param name="field-info" select="$field-name"/>
                     <xsl:with-param name="field-name" select="'syntax'"/>
                     <xsl:with-param name="errormessage" 
                      select="concat('The ',name(),' tag is invalid.')"/>
                   </xsl:call-template>
                </xsl:if>
              </xsl:when>
              <xsl:when test="contains($binary-conditions,concat(' ',name(),' '))">
                <!-- Check for an 'a' and a 'b' attribute. -->
                <xsl:if test="count(@a) != 1 or count(@b) != 1">
                  <xsl:call-template name="print-error">
                     <xsl:with-param name="error-type" select="'Error'"/>
                     <xsl:with-param name="field-info" select="$field-name"/>
                     <xsl:with-param name="field-name" select="'syntax'"/>
                     <xsl:with-param name="errormessage" 
                      select="concat('The ',name(),' tag is invalid.')"/>
                   </xsl:call-template>
                </xsl:if>
              </xsl:when>
              <xsl:when test="name() = 'exists'">
                <!-- Check for a 'type' and a 'named' attribute -->
                <xsl:choose>
                  <xsl:when test="count(@type) = 1 and
                                  count(@named) = 1">
                    <xsl:call-template name="verify-code-structure">
                      <xsl:with-param name="src-node" select="."/> 
                      <xsl:with-param name="field-name" select="$field-name"/>
                      <xsl:with-param name="help-nodes" select="$help-nodes"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:call-template name="print-error">
                      <xsl:with-param name="error-type" select="'Error'"/>
                      <xsl:with-param name="field-info" select="$field-name"/>
                      <xsl:with-param name="field-name" select="'syntax'"/>
                      <xsl:with-param name="errormessage" 
                       select="'The exists tag is invalid.'"/>
                    </xsl:call-template>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:when test="name() = 'all'">
                <xsl:call-template name="verify-code-structure">
                  <xsl:with-param name="src-node" select="."/> 
                  <xsl:with-param name="field-name" select="$field-name"/>
                  <xsl:with-param name="help-nodes" select="$help-nodes"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="print-error">
                  <xsl:with-param name="error-type" select="'Error'"/>
                  <xsl:with-param name="field-info" select="$field-name"/>
                  <xsl:with-param name="field-name" select="'syntax'"/>
                  <xsl:with-param name="errormessage" 
                   select="concat('The condition ',name(),' is invalid.')"/>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="not(contains($logical-ops,concat(' ',name(),' ')))">
              <xsl:call-template name="print-error">
                <xsl:with-param name="error-type" select="'Error'"/>
                <xsl:with-param name="field-info" select="$field-name"/>
                <xsl:with-param name="field-name" select="'syntax'"/>
                <xsl:with-param name="errormessage" 
                 select="concat('The logical operator ',name(),' is invalid.')"/>
              </xsl:call-template>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>



<!-- Given a help-name, ensure it exists in the helps node -->
<xsl:template name="verify-field-fill-helps">
  <xsl:param name="help-path"/>
  <xsl:param name="help-name"/>
  <xsl:param name="field-name"/>
  <xsl:if test="count($help-path[@name = $help-name]) = 0">
    <xsl:call-template name="print-error">
      <xsl:with-param name="error-type" select="'Error'"/>
      <xsl:with-param name="field-info" select="$field-name"/>
      <xsl:with-param name="field-name" select="'bad help name'"/>
      <xsl:with-param name="errormessage" 
       select="concat('The help name ',$help-name,' does not exist.')"/>
    </xsl:call-template>  
  </xsl:if>
</xsl:template>



<!-- Ensure all help names are unique -->
<xsl:template name="verify-field-helps-unique">
  <xsl:param name="helps-node"/>
  <xsl:param name="field-name"/>
  <xsl:for-each select="$helps-node/help">
    <xsl:variable name="help-name" select="@name"/>
    <xsl:variable name="pos" select="position()"/>
    <!-- The following condition is to prevent multiple output for duplicates -->
    <xsl:if test="count($helps-node/help[@name = $help-name]) &gt;  1 and
                  position() = last() or
                  $helps-node/help[$pos]/@name != $help-name">
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type" select="'Error'"/>
        <xsl:with-param name="field-info" select="$field-name"/>
        <xsl:with-param name="field-name" select="'bad help name'"/>
        <xsl:with-param name="errormessage" 
         select="concat('The help name ',@name,' occurs more than once.')"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:for-each>
</xsl:template>



<!-- param "field"      a field name or field name list. 
     param "parent"     either group, queue, quick or msend.
     param "field-path" path to the node of fields/field.
     This template is used to check group, queue, quick and msend field name.
-->
<xsl:template name="one-field-name">
  <xsl:param name="field"/> 
  <xsl:param name="parent"/>
  <xsl:param name="field-path"  select="."/>
  <!-- create a variable of group field with no space-->
  <xsl:variable name="field-no-space">
    <xsl:value-of select="translate($field, ' ', '')"/>
  </xsl:variable>

  <xsl:variable name="current-node" select="."/>
  
  <xsl:for-each select="tokenize($field-no-space,',')">

    <xsl:variable name="target-field" select="."/>
  
    <xsl:variable name="field-exist">
      <xsl:for-each select="$field-path">
        <xsl:if test="@name = $target-field">exist</xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:if test="$field-exist != 'exist' and $current-node/@name != 'NULL'">
      <xsl:call-template name="print-error">
        <xsl:with-param name="node"       select="$current-node"/>
        <xsl:with-param name="error-type" select="'Error'"/>
        <xsl:with-param name="field-info" select="$parent"/>
        <xsl:with-param name="field-name" select="$target-field"/>
        <xsl:with-param name="errormessage" select="concat('does not exist. ', $target-field)"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:for-each>

  <!-- cut off one field name from field-->
<!--
  <xsl:variable name="one-field">
    <xsl:choose> 
      <xsl:when test="starts-with($field-no-space, ',') = true">
        <xsl:value-of select="substring-after($field-no-space, ',')"/>
      </xsl:when>
      <xsl:otherwise> 
        <xsl:choose>
          <xsl:when test="contains($field-no-space, ',') = true">
            <xsl:value-of select="substring-before($field-no-space, ',')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$field-no-space"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
-->
  <!-- check if a field name exists in field names --> 
<!--
  <xsl:if test="string-length($field) &gt; 0">
    <xsl:variable name="field-exist">
      <xsl:for-each select="$field-path">
        <xsl:if test="@name = $one-field">exist</xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:if test="$field-exist != 'exist' and @name != 'NULL'">
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type" select="'Error'"/>
        <xsl:with-param name="field-info" select="$parent"/>
        <xsl:with-param name="field-name" select="$one-field"/>
        <xsl:with-param name="errormessage" select="concat('does not exist. ', $one-field)"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:if>
-->
  <!-- recursive itself until field is empty-->
<!--
  <xsl:if test="string-length($field) &gt; 0"> 
    <xsl:variable name="remain-field">
      <xsl:value-of select="substring-after($field, ',')"/>
    </xsl:variable>
    <xsl:call-template name="one-field-name">
      <xsl:with-param name="field" select="$remain-field"/>
      <xsl:with-param name="parent" select="$parent"/>
      <xsl:with-param name="field-path" select="$field-path"/>
    </xsl:call-template>
  </xsl:if>
-->
</xsl:template>



<xsl:template name="verify-group-name">
  <xsl:param name="order-utility"/>
  <xsl:for-each select="$order-utility">
    <xsl:call-template name="one-field-name">
      <xsl:with-param name="field" select="@field"/>
      <xsl:with-param name="parent" select="'group'"/>
      <xsl:with-param name="field-path" select="../../../../fields/field"/>
    </xsl:call-template>
  </xsl:for-each>
</xsl:template>



<!--
 This template checks if field/@require="ALTMAN or ALTOPT",
 that field name has to be in groups/group/entries/entry/@field
 added March 19, 2007
-->
<xsl:template name="verify-require-alt-field-in-group-entry">
 <xsl:param name="field-nodes"/>
 <xsl:for-each select="$field-nodes">
    <xsl:variable name="alt-field-name" select="@name"/>
    <xsl:if test="@require = 'ALTMAN' or  @require = 'ALTOPT'">
      <!--check if a field name is contained in a group/entry-->
      <xsl:variable name="field-in-group">
         <xsl:for-each select="../../groups/group/entries/entry">          
           <xsl:choose>
             <xsl:when test="contains(@field, $alt-field-name)">
               <xsl:text>1</xsl:text>
             </xsl:when>
             <xsl:otherwise>0</xsl:otherwise>
           </xsl:choose>
         </xsl:for-each>
      </xsl:variable>    
      <xsl:choose>
        <xsl:when test="contains($field-in-group, '1') = false">
          <xsl:call-template name="print-error">
            <xsl:with-param name="error-type"     select="'Error'"/>
            <xsl:with-param name="field-info"     select="'field name'"/>
            <xsl:with-param name="field-name"     select="$alt-field-name"/>
            <xsl:with-param name="errormessage"   select="concat('require type is declared as &quot;ALTMAN&quot; or &quot;ALTOPT&quot;; ', ' ')"/>
            <xsl:with-param name="errormessage2"  select="concat('however, it is not shown in group/entry/@field. ',' ')"/>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
 </xsl:for-each>
</xsl:template>



<!--
 This template checks if field/@require="OPT or ALTOPT",
 that class/@default must be 'NE'
 Date:       5-6-2011
 Programmer: Etsuko Lippi
-->
<xsl:template name="verify-require-and-defalut">
 <xsl:param name="field-nodes"/>
 <xsl:for-each select="$field-nodes">

    <xsl:variable name="alt-field-name" select="@name"/>

    <xsl:if test="@require = 'OPT' or  @require = 'ALTOPT'">
      <xsl:value-of select="@name"/>
      <!--check default must be 'NE'-->          
      <xsl:if test="class/@default != 'NE'">
         <xsl:call-template name="print-error">
            <xsl:with-param name="error-type"     select="'Error'"/>
            <xsl:with-param name="field-info"     select="'field name'"/>
            <xsl:with-param name="field-name"     select="$alt-field-name"/>
            <xsl:with-param name="errormessage"   select="concat('require type is declared as &quot;OPT&quot; or &quot;ALTOPT&quot;; ', ' ')"/>
            <xsl:with-param name="errormessage2"  select="concat('however, the class/@default is not NE. ',' ')"/>
          </xsl:call-template>    
      </xsl:if>      
    </xsl:if>
 </xsl:for-each>
</xsl:template>



<!-- 
This templates varify a restrict field name that must be exist in the field.
     Date added: 5-6-2011
     Programmer: Etsuko Lippi
-->
<xsl:template name="verify-restrict-fields-name">
 <!-- Check for names that do not exist. -->
  <xsl:for-each select="field-restrictions/restrict/@fields">
    <xsl:call-template name="verify-field-name-list">
      <xsl:with-param name="names" select="."/>
      <xsl:with-param name="field-nodes" select="$all-fields"/>
    </xsl:call-template>
  </xsl:for-each>
</xsl:template>



<!--
 This template checks if groups/group/entries/entry/@field has a field name,
 that field's require type has to be "ALTMAN" or "ALTOPT" in fields/field/@require
 added March 20, 2007
-->
<xsl:template name="verify-group-entry-in-require-alt-field">
  <xsl:param name="group-nodes"/> 
  <xsl:for-each select="$group-nodes">
    <xsl:variable name="field-name" select="@field"/>
    <xsl:call-template name="check-require-type-in-field">
       <xsl:with-param name="field" select="@field"/>
       <xsl:with-param name="field-path" select="../../../../fields/field"/>
    </xsl:call-template>
  </xsl:for-each>
</xsl:template>


<!--
 This template works with the verify-group-entry-in-require-alt-field template.
 It cuts off a field name and checks the require type in fields/field/@require
 The declaration has to be "ALTMAN" or "ALTOPT".
 added March 20, 2007
-->
<xsl:template name="check-require-type-in-field">
  <xsl:param name="field"/> 
  <xsl:param name="field-path"/>

  <xsl:variable name="current-node" select="."/>
  <xsl:variable name="group-name" select="../../@label"/>
  <xsl:variable name="entry-name" select="@label"/>

  <!-- create a variable of group field with no space-->
  <xsl:variable name="field-no-space">
    <xsl:value-of select="translate($field, ' ', '')"/>
  </xsl:variable>

  <xsl:for-each select="tokenize($field-no-space,',')">

    <xsl:variable name="target-field" select="."/>
  
    <!-- check if a field name exists in field names --> 
    <xsl:variable name="check-require">
      <xsl:for-each select="$field-path">
        <xsl:if test="@name = $target-field">
           <xsl:choose>
             <xsl:when test="@require = 'ALTMAN' or @require = 'ALTOPT'">
                <xsl:text>1</xsl:text>
             </xsl:when>
             <xsl:otherwise>
                <xsl:text>0</xsl:text>
             </xsl:otherwise>
           </xsl:choose>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="field-req">
      <xsl:for-each select="$field-path">
        <xsl:if test="@name = $target-field">
           <xsl:value-of select="@require"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:if test="$field-req != 'ALTMAN' and $field-req != 'ALTOPT'">
      <xsl:call-template name="print-error">
        <xsl:with-param name="node"          select="$current-node"/>
        <xsl:with-param name="error-type"    select="'Error'"/>
        <xsl:with-param name="field-info"    select="'field name'"/>
        <xsl:with-param name="field-name"    select="$target-field"/>
        <xsl:with-param name="errormessage" select="concat('The field &quot;',$target-field,'&quot; is referenced')"/>
        <xsl:with-param name="errormessage2" select="concat('    in group &quot;',$group-name,'&quot; by entry &quot;',$entry-name,'&quot;.')"/>
        <xsl:with-param name="errormessage3" select="concat('The &quot;require&quot; attribute of &quot;',$target-field,'&quot; must be defined as &quot;ALTMAN&quot; or &quot;ALTOPT&quot;,')"/>
        <xsl:with-param name="errormessage4" select="concat('but the value &quot;',$field-req,'&quot; was found.')"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:for-each>

  <!-- cut off one field name from field-->
<!--
  <xsl:variable name="one-field">
    <xsl:choose> 
      <xsl:when test="starts-with($field-no-space, ',') = true">
        <xsl:value-of select="substring-after($field-no-space, ',')"/>
      </xsl:when>
      <xsl:otherwise> 
        <xsl:choose>
          <xsl:when test="contains($field-no-space, ',') = true">
            <xsl:value-of select="substring-before($field-no-space, ',')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$field-no-space"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
<xsl:value-of select="concat('one-field has ,=',contains($field-no-space, ','),$cr)"/>
<xsl:value-of select="concat('one-field substring =',substring-before($field-no-space, ','),$cr)"/>
<xsl:value-of select="concat('one-field=',$one-field,$cr)"/>
-->
  <!-- check if a field name exists in field names --> 
<!--
  <xsl:if test="string-length($field) &gt; 0">
    <xsl:variable name="check-require">
      <xsl:for-each select="$field-path">
        <xsl:if test="@name = $one-field">
           <xsl:choose>
             <xsl:when test="@require = 'ALTMAN' or @require = 'ALTOPT'">
                <xsl:text>1</xsl:text>
             </xsl:when>
             <xsl:otherwise>
                <xsl:text>0</xsl:text>
             </xsl:otherwise>
           </xsl:choose>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:if test="$check-require != '1'">
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type"    select="'Error'"/>
        <xsl:with-param name="field-info"    select="'field name'"/>
        <xsl:with-param name="field-name"    select="$one-field"/>
        <xsl:with-param name="errormessage"  select="concat('require type have to be declared as &quot;ALTMAN&quot; or &quot;ALTOPT&quot;', ' ')"/>
        <xsl:with-param name="errormessage2" select="concat('in fields/field/@require.', ' ')"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:if>
-->
  <!-- recursive itself until field is empty-->
<!--
  <xsl:if test="string-length($field) &gt; 0"> 
    <xsl:variable name="remain-field">
      <xsl:value-of select="substring-after($field, ',')"/>
    </xsl:variable>
    <xsl:call-template name="one-field-name">
      <xsl:with-param name="field"      select="$remain-field"/>
      <xsl:with-param name="field-path" select="$field-path"/>
    </xsl:call-template>
  </xsl:if>
-->
</xsl:template>



<!--
 This template checks group/entries/entry @field if TGF Move includs subset of Group Move
 param
 -->
<xsl:template name="verify-group-entry-field-subset">
  <xsl:param name="groups"/>

  <xsl:for-each select="$groups">
     <xsl:variable name="entries-i" select="entries/entry"/>
     <xsl:variable name="entries-j" select="entries/entry"/>
     
     <xsl:for-each select="$entries-i">
        <xsl:variable name="entry-i" select="."/>
        <xsl:for-each select="$entries-j">
           <xsl:variable name="entry-j" select="."/> 
           <xsl:if test="$entry-i/@label != $entry-j/@label">      
              <xsl:call-template name="verify-group-entry-field-duplicates">
                <xsl:with-param name="entry-i" select="$entry-i"/>
                <xsl:with-param name="entry-j" select="$entry-j"/>
              </xsl:call-template>
           </xsl:if>
        </xsl:for-each>
     </xsl:for-each>
  </xsl:for-each>
</xsl:template>


<!--
 This template checks group/entries/entry @label spell check
 -->
<xsl:template name="verify-group-entry-label-spellcheck">
  <xsl:param name="groups"/>
  <xsl:for-each select="$groups">
    <xsl:variable name="entry-count">
      <xsl:for-each select="entries/entry">      
        <xsl:text>1</xsl:text>      
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="label-count">
      <xsl:for-each select="entries/entry/@label">      
        <xsl:text>1</xsl:text>      
      </xsl:for-each>
    </xsl:variable>
    <xsl:if test="string-length($entry-count) != string-length($label-count)">
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type"    select="'Error'"/>
        <xsl:with-param name="field-info"    select="'label spell'"/>
        <xsl:with-param name="field-name"    select="'groups'"/>
        <xsl:with-param name="errormessage"  select="('@label spelling is not correct')"/>
      </xsl:call-template>
    </xsl:if>    
  </xsl:for-each>
</xsl:template>



<xsl:template name="verify-group-entry-field-duplicates">
  <xsl:param name="entry-i"/>
  <xsl:param name="entry-j"/>
  <xsl:variable name="fields-i"
       select="translate($entry-i/@field, ' ', '')"/>
  <xsl:variable name="fields-j"
       select="translate($entry-j/@field, ' ', '')"/>
  <xsl:variable name="result">
     <xsl:call-template name="list-to-bits">
       <xsl:with-param name="list" select="$fields-j"/>
       <xsl:with-param name="words" select="$fields-i"/>
     </xsl:call-template>
  </xsl:variable>  
  <xsl:if test="contains($result,'0') = false"> 
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type" select="'Error'"/>
        <xsl:with-param name="field-info" select="'GROUP'"/>
        <xsl:with-param name="field-name" select="$entry-i/@label"/>
        <xsl:with-param name="errormessage" 
          select="concat('Group entry &quot;',$entry-i/@label,'&quot; has a field list that')"/>
        <xsl:with-param name="errormessage2" 
          select="concat('is a subset of &quot;', $entry-j/@label,'&quot;.')"/>
        <xsl:with-param name="errormessage3" 
          select="'This is not allowed.'"/>
      </xsl:call-template>      
  </xsl:if>
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






<xsl:template name="verify-queue-entry">
  <xsl:param name="order-utility"/>
  <xsl:for-each select="$order-utility">
    <xsl:call-template name="one-field-name">
      <xsl:with-param name="field" select="@entry"/>
      <xsl:with-param name="parent" select="'queue'"/>
      <xsl:with-param name="field-path" select="../fields/field"/>
    </xsl:call-template>
  </xsl:for-each>
</xsl:template>



<xsl:template name="verify-quick-entry">
  <xsl:param name="order-utility"/>
<xsl:value-of select="$order-utility"/>
  <xsl:for-each select="$order-utility">
    <xsl:call-template name="one-field-name">
      <xsl:with-param name="field" select="@entry"/>
      <xsl:with-param name="parent" select="'quick'"/>
      <xsl:with-param name="field-path" select="../fields/field"/>
    </xsl:call-template>
  </xsl:for-each>
</xsl:template>



<xsl:template name="verify-msend-entry">
  <xsl:param name="order-utility"/>
  <xsl:for-each select="$order-utility">
    <xsl:call-template name="one-field-name">
      <xsl:with-param name="field" select="@entry"/>
      <xsl:with-param name="parent" select="'msend'"/>
      <xsl:with-param name="field-path" select="../fields/field"/>
    </xsl:call-template>
  </xsl:for-each>
</xsl:template>



<!-- param "var"     a field name in constraint node 
     This template checks if a field name contains attribute, and it is in
     parentheses. 
     if so, it extracts only field name. 
-->
<xsl:template name="extract-field-name">
  <xsl:param name="var"/>
    <xsl:variable name="const-field">
      <xsl:choose>
        <!-- if parenthesis is included -->
        <xsl:when test="contains($var[1], '(')">
          <!-- extract field name from field text of constraint -->
          <xsl:variable name="extract-name">
            <xsl:value-of 
                 select="substring-before(substring-after($var[1], '('), ')')"/>
          </xsl:variable>
          <xsl:value-of select="$extract-name"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$var"/> 
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="$const-field"/>
</xsl:template>



<!-- param "const"  path 
     param "if-var" a text either IF_ATTRIBUTE, IF_VALUE or IF_FIELD
     This template checks first field name of constraint such as
     FILL_ATLEAST_ONE, FILL_ONLY_ONE, EQUAL, NOT_EQUAL, GREATER_THAN,
     LESS_THAN
-->
<xsl:template name="constraints-common">
  <xsl:param name="const"/>
  <xsl:param name="if-var"/>
  <xsl:for-each select="$const">
    <!-- choose field name -->
    <xsl:variable name="const-text-field">
      <xsl:value-of select="."/>
    </xsl:variable>
    <xsl:variable name="const-field">
      <xsl:call-template name="extract-field-name">
        <xsl:with-param name="var" select="$const-text-field"/>
      </xsl:call-template> 
    </xsl:variable>
    <xsl:variable name="field-exist">
     <xsl:for-each select="../../../../fields/field">
       <xsl:if test="@name = $const-field">exist</xsl:if>
     </xsl:for-each>
    </xsl:variable>
    <xsl:if test="$field-exist != 'exist'">
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type" select="'Error'"/>
        <xsl:with-param name="field-info" select="'constraint'"/>
        <xsl:with-param name="field-name" select="$const-field"/>
        <xsl:with-param name="errormessage" select="'does not exist.'"/>
      </xsl:call-template>  
    </xsl:if>
    <xsl:call-template name="constraint-if">
      <xsl:with-param name="if-var" select="$if-var"/>
    </xsl:call-template> 
  </xsl:for-each>
</xsl:template>



<!-- param "const"   path to the IF_ATTRIBUTE or IF_VALUE/field 
     param "if-var"  either IF_ATTRIBUTE or IF_VALUE
     This template processes the first field name
 -->
<xsl:template name="constraints-if-attribute-value">
  <xsl:param name="const"/>
  <xsl:param name="if-var"/>
  <xsl:variable name="if-attribute-var">
    <xsl:value-of select="$const"/>
  </xsl:variable>
  <xsl:variable name="field-name">
    <xsl:call-template name="extract-field-name">
      <xsl:with-param name="var" select="$if-attribute-var"/>
    </xsl:call-template> 
  </xsl:variable>
  <xsl:variable name="field-exist">
    <xsl:for-each select="../../fields/field">
      <xsl:if test="@name = $field-name">exist</xsl:if>
    </xsl:for-each>
  </xsl:variable>
  <xsl:if test="$field-exist != 'exist'">
    <xsl:call-template name="print-error">
      <xsl:with-param name="error-type" select="'Error'"/>
      <xsl:with-param name="field-info" select="'constraint-then'"/>
      <xsl:with-param name="field-name" select="$if-attribute-var"/>
      <xsl:with-param name="errormessage" select="'does not exist.'"/>
    </xsl:call-template>  
  </xsl:if> 
</xsl:template>



<!-- param "if-var"  either IF_FIELD, IF_VALUE or IF_ATTRIBUTE
     This template processes THEN_***** field
 -->
<xsl:template name="constraint-if">   
  <xsl:param name="if-var"/>
  <xsl:choose>
    <xsl:when test="string-length($if-var) &gt; 0">
      <xsl:choose>
        <xsl:when test="count(../THEN_FIELD) != 0">
          <xsl:call-template name="constraint-if-common">
            <xsl:with-param name="then-var" select="../THEN_FIELD/field"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="count(../THEN_NOT_FIELD) != 0">
          <xsl:call-template name="constraint-if-common">
            <xsl:with-param name="then-var" select="../THEN_NOT_FIELD/field"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="count(../THEN_VALUE) != 0">
          <xsl:call-template name="attribute-value-common">
            <xsl:with-param name="then-var" select="../THEN_VALUE/field[1]"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="count(../THEN_ATTRIBUTE) != 0">
          <xsl:call-template name="attribute-value-common">
            <xsl:with-param name="then-var" select="../THEN_ATTRIBUTE/field"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="count(../THEN_ARRAY) != 0">
          <xsl:call-template name="constraint-if-common">
            <xsl:with-param name="then-var" select="../THEN_ARRAY/field"/>
          </xsl:call-template>
        </xsl:when>
      </xsl:choose>  
    </xsl:when>
  </xsl:choose>
</xsl:template>



<!-- param "then-var" path to the node <THEN_VALUE><field> or
                      <THEN_ATTRIBUTE><field> 
     This template processes only one field name
-->
<xsl:template name="attribute-value-common">
  <xsl:param name="then-var"/>
  <xsl:variable name="then-field-name">
    <xsl:call-template name="extract-field-name">
      <xsl:with-param name="var" select="$then-var"/>
    </xsl:call-template> 
  </xsl:variable>
  <xsl:variable name="field-exist">
    <xsl:for-each select="../../../../fields/field">
      <xsl:if test="@name = $then-field-name">exist</xsl:if>
    </xsl:for-each>
  </xsl:variable>
  <!--xsl:value-of select="$field-exist"/-->
  <xsl:if test="$field-exist != 'exist'">
    <xsl:call-template name="print-error">
      <xsl:with-param name="error-type" select="'Error'"/>
      <xsl:with-param name="field-info" select="'constraint-then'"/>
      <xsl:with-param name="field-name" select="$then-var"/>
      <xsl:with-param name="errormessage" select="'does not exist.'"/>
    </xsl:call-template>  
  </xsl:if> 
</xsl:template>



<!-- param "then-var"   path to the node <THEN_****><field>.
     This template is used only node <IF_FIELD> or <IF_VALUE> exists.
     then, it checks node <THEN_****><field>. 
-->
<xsl:template name="constraint-if-common">
  <xsl:param name="then-var"/>
  <xsl:for-each select="$then-var">
    <xsl:variable name="then-field">
      <xsl:value-of select="."/>
    </xsl:variable> 
    <xsl:variable name="then-field-name">
      <xsl:call-template name="extract-field-name">
        <xsl:with-param name="var" select="$then-field"/>
      </xsl:call-template> 
    </xsl:variable>
    <xsl:variable name="field-exist">
      <xsl:for-each select="../../../../../fields/field">
        <xsl:if test="@name = $then-field-name">exist</xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <!--xsl:value-of select="$field-exist"/-->
    <xsl:if test="$field-exist != 'exist'">
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type" select="'Error'"/>
        <xsl:with-param name="field-info" select="'constraint-then'"/>
        <xsl:with-param name="field-name" select="$then-field"/>
        <xsl:with-param name="errormessage" select="'does not exist.'"/>
      </xsl:call-template>  
    </xsl:if> 
  </xsl:for-each>
</xsl:template>



<xsl:template name="verify-constraints-name">
  <xsl:param name="order-utility"/>
  <xsl:for-each select="$order-utility">
    <xsl:choose>
      <xsl:when test="count(FILL_ATLEAST_ONE) != 0">
        <xsl:call-template name="constraints-common">
          <xsl:with-param name="const" select="FILL_ATLEAST_ONE/field"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="count(FILL_ONLY_ONE) != 0">
        <xsl:call-template name="constraints-common">
          <xsl:with-param name="const" select="FILL_ONLY_ONE/field"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="count(EQUAL) != 0">
        <xsl:call-template name="constraints-common">
          <xsl:with-param name="const" select="EQUAL/field"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="count(NOT_EQUAL) != 0">
        <xsl:call-template name="constraints-common">
          <xsl:with-param name="const" select="NOT_EQUAL/field"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="count(GREATER_THAN) != 0">
        <xsl:call-template name="constraints-common">
          <xsl:with-param name="const" select="GREATER_THAN/field"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="count(LESS_THAN) != 0">
        <xsl:call-template name="constraints-common">
          <xsl:with-param name="const" select="LESS_THAN/field"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="count(IF_FIELD) != 0">
        <xsl:call-template name="constraints-common">
          <xsl:with-param name="const" select="IF_FIELD/field"/>
          <xsl:with-param name="if-var" select="'IF_FIELD'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="count(IF_VALUE) != 0">
        <xsl:call-template name="constraints-if-attribute-value">
          <xsl:with-param name="const" select="IF_VALUE/field[1]"/>
          <xsl:with-param name="if-var" select="'IF_VALUE'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="count(IF_ATTRIBUTE) != 0">
        <xsl:call-template name="constraints-if-attribute-value">
          <xsl:with-param name="const" select="IF_ATTRIBUTE/field[1]"/>
          <xsl:with-param name="if-var" select="'IF_ATTRIBUTE'"/>
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:for-each>
</xsl:template>



<xsl:template name="verify-constraints-message">
  <xsl:param name="order-utility"/>
  <xsl:for-each select="$order-utility">   
    <xsl:if test="count(message) = 0">
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type" select="'Error'"/>
        <xsl:with-param name="field-info" select="''"/>
        <xsl:with-param name="field-name" select="'constraint'"/>
        <xsl:with-param name="errormessage" 
         select="concat('The #', position(), ' &lt;constraint&gt; node contains no message.')"/>
      </xsl:call-template>  
    </xsl:if>
    <xsl:if test="count(*/message) != 0">
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type" select="'Error'"/>
        <xsl:with-param name="field-info" select="''"/>
        <xsl:with-param name="field-name" select="'constraints'"/>
        <xsl:with-param name="errormessage" 
         select="'The &lt;message&gt; node found at inncorrect position.'"/>
        <xsl:with-param name="errormessage2" 
         select="'It should be located as a child of &lt;constraint&gt;.'"/>
      </xsl:call-template>  
    </xsl:if>   
  </xsl:for-each>
</xsl:template>



<xsl:template name="print-order-name">
  <xsl:param name="order-node" select="."/>
  <xsl:param name="message" select="'The error was not specified.'"/>
  <xsl:variable name="order-type">
    <xsl:choose>
      <xsl:when test="name($order-node) = 'utility'">
        <xsl:text>Utility</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>Order</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:value-of select="concat($order-type,' ',$order-node/@name,' (',$order-node/@short-name,'):')"/>
</xsl:template> 



<xsl:template name="print-error">
  <xsl:param name="node" select="."/>
  <xsl:param name="error-type"/>
  <xsl:param name="field-info"/>
  <xsl:param name="field-name"/>
  <xsl:param name="errormessage"/>
  <xsl:param name="errormessage2" select="' '"/>
  <xsl:param name="errormessage3" select="' '"/>
  <xsl:param name="errormessage4" select="' '"/>
  <xsl:param name="errormessage5" select="' '"/>
  <xsl:variable name="stack">
     <xsl:call-template name="print-tag-stack">
       <xsl:with-param name="node" select="$node"/>
     </xsl:call-template>
  </xsl:variable>
  <xsl:choose>
    <xsl:when test="$error-type = 'Warning'">
      <xsl:value-of select="concat('   ',$error-type, ': ' ,$field-info, ' [', $field-name, '] ', $stack,$cr)"/>
      <xsl:value-of select="concat('            ', $errormessage,$cr)"/>
       <xsl:if test="$errormessage2 != ' '">
           <xsl:value-of select="concat('            ', $errormessage2,$cr)"/>
       </xsl:if>
       <xsl:if test="$errormessage3 != ' '">
           <xsl:value-of select="concat('            ', $errormessage3,$cr)"/>
       </xsl:if>
       <xsl:if test="$errormessage4 != ' '">
           <xsl:value-of select="concat('            ', $errormessage4,$cr)"/>
       </xsl:if>
       <xsl:if test="$errormessage5 != ' '">
           <xsl:value-of select="concat('            ', $errormessage5,$cr)"/>
       </xsl:if>
    </xsl:when>
    <xsl:when test="$error-type = 'Error'">
      <xsl:value-of select="concat('   ',$error-type, ': ' ,$field-info, ' [', $field-name[1], '] ', $stack,$cr)"/>
      <xsl:value-of select="concat('          ', $errormessage,$cr)"/>
       <xsl:if test="$errormessage2 != ' '">
           <xsl:value-of select="concat('          ', $errormessage2,$cr)"/>
       </xsl:if>
       <xsl:if test="$errormessage3 != ' '">
           <xsl:value-of select="concat('          ', $errormessage3,$cr)"/>
       </xsl:if>
       <xsl:if test="$errormessage4 != ' '">
           <xsl:value-of select="concat('          ', $errormessage4,$cr)"/>
       </xsl:if>
       <xsl:if test="$errormessage5 != ' '">
           <xsl:value-of select="concat('          ', $errormessage5,$cr)"/>
       </xsl:if>
    </xsl:when>
  </xsl:choose>
</xsl:template>


<xsl:template name="print-tag-stack">
  <xsl:param name="node" select="."/>
  <xsl:param name="out-text" select="' )'"/>
  <xsl:choose>
    <xsl:when test="name($node) != 'order' and name($node) != 'utility'">
      <xsl:call-template name="print-tag-stack">
        <xsl:with-param name="node" select="$node/.."/>
        <xsl:with-param name="out-text" select="concat('/',name($node),$out-text)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="concat('( /',name($node),$out-text)"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- Templates that verify variables used in a given scope.
     Date:       10 May 2004
     Programmer: Humberto Yeverino
  -->
<xsl:template name="verify-field-variables">
  <xsl:param name="field-nodes"/>
  <xsl:variable name="global-vars"> SYSTEM </xsl:variable>
  <xsl:for-each select="$field-nodes">
    <!-- If this field has a fill, verify variable usage. -->
    <xsl:if test="count(fill) = 1">
      <xsl:call-template name="verify-variable-scope">
        <xsl:with-param name="field-name" select="@name"/>
        <xsl:with-param name="src-node" select="fill/with"/>
        <xsl:with-param name="vars" 
         select="concat($global-vars,@name,' ')"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:for-each>
</xsl:template>



<!-- Templates that verify variables used in a given scope for all field
     restrictions.
     Date:       11 May 2004
     Programmer: Humberto Yeverino
  -->
<xsl:template name="verify-restrict-variables">
  <xsl:param name="restrict-nodes"/>
  <xsl:variable name="global-vars"> SYSTEM </xsl:variable>
  <xsl:for-each select="$restrict-nodes">
    <xsl:call-template name="verify-variable-scope">
      <xsl:with-param name="field-name" select="@fields"/>
      <xsl:with-param name="src-node" select="such-that"/>
      <xsl:with-param name="vars" 
       select="concat($global-vars,translate(@fields,',',' '),' ')"/>
    </xsl:call-template>
  </xsl:for-each>
</xsl:template>


<!-- A recursive template that verifies the existance of variables given a
     source node.
     Date:       10 May 2004
     Programmer: Humberto Yeverino
  -->
<xsl:template name="verify-variable-scope">
  <xsl:param name="src-node" />
  <xsl:param name="vars"/>
  <xsl:param name="field-name"/>
  <xsl:for-each select="$src-node/*">
    <xsl:if test="position() mod 2 != 0">
      <xsl:choose>
        <xsl:when test="contains($binary-conditions,concat(' ',name(),' '))">
          <!-- Verify value a -->
          <xsl:call-template name="verify-variable-scope-expr">
            <xsl:with-param name="vars" select="$vars"/>
            <xsl:with-param name="expr" select="@a"/>
            <xsl:with-param name="field-name" select="$field-name"/>
          </xsl:call-template>
          <!-- Verify value b -->
          <xsl:call-template name="verify-variable-scope-expr">
            <xsl:with-param name="vars" select="$vars"/>
            <xsl:with-param name="expr" select="@b"/>
            <xsl:with-param name="field-name" select="$field-name"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="contains($unary-conditions,concat(' ',name(),' '))">
          <!-- Verify value a -->
          <xsl:call-template name="verify-variable-scope-expr">
            <xsl:with-param name="vars" select="$vars"/>
            <xsl:with-param name="expr" select="@a"/>
            <xsl:with-param name="field-name" select="$field-name"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="name() = 'exists'">
          <!-- Verfify code scoped by the exists condition -->
          <xsl:call-template name="verify-variable-scope">
            <xsl:with-param name="vars" select="concat($vars,@named,' ')"/>
            <xsl:with-param name="src-node" select="."/>
            <xsl:with-param name="field-name" select="$field-name"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="name() = 'all'">
          <!-- Verfify code scoped by the exists condition -->
          <xsl:call-template name="verify-variable-scope">
            <xsl:with-param name="vars" select="$vars"/>
            <xsl:with-param name="src-node" select="."/>
            <xsl:with-param name="field-name" select="$field-name"/>
          </xsl:call-template>
        </xsl:when>

        <!-- Should already be checked if the condition is invalid. -->

      </xsl:choose>
    </xsl:if>
  </xsl:for-each>
</xsl:template>



<!-- A recursive template that verifies the existance of variables given an
     expression.
     Date:       10 May 2004
     Programmer: Humberto Yeverino
  -->
<xsl:template name="verify-variable-scope-expr">
  <xsl:param name="expr"/>
  <xsl:param name="vars"/>
  <xsl:param name="field-name"/>
  <xsl:if test="contains($expr,'.')">
    <!-- Check the variable. -->
    <xsl:variable name="var-name" select="substring-before($expr,'.')"/>
    <xsl:if test="not(contains($vars,concat(' ',$var-name,' ')))">
      <xsl:call-template name="print-error">
        <xsl:with-param name="error-type" select="'Error'"/>
        <xsl:with-param name="field-info" select="$field-name"/>
        <xsl:with-param name="field-name" select="'scope'"/>
        <xsl:with-param name="errormessage" 
         select="concat('The variable ',$var-name,' does not exist in ',$expr,'.')"/>
      </xsl:call-template>  
      <xsl:value-of 
       select="concat('   Available variables: ',normalize-space($vars),$cr,$cr)"/>
    </xsl:if>
  </xsl:if>
</xsl:template>




<!-- This template verify 'FLAG' nodes are serial in the field
     Added date:       18 March 2005
  -->
<xsl:template name="verify-field-flag-nodes">
  <xsl:param name="field-nodes"/>

  <xsl:for-each select="$field-nodes">
    <xsl:if test="class/@is = 'FLAG'">
      <xsl:variable name="label" select="@label"/>

      <xsl:variable name="flag_position">
        <xsl:for-each select="../../fields/field">
          <xsl:if test="class/@is ='FLAG' and @label = $label">
             <xsl:value-of select="position()"/>
             <xsl:text>,</xsl:text>
          </xsl:if>
        </xsl:for-each>
      </xsl:variable>

      <xsl:variable name="count_flag">
        <xsl:call-template name="count-flag-position">
          <xsl:with-param name="flag_pos" select="$flag_position"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:if test="string-length($flag_position) &gt; 0">
        <xsl:variable name="first_flag" select="substring-before($flag_position, ',')"/>
        <xsl:variable name="last_flag">
          <xsl:call-template name="get-last-flag-pos">
            <xsl:with-param name="remaining" select="substring($flag_position, 1, string-length($flag_position) - 1)"/>
          </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="flag_error">
          <xsl:if test="$first_flag + string-length($count_flag) - 1 != $last_flag">
            <xsl:text> error </xsl:text>  
          </xsl:if>
        </xsl:variable>
        <xsl:if test="contains($flag_error, 'error') = true">
          <xsl:value-of select="'FLAG field error: '"/>
          <xsl:value-of select="concat('field ', @name, ' ')"/>
          <xsl:text> is not together with other FLAG fields.</xsl:text>
          <xsl:value-of select="$cr"/>
        </xsl:if> 

      </xsl:if> 

    </xsl:if>
  </xsl:for-each>
</xsl:template>



<!-- this template finds the last FLAG position in order to omit 
     the dupricated other FLAGs.
-->
<xsl:template name="get-last-flag-pos">
  <xsl:param name="remaining"/>
  <xsl:variable name="flag_group_writable">
    <xsl:if test="string-length($remaining) != 0">
       <xsl:choose>
         <xsl:when test="contains($remaining, ',')">
           <xsl:call-template name="get-last-flag-pos">
             <xsl:with-param name="remaining"
                       select="substring-after($remaining, ',')"/>
           </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
           <xsl:value-of select="$remaining"/>
         </xsl:otherwise> 
       </xsl:choose>
    </xsl:if>
  </xsl:variable>
  <xsl:value-of select="$flag_group_writable"/>
</xsl:template>





<xsl:template name="count-flag-position">
  <xsl:param name="flag_pos"/>
  <xsl:param name="pos"/>
  <xsl:if test="string-length($flag_pos) &gt; 0">
    <xsl:text>1</xsl:text>
    <xsl:variable name="flag_vars">
      <xsl:value-of select="substring-after($flag_pos, ',')"/>
    </xsl:variable>
    <xsl:if test="string-length($flag_vars) &gt; 0">
      <xsl:call-template name="count-flag-position">
        <xsl:with-param name="flag_pos" select="$flag_vars"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:if>
</xsl:template>




<!-- This template verifies label length: it must be less than 30.
     Added date:       22 March 2005
-->
<xsl:template name="verify-field-label-length">
  <xsl:param name="field-nodes" select="fields/field"/>
  <xsl:for-each select="$field-nodes">
    <xsl:if test="string-length(@label) &gt; 31">
       <xsl:call-template name="print-error">
         <xsl:with-param name="error-type" select="'Error'"/>
         <xsl:with-param name="field-info" select="@label"/>
         <xsl:with-param name="field-name" select="@label"/>
         <xsl:with-param name="errormessage" 
                select="'length is over 30 characters.'"/>
       </xsl:call-template>  
    </xsl:if>
  </xsl:for-each>
</xsl:template>



<!-- This template verifies illegal characters such as "&#@/\$ in help/line node.
     Added date        17 November 2005
     This template verifies that help/line is not include double-quotes.
     Modified data     22 November 2005
-->

<xsl:template name="verify-help-illegal-characters">
  <xsl:param name="field-nodes" select="."/>
  <xsl:call-template name="verify-help-line-illegal-chars">
    <xsl:with-param name="nodes" select="."/>
  </xsl:call-template>
  <xsl:call-template name="verify-help-line-illegal-chars">
    <xsl:with-param name="nodes" select="fields/field"/>
  </xsl:call-template>
  <xsl:call-template name="verify-help-line-illegal-chars">
    <xsl:with-param name="nodes" select="groups/group"/>
  </xsl:call-template>
</xsl:template>


<!-- This template verifies illegal characters such as "&#@/\$ in help/line node.
     Added date        17 November 2005
     This template verifies that help/line is not include double-quotes(").
     Modified data     22 November 2005
-->
<xsl:template name="verify-help-line-illegal-chars">
  <xsl:param name="nodes"/>
  <xsl:param name="pos" />
  <xsl:variable name="double-quote">&quot;</xsl:variable>
  <!--xsl:variable name="amp">&amp;</xsl:variable>
  <xsl:variable name="hash">#</xsl:variable>
  <xsl:variable name="at">@</xsl:variable>
  <xsl:variable name="doller">$</xsl:variable>
  <xsl:variable name="back-slash">\</xsl:variable>
  <xsl:variable name="forward-slash">/</xsl:variable-->
  
  <xsl:for-each select="$nodes">
    <xsl:for-each select="help"> 
      <xsl:for-each select="line"> 
         <xsl:variable name="one-line" select="."/>         
         <xsl:if test="contains($one-line, $double-quote)">
           <xsl:call-template name="print-error">
             <xsl:with-param name="error-type" select="'Error'"/>
             <xsl:with-param name="field-info" select="../@label"/>
             <xsl:with-param name="field-name" select="."/>
             <xsl:with-param name="errormessage" 
                    select="'Double-quotes (&quot;) are found.'"/>
           </xsl:call-template>  
          </xsl:if>
       </xsl:for-each>
    </xsl:for-each>
  </xsl:for-each>
</xsl:template>



<!-- This template verifies that order name matches the passed in order name
     Added date:       31 January 2008
-->
<xsl:template name="verify-order-name">

  <xsl:if test="not(@short-name = $order-name)">
     <xsl:call-template name="print-error">
       <xsl:with-param name="error-type" select="'Error'"/>
       <xsl:with-param name="field-info" select="@short-name"/>
       <xsl:with-param name="field-name" select="@short-name"/>
       <xsl:with-param name="errormessage" 
              select="concat('order short name (', @short-name, ') does not match file name (',$order-name,').')"/>
     </xsl:call-template>  
  </xsl:if>

</xsl:template> <!-- verify-order-name -->



<!-- This template verifies that order name does not include extra space.
     Added date:       07 January 2008
-->
<xsl:template name="verify-order-name-space">

  <xsl:if test="contains(@name, ' ')">
     <xsl:call-template name="print-error">
       <xsl:with-param name="error-type" select="'Error'"/>
       <xsl:with-param name="field-info" select="@name"/>
       <xsl:with-param name="field-name" select="@name"/>
       <xsl:with-param name="errormessage" 
              select="'order name includes extra space.'"/>
     </xsl:call-template>  
  </xsl:if>
  <xsl:if test="contains(@short-name, ' ')">
     <xsl:call-template name="print-error">
       <xsl:with-param name="error-type" select="'Error'"/>
       <xsl:with-param name="field-info" select="@short-name"/>
       <xsl:with-param name="field-name" select="@short-name"/>
       <xsl:with-param name="errormessage" 
              select="'order short-name includes extra space.'"/>
     </xsl:call-template>  
  </xsl:if>

</xsl:template> <!-- verify-order-name-space -->



<!-- This template verifies order name length: The length is limited to 26
     characters since the OEC adds "OEC_" to the order name to create an
     oracle table (limit 30 characters).
     Added date:       09 January 2007
-->
<xsl:template name="verify-order-name-length">

  <xsl:if test="string-length(@name) &gt; 26">
     <xsl:call-template name="print-error">
       <xsl:with-param name="error-type" select="'Error'"/>
       <xsl:with-param name="field-info" select="@name"/>
       <xsl:with-param name="field-name" select="@name"/>
       <xsl:with-param name="errormessage" 
              select="'order name is greater than 26 characters.'"/>
     </xsl:call-template>  
  </xsl:if>

</xsl:template> <!-- verify-order-name-length -->



<!-- This template verifies the static_v class field name exists in either
     static_voc.xml or dynamic_voc.xml files
     Added date:       02 April 2007
-->
<xsl:template name="verify-field-name-in-static-dynamic-voc">
 <xsl:param name="field-nodes"/>

 <xsl:for-each select="$field-nodes">
    <xsl:choose>
    <xsl:when test="class/@is = 'STATIC_V'">
      <xsl:variable name="class-name" select="class/@name"/>    
      <xsl:if test="count($static-voc-doc/static.voc/*[name() = $class-name]) = 0">     
        <xsl:call-template name="print-error">
           <xsl:with-param name="error-type" select="'Error'"/>
           <xsl:with-param name="field-info" select="class/@name"/>
           <xsl:with-param name="field-name" select="class/@name"/>
           <xsl:with-param name="errormessage" 
                  select="'The name does not exist in static vocabulary file.'"/>
         </xsl:call-template> 
      </xsl:if>     
    </xsl:when>
    <xsl:when test="class/@is = 'DATA_V'">
      <xsl:variable name="class-name" select="class/@name"/>    
      <xsl:if test="count($dynamic-voc-doc/dynamic.voc/*[name() = $class-name]) = 0">     
        <xsl:call-template name="print-error">
           <xsl:with-param name="error-type" select="'Error'"/>
           <xsl:with-param name="field-info" select="class/@name"/>
           <xsl:with-param name="field-name" select="class/@name"/>
           <xsl:with-param name="errormessage" 
                  select="'The name does not exist in dynamic vocabulary file.'"/>
         </xsl:call-template> 
      </xsl:if>     
    </xsl:when>
    </xsl:choose>
  </xsl:for-each>
</xsl:template>



<!-- This template verifies the pow or pow2 attribute's name which must 
     exists in position text
     Added date:       01 May 2007
-->
<xsl:template name="verify-pow-exists-position-text">
 <xsl:param name="field-nodes"/>
 <xsl:for-each select="$field-nodes">
    <xsl:if test="contains($pow-list, concat(' ', @pow, ' ')) = false">
      <xsl:call-template name="print-error">
         <xsl:with-param name="error-type" select="'Error'"/>
         <xsl:with-param name="field-info" select="@pow"/>
         <xsl:with-param name="field-name" select="@name"/>
         <xsl:with-param name="errormessage" 
                select="concat('&quot;', @pow,'&quot; is not a valid player order word.')"/>
         <xsl:with-param name="errormessage2" 
                select="'Valid player order words are:'"/>
         <xsl:with-param name="errormessage3" 
                select="$pow-list"/>
         <xsl:with-param name="errormessage4" 
                select="'Note: If you have added a new player order word you need to'"/>
         <xsl:with-param name="errormessage5" 
                select="'add it to the pow-list in $JTLSHOME/script/xsl/verify_order.xsl'"/>
       </xsl:call-template> 
    </xsl:if>
    <xsl:if test="contains($pow-list, concat(' ', @pow2, ' ')) = false">
      <xsl:call-template name="print-error">
         <xsl:with-param name="error-type" select="'Error'"/>
         <xsl:with-param name="field-info" select="@pow2"/>
         <xsl:with-param name="field-name" select="@name"/>
         <xsl:with-param name="errormessage" 
                select="concat('&quot;', @pow2,'&quot; is not a valid player order word.')"/>
         <xsl:with-param name="errormessage2" 
                select="'Valid player order words are:'"/>
         <xsl:with-param name="errormessage3" 
                select="$pow-list"/>
         <xsl:with-param name="errormessage4" 
                select="'Note: If you have added a new player order word you need to'"/>
         <xsl:with-param name="errormessage5" 
                select="'add it to the pow-list in $JTLSHOME/script/xsl/verify_order.xsl'"/>
       </xsl:call-template> 
    </xsl:if>
 </xsl:for-each>
</xsl:template>



<!-- This template counts the number of members in the list 
     Added date:  14 August 2007
-->
<xsl:template name="count-members">
  <xsl:param name="list"/>
  <xsl:variable name="list-for-count" select="concat($list, ',')"/>
  <xsl:variable name="alphabets" select="'abcdefghijklmnopqrstuvwxyz_ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  <xsl:variable name="delimiter" select="translate(translate($list-for-count, $alphabets, ''), ' ', '')"/>
  <!--xsl:variable name="delimiter" select="translate($pre, ' ','')"/-->
  <xsl:value-of select="string-length($delimiter)"/>
</xsl:template>



<!-- This template verifies the all check words which is in included file
     check_words_list.xsl
     Added date:  14 August 2007
-->
<xsl:template name="verify-check-words">
   <xsl:param name="field-nodes"/>
   <xsl:for-each select="$field-nodes">
      <xsl:choose>
<!--UT-->
         <xsl:when test="class/@is = 'UT'">
            <!--check unit words-->
            <xsl:variable name="unit-check">
               <xsl:call-template name="list-check">
                 <xsl:with-param name="list" select="$unit-check-words"/>
                 <xsl:with-param name="words" select="class/@unit-checks"/>
               </xsl:call-template> 
            </xsl:variable>          
            <xsl:variable name="unit-check-value" select="translate($unit-check, '1', '')"/>          
            <xsl:if test="string-length($unit-check-value) &gt; 0">
               <xsl:call-template name="print-error">
                 <xsl:with-param name="error-type" select="'Error'"/>
                 <xsl:with-param name="field-info" select="$unit-check-value"/>
                 <xsl:with-param name="field-name" select="@name"/>
                 <xsl:with-param name="errormessage" 
                        select="concat('The word does not exist in the list [', $unit-check-words, ']')"/>
               </xsl:call-template> 
            </xsl:if>
            <!-- check unit type words-->
            <xsl:variable name="unit-type">
               <xsl:call-template name="list-check">
                 <xsl:with-param name="list" select="$unit-type-words"/>
                 <xsl:with-param name="words" select="fill/with/@types"/>
               </xsl:call-template>                
            </xsl:variable> 
            <xsl:variable name="unit-type-value" select="translate($unit-type, '1', '')"/>
            <xsl:if test="string-length($unit-type-value) &gt; 0">
               <xsl:call-template name="print-error">
                 <xsl:with-param name="error-type" select="'Error'"/>
                 <xsl:with-param name="field-info" select="$unit-type-value"/>
                 <xsl:with-param name="field-name" select="@name"/>
                 <xsl:with-param name="errormessage" 
                         select="concat('The type does not exist in the list [', $unit-type-words, ']')"/>
               </xsl:call-template> 
            </xsl:if>      
         </xsl:when>
<!--TG-->
         <xsl:when test="class/@is = 'TG'">            
            <xsl:if test="fill/with/@types = 'target'">
              <xsl:variable name="field-name-category" select="concat(@name, '.category')"/>
              <xsl:variable name="target-category-equal-node" 
                                         select="fill/with/equal[@a = $field-name-category]"/>
              <xsl:variable name="target-category-list">
                <xsl:choose>
                <xsl:when test="count($target-category-equal-node) = 1">
                   <xsl:value-of select="$target-category-equal-node/@b"/>
                </xsl:when>
                <xsl:otherwise>
                   error
                </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>
              <!-- check unit relationship words-->
              <xsl:variable name="target-category">                         
                 <xsl:call-template name="list-check">
                   <xsl:with-param name="list" select="$target-category-words"/>
                   <xsl:with-param name="words" select="$target-category-list"/>
                 </xsl:call-template>            
              </xsl:variable> 
              <xsl:variable name="target-category-value" select="translate($target-category, '1', '')"/>
              <xsl:if test="string-length($target-category-value) &gt; 0">
                 <xsl:call-template name="print-error">
                   <xsl:with-param name="error-type" select="'Error'"/>
                   <xsl:with-param name="field-info" select="$target-category-value"/>
                   <xsl:with-param name="field-name" select="@name"/>
                   <xsl:with-param name="errormessage" 
                          select="concat('The target category does not exist in the list [', $target-category-words, ']')"/>
                 </xsl:call-template> 
              </xsl:if>   
            </xsl:if>
         </xsl:when>
<!--MSN-->
         <xsl:when test="class/@is = 'MSN'">
            <!--check mission-type-words-->
            <xsl:if test="fill/with/@types = 'airmission'">            
               <xsl:variable name="mission-type-name" select="concat(@name, '.mission_type')"/> 
               <xsl:variable name="mission-type-equal-node" 
                             select="fill/with/equal[@a = $mission-type-name]"/>
                 <xsl:variable name="mission-type-list">
                   <xsl:choose>
                   <xsl:when test="count($mission-type-equal-node) = 1">
                      <xsl:value-of select="$mission-type-equal-node/@b"/>
                   </xsl:when>
                   <xsl:otherwise>
                      error
                   </xsl:otherwise>
                   </xsl:choose>
                 </xsl:variable>
              <!-- check unit type words-->
              <xsl:variable name="mission-type">                         
                 <xsl:call-template name="list-check">
                   <xsl:with-param name="list" select="$mission-type-words"/>
                   <xsl:with-param name="words" select="$mission-type-list"/>
                 </xsl:call-template>            
              </xsl:variable> 
              <xsl:variable name="mission-type-value" select="translate($mission-type, '1', '')"/>
              <xsl:if test="string-length($mission-type-value) &gt; 0">
                 <xsl:call-template name="print-error">
                   <xsl:with-param name="error-type" select="'Error'"/>
                   <xsl:with-param name="field-info" select="$mission-type-value"/>
                   <xsl:with-param name="field-name" select="@name"/>
                   <xsl:with-param name="errormessage" 
                          select="concat('The mission type does not exist in the list [', $mission-type-words, ']')"/>
                 </xsl:call-template> 
              </xsl:if>  
            </xsl:if>

            <xsl:variable name="mission-fill">                         
              <xsl:call-template name="list-check">
                <xsl:with-param name="list" select="$mission-fill-with"/>
                <xsl:with-param name="words" select="fill/with/@types"/>
              </xsl:call-template>            
            </xsl:variable> 
            <xsl:variable name="mission-fill-value" select="translate($mission-fill, '1', '')"/>
            <xsl:if test="string-length($mission-fill-value) &gt; 0">
                 <xsl:call-template name="print-error">
                   <xsl:with-param name="error-type" select="'Error'"/>
                   <xsl:with-param name="field-info" select="$mission-fill-value"/>
                   <xsl:with-param name="field-name" select="@name"/>
                   <xsl:with-param name="errormessage" 
                          select="concat('The mission fill with does not exist in the list [', $mission-fill-with, ']')"/>
                 </xsl:call-template> 
             </xsl:if>  
         </xsl:when>
         <xsl:otherwise>
         </xsl:otherwise>
      </xsl:choose>

<!--ALL-->
      <!--verify the side relationship-->
      <xsl:variable name="rel-node"
           select="concat(@name, '.', 'side_id', '.', 'relationship')"/>

      <xsl:if test="fill/with/all/equal[@a = $rel-node] or
                    fill/with/equal[@a = $rel-node]">
         <xsl:variable name="equal-node"
              select="fill/with/all/equal[@a = $rel-node] |
                      fill/with/equal[@a = $rel-node]"/>         
         <!-- check unit relationship words-->

         <xsl:if test="count($equal-node) = 1">
            <xsl:variable name="unit-relationship">                         
               <xsl:call-template name="list-check">
                 <xsl:with-param name="list" select="$relationship-words"/>
                 <xsl:with-param name="words" select="$equal-node/@b"/>
               </xsl:call-template>            
            </xsl:variable> 

            <xsl:variable name="unit-relationship-value" select="translate($unit-relationship, '1', '')"/>         
            <xsl:if test="string-length($unit-relationship-value) &gt; 0">
               <xsl:call-template name="print-error">
                 <xsl:with-param name="error-type" select="'Error'"/>
                 <xsl:with-param name="field-info" select="$unit-relationship-value"/>
                 <xsl:with-param name="field-name" select="@name"/>
                 <xsl:with-param name="errormessage" 
                        select="concat('The relationship does not exist in the list [', $relationship-words, ']')"/>
               </xsl:call-template> 
            </xsl:if> 
         </xsl:if>  
      </xsl:if> 

      <!--verify the input-words-->  
      <xsl:if test="count(class/@input) = 1">
         <xsl:variable name="input-keywords">                         
            <xsl:call-template name="list-check">
              <xsl:with-param name="list" select="$input-words"/>
              <xsl:with-param name="words" select="class/@input"/>
            </xsl:call-template>            
         </xsl:variable> 
         <xsl:variable name="input-words-value" select="translate($input-keywords, '1', '')"/>

         <xsl:if test="string-length($input-words-value) &gt; 0">
            <xsl:call-template name="print-error">
              <xsl:with-param name="error-type" select="'Error'"/>
              <xsl:with-param name="field-info" select="$input-words-value"/>
              <xsl:with-param name="field-name" select="@name"/>
              <xsl:with-param name="errormessage" 
                     select="concat('The input words does not exist in the list [', $input-words, ']')"/>
            </xsl:call-template> 
         </xsl:if>                   
      </xsl:if> 

      <!--"require" field check-->
      <xsl:if test="string-length(@require) = 0">
         <xsl:call-template name="print-error">
           <xsl:with-param name="error-type" select="'Error'"/>
           <xsl:with-param name="field-info" select="'Empty require attribute'"/>
           <xsl:with-param name="field-name" select="@name"/>
           <xsl:with-param name="errormessage" 
                  select="concat('The require attribute has to be filled with one of list [', $require-words, ']')"/>
         </xsl:call-template> 
      </xsl:if>
      <xsl:variable name="require-check">
         <xsl:call-template name="list-check">
           <xsl:with-param name="list" select="$require-words"/>
           <xsl:with-param name="words" select="concat(@require, ',')"/>
         </xsl:call-template> 
      </xsl:variable>    
      <xsl:variable name="require-check-value" select="translate($require-check, '1', '')"/>          
    
      <xsl:if test="string-length($require-check-value) &gt; 0">
         <xsl:call-template name="print-error">
           <xsl:with-param name="error-type" select="'Error'"/>
           <xsl:with-param name="field-info" select="$require-check-value"/>
           <xsl:with-param name="field-name" select="@name"/>
           <xsl:with-param name="errormessage" 
                  select="concat('The word does not exist in the require list [', $require-words, ']')"/>
         </xsl:call-template> 
      </xsl:if>

   </xsl:for-each>
</xsl:template>



<!-- check the giving words list from the words list convert 1 if there exists in the list 
     return non existing words
-->
<xsl:template name="list-check">
  <xsl:param name="words"/>
  <xsl:param name="delimiter" select="','"/>
  <xsl:param name="list"/>

  <xsl:variable name="temp-list"
       select="concat(' ', translate($list, $delimiter, ' '), ' ')"/>

  <xsl:call-template name="list-check-helper">
    <xsl:with-param name="remaining-words" select="$words"/>
    <xsl:with-param name="list" select="$temp-list"/>
  </xsl:call-template>
</xsl:template>


<xsl:template name="list-check-helper">
  <xsl:param name="remaining-words"/>
  <xsl:param name="list"/>

    <xsl:variable name="normalize" select="normalize-space($remaining-words)"/>
    <xsl:if test="string-length($normalize) != 0">
      <xsl:variable name="current-word"
                    select="substring-before($normalize, ',')"/>
      <xsl:choose>
        <xsl:when test="contains($list, $current-word)">
          <xsl:text>1</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat($current-word, ',')"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="list-check-helper">
        <xsl:with-param name="list" select="$list"/>
        <xsl:with-param name="remaining-words" 
              select="substring-after($normalize, concat($current-word, ','))"/>
      </xsl:call-template>
    </xsl:if>
</xsl:template>



<!-- This template verifies between all nodes.
     If there is invalid extra character is found outside of the node, it will be
     an error. The order allows text only between <line></line> and <field></field>
     Added date:  13 August 2007
-->
<xsl:template name="verify-text-node">
   <xsl:for-each select="descendant::text()">
     
     <xsl:variable name="invalid-string" select="normalize-space(.)"/>
     <xsl:variable name="parent-name" select="name(..)"/>
     <xsl:if test="string-length($invalid-string) &gt; 0">
       <xsl:if test="count(../*) &gt; 1 or ($parent-name != 'line' and $parent-name != 'field')">
         <xsl:call-template name="print-error">
           <xsl:with-param name="error-type"   select="'Error'"/>
           <xsl:with-param name="field-info"   select="concat('&quot;', $invalid-string,'&quot; found in node &lt;',$parent-name,'&gt;',$cr)"/>
           <xsl:with-param name="field-name"   select="$parent-name"/>
           <xsl:with-param name="errormessage" select="concat('Invalid text or character &quot;',$invalid-string,'&quot; found in node &lt;',$parent-name,'&gt;',$cr)"/>
         </xsl:call-template> 
         <!--xsl:value-of select="concat('Invalid text &quot;',$invalid-string,'&quot; found in node &lt;',$parent-name,'&gt;',$cr)"/-->
       </xsl:if>
     </xsl:if>
   </xsl:for-each>
</xsl:template>

<!--
Template to convert numbers exponential notation to decimal format.
XSLT 1.0 number() function can not handle exponential notation.

-->

<xsl:variable name="max-exp">
  <xsl:value-of select="'0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'"/>
</xsl:variable>

<xsl:template name="convertSciToNumString" >
  <xsl:param name="inputVal" select="0"/>

  <xsl:variable name="numInput">
    <xsl:value-of select="translate(string($inputVal),'e','E')"/>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="number($numInput)">
        <xsl:value-of select="$numInput"/>
    </xsl:when> 
    <xsl:otherwise>

        <!-- ==== Mantisa ==== -->
        <xsl:variable name="numMantisa">
            <xsl:value-of select="number(substring-before($numInput,'E'))"/>
        </xsl:variable>

        <!-- ==== Exponent ==== -->
        <xsl:variable name="numExponent">
            <xsl:choose>
                <xsl:when test="contains($numInput,'E+')">
                    <xsl:value-of select="substring-after($numInput,'E+')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring-after($numInput,'E')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

         <!-- ==== Coefficient ==== -->
        <xsl:variable name="numCoefficient">
            <xsl:choose>
                <xsl:when test="number($numExponent) &gt; 0">
                    <xsl:text>1</xsl:text>
                    <xsl:value-of select="substring($max-exp, 1, number($numExponent))"/>
                </xsl:when>
                <xsl:when test="number($numExponent) &lt; 0">
                    <xsl:text>0.</xsl:text>
                    <xsl:value-of select="substring($max-exp, 1, -number($numExponent)-1)"/>
                    <xsl:text>1</xsl:text>
                </xsl:when>
                <xsl:otherwise>1</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="number($numCoefficient) * number($numMantisa)"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>





<!-- This template simply check class/@uom value. 
     Y if value is valid.
     Added date:   by Etsuko Lippi  11 Oct. 2010
-->
<xsl:template name="uom-required-value-check">
	<xsl:param name="uom"/>
     <xsl:choose>
        <xsl:when test="$uom = 'NO_UOM'      or
                        $uom = 'FT'          or
                        $uom = 'KM'          or
                        $uom = 'METERS'      or
                        $uom = 'KM_PER_DAY'  or
                        $uom = 'KM_PER_HR'   or
                        $uom = 'TON_GAL'"> 
            <xsl:text>Y</xsl:text>
		   </xsl:when>
         <xsl:otherwise> 
            <xsl:text>N</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
</xsl:template>



<!-- This template simply check class/@uom-type is specified. 
     Y if specified.
     Added date:   by Etsuko Lippi  11 Oct. 2010
-->
<xsl:template name="uom-type-check">
	<xsl:param name="uom-type"/>
     <xsl:choose>
       <xsl:when test="$uom-type = 'AIRDISTANCE' or
                       $uom-type = 'DISTANCE'    or
                       $uom-type = 'SPEED'       or
                       $uom-type = 'NAVAL_SPEED' or
                       $uom-type = 'DRY_WEIGHT'  or
                       $uom-type = 'WET_WEIGHT'  or
                       $uom-type = 'by_suppy'"> 
         <xsl:text>Y</xsl:text>
	    </xsl:when>
       <xsl:otherwise> 
         <xsl:text>N</xsl:text>
       </xsl:otherwise>
     </xsl:choose>
</xsl:template>


<!-- This template verifies the field class="INTEGER" and "REAL": check relationship of  
     uom and uom-type, default and uom-for-default.
     Added date:   by Etsuko Lippi  9 Oct. 2010
-->
<xsl:template name="verify-uom-checks">
	<xsl:param name="field-nodes"/>
	<xsl:for-each select="$field-nodes">
		<xsl:if test="class/@is = 'REAL' or class/@is = 'INTEGER'">
            <!--@uom value check variable-->
            <xsl:variable name="uom-check">
               <xsl:call-template name="uom-required-value-check">
               	<xsl:with-param name="uom" select="class/@uom"/>
              	</xsl:call-template>
            </xsl:variable>
            <!--@uom-type check variable-->
            <xsl:variable name="uom-type-check">
               <xsl:call-template name="uom-type-check">
               	<xsl:with-param name="uom-type" select="class/@uom-type"/>
              	</xsl:call-template>
            </xsl:variable>
            <!--@uom attribute is required.-->
            <xsl:if test="$uom-check != 'Y'">
              <xsl:call-template name="print-error">
                 <xsl:with-param name="error-type" select="'Error'"/>
                 <xsl:with-param name="field-info" select="@name"/>
                 <xsl:with-param name="field-name" select="class/@is"/>
                 <xsl:with-param name="errormessage" select="('The &quot;uom&quot; attribute is required. The &quot;uom&quot; ')"/>
                 <xsl:with-param name="errormessage2" select="concat('attribute has not a permitted value : &quot;', class/@uom, '&quot;.')"/>
            	</xsl:call-template> 
            </xsl:if>
            <!--"@uom"is'NO_UOM'-->
				<xsl:if test="class/@uom = 'NO_UOM' and count(class/@uom-type) = 1     or
                          class/@uom = 'NO_UOM' and count(class/@uom-for-default) = 1">
					<xsl:call-template name="print-error">
                 <xsl:with-param name="error-type" select="'Error'"/>
                 <xsl:with-param name="field-info" select="@name"/>
                 <xsl:with-param name="field-name" select="class/@is"/>
                 <xsl:with-param name="errormessage" select="('When &quot;uom&quot; attribute is &quot;NO_UOM&quot;, the &quot;uom-type&quot; and, ')"/>
                 <xsl:with-param name="errormessage2" select="('&quot;uom-for-default&quot; attribute are not permitted.')"/>
            	</xsl:call-template> 
				</xsl:if>

            <!--"@uom"is specified, uom-type & uom-for-default are required-->                      
            <xsl:if test="$uom-type-check = 'Y'">
               <xsl:if  test="count(class/@uom) != 1 or count(class/@uom-for-default) != 1">
				     <xsl:call-template name="print-error">
                   <xsl:with-param name="error-type" select="'Error'"/>
                   <xsl:with-param name="field-info" select="@name"/>
                   <xsl:with-param name="field-name" select="class/@is"/>
                   <xsl:with-param name="errormessage" select="concat('When &quot;uom-type&quot; attribute is specified : &quot;', class/@uom-type, '&quot;')"/>
                   <xsl:with-param name="errormessage2" select="('the &quot;uom&quot; and &quot;uom-for-default&quot; attribute are required.')"/>
                 </xsl:call-template> 
               </xsl:if>
            </xsl:if>				
           <!--"@uom"is specified, default is "NE" & uom-for-default is "NO_UOM"-->
            <xsl:if test="$uom-type-check = 'Y' and class/@default = 'NE'"> 
               <xsl:if  test="class/@uom-for-default != 'NO_UOM'">	  
               <xsl:call-template name="print-error">
                   <xsl:with-param name="error-type" select="'Error'"/>
                   <xsl:with-param name="field-info" select="@name"/>
                   <xsl:with-param name="field-name" select="class/@is"/>
                   <xsl:with-param name="errormessage" select="concat('When &quot;uom-type&quot; attribute is specified &quot;', class/@uom-type, '&quot;')"/>
                   <xsl:with-param name="errormessage2" select="('and &quot;default&quot; attribute is &quot;NE&quot;, ')"/>
                   <xsl:with-param name="errormessage3" select="('the &quot;uom-for-default&quot; attribute must be &quot;NO_UOM&quot;.')"/>
                   <xsl:with-param name="errormessage4" select="concat('But, &quot;uom-for-default&quot; attribute has a value : &quot;', class/@uom-for-default, '&quot;.')"/>
            	  </xsl:call-template> 
                </xsl:if>
				</xsl:if>
            <!--"@uom"is specified, default is NOT "NE" & uom-for-default is permitted value but "NO_UOM"-->                        
            <xsl:if test="$uom-type-check = 'Y' and class/@default != 'NE'"> 
               <xsl:variable name="uom-default">
	               <xsl:call-template name="uom-required-value-check">
		               <xsl:with-param name="uom" select="class/@uom-for-default"/>
	               </xsl:call-template>
               </xsl:variable>                
               <xsl:choose>
               <xsl:when test="$uom-default = 'Y'">
                  <xsl:if  test="class/@uom-for-default = 'NO_UOM'">
					     <xsl:call-template name="print-error">
                      <xsl:with-param name="error-type" select="'Error'"/>
                      <xsl:with-param name="field-info" select="@name"/>
                      <xsl:with-param name="field-name" select="class/@is"/>
                      <xsl:with-param name="errormessage" select="concat('When &quot;uom-type&quot; attribute is specified : &quot;', class/@uom-type, '&quot; and ')"/>
                      <xsl:with-param name="errormessage2" select="('&quot;default&quot; is not &quot;NE&quot;, the &quot;uom-for-default&quot; ')"/>
                      <xsl:with-param name="errormessage3" select="('must be one of the values permitted for the &quot;uom-type&quot;.  ')"/>
                      <xsl:with-param name="errormessage4" select="concat('But, &quot;uom-for-default&quot; attribute has a value : &quot;', class/@uom-for-default, '&quot;.')"/>
            	     </xsl:call-template> 
                  </xsl:if>
               </xsl:when>
               <xsl:otherwise>
                    <xsl:call-template name="print-error">
                      <xsl:with-param name="error-type" select="'Error'"/>
                      <xsl:with-param name="field-info" select="@name"/>
                      <xsl:with-param name="field-name" select="class/@is"/>
                      <xsl:with-param name="errormessage" select="concat('When &quot;uom-type&quot; attribute is specified : &quot;', class/@uom-type, '&quot; and ')"/>
                      <xsl:with-param name="errormessage2" select="('&quot;default&quot; is not &quot;NE&quot;, the &quot;uom-for-default&quot; ')"/>
                      <xsl:with-param name="errormessage3" select="('must be one of the values permitted for the &quot;uom-type&quot;.')"/>
                      <xsl:with-param name="errormessage4" select="concat('But, &quot;uom-for-default&quot; attribute has a not permitted value : &quot;', class/@uom-for-default, '&quot;.')"/>
            	     </xsl:call-template> 
               </xsl:otherwise>
               </xsl:choose>               
				</xsl:if>
            

				<!--class/@uom-type check-->
				<xsl:choose>
               <!--uom-type is 'AIRDISTANCE'-->
					<xsl:when test="class/@uom-type = 'AIRDISTANCE'">                     
                  <xsl:if test="class/@uom != 'FT'">                                              
							<xsl:call-template name="print-error">
                			<xsl:with-param name="error-type" select="'Error'"/>
                 			<xsl:with-param name="field-info" select="@name"/>
                 			<xsl:with-param name="field-name" select="class/@is"/>
                 			<xsl:with-param name="errormessage" select="('When &quot;uom-type&quot; attribute is &quot;AIRDISTANCE&quot;, the &quot;uom&quot; attribute')"/>
                        <xsl:with-param name="errormessage2" select="concat('must be &quot;FT&quot;, but the &quot;uom&quot; attribute value : &quot;', class/@uom, '&quot;.')"/>
            			</xsl:call-template>                        
                  </xsl:if>                 
               </xsl:when>
					<xsl:when test="class/@uom-type = 'DISTANCE'">
                  <xsl:if test="class/@uom != 'FT' and class/@uom != 'KM' and class/@uom != 'METERS'">
							<xsl:call-template name="print-error">
                			<xsl:with-param name="error-type" select="'Error'"/>
                 			<xsl:with-param name="field-info" select="@name"/>
                 			<xsl:with-param name="field-name" select="class/@is"/>
                 			<xsl:with-param name="errormessage" select="('When &quot;uom-type&quot; attribute is &quot;DISTANCE&quot;, the &quot;uom&quot; attribute ')"/>
                        <xsl:with-param name="errormessage2" select="('must be &quot;FT&quot; or &quot;KM&quot; or &quot;METERS&quot;,')"/>
                        <xsl:with-param name="errormessage3" select="concat('but the &quot;uom&quot; attribute value : &quot;', class/@uom, '&quot;')"/>
            			</xsl:call-template> 
                  </xsl:if>
               </xsl:when>
					<xsl:when test="class/@uom-type = 'SPEED'">
                  <xsl:if test="class/@uom != 'KM_PER_DAY' and class/@uom != 'KM_PER_HR'">
							<xsl:call-template name="print-error">
                			<xsl:with-param name="error-type" select="'Error'"/>
                 			<xsl:with-param name="field-info" select="@name"/>
                 			<xsl:with-param name="field-name" select="class/@is"/>
                 			<xsl:with-param name="errormessage" select="('When &quot;uom-type&quot; attribute is &quot;SPEED&quot;, the &quot;uom&quot; attribute  ')"/>
                        <xsl:with-param name="errormessage2" select="('must be &quot;KM_PER_DAY&quot; or &quot;KM_PER_HR&quot;, ')"/>
                        <xsl:with-param name="errormessage3" select="concat('but the &quot;uom&quot; attribute value : &quot;', class/@uom, '&quot;')"/>
            			</xsl:call-template> 
                  </xsl:if>
               </xsl:when>
               <xsl:when test="class/@uom-type = 'NAVAL_SPEED'">
                  <xsl:if test="class/@uom != 'KM_PER_DAY' and class/@uom != 'KM_PER_HR'">
							<xsl:call-template name="print-error">
                			<xsl:with-param name="error-type" select="'Error'"/>
                 			<xsl:with-param name="field-info" select="@name"/>
                 			<xsl:with-param name="field-name" select="class/@is"/>
                 			<xsl:with-param name="errormessage" select="('When &quot;uom-type&quot; attribute is &quot;NAVAL_SPEED&quot;, the &quot;uom&quot; attribute  ')"/>
                        <xsl:with-param name="errormessage2" select="('must be &quot;KM_PER_DAY&quot; or &quot;KM_PER_HR&quot;,')"/>
                        <xsl:with-param name="errormessage3" select="concat('but the &quot;uom&quot; attribute value : &quot;', class/@uom, '&quot;')"/>
            			</xsl:call-template> 
                  </xsl:if>
               </xsl:when>
					<xsl:when test="class/@uom-type = 'DRY_WEIGHT'">
                  <xsl:if test="class/@uom != 'TON_GAL'">
							<xsl:call-template name="print-error">
                			<xsl:with-param name="error-type" select="'Error'"/>
                 			<xsl:with-param name="field-info" select="@name"/>
                 			<xsl:with-param name="field-name" select="class/@is"/>
                 			<xsl:with-param name="errormessage" select="('When &quot;uom-type&quot; attribute is &quot;DRY_WEIGHT&quot;, the &quot;uom&quot; attribute  ')"/>
                        <xsl:with-param name="errormessage2" select="concat('must be &quot;TON_GAL&quot;, but the &quot;uom&quot; attribute value : &quot;', class/@uom, '&quot;')"/>                       
            			</xsl:call-template> 
                  </xsl:if>
               </xsl:when>
					<xsl:when test="class/@uom-type = 'WET_WEIGHT'">
                  <xsl:if test="class/@uom != 'TON_GAL'">
							<xsl:call-template name="print-error">
                			<xsl:with-param name="error-type" select="'Error'"/>
                 			<xsl:with-param name="field-info" select="@name"/>
                 			<xsl:with-param name="field-name" select="class/@is"/>
                 			<xsl:with-param name="errormessage" select="('When &quot;uom-type&quot; attribute is &quot;WET_WEIGHT&quot;, the &quot;uom&quot; attribute  ')"/>
                        <xsl:with-param name="errormessage2" select="concat('must be &quot;TON_GAL&quot;, but the &quot;uom&quot; attribute value : &quot;', class/@uom, '&quot;')"/>                       
            			</xsl:call-template> 
                  </xsl:if>
               </xsl:when>
					<xsl:when test="class/@uom-type = 'by_supply'">
                  <xsl:if test="class/@uom != 'TON_GAL'">
							<xsl:call-template name="print-error">
                			<xsl:with-param name="error-type" select="'Error'"/>
                 			<xsl:with-param name="field-info" select="@name"/>
                 			<xsl:with-param name="field-name" select="class/@is"/>
                 			<xsl:with-param name="errormessage" select="('When &quot;uom-type&quot; attribute is &quot;by_supply&quot;, the &quot;uom&quot; attribute  ')"/>
                        <xsl:with-param name="errormessage2" select="concat('must be &quot;TON_GAL&quot;, but the &quot;uom&quot; attribute value : &quot;', class/@uom, '&quot;')"/>                                  			
            			</xsl:call-template> 
                  </xsl:if>
               </xsl:when>
				</xsl:choose>				        
		</xsl:if>
	</xsl:for-each>
</xsl:template>




<!-- This template verifies the field class="INTEGER" or "REAL": min & max attribute
     number and not included spaace.    
     Added date:   by EL    6 September 2007
-->
<xsl:template name="verify-REAL-INTEGER-class">
  <xsl:param name="field-nodes"/>
  <xsl:for-each select="$field-nodes">
     <xsl:if test="class/@is = 'REAL' or class/@is = 'INTEGER'">
       <xsl:variable name="no-space-min" select="normalize-space(class/@min)"/>
       <xsl:variable name="no-space-max" select="normalize-space(class/@max)"/>
       <xsl:variable name="minval">
           <xsl:call-template name="convertSciToNumString">
              <xsl:with-param name="inputVal" select="class/@min"/>
           </xsl:call-template>
       </xsl:variable>
       <xsl:variable name="maxval">
           <xsl:call-template name="convertSciToNumString">
              <xsl:with-param name="inputVal" select="class/@max"/>
           </xsl:call-template>
       </xsl:variable>
       
          <xsl:if test="string(number($minval)) = 'NaN'"> 
             <xsl:if test="string(number(class/@min)) = 'NaN'"> 
               <xsl:call-template name="print-error">
                 <xsl:with-param name="error-type" select="'Error'"/>
                 <xsl:with-param name="field-info" select="@name"/>
                 <xsl:with-param name="field-name" select="class/@min"/>
                 <xsl:with-param name="errormessage" 
                     select="concat('The input number includes non-number character',$minval)"/>
               </xsl:call-template> 
            </xsl:if>
         </xsl:if>

         <xsl:if test="string(number($maxval)) = 'NaN'">
            <xsl:if test="string(number(class/@min)) = 'NaN'">
               <xsl:call-template name="print-error">
                 <xsl:with-param name="error-type" select="'Error'"/>
                 <xsl:with-param name="field-info" select="@name"/>
                 <xsl:with-param name="field-name" select="class/@max"/>
                 <xsl:with-param name="errormessage" 
                     select="'The input number includes non-number character'"/>
               </xsl:call-template> 
            </xsl:if>       
         </xsl:if>       

       <xsl:if test="string-length($no-space-min) &lt; string-length(class/@min)">
         <xsl:call-template name="print-error">
           <xsl:with-param name="error-type" select="'Error'"/>
           <xsl:with-param name="field-info" select="@name"/>
           <xsl:with-param name="field-name" select="class/@min"/>
           <xsl:with-param name="errormessage" 
                  select="'The input number includes extra character or space'"/>
         </xsl:call-template> 
       </xsl:if>
       <xsl:if test="string-length($no-space-max) &lt; string-length(class/@max)">
         <xsl:call-template name="print-error">
           <xsl:with-param name="error-type" select="'Error'"/>
           <xsl:with-param name="field-info" select="@name"/>
           <xsl:with-param name="field-name" select="class/@max"/>
           <xsl:with-param name="errormessage" 
                  select="'The input number includes extra character or space'"/>
         </xsl:call-template> 
       </xsl:if>
     </xsl:if>
  </xsl:for-each>
</xsl:template>


<!--
!! TEMPLATE:     get-sql-name
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: February 21, 2005
!! DESCRIPTION:  This template is designed to take a word, remove special
!!               characters and produce a name that can be used in Oracle.
-->
<xsl:template name="get-sql-name">
  <xsl:param name="base_name"/>
  
  <xsl:variable name="lower_name">
    <xsl:call-template name="to-lower">
      <xsl:with-param name="base_name" select="$base_name"/>
    </xsl:call-template>
  </xsl:variable>
  
  <!-- Convert some special characters to spaces or remove them. -->
  <xsl:variable name="translated_name" select="translate($lower_name, '[]()/.-:?%#', '           ')"/>
  
  <!-- Convert some special characters to spaces or remove them. -->
  <xsl:variable name="normalized_name" select="normalize-space($translated_name)"/>
  
  <!-- replace the reamining spaces with underscores. -->
  <xsl:variable name="final_name" select="translate($normalized_name, ' ', '_')"/>

  <xsl:value-of select="$final_name"/>
</xsl:template>  <!-- get-sql-name -->


<!--
!! TEMPLATE:     verify-not-equal-external-model
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: August 13, 2008
!! DESCRIPTION:  This template checks if not-equal tag exist for the
!!               external_model
-->
<xsl:template name="verify-not-equal-external-model">
 <xsl:param name="field-nodes"/>
  <!--xsl:value-of select="$field-nodes"/-->
  <xsl:for-each select="$field-nodes">  
    <xsl:variable name="ghost-check"
         select="concat(@name,'.external_model')"/>
    <!--xsl:value-of select="$ghost-check"/-->
    <xsl:variable name="not-equal-tag"
     select="fill/with/not-equal[@a = $ghost-check]"/>
    <xsl:if test="count($not-equal-tag) = 1">
    <!-- not-equal node for external_model should not be here. ERROR-->
    <xsl:call-template name="print-error">
      <xsl:with-param name="error-type" select="'Error'"/>
      <xsl:with-param name="field-info" select="@name"/>
      <xsl:with-param name="field-name" select="@name"/>
      <xsl:with-param name="errormessage" 
             select="'The node not-equal for external_model does not allow here'"/>
      <xsl:with-param name="errormessage2" 
             select="'Change the node to the equal'"/>
    </xsl:call-template> 
    </xsl:if>
  </xsl:for-each>
</xsl:template>



<!--
!! TEMPLATE:     verify-default-value-and-quick-entry
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: February 17, 2011
!! DESCRIPTION:  This template checks the following if quick entry exists,
!!               the field @name besides 'NAME' and 'REFERENCE' or in quick entry
!!               if the field @require is 'MANDATORY', default should not be "NE".
-->
<xsl:template name="verify-default-value-and-quick-entry">
 <xsl:param name="field-nodes"/>
 <xsl:if test="count(quick/@entry) != 0">
   <xsl:variable name="entry-value" select="translate(quick/@entry, ' ', '')"/>
   <xsl:variable name="entry-value1" >
     <xsl:value-of select="substring-before($entry-value,',')"/>  
   </xsl:variable>
   <xsl:variable name="entry-value2" >
     <xsl:value-of select="substring-after($entry-value, ',')"/>     
   </xsl:variable>
   <xsl:for-each select="$field-nodes">  
      <xsl:if test="@name != 'NAME' and @name != 'REFERENCE'">       		
        <xsl:if test="@name != $entry-value1 and @name != $entry-value2">
          <xsl:if test="@require = 'MANDATORY'"> 
           <xsl:if test="class/@default = 'NE'">
		      <xsl:call-template name="print-error">
      	     <xsl:with-param name="error-type" select="'Error'"/>
      	     <xsl:with-param name="field-info" select="@name"/>
      	     <xsl:with-param name="field-name" select="@name"/>
      	     <xsl:with-param name="errormessage" 
                   select="'Regarding a field name which is not in a quick/@entry,'"/>
              <xsl:with-param name="errormessage2" 
                   select="'when field/@require attribute is &quot;MANDATORY&quot;,'"/>
      	     <xsl:with-param name="errormessage3" 
                   select="'class/@default attribute should not be &quot;NE&quot;.  '"/>
			     <xsl:with-param name="errormessage4" 
                   select="'Change &quot;NE&quot; to actual value.'"/>
              <xsl:with-param name="errormessage5"
                   select="'if quick/@entry is single, set &quot;NULL&quot; for second entry.'"/>
    	      </xsl:call-template> 
           </xsl:if>
         </xsl:if>   			
        </xsl:if>         
      </xsl:if>
   </xsl:for-each>
 </xsl:if>
</xsl:template>


<!--
!! TEMPLATE:     to-lower
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This template returns the passed in parameter with all upper
!!               case alphabetics replaced with lower case.
-->
<xsl:template name="to-lower">
  <xsl:param name="base_name"/>
  <xsl:variable name="lower_name" select="translate($base_name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
  <xsl:value-of select="$lower_name"/>
</xsl:template> <!-- to-lower -->

</xsl:stylesheet>
