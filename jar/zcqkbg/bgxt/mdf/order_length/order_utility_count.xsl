<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xt="http://www.jclark.com/xt"
  xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
  extension-element-prefixes="xt"
  exclude-result-prefixes="xt"
  >

<!-- This stylesheet procedure is selected @require="MANDATORY" or "OPTIONAL"
     class and name-length number to be add up to @total-length.

     It adds up the extra length such as a space, the number of class
     and name-length.

     Input file : order-utility-temp.xml
     Output file: order-utility.xml

     The output file will be used by utility_group_length.xsl

   file_name     : $JTLSHOME/script/xsl/order_length/order_utility_count.xsl
   programmer    : Etsuko Lippi
   date create   : 2-6-07
-->

<xsl:output method="xml" indent="yes"/>


<!-- Check each utility -->
<xsl:template match="/temp">
  <xsl:element name="order-length">
    <xsl:call-template name="count-order"/>
    <xsl:call-template name="count-utility"/>
  </xsl:element>
</xsl:template>

<!-- Space -->
<xsl:variable name="SPACE"        select="2"/>

<!--Count order length here-->
<xsl:template name="count-order">
  <xsl:element name="orders">
     <xsl:for-each select="orders/order">
       <!--xsl:sort select="@name" data-type="text" order="ascending"/-->
       <xsl:element name="order">
          <xsl:attribute name="name">
            <xsl:value-of select="@name"/>
          </xsl:attribute> 

          <!--count number of fields + 1 will be the space-->
          <!--$space-between: the number of attributes(class & name-length) in a field--> 
          <xsl:variable name="space-between" select="count(fields/field)"/>

          <!--count fields that are MANDATORY & OPTIONAL for the space-->
          <xsl:variable name="space-between">
            <!--xsl:value-of select="count(fields/field[@require!='MANDATORY' and @require!='OPTIONAL'])"/-->
            <xsl:value-of select="count(fields/field[@require='MANDATORY' or @require='OPTIONAL'])"/>
          </xsl:variable>
          <xsl:variable name="man-space" select="$space-between*2"/>
          
          <xsl:attribute name="total-length">
            <xsl:for-each select="fields">
              <xsl:choose>
                <xsl:when test="count(field) != 0">
                  <xsl:variable name="man-classes" 
                                select="field[@require = 'MANDATORY' or @require = 'OPTIONAL']/@class"/>
                  <xsl:variable name="man-names" 
                                select="field[@require = 'MANDATORY' or @require = 'OPTIONAL']/@name-length"/>
                  <xsl:value-of select="sum($man-classes) + 
                                        sum($man-names)   + 
                                        $man-space - 1    +
                                        $SPACE" />   
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </xsl:attribute>

          <xsl:for-each select="fields/field"> 
            <!--write child element only @require = 'MANDATORY' or 'OPTIONAL'--> 
            <xsl:if test="@child != 0"> 
               <xsl:if test="@require = 'MANDATORY' or @require = 'OPTIONAL'"> 
                  <xsl:element name="child">
                     <xsl:attribute name="name">             
                        <xsl:value-of select="@child"/> 
                     </xsl:attribute>
                  </xsl:element> 
               </xsl:if>  
            </xsl:if>                              
                                              
          </xsl:for-each>    
          <!--count group -->
          <xsl:call-template name="count-order-group"/>      
       </xsl:element>
     </xsl:for-each>
  </xsl:element>

</xsl:template>




<!--Count Utility length here-->
<xsl:template name="count-utility">
  <xsl:element name="utilities">
     <xsl:for-each select="utilities/utility">
       <!--xsl:sort select="@name" data-type="text" order="ascending"/-->
       <xsl:variable name="max-entries" select="@max-entries"/>
       <xsl:element name="utility">
          <xsl:attribute name="name">
            <xsl:value-of select="@name"/>
          </xsl:attribute> 

          <!--count number of fields + 1 will be the space-->
          <xsl:variable name="space-between" select="count(fields/field)"/>
          <!--count { } default -->
          <xsl:variable name="brackets" select="2"/>
          <xsl:variable name="brackets-space" select="2*$max-entries"/>

          <!--count fields that are MANDATORY or OPTIONAL for the space-->
          <xsl:variable name="space-between">
            <xsl:value-of select="count(fields/field[@require ='MANDATORY' or @require ='OPTIONAL'])"/>
          </xsl:variable>
          <xsl:variable name="man-space" select="$space-between*2"/>
          
          <xsl:attribute name="total-length">
            <xsl:for-each select="fields">
              <xsl:choose>
                <xsl:when test="count(field) != 0">      
                  <xsl:variable name="man-classes" 
                                select="field[@require = 'MANDATORY' or @require = 'OPTIONAL']/@class"/>
                  <xsl:variable name="man-names" 
                                select="field[@require = 'MANDATORY' or @require = 'OPTIONAL']/@name-length"/>
                  <xsl:choose>
                     <xsl:when test="sum($man-classes) != 0 and sum($man-names) != 0">
                        <xsl:value-of select="(sum($man-classes)           +
                                               sum($man-names)             + 
                                               $man-space - 1              +                                      
                                               $SPACE)* $max-entries       +
                                               $brackets*$max-entries      +
                                               $brackets-space" />    
                     </xsl:when>
                     <xsl:otherwise>0</xsl:otherwise>
                   </xsl:choose> 
                </xsl:when>
                <xsl:otherwise>0</xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </xsl:attribute>

          <xsl:attribute name="max-entries">
            <xsl:value-of select="$max-entries"/>
          </xsl:attribute>

          <xsl:for-each select="fields/field">    
            <xsl:if test="@child != 0"> 
               <xsl:if test="@require = 'MANDATORY' or @require = 'OPTIONAL'"> 
                  <xsl:element name="child">
                     <xsl:attribute name="name">             
                        <xsl:value-of select="@child"/> 
                     </xsl:attribute>
                  </xsl:element> 
               </xsl:if>  
            </xsl:if>                                                                            
          </xsl:for-each>  
          <!--count group -->
          <xsl:call-template name="count-order-group"/>           
       </xsl:element>
     </xsl:for-each>
  </xsl:element>
</xsl:template>



<!--Count group length here-->
<xsl:template name="count-order-group">
  <xsl:element name="groups">
     <xsl:for-each select="groups/group">
       <xsl:element name="group">
          <xsl:for-each select="entry">
             <xsl:element name="entry">
               <xsl:attribute name="name">
                 <xsl:value-of select="@name"/>
               </xsl:attribute>
               <xsl:attribute name="total-length">
                  <xsl:for-each select="."> 
                    <!--$space-between: the number of field(class & name-length)-->                    
                    <xsl:value-of select="sum(item/@class)       + 
                                          sum(item/@name-length)" />                               
                  </xsl:for-each>
               </xsl:attribute>

               <xsl:for-each select="item"> 
                  <!--write child element--> 
                  <xsl:if test="@child != 0"> 
                     <xsl:element name="child">
                        <xsl:attribute name="name">             
                           <xsl:value-of select="@child"/> 
                        </xsl:attribute>
                     </xsl:element> 
                  </xsl:if>                                                                            
                </xsl:for-each>  
             </xsl:element>  
          </xsl:for-each> 

       </xsl:element>
     </xsl:for-each>
  </xsl:element>

</xsl:template>


</xsl:stylesheet>
