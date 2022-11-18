<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xt="http://www.jclark.com/xt"
  extension-element-prefixes="xt"
  exclude-result-prefixes="xt">

<!-- This stylesheet process to calculate Orders groups/group/entry length including 
     its children(utility's total-length).

     This stylesheet must run after utility_group_length.xsl processed of order-utility.xml
     and created utility-group.xml because, all utility need to be ready its total-length
     for order length calculation. 
    
   input file    : utility-group.xml
   output file   : order-utility-final.xml
   file_name     : $JTLSHOME/script/xsl/order_length/order_group_length.xsl
   programmer    : Etsuko Lippi
   date create   : 3-13-07
-->
<xsl:output method="xml"/>

<!-- new line text variables -->
<xsl:variable name="cr">
<xsl:text>
</xsl:text>
</xsl:variable>


<!-- main -->
<xsl:template match="/order-length">
  <xsl:element name="order-length">
    <xsl:element name="orders">
      <xsl:call-template name="calculate-order-group-length"/>
    </xsl:element>
    <xsl:value-of select="$cr"/>
    <xsl:call-template name="copy-utilities"/>
  </xsl:element>
</xsl:template>


<xsl:template name="write-child">
   <xsl:if test="child">
     <xsl:for-each select="child">
       <xsl:value-of select="$cr"/>
       <xsl:element name="child">
         <xsl:attribute name="name">
           <xsl:value-of select="@name"/>
         </xsl:attribute>
       </xsl:element>
     </xsl:for-each>
   </xsl:if>
</xsl:template>


<xsl:template name="calculate-order-group-length">
  <xsl:value-of select="$cr"/>
  <xsl:for-each select="orders/order"> 
     <!--xsl:sort select="@name" data-type="text" order="ascending"/-->
     <xsl:element name="order">
        <xsl:variable name="order-name" select="@name"/>
        <xsl:attribute name="name">
            <xsl:value-of select="@name"/>
        </xsl:attribute>
        <xsl:attribute name="total-length">
            <xsl:value-of select="@total-length"/>
        </xsl:attribute>
        <!--copy child if the order has-->
        <xsl:call-template name="write-child"/>
        <!--calculate all child length to add up to total-length of entry -->
        <xsl:if test="count(groups/group/entry) != 0"> 
           <xsl:value-of select="$cr"/>        
           <xsl:element name="groups">
              <xsl:for-each select="groups/group">
                <xsl:value-of select="$cr"/> 
                <xsl:element name="group">

                   <xsl:for-each select="entry">
                      <xsl:sort select="@total-length" data-type="number" order="ascending"/>
                      <xsl:value-of select="$cr"/> 
                      <xsl:element name="entry">
                         <xsl:attribute name="name">
                           <xsl:value-of select="@name"/>
                         </xsl:attribute>
                         <xsl:variable name="order-length">
                           <xsl:call-template name="calculate-total-length">
                             <xsl:with-param name="order"       select="."/>
                             <xsl:with-param name="parent-name" select="@name"/>
                           </xsl:call-template>     
                         </xsl:variable>
                         <xsl:attribute name="total-length">
                           <xsl:value-of select="number($order-length)"/>
                         </xsl:attribute>                          
                         <xsl:for-each select="child">
                           <xsl:value-of select="$cr"/>
                           <xsl:element name="used-child">
                              <xsl:attribute name="name">
                                <xsl:value-of select="@name"/>
                              </xsl:attribute>
                           </xsl:element>   
                         </xsl:for-each>
                         <xsl:value-of select="$cr"/>               
                      </xsl:element>                             
                   </xsl:for-each>
                   <xsl:value-of select="$cr"/> 
                </xsl:element>
                <xsl:value-of select="$cr"/> 
              </xsl:for-each> 
           </xsl:element>                 
       </xsl:if>
       <xsl:value-of select="$cr"/>  
     </xsl:element>
     <xsl:value-of select="$cr"/> 
  </xsl:for-each>
</xsl:template>



<!--Count length in this group-->
<xsl:template name="calculate-total-length">
  <xsl:param name="order"/>
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
         <!--if utility has either child(s) nor /group/entry has child(s), select largest entry-->        
         <xsl:for-each select="$order/groups/group/entry">
            <xsl:sort select="@total-length" data-type="number" order="ascending"/>
            <xsl:if test="position() = last()">
              <xsl:value-of select="@total-length"/>
            </xsl:if>           
         </xsl:for-each>              
      </xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:value-of select="$order/@total-length + $child-length"/>
  
</xsl:template>


<!--utility count
 this template goes all nest utilities that the order has
-->
<xsl:template name="count-child">
   <xsl:param name="child"/>
   <xsl:param name="parent-name"/>

   <!--count the total-length in the related order-->
   <xsl:variable name="first-child">      
     <xsl:call-template name="calculate-total-length">
       <xsl:with-param name="order"       select="/order-length/utilities/utility[@name = $child/@name]"/>
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



<!--copy utilities to the output xml file-->
<xsl:template name="copy-utilities">
    <xsl:element name="utilities">
      <xsl:for-each select="utilities/utility">     
        <xsl:value-of select="$cr"/>
        <xsl:element name="utility">
           <xsl:attribute name="name">
             <xsl:value-of select="@name"/>
           </xsl:attribute>
           <xsl:attribute name="total-length">
             <xsl:value-of select="@total-length"/>
           </xsl:attribute>
           <xsl:attribute name="max-entries">
             <xsl:value-of select="@max-entries"/>
           </xsl:attribute>
           <xsl:value-of select="$cr"/>
           <xsl:for-each select="child">
             <xsl:element name="child">
               <xsl:attribute name="name">
                 <xsl:value-of select="@name"/>
               </xsl:attribute>
             </xsl:element>
             <xsl:value-of select="$cr"/>
           </xsl:for-each>
           <xsl:value-of select="$cr"/>
           <xsl:element name="groups"> 
             <xsl:for-each select="groups/group">
                <xsl:value-of select="$cr"/>
                <xsl:element name="group">
                   <xsl:for-each select="entry">
                      <xsl:value-of select="$cr"/>
                      <xsl:element name="entry">
                        <xsl:attribute name="name">
                           <xsl:value-of select="@name"/>
                        </xsl:attribute>
                        <xsl:attribute name="total-length">
                           <xsl:value-of select="@total-length"/>
                        </xsl:attribute>
                      </xsl:element>
                   </xsl:for-each>
                   <xsl:value-of select="$cr"/>
                </xsl:element>
                <xsl:value-of select="$cr"/>
             </xsl:for-each>
           </xsl:element>
           <xsl:value-of select="$cr"/>
        </xsl:element>             
      </xsl:for-each>
    </xsl:element>
    <xsl:value-of select="$cr"/>
</xsl:template>


</xsl:stylesheet>
