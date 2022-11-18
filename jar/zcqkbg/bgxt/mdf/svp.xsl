<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- This stylesheet procedure is used:
     1. Count the structure of an [scenario].xml_time&date file in 
        data/scenario/[scenario]/verify directly.
     2. Prints descriptions of warnings and errors by svp sections.
        It counts each description column and prints next line when column is 
        over 165.
     3. Prints a list of all Errors and Warnings sorted by number.
     4. Prints the warning checks skipped.
     5. The stylesheet generates a text file that called scenario.err_time&date
        file.

   file_name     : $JTLSHOME/script/xsl/svp.xsl
   programmer    : Etsuko Lippi
   date create   : 12-29-2008
-->
<xsl:output method="text"/>

<xsl:param name="line_length" select="''"/>

<!-- new line text variables -->
<xsl:variable name="cr">
<xsl:text>
</xsl:text>
</xsl:variable>


<!--all variables contains text are here-->
<xsl:variable name="mpv"    select="'Finished Model Parameter Verification:'"/>
<xsl:variable name="pv"     select="'Finished Prototype       Verification:'"/>
<xsl:variable name="lv"     select="'Finished Lethality       Verification:'"/>
<xsl:variable name="uv"     select="'Finished Unit            Verification:'"/>
<xsl:variable name="hru"    select="'Finished HRU             Verification:'"/>
<xsl:variable name="tv"     select="'Finished Target          Verification:'"/>
<xsl:variable name="tpfddv" select="'Finished TPFDD           Verification:'"/>
<xsl:variable name="ev"     select="'Finished Event           Verification:'"/>
<xsl:variable name="hruv"   select="'Finished Terrain         Verification:'"/>
<xsl:variable name="els"    select="'Finished ELS             Verification:'"/>
<xsl:variable name="cv"     select="'Completed                Verification:'"/>
<xsl:variable name="comment" select="'   SVP   '"/>
<xsl:variable name="errors"          select="'        Errors: '"/>
<xsl:variable name="total-errors"    select="'  Total Errors: '"/>
<xsl:variable name="warnings"        select="'  Warnings: '"/>
<xsl:variable name="title-bold"      select="'THE FOLLOWING ERRORS AND WARNINGS WERE FOUND'"/>
<xsl:variable name="title1"          select="'The following'"/>
<xsl:variable name="title2"          select="' Errors and Warnings were found:'"/>
<xsl:variable name="all-list"        select="'The following is a list of all Errors and Warnings sorted by number:'"/>
<xsl:variable name="warning-checks"  select="'The following is a review of Warning Checks during this run:'"/>
<xsl:variable name="checks-skipped"  select="'   The Warning Checks Skipped Were:'"/>
<xsl:variable name="classification"  select="SVP/@Classification"/>
<xsl:variable name="skipped-list"    select="62"/>


<!-- Document entry point -->
<xsl:template match="/SVP">
  <xsl:call-template name="classified-head"/>
  <xsl:call-template name="process-svp-count"/>
  <xsl:call-template name="process-svp-details"/>
  <!--xsl:call-template name="process-svp-sorted"/-->
  <xsl:call-template name="process-unit-error-sets"/>
  <xsl:call-template name="process-svp-warning-checks-skipped"/>
</xsl:template>



<!--prints classfied beginning the page-->
<xsl:template name="classified-head">
  <xsl:value-of select="$cr"/>
  <xsl:text>                                 </xsl:text>
  <xsl:value-of select="$classification"/>
  <xsl:value-of select="$cr"/>
  <xsl:text>                            </xsl:text>
  <xsl:text>-----------------------</xsl:text>
  <xsl:value-of select="concat($cr,$cr)"/>
</xsl:template>



<!--prints classfied ending the page-->
<xsl:template name="classified-foot">
  <xsl:value-of select="$cr"/>
  <xsl:text>                                 </xsl:text>
  <xsl:value-of select="$classification"/>
  <xsl:value-of select="$cr"/>
  <xsl:text>                            </xsl:text>
  <xsl:text>-----------------------</xsl:text>
  <xsl:value-of select="$cr"/>
  <xsl:text>&lt;np&gt;</xsl:text>
</xsl:template>



<!--prints which svp number-->
<xsl:template name="print-comment">
  <xsl:param name="first-number"/>
  <xsl:value-of select="$comment"/>
  <xsl:value-of select="concat($first-number, '00')"/>
  <xsl:value-of select="$cr"/>
</xsl:template>


<!--svp count process-->
<xsl:template name="process-svp-count">  
  <xsl:value-of select="$mpv"/>
  <xsl:call-template name="count-helper">
    <xsl:with-param name="first-number" select="1"/>
  </xsl:call-template> 
  <xsl:value-of select="$pv"/>
  <xsl:call-template name="count-helper">   
    <xsl:with-param name="first-number" select="2"/>
  </xsl:call-template>
  <xsl:value-of select="$lv"/>
  <xsl:call-template name="count-helper">
    <xsl:with-param name="first-number" select="3"/>
  </xsl:call-template>
  <xsl:value-of select="$uv"/>
  <xsl:call-template name="count-helper">
    <xsl:with-param name="first-number" select="4"/>
  </xsl:call-template>
  <xsl:value-of select="$hru"/>
  <xsl:call-template name="count-helper">
    <xsl:with-param name="first-number" select="5"/>
  </xsl:call-template>
  <xsl:value-of select="$tv"/>
  <xsl:call-template name="count-helper">
    <xsl:with-param name="first-number" select="6"/>
  </xsl:call-template>
  <xsl:value-of select="$tpfddv"/>
  <xsl:call-template name="count-helper">
    <xsl:with-param name="first-number" select="7"/>
  </xsl:call-template>
  <xsl:value-of select="$ev"/>
  <xsl:call-template name="count-helper">
    <xsl:with-param name="first-number" select="8"/>
  </xsl:call-template>
  <xsl:value-of select="$hruv"/>
  <xsl:call-template name="count-helper">
    <xsl:with-param name="first-number" select="9"/>
  </xsl:call-template>
  <xsl:value-of select="$els"/>
  <xsl:call-template name="count-helper">
    <xsl:with-param name="first-number" select="10"/>
    <xsl:with-param name="els-flag"     select="'y'"/>
  </xsl:call-template>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cv"/>
  <xsl:call-template name="count-helper-total"/> 
  <!--xsl:value-of select="result:getCounter(0)"/-->  
<!--space lines-->
  <xsl:value-of select="concat($cr,$cr,$cr,$cr,$cr,$cr,$cr,$cr,$cr,$cr)"/>
  <xsl:value-of select="concat($cr,$cr,$cr,$cr,$cr,$cr,$cr,$cr,$cr,$cr)"/>
  <xsl:value-of select="concat($cr,$cr,$cr,$cr,$cr,$cr,$cr,$cr,$cr,$cr)"/>
  <xsl:value-of select="concat($cr,$cr,$cr,$cr,$cr,$cr,$cr,$cr)"/>
</xsl:template>


<!--prints description -->
<xsl:template name="process-svp-details">
<!--details -->
  <xsl:value-of select="concat($cr,$cr)"/>
  <xsl:text>                            </xsl:text>
  <xsl:value-of select="$title-bold"/>
  <xsl:value-of select="concat($cr,$cr)"/>
  <xsl:call-template name="detail-helper">
    <xsl:with-param name="first-number" select="1"/>
    <xsl:with-param name="svp-section" select="' Model Parameter'"/>
  </xsl:call-template> 
  <xsl:value-of select="concat($cr,$cr,$cr)"/>
  <xsl:call-template name="detail-helper">
    <xsl:with-param name="first-number" select="2"/>
    <xsl:with-param name="svp-section" select="' Prototype'"/>
  </xsl:call-template> 
  <xsl:value-of select="concat($cr,$cr,$cr)"/>
  <xsl:call-template name="detail-helper">
    <xsl:with-param name="first-number" select="3"/>
    <xsl:with-param name="svp-section" select="' Lethality'"/>
  </xsl:call-template> 
  <xsl:value-of select="concat($cr,$cr,$cr)"/>
  <xsl:call-template name="detail-helper">
    <xsl:with-param name="first-number" select="4"/>
    <xsl:with-param name="svp-section" select="' Unit'"/>
  </xsl:call-template> 
  <xsl:value-of select="concat($cr,$cr,$cr)"/>
  <xsl:call-template name="detail-helper">
    <xsl:with-param name="first-number" select="5"/>
    <xsl:with-param name="svp-section" select="' HRU'"/>
  </xsl:call-template> 
  <xsl:value-of select="concat($cr,$cr,$cr)"/>
  <xsl:call-template name="detail-helper">
    <xsl:with-param name="first-number" select="6"/>
    <xsl:with-param name="svp-section" select="' Target'"/>
  </xsl:call-template> 
  <xsl:value-of select="concat($cr,$cr,$cr)"/>
  <xsl:call-template name="detail-helper">
    <xsl:with-param name="first-number" select="7"/>
    <xsl:with-param name="svp-section" select="' TPFDD'"/>
  </xsl:call-template> 
  <xsl:value-of select="concat($cr,$cr,$cr)"/>
  <xsl:call-template name="detail-helper">
    <xsl:with-param name="first-number" select="8"/>
    <xsl:with-param name="svp-section" select="' EVENT'"/>  
  </xsl:call-template> 
  <xsl:value-of select="concat($cr,$cr,$cr)"/>
  <xsl:call-template name="detail-helper">
    <xsl:with-param name="first-number" select="9"/>
    <xsl:with-param name="svp-section" select="' Terrain'"/>
  </xsl:call-template> 
  <xsl:value-of select="concat($cr,$cr,$cr)"/>
  <xsl:call-template name="detail-helper">
    <xsl:with-param name="first-number" select="10"/>
    <xsl:with-param name="svp-section" select="' ELS'"/>
    <xsl:with-param name="els-flag"    select="'y'"/>
  </xsl:call-template> 
</xsl:template>


<!--added 07/01/09 -->
<!--prints description -->
<xsl:template name="process-unit-error-sets">
<!--print unit by unit error -->
  <xsl:value-of select="concat($cr,$cr)"/>
  <xsl:text>                            </xsl:text>
  <xsl:value-of select="$title-bold"/>
  <xsl:value-of select="concat($cr,$cr)"/>
  <xsl:call-template name="unit-error-list-helper">
    <xsl:with-param name="first-number" select="4"/>
    <xsl:with-param name="svp-section" select="' Unit'"/>
  </xsl:call-template> 
  <xsl:value-of select="concat($cr,$cr,$cr)"/>
</xsl:template>



<xsl:variable name="counter" select="1"/>

<!--prints a list of all errors and warnings sorted by item number
    errors first, warnings second.-->
<xsl:template name="process-svp-sorted">
<!--all details sorted by number-->  
 <xsl:value-of select="concat($cr,$cr)"/>
  <xsl:value-of select="$all-list"/>
  <xsl:value-of select="concat($cr,$cr)"/>
  <xsl:for-each select="Errors/Item">   
    <xsl:sort select="@Number" data-type="number" order="ascending"/>  
    <xsl:variable name="pos" select="position()"/>        
    <xsl:choose>
       <xsl:when test="string-length(@Description) &gt; $line_length">            
          <xsl:call-template name="line-helper"> 
            <xsl:with-param name="line"          select="@Description"/>
            <xsl:with-param name="line-number"   select="1"/>
            <xsl:with-param name="error-warning" select="'error'"/>
            <xsl:with-param name="row-num"       select="$counter + 1"/>            
          </xsl:call-template> 
       </xsl:when>
       <xsl:otherwise>            
          <xsl:value-of select="@Description"/> 
       </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$cr"/>        
  </xsl:for-each> 
  <xsl:for-each select="Warnings/Item">   
    <xsl:sort select="@Number" data-type="number" order="ascending"/>  
    <xsl:variable name="pos" select="position()"/>    
    <xsl:choose>
       <xsl:when test="string-length(@Description) &gt; $line_length">            
          <xsl:call-template name="line-helper"> 
            <xsl:with-param name="line"        select="@Description"/>
            <xsl:with-param name="line-number" select="1"/>
            <xsl:with-param name="error-warning" select="'warning'"/>
            <xsl:with-param name="row-num"       select="$counter + 1"/>            
          </xsl:call-template> 
       </xsl:when>
       <xsl:otherwise>            
          <xsl:value-of select="@Description"/> 
       </xsl:otherwise>
    </xsl:choose>       
    <xsl:value-of select="$cr"/>      
  </xsl:for-each>
  <xsl:value-of select="concat($cr,$cr)"/>    
</xsl:template>



<!--prints all waarning checks numbers skipped
   it prints 10 skipped number in a raw-->
<xsl:template name="process-svp-warning-checks-skipped">
  <xsl:value-of select="$warning-checks"/>
  <xsl:value-of select="concat($cr,$cr)"/>
  <xsl:value-of select="$checks-skipped"/>
  <xsl:value-of select="concat($cr,$cr)"/>  
  <xsl:variable name="list">
  <xsl:for-each select="SkipWarnings/Skip">     
    <xsl:if test="string-length(@SkipNumber) = 3">
      <xsl:text> </xsl:text>
    </xsl:if>
    <xsl:value-of select="@SkipNumber"/>
    <xsl:text>  </xsl:text>    
  </xsl:for-each>
  </xsl:variable>
  <xsl:call-template name="allign-helper">
    <xsl:with-param name="line"        select="$list"/>
    <xsl:with-param name="line-number" select="1"/>
  </xsl:call-template>
</xsl:template>



<!--help to allign skip checks list-->
<xsl:template name="allign-helper">
  <xsl:param name="line"/>
  <xsl:param name="line-number"/>
  <xsl:choose>
    <xsl:when test="number($line-number) = 1">
      <xsl:text>    </xsl:text>  
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>     </xsl:text>  
    </xsl:otherwise>  
  </xsl:choose>  
  <xsl:choose>
     <!--xsl:when test="string-length($line) &gt; 162"-->
     <xsl:when test="string-length($line) &gt; $skipped-list">
       <xsl:variable name="print-line-pos">
         <xsl:call-template name="new-line-helper">
           <!--xsl:with-param name="line" select="substring($line, 1, 162)"/-->  
           <xsl:with-param name="line" select="substring($line, 1, $skipped-list)"/>         
         </xsl:call-template>
       </xsl:variable>           
       <xsl:value-of select="substring($line,1,$print-line-pos)"/>
       <xsl:value-of select="$cr"/>
       <xsl:variable name="varify-check-number">
         <!--check passing line if it starts with 1000's number-->
         <xsl:value-of select="substring($line,$print-line-pos+1,string-length($line))"/>
       </xsl:variable>
       <xsl:choose>
         <xsl:when test="starts-with($varify-check-number, '1')">
           <xsl:call-template name="allign-helper">      
              <xsl:with-param name="line" select="substring($line,$print-line-pos+1,string-length($line))"/>              
              <xsl:with-param name="line-number" select="1"/>
           </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
           <xsl:call-template name="allign-helper">      
              <xsl:with-param name="line" select="substring($line,$print-line-pos+1,string-length($line))"/>                           
           </xsl:call-template>
         </xsl:otherwise> 
       </xsl:choose>
     </xsl:when>
     <xsl:otherwise>
       <xsl:value-of select="$line"/>
     </xsl:otherwise>
  </xsl:choose>
</xsl:template>




<xsl:template name="print-detail">
  <xsl:param name="node"/>
  <xsl:param name="first-number"/>
  <xsl:param name="els-flag"/>
  <xsl:param name="error-warning"/>
  <xsl:for-each select="$node">    
    <xsl:sort select="@Number" data-type="number" order="ascending"/> 
    <xsl:variable name="pos" select="position()"/> 
    <xsl:choose>
      <xsl:when test="$els-flag = 'y' and string-length(@Number) = 4">
        <!--els data-->       
        <xsl:choose>
           <xsl:when test="string-length(@Description) &gt; $line_length">            
              <xsl:call-template name="line-helper"> 
                <xsl:with-param name="line"          select="@Description"/>
                <xsl:with-param name="line-number"   select="1"/>
                <xsl:with-param name="error-warning" select="$error-warning"/>
                <xsl:with-param name="row-num"       select="$counter + 1"/> 
              </xsl:call-template> 
           </xsl:when>
           <xsl:otherwise>            
              <xsl:value-of select="@Description"/> 
           </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$cr"/>   
        <!--end els data-->    
      </xsl:when>
      <xsl:when test="starts-with(string(@Number), string($first-number))
                    and string-length(@Number) = 3">       
        <!--UNIT only start--> 
        <!--xsl:if test="@UNIT and $first-number = 4">             
          <xsl:if test="count(preceding-sibling::*[1]/@UNIT) = 0 or
                        @UNIT != preceding-sibling::*[1]/@UNIT">   
            <xsl:value-of select="$cr"/>          
            <xsl:value-of select="@UNIT"/>
            <xsl:value-of select="$cr"/>      
            <xsl:call-template name="print-under-line">
               <xsl:with-param name="number" select="string-length(@UNIT)"/>
            </xsl:call-template>  
            <xsl:value-of select="concat($cr,$cr)"/>
          </xsl:if>            
        </xsl:if-->       
        <!--UNIT only end--> 
        <xsl:choose>
           <xsl:when test="string-length(@Description) &gt; $line_length">            
              <xsl:call-template name="line-helper"> 
                <xsl:with-param name="line" select="@Description"/>
                <xsl:with-param name="line-number" select="1"/>
                <xsl:with-param name="error-warning" select="$error-warning"/>
                <xsl:with-param name="row-num" select="$counter + 1"/> 
              </xsl:call-template> 
           </xsl:when>
           <xsl:otherwise>            
              <xsl:value-of select="@Description"/> 
           </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$cr"/>       
      </xsl:when>  
    </xsl:choose>      
  </xsl:for-each>  
</xsl:template>



<xsl:template name="unit-print-detail">
  <xsl:param name="node"/>
  <xsl:param name="first-number"/>
  <xsl:param name="error-warning"/>
  <xsl:for-each select="$node">    
    <xsl:sort select="@Number" data-type="number" order="ascending"/> 
    <xsl:variable name="pos" select="position()"/> 
    <xsl:choose>
      <xsl:when test="starts-with(string(@Number), string($first-number))
                    and string-length(@Number) = 3">       
        <!--UNIT only start--> 
        <xsl:if test="@UNIT and $first-number = 4">             
          <xsl:if test="count(preceding-sibling::*[1]/@UNIT) = 0 or
                        @UNIT != preceding-sibling::*[1]/@UNIT">   
            <xsl:value-of select="$cr"/>          
            <xsl:value-of select="@UNIT"/>
            <xsl:value-of select="$cr"/>      
            <xsl:call-template name="print-under-line">
               <xsl:with-param name="number" select="string-length(@UNIT)"/>
            </xsl:call-template>  
            <xsl:value-of select="concat($cr,$cr)"/>
          </xsl:if>            
        </xsl:if>       
        <!--UNIT only end--> 
        <xsl:choose>
           <xsl:when test="string-length(@Description) &gt; $line_length">            
              <xsl:call-template name="line-helper"> 
                <xsl:with-param name="line" select="@Description"/>
                <xsl:with-param name="line-number" select="1"/>
                <xsl:with-param name="error-warning" select="$error-warning"/>
                <xsl:with-param name="row-num" select="$counter + 1"/> 
              </xsl:call-template> 
           </xsl:when>
           <xsl:otherwise>            
              <xsl:value-of select="@Description"/> 
           </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$cr"/>       
      </xsl:when>  
    </xsl:choose>      
  </xsl:for-each>  
</xsl:template>




<!--It prints the description from each error & warning -->
<xsl:template name="detail-helper">
  <xsl:param name="first-number"/>
  <xsl:param name="svp-section"/> 
  <xsl:param name="els-flag"/> 
  <!--print title only if matching number exists-->
  <xsl:variable name="print-title"> 
    <xsl:call-template name="count-data">
      <xsl:with-param name="first-number" select="$first-number"/> 
      <xsl:with-param name="node"         select="Errors/Item"/>
      <xsl:with-param name="els-flag"     select="$els-flag"/>
    </xsl:call-template>
    <xsl:call-template name="count-data">
      <xsl:with-param name="first-number" select="$first-number"/> 
      <xsl:with-param name="node"         select="Warnings/Item"/>
      <xsl:with-param name="els-flag"     select="$els-flag"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:if test="string-length($print-title) &gt; 0">
    <xsl:value-of select="$title1"/>
    <xsl:value-of select="$svp-section"/>
    <xsl:value-of select="$title2"/>
    <xsl:value-of select="concat($cr,$cr)"/>
  </xsl:if>
  <xsl:if test="string-length($print-title) &gt; 0">
  	 <xsl:call-template name="print-detail">
      <xsl:with-param name="node"          select="Errors/Item"/>
      <xsl:with-param name="first-number"  select="$first-number"/>
      <xsl:with-param name="els-flag"      select="$els-flag"/>
      <xsl:with-param name="error-warning" select="'error'"/>
    </xsl:call-template>
    <xsl:value-of select="$cr"/>
    <xsl:call-template name="print-detail">
      <xsl:with-param name="node"          select="Warnings/Item"/>
      <xsl:with-param name="first-number"  select="$first-number"/>
      <xsl:with-param name="els-flag"      select="$els-flag"/>
      <xsl:with-param name="error-warning" select="'warning'"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>



<!--added 07/01/09 -->
<!--It prints the description from unit (only) error & warning -->
<xsl:template name="unit-error-list-helper">
  <xsl:param name="first-number"/>
  <xsl:param name="svp-section"/> 
  <!--print title only if matching number exists-->
  <xsl:variable name="print-title"> 
    <xsl:call-template name="count-data">
      <xsl:with-param name="first-number" select="$first-number"/> 
      <xsl:with-param name="node"         select="Errors/Item"/>
    </xsl:call-template>
    <xsl:call-template name="count-data">
      <xsl:with-param name="first-number" select="$first-number"/> 
      <xsl:with-param name="node"         select="Warnings/Item"/>
    </xsl:call-template>
  </xsl:variable>
  <xsl:if test="string-length($print-title) &gt; 0">
    <xsl:value-of select="$title1"/>
    <xsl:value-of select="$svp-section"/>
    <xsl:value-of select="$title2"/>
    <xsl:value-of select="concat($cr,$cr)"/>
  </xsl:if>
  <xsl:if test="string-length($print-title) &gt; 0">
  	 <xsl:call-template name="unit-print-detail">
      <xsl:with-param name="node"          select="Errors/Item"/>
      <xsl:with-param name="first-number"  select="$first-number"/>
      <xsl:with-param name="error-warning" select="'error'"/>
    </xsl:call-template>
    <xsl:value-of select="$cr"/>
    <xsl:call-template name="unit-print-detail">
      <xsl:with-param name="node"          select="Warnings/Item"/>
      <xsl:with-param name="first-number"  select="$first-number"/>
      <xsl:with-param name="error-warning" select="'warning'"/>
    </xsl:call-template>
  </xsl:if>
</xsl:template>



<!--helps to separate a description line-->
<xsl:template name="line-helper">
  <xsl:param name="line"/>
  <xsl:param name="line-number"/>  
  <xsl:param name="error-warning"/>
  <xsl:param name="row-num"/> 
  <xsl:choose>
     <xsl:when test="number($line-number) = 1">   
       <!--it comes here only once-->    
       <xsl:if test="string-length($line) &gt; $line_length">
         <xsl:variable name="print-line-pos">
           <xsl:call-template name="new-line-helper">
             <xsl:with-param name="line" select="substring($line, 1, $line_length)"/>         
           </xsl:call-template>
         </xsl:variable>   
         <xsl:value-of select="substring($line,1,$print-line-pos)"/>
         <xsl:value-of select="$cr"/>
         <xsl:call-template name="line-helper">      
           <xsl:with-param name="line" select="substring($line,$print-line-pos+1,string-length($line))"/>  
           <xsl:with-param name="error-warning" select="$error-warning"/>  
           <xsl:with-param name="row-num"       select="$row-num + 1"/>             
         </xsl:call-template>
       </xsl:if>               
     </xsl:when>     
     <xsl:otherwise>
     <!--the second line or more-->
       <xsl:if test="$error-warning = 'warning' and string-length(@Number) = 4">
         <xsl:text>   </xsl:text> 
       </xsl:if> 
       <xsl:if test="$error-warning = 'warning' and string-length(@Number) = 3">
         <xsl:text>  </xsl:text> 
       </xsl:if> 
       <xsl:text>           </xsl:text>      
       <xsl:choose>
          <xsl:when test="string-length($line) &gt; 52">
            <xsl:variable name="print-line-pos">
              <xsl:call-template name="new-line-helper">
                <xsl:with-param name="line" select="substring($line, 1, 52)"/>         
              </xsl:call-template>
            </xsl:variable>           
            <xsl:value-of select="substring($line,1,$print-line-pos)"/>
            <xsl:value-of select="$cr"/>
            <xsl:call-template name="line-helper">      
               <xsl:with-param name="line" select="substring($line,$print-line-pos+1,string-length($line))"/>              
               <xsl:with-param name="error-warning" select="$error-warning"/> 
               <xsl:with-param name="row-num"       select="$row-num + 1"/>                 
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$line"/>
          </xsl:otherwise>
       </xsl:choose>
     </xsl:otherwise>
  </xsl:choose>
</xsl:template>




<!--helps to find an appropriate position of the end line.
    it searchs through from the pos of the end line.
    if there is not space, search position goes backward
    until it finds a space which is cut the line position. -->
<xsl:template name="new-line-helper">
  <xsl:param name="line" />   
  <xsl:if test="string-length($line) != 0">
    <xsl:variable name="check-word">
      <xsl:value-of select="substring($line, string-length($line), string-length($line))"/>
    </xsl:variable>    
    <xsl:choose>
      <xsl:when test="$check-word = ' '">
        <xsl:value-of select="string-length($line)"/>
      </xsl:when>
      <xsl:otherwise>       
        <xsl:call-template name="new-line-helper">
          <xsl:with-param name="line" select="substring($line, 1, string-length($line)-1)"/>         
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:if>   
</xsl:template>



<!--count items by giving the first-number and els-flag-->
<xsl:template name="count-data">
  <xsl:param name="first-number"/>
  <xsl:param name="node"/>
  <xsl:param name="els-flag"/>
  <xsl:choose>
    <!--if ELS data & number is and 4 figures-->
    <xsl:when test="$els-flag = 'y'">
      <xsl:for-each select="$node">        
        <xsl:if test="string-length(@Number) = 4">
          <xsl:text>1</xsl:text>      
        </xsl:if>      
      </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>     
      <xsl:for-each select="$node">        
        <xsl:if test="starts-with(string(@Number), string($first-number))
                      and  string-length(@Number) = 3">
          <xsl:text>1</xsl:text>      
        </xsl:if>      
      </xsl:for-each>     
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>





<!--It counts the each section total by giving the number of 'first-number'-->
<xsl:template name="count-helper">
  <xsl:param name="first-number"/> 
  <xsl:param name="els-flag"/>
  <xsl:value-of select="$errors"/>

  <xsl:variable name="count-errors">   
    <xsl:call-template name="count-data">
      <xsl:with-param name="first-number" select="$first-number"/> 
      <xsl:with-param name="node"         select="Errors/Item"/>
      <xsl:with-param name="els-flag"     select="$els-flag"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:call-template name="alignment">
     <xsl:with-param name="count" select="string-length($count-errors)"/>
  </xsl:call-template>
  <xsl:choose>
    <xsl:when test="string-length($count-errors) = 0">
      <xsl:text>0</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="string-length($count-errors)"/>
    </xsl:otherwise>
  </xsl:choose>

 <xsl:value-of select="$warnings"/>
  <xsl:variable name="count-warnings">       
    <xsl:call-template name="count-data">
      <xsl:with-param name="first-number" select="$first-number"/> 
      <xsl:with-param name="node"         select="Warnings/Item"/>
      <xsl:with-param name="els-flag"     select="$els-flag"/>
    </xsl:call-template>       
  </xsl:variable>
  <xsl:call-template name="alignment">
     <xsl:with-param name="count" select="string-length($count-warnings)"/>
  </xsl:call-template>
  <xsl:choose>
    <xsl:when test="string-length($count-warnings) = 0">
      <xsl:text>0</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="string-length($count-warnings)"/>
    </xsl:otherwise>
  </xsl:choose>
  <!--xsl:call-template name="print-comment">
    <xsl:with-param name="first-number" select="$first-number"/>
  </xsl:call-template--> 
  <xsl:value-of select="$cr"/>   
</xsl:template>



<!--It counts total errors and warnings numbers-->
<xsl:template name="count-helper-total">
  <xsl:value-of select="$total-errors"/>                   
  <xsl:call-template name="alignment">
     <xsl:with-param name="count" select="count(Errors/Item)"/>
  </xsl:call-template>
  <xsl:value-of select="count(Errors/Item)"/>  
 <xsl:value-of select="$warnings"/>
  <xsl:call-template name="alignment">
     <xsl:with-param name="count" select="count(Warnings/Item)"/>
  </xsl:call-template>
  <xsl:value-of select="count(Warnings/Item)"/>  
</xsl:template>


<!--prints space and aligns number that will print--> 
<xsl:template name="alignment">
  <xsl:param name="count"/>
  <!--alignment-->
  <xsl:choose>
    <xsl:when test="string-length(string($count)) = 1">
      <xsl:text>     </xsl:text>
    </xsl:when>
    <xsl:when test="string-length(string($count)) = 2">
      <xsl:text>    </xsl:text>
    </xsl:when>
    <xsl:when test="string-length(string($count)) = 3">
      <xsl:text>   </xsl:text>
    </xsl:when>   
    <xsl:when test="string-length(string($count)) = 4">
      <xsl:text>  </xsl:text>
    </xsl:when>  
    <xsl:when test="string-length(string($count)) = 5">
      <xsl:text> </xsl:text>
    </xsl:when>   
  </xsl:choose>
</xsl:template>


<!--It prints '-'underline, the same lengh of unit's name-->
<xsl:template name="print-under-line">
  <xsl:param name="number"/>
  <xsl:if test="$number != 0">
    <xsl:text>-</xsl:text>   
    <xsl:call-template name="print-under-line">
      <xsl:with-param name="number" select="$number - 1"/>
    </xsl:call-template>
  </xsl:if> 
</xsl:template>

</xsl:stylesheet>
