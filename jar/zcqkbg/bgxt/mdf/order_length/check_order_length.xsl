<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xt="http://www.jclark.com/xt"
  extension-element-prefixes="xt"
  exclude-result-prefixes="xt">

<!-- This stylesheet is the final procedure is used to add up order @total-length
     and all utilities value length.

     Count patterns will be following:
     a.)  order total length = @total-length(MANDATORY, OPTIONAL).
     b.)  order total length = @total-length(MAN, OPT)     + 
          utility's total-length(MAN + OPT + largest ALTMAN, ALTOPT)  +
          order largest entry in group(ALTMAN, ALTOPT).
     c.)  order total length = @total-length(MAN, OPT)     +
          utility's total-length(MAN + OPT + largest ALTMAN, ALTOPT).
     d.)  order total length = @total-length(MAN, OPT)     +
          order largest entry in group(ALTMAN, ALTOPT).

   input file    : order-utility-final.xml  
   output file   : order-length.txt, utility-length.txt 
   file_name     : $JTLSHOME/script/xsl/order_length/check_order_length.xsl
   programmer    : Etsuko Lippi
   date create   : 2-9-07
-->

<xsl:output method="text"/>

<!-- new line text variables -->
<xsl:variable name="cr">
<xsl:text>
</xsl:text>
</xsl:variable>

<!--following variables are set as default -->
<xsl:variable name="HEADER"       select="4"/>
<xsl:variable name="WHIP-NAME"    select="15"/>
<xsl:variable name="ORDER-NUMBER" select="4"/>

<!--an argument from script(listorderlength)-->
<xsl:param name="one-order-length" select="'true'"/>
<xsl:param name="jtls-game" select="'/home/jtlsdev/game/data'"/>

<!-- main -->
<xsl:template match="/order-length">
   <!--create list first-->
   <xsl:variable name="order-file" select="concat($jtls-game, '/order-length-tmp.txt')"/>
   <!--xsl:variable name="order-file" select="'order-length-tmp.txt'"/-->
   <xt:document method="text" href="{$order-file}">
     <xsl:call-template name="write-order-with-utilities"/>
     <xsl:call-template name="write-order-no-utility"/>
   </xt:document>

   <xsl:variable name="utility-file" select="concat($jtls-game, '/utility-length-list.txt')"/>
   <!--xsl:variable name="utility-file" select="'utility-length.txt'"/-->
   <xt:document method="text" href="{$utility-file}">
   <!--extra info-->
     <xsl:call-template name="write-utility"/>
   <!--extra info-->
     <!--not necessary to create this list-->
     <xsl:call-template name="write-utility-of-order"/>
   </xt:document>

   <!--one order request-->
   <xsl:value-of select="$cr"/>
   <!--xsl:for-each select="orders/order|utilities/utility"-->
   <xsl:for-each select="orders/order">
     <xsl:value-of select="@short-name"/>
     <xsl:if test="@name = $one-order-length">
       <xsl:call-template name="write-line">
          <xsl:with-param name="order" select="."/> 
       </xsl:call-template>
     </xsl:if>
   </xsl:for-each>
</xsl:template>


<!-- Checks if there is a child that order has -->
<xsl:template name="write-order-with-utilities">
  <!--xsl:text>&lt;order with utilities&gt;</xsl:text-->
  <xsl:value-of select="$cr"/>
  <xsl:for-each select="orders/order"> 
     <xsl:sort select="@name" data-type="text" order="ascending"/>
     <!--order that have 'utility' -->
     <xsl:if test="child or groups/group/entry/child">
       <xsl:call-template name="write-line"/>
     </xsl:if>   
  </xsl:for-each>
</xsl:template>


<!-- Checks if there is NOT child that order has -->
<xsl:template name="write-order-no-utility">
  <xsl:value-of select="$cr"/>
  <!--xsl:text>&lt;order without utility&gt;</xsl:text-->
  <xsl:value-of select="$cr"/>
  <xsl:for-each select="orders/order"> 
     <xsl:sort select="@name" data-type="text" order="ascending"/>
     <!--order that does not have 'utility' -->
     <xsl:if test="count(child) = 0 and 
                   count(groups/group/entry/child) = 0">
       <xsl:call-template name="write-line">
         <xsl:with-param name="order" select="."/>
       </xsl:call-template>
     </xsl:if>   
  </xsl:for-each>
</xsl:template>



<!-- utility with child utility length -->
<xsl:template name="write-utility">
  <xsl:value-of select="$cr"/>
  <xsl:text>&lt;utilities total length&gt;</xsl:text>
 <xsl:value-of select="concat($cr,$cr)"/>
  <xsl:for-each select="utilities/utility"> 
    <xsl:sort select="@name" data-type="text" order="ascending"/>    
    <xsl:call-template name="write-line">
      <xsl:with-param name="order" select="."/>  
      <xsl:with-param name="type"  select="'utility'"/>            
    </xsl:call-template>       
  </xsl:for-each>
</xsl:template>


<!-- List of utilities that orders have -->
<xsl:template name="write-utility-of-order">
  <xsl:value-of select="$cr"/>
  <xsl:text>&lt;utility that orders have (max-entries)&gt;</xsl:text>
  <xsl:value-of select="concat($cr,$cr)"/>
  <xsl:for-each select="utilities/utility"> 
     <xsl:sort select="@name" data-type="text" order="ascending"/>
     <xsl:variable name="utility-name" select="@name"/>
     <xsl:variable name="utility-max"  select="@max-entries"/>
     <xsl:text>utility :</xsl:text>
     <xsl:value-of select="$utility-name"/>
     <xsl:text> (</xsl:text>
     <xsl:value-of select="$utility-max"/>
     <xsl:text>) </xsl:text>
     <xsl:value-of select="$cr"/>
     <!--search order name that has this 'utility' -->
     <xsl:for-each select="../../orders/order">
       <xsl:sort select="@name" data-type="text" order="ascending"/>
       <xsl:if test="child/@name = $utility-name or
                     groups/group/entry/used-child/@name = $utility-name">
         <xsl:text>  - </xsl:text>
         <xsl:call-template name="write-line">
           <xsl:with-param name="order" select="order"/>
           <xsl:with-param name="type"  select="'utility'"/>     
         </xsl:call-template>
         <!--list of child: keep them comment out-->
         <!--xsl:if test="child">
           <xsl:for-each select="child">
             <xsl:text>           :</xsl:text>
             <xsl:value-of select="@name"/>
             <xsl:value-of select="$cr"/>
           </xsl:for-each>
         </xsl:if-->
       </xsl:if>  
     </xsl:for-each> 
  </xsl:for-each>
</xsl:template>




<!--write order name and total-length here-->
<xsl:template name="write-line">
  <xsl:param name="order"/>
  <xsl:param name="type" />     
  <xsl:text>order  </xsl:text>          
  <xsl:value-of select="@name"/>
  <!--just for allignment -->
  <xsl:variable name="allignment" select="string-length(string(@name))"/>
  <xsl:choose>
    <xsl:when test="$allignment = 2">
      <xsl:text>    </xsl:text>
    </xsl:when>
    <xsl:when test="$allignment = 3">
      <xsl:text>   </xsl:text>
    </xsl:when>
    <xsl:when test="$allignment = 4">
      <xsl:text>  </xsl:text>
    </xsl:when>
    <xsl:when test="$allignment = 5">
      <xsl:text> </xsl:text>
    </xsl:when>
  </xsl:choose>
  <xsl:text>   total-length  </xsl:text>
  <xsl:variable name="order-length">
      <xsl:call-template name="calculate-total-length">
        <xsl:with-param name="order" select="."/>
        <xsl:with-param name="type"  select="$type"/>
      </xsl:call-template>     
  </xsl:variable>
  <!--Here that evaluates the largest entry in each group-->
  <xsl:variable name="multiple-group-length">
    <xsl:choose>
       <!--only if there are more than 2 groups in a order-->
       <xsl:when test="count(groups/group) &gt; 2 or count(groups/group) = 2">    
           <xsl:call-template name="evaluate-group">
              <xsl:with-param name="order"       select="$order"/>
              <xsl:with-param name="groups"      select="groups"/>
           </xsl:call-template>    
       </xsl:when>
       <!--there is only one group in order-->
       <xsl:when test="count(groups/group) = 1">
           <xsl:for-each select="groups/group/entry">          
             <xsl:sort select="@total-length" data-type="number" order="ascending"/>             
             <xsl:if test="position() = last()">              
               <xsl:value-of select="@total-length"/>
             </xsl:if>                    
           </xsl:for-each>
       </xsl:when>
       <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$type = 'utility'">
      <xsl:value-of select="$order-length + $multiple-group-length"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$HEADER + $WHIP-NAME + $ORDER-NUMBER + $order-length + $multiple-group-length"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="concat($cr, '')"/>  

</xsl:template>




<!--Evaluate the largest entries in multiple groups -->
<xsl:template name="evaluate-group">
  <xsl:param name="order"/>
  <xsl:param name="groups"/>
  <xsl:variable name="largest-xml">
     <values>
        <xsl:for-each select="$groups/group">
           <value>
              <xsl:for-each select="entry">          
                <xsl:sort select="@total-length" data-type="number" order="ascending"/>             
                <xsl:if test="position() = last()">              
                  <xsl:value-of select="@total-length"/>
                </xsl:if>                    
              </xsl:for-each>
           </value> 
        </xsl:for-each>
     </values>
  </xsl:variable> 
  <xsl:variable name="largest-values" select="xt:node-set($largest-xml)/values/value"/>

  <xsl:value-of select="sum($largest-values)"/>  
</xsl:template>




<!--Calculate total length in this order-->
<xsl:template name="calculate-total-length">
  <xsl:param name="order"/>
  <xsl:param name="type"/>
<!--this param needs to know its parent-->
  <xsl:param name="parent-name"/>  

  <xsl:variable name="child-length">
    <xsl:choose>
       <xsl:when test="$order/child[@name]">
         <xsl:call-template name="count-child">
           <xsl:with-param name="child" select="$order/child[@name][1]"/>
           <xsl:with-param name="parent-name" select="$order/@name"/>
         </xsl:call-template>
       </xsl:when>
       <xsl:when test="$order/groups/group/entry">
         <!--if order does not have a child but has a single /group/entry, 
             select the largest total in the entry-->  
         <xsl:choose>    
            <xsl:when test="$type = 'utility'"> 
               <xsl:for-each select="$order/groups/group/entry">
                  <xsl:sort select="@total-length" data-type="number" order="ascending"/>
                  <xsl:if test="position() = last()">
                    <xsl:value-of select="@total-length"/>
                  </xsl:if>           
               </xsl:for-each> 
            </xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
         </xsl:choose>             
      </xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:value-of select="$order/@total-length + $child-length"/>          
</xsl:template>



<!--utility count
 this template goes all nest utilities that the order has-->
<xsl:template name="count-child">
   <xsl:param name="child"/>
   <xsl:param name="parent-name"/>

   <xsl:variable name="util">
     <xsl:if test="/order-length/utilities/utility[@name = $child/@name]">
       <xsl:value-of select="'utility'"/>
     </xsl:if>
   </xsl:variable>

   <!--count the total-length in the related order-->
   <xsl:variable name="first-child">      
     <xsl:call-template name="calculate-total-length">
       <xsl:with-param name="order"       select="/order-length/utilities/utility[@name = $child/@name]"/>
       <xsl:with-param name="type"        select="$util"/>
       <xsl:with-param name="parent-name" select="$parent-name"/>
     </xsl:call-template>
   </xsl:variable>

   <!--count the total-length in the following-sibling total-length with order name-->
   <xsl:variable name="following-child">                         
     <xsl:choose>
       <xsl:when test="$child/following-sibling::child[@name]">                  
          <xsl:call-template name="count-child">
            <xsl:with-param name="child"
                      select="$child/following-sibling::child[@name][1]"/>
            <xsl:with-param name="parent-name" select="$parent-name"/>
          </xsl:call-template>                  
       </xsl:when>
       <xsl:otherwise>0</xsl:otherwise>
     </xsl:choose>                   
   </xsl:variable>

   <xsl:value-of select="$first-child + $following-child"/>
</xsl:template>

</xsl:stylesheet>
