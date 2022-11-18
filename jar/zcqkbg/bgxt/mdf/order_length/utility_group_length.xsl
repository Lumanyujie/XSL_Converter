<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xt="http://www.jclark.com/xt"
  extension-element-prefixes="xt"
  exclude-result-prefixes="xt">

<!-- This stylesheet process to calculate utilities groups/group/entry length including 
     its children.
     Notice: there are 2 exceptions while processing orders
     STRLP and ATCL utilities have three nest utilities.
     All orders will be copied to utility-group.xml

   file_name     : $JTLSHOME/script/xsl/order_length/utility_group_length.xsl
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
    <xsl:element name="utilities">
        <xsl:value-of select="$cr"/>
        <xsl:for-each select="utilities/utility"> 
          <xsl:variable name="number-of-nest">
            <xsl:call-template name="find-nest">
               <xsl:with-param name="order" select="."/>
            </xsl:call-template>  
          </xsl:variable>
          <xsl:call-template name="calculate-utility-group-length">
            <xsl:with-param name="nest" select="$number-of-nest"/>
          </xsl:call-template>
        </xsl:for-each>
    </xsl:element>
    <xsl:value-of select="$cr"/>
    <xsl:call-template name="copy-orders"/>
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




<!--find the number of the nested node-->
<xsl:template name="find-nest">
  <xsl:param name="order"/>
  <xsl:variable name="base" select="1"/>
  <xsl:variable name="child-length">
    <xsl:choose>
       <xsl:when test="$order/child[@name]">
         <xsl:call-template name="count-nest">
           <xsl:with-param  name="child"       select="$order/child[@name][1]"/>
         </xsl:call-template>
       </xsl:when>
       <xsl:when test="$order/groups/group/entry/child[@name][1]">
         <xsl:call-template name="count-nest">
           <xsl:with-param  name="child"       select="$order/groups/group/entry/child[@name][1]"/>
         </xsl:call-template>
       </xsl:when>   
       <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:value-of select="$base + $child-length"/>  
</xsl:template>



<xsl:template name="count-nest">
   <xsl:param name="child"/>
   <xsl:variable name="first-child">      
     <xsl:call-template name="find-nest">
       <xsl:with-param name="order" select="/order-length/utilities/utility[@name = $child/@name]"/>
     </xsl:call-template>
   </xsl:variable>
   <xsl:value-of select="$first-child"/>
</xsl:template>



<xsl:template name="calculate-utility-group-length">
     <xsl:param name="nest"/>
     <xsl:element name="utility">
        <xsl:variable name="utility-name" select="@name"/>
        <xsl:attribute name="name">
            <xsl:value-of select="@name"/>
        </xsl:attribute>
        <xsl:attribute name="total-length">
            <xsl:value-of select="@total-length"/>
        </xsl:attribute>
        <xsl:variable name="top-util-max" select="@max-entries"/>
        <xsl:attribute name="max-entries">
            <xsl:value-of select="@max-entries"/>
        </xsl:attribute>
        <!--copy child if the order has-->
        <xsl:call-template name="write-child"/>
          
        <!--the nest 3 is exception that are only "STRLP" and "ATCL"--> 
        <xsl:variable name="one-down-name" select="groups/group/entry/child/@name[1]"/> 
        <xsl:variable name="one-down-node" select="/order-length/utilities/utility[@name = $one-down-name]"/>
                    
        <xsl:variable name="nest-2-xml">
          <xsl:if test="$nest = 3">           
            <groups>
               <xsl:for-each select="$one-down-node/groups/group">
                 <group>
                   <xsl:for-each select="entry">
                     <xsl:element name="entry">
                        <xsl:attribute name="name">
                          <xsl:value-of select="@name"/>
                        </xsl:attribute>
                        <xsl:variable name="order-length2">
                           <xsl:call-template name="calculate-utility-total-length">
                             <xsl:with-param name="order"       select="."/>
                             <xsl:with-param name="parent-name" select="$one-down-node/@name"/>                            
                           </xsl:call-template> 
                        </xsl:variable>
                        <xsl:attribute name="total-length">
                          <xsl:value-of select="$order-length2"/>
                        </xsl:attribute>  
                     </xsl:element>
                   </xsl:for-each>
                 </group>
               </xsl:for-each>
            </groups>
          </xsl:if>
        </xsl:variable>     

        <!--calculate all child length to add up to total-length of entry -->                   
        <xsl:if test="count(groups/group/entry) != 0"> 
           <xsl:value-of select="$cr"/>        
           <xsl:element name="groups">
              <xsl:choose>
                <xsl:when test="$nest = 3">
                  <xsl:variable name="total-for-nest-3" select="xt:node-set($nest-2-xml)/groups/group"/>                                                           
                  <xsl:for-each select="$total-for-nest-3">
                    <xsl:value-of select="$cr"/> 
                    <xsl:element name="group">
                       <xsl:for-each select="entry">
                          <!--xsl:sort select="@total-length" data-type="number" order="ascending"/-->
                          <xsl:value-of select="$cr"/> 
                          <xsl:element name="entry">
                             <xsl:attribute name="name">
                                <xsl:value-of select="@name"/>
                             </xsl:attribute>
                             <xsl:attribute name="prev-total-length">
                                <xsl:value-of select="@total-length"/>
                             </xsl:attribute>
                             <xsl:attribute name="total-length">                           
                                <xsl:value-of select="@total-length*$top-util-max"/>                             
                             </xsl:attribute>                   
                          </xsl:element>                             
                       </xsl:for-each>
                       <xsl:value-of select="$cr"/> 
                    </xsl:element>
                    <xsl:value-of select="$cr"/> 
                  </xsl:for-each>          
                </xsl:when>
                <xsl:otherwise>
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
                               <xsl:call-template name="calculate-utility-total-length">
                                 <xsl:with-param name="order"       select="."/>
                                 <xsl:with-param name="parent-name" select="$utility-name"/>
                               </xsl:call-template>                              
                             </xsl:variable>
                             <xsl:attribute name="total-length">                           
                                <xsl:value-of select="$order-length"/>                             
                             </xsl:attribute>                   
                          </xsl:element>                             
                       </xsl:for-each>
                       <xsl:value-of select="$cr"/> 
                    </xsl:element>
                    <xsl:value-of select="$cr"/> 
                  </xsl:for-each> 
                </xsl:otherwise>
              </xsl:choose>  
           </xsl:element>                 
       </xsl:if>
       <xsl:value-of select="$cr"/>  
     </xsl:element>
     <xsl:value-of select="$cr"/>  
</xsl:template>



<!--Count length in this group-->
<xsl:template name="calculate-utility-total-length">
  <xsl:param name="order"/>
<!--this param needs to know its parent-->
  <xsl:param name="parent-name"/>  
 
  <xsl:variable name="parent-node" select="/order-length/utilities/utility[@name = $parent-name]"/>
  <xsl:variable name="max-parent" select="$parent-node/@max-entries"/>

  <xsl:variable name="child-length">
    <xsl:choose>
       <!--if utility has child(s), count them-->
       <xsl:when test="$order/child[@name]">
         <xsl:call-template name="count-utility-child">
           <xsl:with-param name="child" select="$order/child[@name][1]"/>
           <xsl:with-param name="parent-name" select="$parent-name"/>
         </xsl:call-template>
       </xsl:when>
       <!--if utility/group/entry has child(s), count them-->
       <xsl:when test="$order/groups/group/entry/child[@name][1]">
         <xsl:call-template name="count-utility-child">
           <xsl:with-param name="child" select="$order/groups/group/entry/child[@name][1]"/>
           <xsl:with-param name="parent-name" select="$order/@name"/>
         </xsl:call-template>
       </xsl:when>   
       <xsl:otherwise>
         <!--if utility has either child(s) nor /group/entry has child(s), select largest entry-->
         <xsl:variable name="largest-entry">
            <xsl:choose>
              <xsl:when test="$order/groups/group/entry">
                <xsl:for-each select="$order/groups/group/entry">
                   <xsl:sort select="@total-length" data-type="number" order="ascending"/>
                   <xsl:if test="position() = last()">
                     <xsl:value-of select="((@total-length + $order/@total-length)*$order/@max-entries)*$max-parent"/>
                   </xsl:if>           
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>0</xsl:otherwise>
            </xsl:choose>
         </xsl:variable>
         <xsl:value-of select="$largest-entry "/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:value-of select="$order/@total-length*$max-parent + $child-length"/>        
 
</xsl:template>


<!--utility count
 this template goes all nest utilities that the order has
-->
<xsl:template name="count-utility-child">
   <xsl:param name="child"/>
   <xsl:param name="parent-name"/>

   <!--count the total-length in the related order-->
   <xsl:variable name="first-child">      
     <xsl:call-template name="calculate-utility-total-length">
       <xsl:with-param name="order" select="/order-length/utilities/utility[@name = $child/@name]"/>
       <xsl:with-param name="parent-name" select="$parent-name"/>
     </xsl:call-template>
   </xsl:variable>

   <!--count the total-length in the following-sibling total-length with order name-->
   <xsl:variable name="following-child">                         
     <xsl:choose>
       <xsl:when test="$child/following-sibling::child[@name]">                  
          <xsl:call-template name="count-utility-child">
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


<!--copy orders to output xml file-->
<xsl:template name="copy-orders">
    <xsl:element name="orders">
      <xsl:for-each select="orders/order">
        <xsl:value-of select="$cr"/>
        <xsl:element name="order">
           <xsl:attribute name="name">
             <xsl:value-of select="@name"/>
           </xsl:attribute>
           <xsl:attribute name="total-length">
             <xsl:value-of select="@total-length"/>
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
                        <xsl:for-each select="child">
                           <xsl:value-of select="$cr"/>
                           <xsl:element name="child">
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
           <xsl:value-of select="$cr"/>
        </xsl:element>       
      </xsl:for-each>
    </xsl:element>
    <xsl:value-of select="$cr"/>
</xsl:template>
</xsl:stylesheet>
