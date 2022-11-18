<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xt="http://www.jclark.com/xt"
  extension-element-prefixes="xt"
  exclude-result-prefixes="xt">

<!-- This stylesheet procedure is used to calculate all orders/utilities value
     length.

   file_name     : $JTLSHOME/script/xsl/order_length/order_utility_length_replace.xsl
   programmer    : Etsuko Lippi
   date create   : 2-6-07
-->

<xsl:output method="xml" indent="yes"/>

<!-- new line text variables -->
<xsl:variable name="cr">
<xsl:text>
</xsl:text>
</xsl:variable>

<!--Those number are default fixed estimated order length.
-->
<xsl:variable name="static-v"  select="2"/>
<xsl:variable name="data-v"    select="2"/>
<xsl:variable name="location"  select="20"/>
<xsl:variable name="duration"  select="13"/>
<xsl:variable name="tg"        select="15"/>
<xsl:variable name="bearing"   select="3"/>
<xsl:variable name="dmpi"      select="15"/>
<xsl:variable name="form"      select="12"/>
<xsl:variable name="msn"       select="15"/>
<xsl:variable name="pipe"      select="15"/>
<xsl:variable name="rectangle" select="80"/>
<xsl:variable name="time"      select="12"/>
<xsl:variable name="ut"        select="9"/>
<xsl:variable name="faction"   select="15"/>
<xsl:variable name="utility"    select="0"/>
<!--xsl:variable name="interger"   select=""/-->
<!--xsl:variable name="real"       select=""/-->
<!--xsl:variable name="fraction"   select=""/-->
<!--xsl:variable name="flag"       select=""/-->
<!--xsl:variable name="msn_name"   select=""/-->
<!--xsl:variable name="polygon"    select=""/-->
<!--xsl:variable name="player-mip" select=""/-->
<!--xsl:variable name="text"       select=""/-->



<!-- Check each order/utility -->
<xsl:template match="/orders-def">
  <xsl:element name="temp">  
    <xsl:call-template name="write-orders"/>
    <xsl:call-template name="write-utilities"/>
  </xsl:element> 
</xsl:template>


<!-- Order -->
<xsl:template name="write-orders">
  <xsl:element name="orders">
     <xsl:for-each select="orders/order">
       <xsl:element name="order">
          <xsl:attribute name="name">
            <xsl:value-of select="@short-name" />
          </xsl:attribute> 
          <xsl:element name="fields">
            <xsl:call-template name="write-field-attribute">
              <xsl:with-param name="node" select="fields/field"/>
            </xsl:call-template>
          </xsl:element>          
          <xsl:call-template name="write-groups">
            <xsl:with-param name="groups-node" select="groups"/>
          </xsl:call-template>
       </xsl:element>
       <xsl:value-of select="$cr"/>
     </xsl:for-each>
  </xsl:element>
</xsl:template>


<!-- Utility -->
<xsl:template name="write-utilities">
  <xsl:element name="utilities">
     <xsl:for-each select="utility/order">
       <xsl:element name="utility">
          <xsl:attribute name="name">
            <xsl:value-of select="@short-name" />
          </xsl:attribute> 
          <xsl:attribute name="max-entries">  
            <xsl:value-of select="@max-entries" />  
          </xsl:attribute> 
          <xsl:element name="fields">
            <xsl:call-template name="write-field-attribute">
              <xsl:with-param name="node" select="fields/field"/>
            </xsl:call-template>
          </xsl:element>
          <xsl:call-template name="write-groups">
            <xsl:with-param name="groups-node" select="groups"/>
          </xsl:call-template>
       </xsl:element>
       <xsl:value-of select="$cr"/>
     </xsl:for-each>
  </xsl:element>
</xsl:template>



<!-- groups -->
<xsl:template name="write-groups">
  <xsl:param name="groups-node" />
    <xsl:if test="count($groups-node/group/entries/entry) &gt; 0">
      <xsl:element name="groups">
        <xsl:for-each select="$groups-node/group">   
          <xsl:element name="group">            
             <xsl:for-each select="entries/entry">
               <xsl:element name="entry">
                 <xsl:variable name="field" select="@field"/>
                 <xsl:attribute name="name">
                   <xsl:value-of select="@label"/>
                 </xsl:attribute>                
                 <xsl:for-each select="../../../../fields/field">                              
                   <xsl:if test="contains($field, @name)">
                     <xsl:element name="item">
                       <xsl:attribute name="class">
                         <xsl:call-template name="replace-to-length"/>   
                       </xsl:attribute>
                       <xsl:attribute name="name-length">
                         <xsl:value-of select="string-length(@name)"/> 
                       </xsl:attribute>
                       <xsl:attribute name="child">
                         <xsl:choose>
                           <xsl:when test="class/@is = 'UTILITY'">
                             <xsl:value-of select="class/@name"/>
                           </xsl:when>
                           <xsl:otherwise>
                             <xsl:text>0</xsl:text>
                           </xsl:otherwise>
                         </xsl:choose>
                       </xsl:attribute>  
                     </xsl:element>    
                   </xsl:if>                                                                                                        
                 </xsl:for-each>  
               </xsl:element>
             </xsl:for-each> 
          </xsl:element>              
        </xsl:for-each>
      </xsl:element>
    </xsl:if>         
</xsl:template>



<!-- writes attribute under field node such as
     @class, @name-length and @child
     if field require is not 'MANDATORY' or 'OPTIONAL'
     it processes group process which select one option. -->
<xsl:template name="write-field-attribute">
  <xsl:param name="node"/>
  <xsl:for-each select="$node">
     <xsl:element name="field">
        <xsl:variable name="field-name" select="@name"/>
        <xsl:attribute name="class">
          <xsl:call-template name="replace-to-length"/>          
        </xsl:attribute> 
        <xsl:attribute name="name-length">
          <xsl:value-of select="string-length($field-name)"/>
        </xsl:attribute>
        <xsl:attribute name="require">
          <xsl:value-of select="@require"/>
        </xsl:attribute>
        <xsl:attribute name="child">
          <xsl:choose>
            <xsl:when test="class/@is = 'UTILITY'">
              <xsl:value-of select="class/@name"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>0</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>  
     </xsl:element>
  </xsl:for-each>
</xsl:template>



<!-- Each order is replaced the length
-->
<xsl:template name="replace-to-length">
  <xsl:variable name="length-list">
     <xsl:choose>
       <xsl:when test="class/@is = 'TEXT'       or
                       class/@is = 'PLAYER_MIP' or
                       class/@is = 'MSN_NAME'">
         <xsl:value-of select="class/@max-length"/>
       </xsl:when>
      
       <xsl:when test="class/@is = 'UTILITY'">
         <xsl:value-of select="$utility"/>
       </xsl:when>
       <xsl:when test="class/@is = 'FORM'">
         <xsl:value-of select="$form"/>
       </xsl:when>
       <xsl:when test="class/@is = 'MSN'">
         <xsl:value-of select="$msn"/>
       </xsl:when>
       <xsl:when test="class/@is = 'PIPE'">
         <xsl:value-of select="$pipe"/>
       </xsl:when>
       <xsl:when test="class/@is = 'POLYGON'">
         <!--POLYGON data repeat the number of max-vertices, 
             so count space in between each polygon data-->
         <xsl:variable name="polygon-space" 
                       select="class/@max-vertices * 2 - 1"/>
         <xsl:value-of select="string-length(string(class/@max-vertices)) + 
                               class/@max-vertices * $location            +
                               $polygon-space"/>
       </xsl:when>
       <xsl:when test="class/@is = 'RECTANGLE'">
         <!--RECTANGLE data repeat four times, so count seven space
             in between each data-->
         <xsl:variable name="rectangle-space" select="7"/>
         <!--RECTANGLE number of count + one space-->
         <xsl:variable name="rectangle-count" select="2"/>
         <xsl:value-of select="$rectangle-count      +
                               $rectangle            + 
                               $rectangle-space"/>
       </xsl:when>
       <xsl:when test="class/@is = 'TIME'">
         <xsl:value-of select="$time"/>
       </xsl:when>
       <xsl:when test="class/@is = 'UT'">
         <xsl:value-of select="$ut"/>
       </xsl:when>
       <xsl:when test="class/@is = 'FACTION'">
         <xsl:value-of select="$faction"/>
       </xsl:when>
       <xsl:when test="class/@is = 'INTEGER'">
         <xsl:value-of select="string-length(string(class/@max))"/>
       </xsl:when>
       <xsl:when test="class/@is = 'DATA_V'">
         <xsl:value-of select="$data-v"/>
       </xsl:when>
       <xsl:when test="class/@is = 'STATIC_V'">
         <xsl:value-of select="$static-v"/>
       </xsl:when>
       <xsl:when test="class/@is = 'LOCATION'">
         <xsl:variable name="location-space" select="1"/>
         <xsl:value-of select="$location + $location-space"/>
       </xsl:when>
       <xsl:when test="class/@is = 'DURATION'">
         <xsl:value-of select="$duration"/>
       </xsl:when>
       <xsl:when test="class/@is = 'FRACTION'">
         <xsl:value-of select="class/@precision"/>
       </xsl:when>
       <xsl:when test="class/@is = 'TG'">
         <xsl:value-of select="$tg"/>
       </xsl:when>
       <xsl:when test="class/@is = 'BEARING'">
         <xsl:value-of select="$bearing"/>
       </xsl:when>
       <xsl:when test="class/@is = 'REAL'">
         <xsl:value-of select="string-length(string(class/@max))"/>
       </xsl:when>
       <xsl:when test="class/@is = 'DMPI'">
         <xsl:value-of select="$dmpi"/>
       </xsl:when>
       <xsl:when test="class/@is = 'FLAG'">
         <xsl:value-of select="string-length(string(class/@default))"/>
       </xsl:when>
       <xsl:otherwise>  
         <!--default-->           
         <xsl:text>2</xsl:text>
       </xsl:otherwise>
     </xsl:choose>
  </xsl:variable>

  <xsl:value-of select="$length-list"/>
</xsl:template>

</xsl:stylesheet>
