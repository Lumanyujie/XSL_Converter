<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
   <xsl:import href="../../../mes-util.xsl"/>
   <xsl:output method="text"/>
   <xsl:variable name="NL" select="$cr"/>
   <xsl:template match="/M">
      <xsl:call-template name="set-table-status">
         <xsl:with-param name="status" select="'0'"/>
      </xsl:call-template>
      <xsl:call-template name="set-table-header">
         <xsl:with-param name="head" select="''"/>
      </xsl:call-template>
      <xsl:call-template name="set-caption">
         <xsl:with-param name="caption" select="''"/>
      </xsl:call-template>&lt;html&gt;&lt;body&gt;<xsl:call-template name="render-header"/>
      <xsl:call-template name="render-body"/>
      <xsl:call-template name="render-footer"/>&lt;/body&gt;&lt;/html&gt;</xsl:template>
   <xsl:template name="render-body">
      <xsl:call-template name="parse-col">
         <xsl:with-param name="target-string">&lt;p class='title'&gt;敏感目标区情报汇总&lt;/p&gt;</xsl:with-param>
         <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="process-br"/>
      <xsl:call-template name="parse-col">
         <xsl:with-param name="target-string">情报汇总时间：</xsl:with-param>
         <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="display_cur_text">
         <xsl:with-param name="in_string">
            <xsl:call-template name="GTIME_FUN">
               <xsl:with-param name="arg1">
                  <xsl:value-of select="/M/D/@D"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="parse-col">
         <xsl:with-param name="target-string">。</xsl:with-param>
         <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
      </xsl:call-template>
      <xsl:for-each select="S50">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">初次观测。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S51">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">无重大变化可报。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S52">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">重要情报如下：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="G1/R">
            <xsl:for-each select="S1">
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">——</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">首次发现。可用：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">维护：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@C"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S24">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">——</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">首次发现。可用：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">维护：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@C"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S81">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">——</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">型舰艇</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">首次发现。数量：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">艘。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S83">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">——</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">首次发现。可用：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">维护：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@C"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S84">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">——</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">首次发现。数量：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S2">
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">——</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="S1">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">可用数：少于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">可用数：多于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">维护数：少于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S4">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">维护数：多于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S24">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">——</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="S1">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">可用数：少于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">可用数：多于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">维护数：少于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S4">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">维护数：多于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S81">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">——</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">型舰艇</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="S1">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">在航：少于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">艘。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">在航：多于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">艘。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">故障：少于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">艘。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S4">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">故障：多于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">艘。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S83">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">——</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="S1">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">可用数：少于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">可用数：多于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">维护数：少于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S4">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">维护数：多于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S84">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">——</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="S1">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">在用数：少于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">在用数：多于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">不可用（毁伤）数：少于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S4">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">不可用（毁伤）数：多于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S1">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">搜索区名称：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="unit_name_transform_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@E"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">属方：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="unit_name_transform_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">坐标：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="LOCATION_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@H"/>
                  </xsl:with-param>
                  <xsl:with-param name="arg2">
                     <xsl:value-of select="/M/D/@I"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">敏感目标区名称：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="/M/D/@J"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">敏感目标区描述：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="/M/D/@K"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="G1/R">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">序号：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">部队名称：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@H"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">部队类型：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="get-vocab-value">
                     <xsl:with-param name="vocab">JMCIS_Unit_Type</xsl:with-param>
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">敏感目标编码：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@G"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">日期：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="GTIME_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@D"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:text>%Y%m%d</xsl:text>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">，时间：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="GTIME_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@D"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:text>%小时%分钟</xsl:text>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:for-each select="S1">
               <xsl:for-each select="G1/R">
                  <xsl:for-each select="S1">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="../D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，类型：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">CSP_System_Name</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@C"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../../../../D/@E"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../../../../D/@F"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="../D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，类型：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">Combat_System</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../../../../D/@E"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../../../../D/@F"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="../D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，机型：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">Aircraft_Type</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../../../../D/@E"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../../../../D/@F"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">部队属</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Graphics_Symbol</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序列，处于</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Unit_Posture</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">态势。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="S1">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">舰艇</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">Riding_Low_State</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">舰艇</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">Listing_Direction</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">舰艇</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">Listing_Position</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S4">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">舰艇</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">Fire_Type_State</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S5">
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">Fire_Size_State</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S6">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">观察舰艇周边</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">Oil_Slick_State</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S7">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">浮油位于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">Oil_Slick_Location</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S2">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">1号通用装备位于</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@F"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S3">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个火控雷达，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@F"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个毁伤；</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@E"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个发射架，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@G"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个毁伤。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">该阵地尚具备作战能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">发射架预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">火控雷达预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S4">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路，尚有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%可用。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">桥梁预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S5">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路，尚有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%可用。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">隧道预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S6">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S7">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注: 总长度</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="UOM_AMT_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>AIRDISTANCE</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="UOM_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>AIRDISTANCE</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">可用长度</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="UOM_AMT_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>AIRDISTANCE</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="UOM_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>AIRDISTANCE</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@E"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">处断裂处。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">断点预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S8">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：尚具备运力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S9">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：多个补给站与存储点损坏。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">恢复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体恢复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S10">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：总计</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个发射架，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@D"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个毁伤。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S11">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S12">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注: 总计</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个掩体，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@D"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个毁伤。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S13">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注: 总计</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个装卸载区，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@D"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个毁伤。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S14">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注: 经统计总计约</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">枚地（水）雷。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S15">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S16">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S17">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S18">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S19">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S20">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S21">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S22">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S23">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">序号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，描述：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="REPLACE_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>.</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg3">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg4">
                           <xsl:text>-</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg5">
                           <xsl:text>_</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S31">
               <xsl:for-each select="G1/R">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">序号：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，描述：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="REPLACE_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@B"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:text>.</xsl:text>
                           </xsl:with-param>
                           <xsl:with-param name="arg3">
                              <xsl:text>_</xsl:text>
                           </xsl:with-param>
                           <xsl:with-param name="arg4">
                              <xsl:text>-</xsl:text>
                           </xsl:with-param>
                           <xsl:with-param name="arg5">
                              <xsl:text>_</xsl:text>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="LOCATION_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="../../../D/@D"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:value-of select="../../../D/@E"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">备注: </xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@C"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S34">
               <xsl:for-each select="G1/R">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="S1">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">向目标定位点</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="../D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">的打击，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">毁伤</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="unit_name_transform_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">向目标定位点</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="../D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">的打击使作战行动受到影响。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S35">
               <xsl:for-each select="G1/R">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">部队名称：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@G"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">部队类型：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="get-vocab-value">
                           <xsl:with-param name="vocab">JMCIS_Unit_Type</xsl:with-param>
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">敏感目标编码：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@F"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">日期：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="GTIME_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="/M/D/@D"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:text>%Y%m%d</xsl:text>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，时间：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="GTIME_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="/M/D/@D"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:text>%小时%分钟</xsl:text>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:for-each select="S1">
                     <xsl:for-each select="G1/R">
                        <xsl:for-each select="S1">
                           <xsl:call-template name="process-br"/>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">序号：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:value-of select="../D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">，类型：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">CSP_System_Name</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../D/@C"/>
                                    </xsl:with-param>
                                    <xsl:with-param name="arg2">
                                       <xsl:value-of select="../D/@B"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="LOCATION_FUN">
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../../../../D/@D"/>
                                    </xsl:with-param>
                                    <xsl:with-param name="arg2">
                                       <xsl:value-of select="../../../../D/@E"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S2">
                           <xsl:call-template name="process-br"/>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">序号：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:value-of select="../D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">，类型：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Combat_System</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../D/@B"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="LOCATION_FUN">
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../../../../D/@D"/>
                                    </xsl:with-param>
                                    <xsl:with-param name="arg2">
                                       <xsl:value-of select="../../../../D/@E"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S3">
                           <xsl:call-template name="process-br"/>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">序号：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:value-of select="../D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">，机型：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Aircraft_Type</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../D/@B"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="LOCATION_FUN">
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../../../../D/@D"/>
                                    </xsl:with-param>
                                    <xsl:with-param name="arg2">
                                       <xsl:value-of select="../../../../D/@E"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">部队属</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">Graphics_Symbol</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序列，处于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">Unit_Posture</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@C"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">态势。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="S1">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">舰艇</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Riding_Low_State</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="D/@A"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S2">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">舰艇</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Listing_Direction</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="D/@A"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S3">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">舰艇</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Listing_Position</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="D/@A"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S4">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">舰艇</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Fire_Type_State</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="D/@A"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S5">
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Fire_Size_State</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="D/@A"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S6">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">观察舰艇周边</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Oil_Slick_State</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="D/@A"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S7">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">浮油位于</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Oil_Slick_Location</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="D/@A"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">1号通用装备位于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个火控雷达，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@F"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个毁伤；</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个发射架，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@G"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">该阵地尚具备作战能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">发射架预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S2">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">火控雷达预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S4">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">条通路，尚有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%可用。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">桥梁预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S5">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">条通路，尚有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%可用。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">隧道预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S6">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S7">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注: 总长度</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_AMT_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@C"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">可用长度</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_AMT_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@D"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">处断裂处。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">断点预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S8">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：尚具备运力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S9">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：多个补给站与存储点损坏。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S10">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个发射架，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S11">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S12">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个掩体，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S13">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个装卸载区，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S14">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：经统计总计约</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">枚地（水）雷。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S15">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S16">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S17">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S18">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S19">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S20">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S21">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S22">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S23">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S31">
                     <xsl:for-each select="G1/R">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">序号：</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">，描述：</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="REPLACE_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="D/@B"/>
                                 </xsl:with-param>
                                 <xsl:with-param name="arg2">
                                    <xsl:text>.</xsl:text>
                                 </xsl:with-param>
                                 <xsl:with-param name="arg3">
                                    <xsl:text>_</xsl:text>
                                 </xsl:with-param>
                                 <xsl:with-param name="arg4">
                                    <xsl:text>-</xsl:text>
                                 </xsl:with-param>
                                 <xsl:with-param name="arg5">
                                    <xsl:text>_</xsl:text>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="LOCATION_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../../../D/@D"/>
                                 </xsl:with-param>
                                 <xsl:with-param name="arg2">
                                    <xsl:value-of select="../../../D/@E"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">备注: </xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:value-of select="D/@C"/>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S34">
                     <xsl:for-each select="G1/R">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="S1">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">向目标定位点</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:value-of select="../D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">的打击，</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">毁伤</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="unit_name_transform_FUN">
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../D/@B"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S2">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">向目标定位点</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:value-of select="../D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">的打击使作战行动受到影响。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S36">
               <xsl:for-each select="G1/R">
                  <xsl:for-each select="S1">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">机型：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="unit_name_transform_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，数量：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="../D/@Q"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@F"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，当前状态：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">IIR_Status_Code</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@J"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">后续状态：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">IIR_Status_Code</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@K"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，变化状态：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">IIR_Change_Code</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@L"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="unit_name_transform_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@Q"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="../D/@O"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">架在陆地。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S32">
                     <xsl:for-each select="G1/R">
                        <xsl:for-each select="S1">
                           <xsl:call-template name="process-br"/>
                        </xsl:for-each>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S33">
                     <xsl:call-template name="process-br"/>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S38">
               <xsl:for-each select="G1/R">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">名称：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="REPLACE_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@B"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:text>.</xsl:text>
                           </xsl:with-param>
                           <xsl:with-param name="arg3">
                              <xsl:text>_</xsl:text>
                           </xsl:with-param>
                           <xsl:with-param name="arg4">
                              <xsl:text>-</xsl:text>
                           </xsl:with-param>
                           <xsl:with-param name="arg5">
                              <xsl:text>_</xsl:text>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">敏感目标标识：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@Q"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">唯一识别编码：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@C"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">类别代码：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@P"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">国家：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@D"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">坐标：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="LOCATION_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@E"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:value-of select="D/@F"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">长度：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@G"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">宽度：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@H"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">方位：0，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">海拔：0米。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地总计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">部火控雷达，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@F"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">部遭毁伤；</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">总计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个发射架，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@G"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个遭毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">发射架预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S2">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">火控雷达预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S4">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：总计</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">条通路，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">尚具备通行能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">桥梁预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S5">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：总计</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">条通路，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">尚具备通行能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">桥梁预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S6">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S7">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注: 总长度</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_AMT_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@C"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">可用长度</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_AMT_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@D"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">处断裂处。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S8">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：尚具备运力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">恢复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体恢复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有恢复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S9">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：多个补给站与存储点损坏。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">恢复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体恢复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有恢复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S10">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：总计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个发射架，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个遭毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S11">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S12">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：总计</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">处掩体，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">处遭毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S13">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：总计</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个装卸载区，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个遭毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S14">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注: 经统计总计约</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">枚地（水）雷。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S15">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S16">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S17">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S18">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S19">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S20">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S21">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S22">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S23">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S34">
                     <xsl:for-each select="G1/R">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="S1">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">向目标定位点</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:value-of select="../D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">的打击，</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">毁伤</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="unit_name_transform_FUN">
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../D/@B"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S2">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">向目标定位点</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:value-of select="../D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">的打击使作战行动受到影响。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S39">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">不再现目标列表：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="G1/R">
                  <xsl:for-each select="S1">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">部队类型：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">JMCIS_Unit_Type</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">敏感目标编码：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@F"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">日期：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="GTIME_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="/M/D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>%Y%m%d</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，时间：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="GTIME_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="/M/D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>%H%MZ</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@E"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>%-2.2D%-2.2M%N%-3.3d%-2.2m%E</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">，编队机型：</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="get-vocab-value">
                                 <xsl:with-param name="vocab">Aircraft_Type</xsl:with-param>
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">部队类型：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">JMCIS_Unit_Type</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">敏感目标编码：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@F"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">日期：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="GTIME_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="/M/D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>%Y%m%d</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，时间：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="GTIME_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="/M/D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>%H%MZ</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@E"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>%-2.2D%-2.2M%N%-3.3d%-2.2m%E</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">目标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="unit_name_transform_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">类型：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="unit_name_transform_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">隶属集团：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@E"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>%-2.2D%-2.2M%N%-3.3d%-2.2m%E</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S2">
         <xsl:for-each select="G1/R">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">——编号：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@B"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">名称：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="REPLACE_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@C"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:text>.</xsl:text>
                     </xsl:with-param>
                     <xsl:with-param name="arg3">
                        <xsl:text>_</xsl:text>
                     </xsl:with-param>
                     <xsl:with-param name="arg4">
                        <xsl:text>-</xsl:text>
                     </xsl:with-param>
                     <xsl:with-param name="arg5">
                        <xsl:text>_</xsl:text>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">敏感目标标识：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@R"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">唯一识别编码：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@D"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">类别代码：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@Q"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">国家：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@E"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">坐标：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="LOCATION_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@F"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="D/@G"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">长度：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@H"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">宽度：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@I"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">方位：0，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">海拔：0米。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:for-each select="S3">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地总计有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">部火控雷达，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@F"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">部遭毁伤；</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">总计有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@E"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个发射架，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@G"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个遭毁伤。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">发射架预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">火控雷达预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S4">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：总计</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">尚具备通行能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S5">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：总计</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">尚具备通行能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S6">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S7">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注: 总长度</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="UOM_AMT_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>AIRDISTANCE</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="UOM_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>AIRDISTANCE</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">可用长度</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="UOM_AMT_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>AIRDISTANCE</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="UOM_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>AIRDISTANCE</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@E"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">处断裂处。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S8">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：尚具备运力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">恢复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体恢复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有恢复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S9">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：多个补给站与存储点损坏。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">恢复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主要恢复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有恢复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S10">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：总计有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个发射架，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@D"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个遭毁伤。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S11">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备运力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S12">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：总计</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">处掩体，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@D"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">处遭毁伤。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S13">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注: 总计</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个装卸载区，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@D"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个毁伤。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S14">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注: 经统计总计约</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">枚地（水）雷。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S15">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">  备注: 阵地百分之</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">可用</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S16">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S17">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S18">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S19">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S20">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S21">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">飞机预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S22">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">交通工具预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S23">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@H"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">修复。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="GTIME_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S34">
               <xsl:for-each select="G1/R">
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="S1">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">向目标定位点</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="../D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">的打击，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">毁伤</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="unit_name_transform_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">向目标定位点</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="../D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">的打击使作战行动受到影响。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S35">
               <xsl:for-each select="G1/R">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">部队名称：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@G"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">部队类型：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="get-vocab-value">
                           <xsl:with-param name="vocab">JMCIS_Unit_Type</xsl:with-param>
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">敏感目标编码：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@F"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">日期：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="GTIME_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="/M/D/@D"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:text>%Y%m%d</xsl:text>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，时间：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="GTIME_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="/M/D/@D"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:text>%小时%分钟</xsl:text>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:for-each select="S1">
                     <xsl:for-each select="G1/R">
                        <xsl:for-each select="S1">
                           <xsl:call-template name="process-br"/>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">序号：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:value-of select="../D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">，类型：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">CSP_System_Name</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../D/@C"/>
                                    </xsl:with-param>
                                    <xsl:with-param name="arg2">
                                       <xsl:value-of select="../D/@B"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="LOCATION_FUN">
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../../../../D/@D"/>
                                    </xsl:with-param>
                                    <xsl:with-param name="arg2">
                                       <xsl:value-of select="../../../../D/@E"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S2">
                           <xsl:call-template name="process-br"/>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">序号：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:value-of select="../D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">，类型：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Combat_System</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../D/@B"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="LOCATION_FUN">
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../../../../D/@D"/>
                                    </xsl:with-param>
                                    <xsl:with-param name="arg2">
                                       <xsl:value-of select="../../../../D/@E"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S3">
                           <xsl:call-template name="process-br"/>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">序号：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:value-of select="../D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">，机型：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Aircraft_Type</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../D/@B"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="LOCATION_FUN">
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../../../../D/@D"/>
                                    </xsl:with-param>
                                    <xsl:with-param name="arg2">
                                       <xsl:value-of select="../../../../D/@E"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">部队属</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">Graphics_Symbol</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序列，处于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">Unit_Posture</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@C"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">态势。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="S1">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">舰艇</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Riding_Low_State</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="D/@A"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S2">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">舰艇</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Listing_Direction</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="D/@A"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S3">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">舰艇</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Listing_Position</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="D/@A"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S4">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">舰艇</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Fire_Type_State</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="D/@A"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S5">
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Fire_Size_State</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="D/@A"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S6">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">观察舰艇周边</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Oil_Slick_State</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="D/@A"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S7">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">浮油位于</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="get-vocab-value">
                                    <xsl:with-param name="vocab">Oil_Slick_Location</xsl:with-param>
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="D/@A"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">1号通用装备位于</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个火控雷达，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@F"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个毁伤；</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个发射架，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@G"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">该阵地尚具备作战能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">发射架预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S2">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">火控雷达预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S4">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">条通路，尚有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%可用。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">桥梁预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S5">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">条通路，尚有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%可用。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">隧道预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S6">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S7">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注: 总长度</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_AMT_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@C"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">可用长度</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_AMT_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@D"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">处断裂处。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">断点预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S8">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：尚具备运力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S9">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：多个补给站与存储点损坏。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S10">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个发射架，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S11">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S12">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个掩体，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S13">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：共计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个装卸载区，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S14">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：经统计总计约</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">枚地（水）雷。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S15">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S16">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S17">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S18">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S19">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S20">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S21">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S22">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S23">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">序号：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，描述：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="REPLACE_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>.</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg4">
                                 <xsl:text>-</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg5">
                                 <xsl:text>_</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复作业预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S31">
                     <xsl:for-each select="G1/R">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">序号：</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">，描述：</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="REPLACE_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="D/@B"/>
                                 </xsl:with-param>
                                 <xsl:with-param name="arg2">
                                    <xsl:text>.</xsl:text>
                                 </xsl:with-param>
                                 <xsl:with-param name="arg3">
                                    <xsl:text>_</xsl:text>
                                 </xsl:with-param>
                                 <xsl:with-param name="arg4">
                                    <xsl:text>-</xsl:text>
                                 </xsl:with-param>
                                 <xsl:with-param name="arg5">
                                    <xsl:text>_</xsl:text>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="LOCATION_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../../../D/@D"/>
                                 </xsl:with-param>
                                 <xsl:with-param name="arg2">
                                    <xsl:value-of select="../../../D/@E"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">备注: </xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:value-of select="D/@C"/>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S34">
                     <xsl:for-each select="G1/R">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="S1">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">向目标定位点</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:value-of select="../D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">的打击，</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">毁伤</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="unit_name_transform_FUN">
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../D/@B"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S2">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">向目标定位点</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:value-of select="../D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">的打击使作战行动受到影响。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S36">
               <xsl:for-each select="G1/R">
                  <xsl:for-each select="S1">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">机型：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="unit_name_transform_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，数量：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="../D/@Q"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@E"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="../D/@F"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，当前状态：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">IIR_Status_Code</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@J"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">后续状态：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">IIR_Status_Code</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@K"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，变化状态：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">IIR_Change_Code</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@L"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="unit_name_transform_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="../D/@Q"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="../D/@O"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">架在陆地。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S32">
                     <xsl:for-each select="G1/R">
                        <xsl:for-each select="S1">
                           <xsl:call-template name="process-br"/>
                        </xsl:for-each>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S33">
                     <xsl:call-template name="process-br"/>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S38">
               <xsl:for-each select="G1/R">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">名称：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="REPLACE_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@B"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:text>.</xsl:text>
                           </xsl:with-param>
                           <xsl:with-param name="arg3">
                              <xsl:text>_</xsl:text>
                           </xsl:with-param>
                           <xsl:with-param name="arg4">
                              <xsl:text>-</xsl:text>
                           </xsl:with-param>
                           <xsl:with-param name="arg5">
                              <xsl:text>_</xsl:text>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">敏感目标标识：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@Q"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">唯一识别编码：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@C"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">类别代码：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@P"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">国家：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@D"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">坐标：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="LOCATION_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@E"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:value-of select="D/@F"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">长度：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@G"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">宽度：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@H"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">方位：0，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">海拔：0米。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地总计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">部火控雷达，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@F"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">部遭毁伤；</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">总计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个发射架，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@G"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个遭毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">发射架预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S2">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">火控雷达预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S4">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：总计</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">条通路，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">尚具备通行能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">桥梁预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S5">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：总计</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">条通路，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">尚具备通行能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">桥梁预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S6">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S7">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注: 总长度</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_AMT_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@C"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">可用长度</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_AMT_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@D"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>AIRDISTANCE</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">处断裂处。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S8">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：尚具备运力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">恢复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体恢复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有恢复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S9">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：多个补给站与存储点损坏。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">恢复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体恢复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有恢复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S10">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：总计有</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个发射架，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个遭毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S11">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S12">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：总计</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">处掩体，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">处遭毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S13">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：总计</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个装卸载区，其中</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">个遭毁伤。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S14">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注: 经统计总计约</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">枚地（水）雷。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S15">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S16">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S17">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S18">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S19">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S20">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S21">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S22">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S23">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">备注：阵地尚具备能力</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">%。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:for-each select="G1/R">
                           <xsl:for-each select="S1">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">修复。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                           <xsl:for-each select="S3">
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">主体修复工作预计于</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="display_cur_text">
                                 <xsl:with-param name="in_string">
                                    <xsl:call-template name="GTIME_FUN">
                                       <xsl:with-param name="arg1">
                                          <xsl:value-of select="../D/@A"/>
                                       </xsl:with-param>
                                    </xsl:call-template>
                                 </xsl:with-param>
                              </xsl:call-template>
                              <xsl:call-template name="parse-col">
                                 <xsl:with-param name="target-string">完成。</xsl:with-param>
                                 <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                              </xsl:call-template>
                           </xsl:for-each>
                        </xsl:for-each>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="process-br"/>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">没有修复记录。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S34">
                     <xsl:for-each select="G1/R">
                        <xsl:call-template name="process-br"/>
                        <xsl:for-each select="S1">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">向目标定位点</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:value-of select="../D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">的打击，</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">毁伤</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:call-template name="unit_name_transform_FUN">
                                    <xsl:with-param name="arg1">
                                       <xsl:value-of select="../D/@B"/>
                                    </xsl:with-param>
                                 </xsl:call-template>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                        <xsl:for-each select="S2">
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">向目标定位点</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="display_cur_text">
                              <xsl:with-param name="in_string">
                                 <xsl:value-of select="../D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                           <xsl:call-template name="parse-col">
                              <xsl:with-param name="target-string">的打击使作战行动受到影响。</xsl:with-param>
                              <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                           </xsl:call-template>
                        </xsl:for-each>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S39">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">不再现目标列表：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="G1/R">
                  <xsl:for-each select="S1">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">部队类型：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">JMCIS_Unit_Type</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">敏感目标编码：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@F"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">日期：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="GTIME_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="/M/D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>%Y%m%d</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，时间：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="GTIME_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="/M/D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>%H%MZ</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@E"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>%-2.2D%-2.2M%N%-3.3d%-2.2m%E</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">，编队机型：</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="get-vocab-value">
                                 <xsl:with-param name="vocab">Aircraft_Type</xsl:with-param>
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">部队类型：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="get-vocab-value">
                              <xsl:with-param name="vocab">JMCIS_Unit_Type</xsl:with-param>
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">敏感目标编码：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@F"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">日期：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="GTIME_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="/M/D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>%Y%m%d</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，时间：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="GTIME_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="/M/D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:text>%H%MZ</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@E"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>%-2.2D%-2.2M%N%-3.3d%-2.2m%E</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">目标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="unit_name_transform_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@A"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">类型：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="unit_name_transform_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">隶属集团：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">坐标：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="LOCATION_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:value-of select="D/@D"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@E"/>
                              </xsl:with-param>
                              <xsl:with-param name="arg3">
                                 <xsl:text>%-2.2D%-2.2M%N%-3.3d%-2.2m%E</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S5">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">（陆上飞机编队情报）</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="G1/R">
            <xsl:for-each select="S1">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">——编号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">机型：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，数量：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@R"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@F"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@G"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，当前状态：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Status_Code</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@K"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">后续状态：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Status_Code</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@L"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，变化状态：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Status_Code</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@M"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S2">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@Q"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@O"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">架在陆地。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S32">
               <xsl:for-each select="G1/R">
                  <xsl:for-each select="S1"/>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S33"/>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S6">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">（作战系统残骸情报）</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="G1/R">
            <xsl:for-each select="S1">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">——编号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">残骸类型：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@F"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@G"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">当前状态：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Status_Code</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@K"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">后续状态：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Status_Code</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@L"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，变化状态：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Status_Code</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@M"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S2">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@Q"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@O"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">处在陆地。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S11">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">——编号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">残骸类型：浮油，坐标：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="LOCATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@C"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">发现时间：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，注释：既有浮油也有其它漂浮物。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S32">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">该地区防空设施：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="save-header">
                  <xsl:with-param name="header-string">类型|数量</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:for-each select="G1/R">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string"/>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="get-vocab-value">
                           <xsl:with-param name="vocab">ADA_Class</xsl:with-param>
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string"/>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
                  <xsl:for-each select="S1"/>
               </xsl:for-each>
               <xsl:call-template name="stop-table"/>
            </xsl:for-each>
            <xsl:for-each select="S33">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">该地区防空设施未知。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
         </xsl:for-each>
      </xsl:for-each>
   </xsl:template>
   <xsl:template name="display_cur_text">
      <xsl:param name="in_string"/>
      <xsl:variable name="table_status">
         <xsl:call-template name="get-table-status"/>
      </xsl:variable>
      <xsl:variable name="normalized-string" select="normalize-space($in_string)"/>
      <xsl:variable name="space-string">
         <xsl:call-template name="replace-func">
            <xsl:with-param name="str" select="$in_string"/>
            <xsl:with-param name="str-a" select="' '' '"/>
            <xsl:with-param name="str-b" select="'&amp;nbsp;'"/>
         </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$table_status=5">
         <xsl:variable name="header-temp">
            <xsl:call-template name="get-table-header"/>
         </xsl:variable>
         <xsl:call-template name="set-table-header">
            <xsl:with-param name="head">
               <xsl:value-of select="concat($header-temp,$in_string)"/>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:if>
      <xsl:if test="$table_status=6">
         <xsl:variable name="caption-temp">
            <xsl:call-template name="get-caption"/>
         </xsl:variable>
         <xsl:call-template name="set-caption">
            <xsl:with-param name="caption">
               <xsl:value-of select="concat($caption-temp,$in_string)"/>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:if>
      <xsl:if test="$table_status=0">
         <xsl:if test="starts-with($normalized-string,'|')=true()">
            <xsl:variable name="header">
               <xsl:call-template name="get-table-header"/>
            </xsl:variable>
            <xsl:variable name="caption">
               <xsl:call-template name="get-caption"/>
            </xsl:variable>
            <xsl:if test="string-length($header)!=0">
               <xsl:if test="string-length($caption)!=0">
                  <xsl:text>&lt;class ='qita'&gt;</xsl:text>
                  <xsl:value-of select="normalize-space($caption)"/>
                  <xsl:text>&lt;/p&gt;&lt;br/&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
                  <xsl:call-template name="set-caption">
                     <xsl:with-param name="caption" select="''"/>
                  </xsl:call-template>
               </xsl:if>
               <xsl:text>&lt;table border="1" cellspacing="0" cellpadding="1" width="97%" class='table_all'&gt;</xsl:text>
               <xsl:text>&lt;tr style="word-wrap:break-word"&gt;</xsl:text>
               <xsl:call-template name="display-headers">
                  <xsl:with-param name="header-string" select="$header"/>
               </xsl:call-template>
               <xsl:text>&lt;/tr&gt;</xsl:text>
               <xsl:text>&lt;tr style="word-wrap:break-word"&gt;</xsl:text>
               <xsl:text>&lt;td class='table_td'&gt;</xsl:text>
               <xsl:if test="string-length($header)&gt;1">
                  <xsl:value-of select="substring-after($normalized-string,'|')"/>
               </xsl:if>
               <xsl:call-template name="set-table-status">
                  <xsl:with-param name="status" select="3"/>
               </xsl:call-template>
            </xsl:if>
            <xsl:if test="string-length($header)=0">
               <xsl:value-of select="$space-string"/>
            </xsl:if>
         </xsl:if>
         <xsl:if test="starts-with($normalized-string,'|')=false()">
            <xsl:variable name="caption-temp">
               <xsl:call-template name="get-caption"/>
            </xsl:variable>
            <xsl:if test="string-length($caption-temp)!=0">
               <xsl:value-of select="$caption-temp"/>
               <xsl:text>&lt;br/&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
               <xsl:call-template name="set-caption">
                  <xsl:with-param name="caption" select="''"/>
               </xsl:call-template>
            </xsl:if>
            <xsl:value-of select="$space-string"/>
         </xsl:if>
      </xsl:if>
      <xsl:if test="$table_status=1">
         <xsl:choose>
            <xsl:when test="starts-with($normalized-string,'|')=true()">
               <text>&lt;tr&gt;</text>
               <text>&lt;td class='table_td'&gt;</text>
               <xsl:value-of select="substring-after($normalized-string,'|')"/>
               <xsl:call-template name="set-table-status">
                  <xsl:with-param name="status" select="3"/>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <text>&lt;/table&gt;</text>
               <xsl:call-template name="set-table-status">
                  <xsl:with-param name="status" select="0"/>
               </xsl:call-template>
               <xsl:variable name="caption-temp">
                  <xsl:call-template name="get-caption"/>
               </xsl:variable>
               <xsl:if test="string-length($caption-temp)!=0">
                  <xsl:value-of select="$caption-temp"/>
                  <xsl:call-template name="set-caption">
                     <xsl:with-param name="caption" select="''"/>
                  </xsl:call-template>
                  <xsl:text>&lt;br/&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
               </xsl:if>
               <xsl:value-of select="$space-string"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:if>
      <xsl:if test="$table_status=2">
         <xsl:text>&lt;td class='table_td'&gt;</xsl:text>
         <xsl:if test="starts-with($normalized-string,'|')">
            <xsl:value-of select="substring-after($normalized-string,'|')"/>
         </xsl:if>
         <xsl:if test="starts-with($normalized-string,'|')=false()">
            <xsl:value-of select="$normalized-string"/>
         </xsl:if>
         <xsl:call-template name="set-table-status">
            <xsl:with-param name="status" select="3"/>
         </xsl:call-template>
      </xsl:if>
      <xsl:if test="$table_status=3">
         <xsl:choose>
            <xsl:when test="starts-with($normalized-string,'|')=true()">
               <text>&lt;/td&gt;</text>
               <xsl:call-template name="set-table-status">
                  <xsl:with-param name="status" select="2"/>
               </xsl:call-template>
               <xsl:if test="string-length(substring-after($normalized-string,'|'))&gt;0">
                  <text>&lt;td class='table_td'&gt;</text>
                  <xsl:value-of select="substring-after($normalized-string,'|')"/>
                  <xsl:call-template name="set-table-status">
                     <xsl:with-param name="status" select="3"/>
                  </xsl:call-template>
               </xsl:if>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$normalized-string"/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:if>
   </xsl:template>
   <xsl:template name="display-headers">
      <xsl:param name="header-string"/>
      <xsl:variable name="first-string" select="substring-before($header-string,'|')"/>
      <xsl:if test="string-length($first-string)!=0">
         <xsl:text>&lt;th class='table_th'&gt;</xsl:text>
         <xsl:value-of select="normalize-space($first-string)"/>
         <xsl:text>&lt;/th&gt;</xsl:text>
         <xsl:call-template name="display-headers">
            <xsl:with-param name="header-string" select="substring-after($header-string,'|')"/>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>
   <xsl:template name="save-header">
      <xsl:param name="header-string"/>
      <xsl:call-template name="set-table-header">
         <xsl:with-param name="head" select="$header-string"/>
      </xsl:call-template>
      <xsl:call-template name="set-table-status">
         <xsl:with-param name="status" select="5"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="stop-table">
      <xsl:variable name="table-status">
         <xsl:call-template name="get-table-status"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="$table-status=3">
            <xsl:text>&lt;/td&gt;&lt;/tr&gt;&lt;/table&gt;</xsl:text>
         </xsl:when>
         <xsl:when test="$table-status=2">
            <xsl:text>&lt;/tr&gt;&lt;/table&gt;</xsl:text>
         </xsl:when>
         <xsl:when test="$table-status=1">
            <xsl:text>&lt;/table&gt;</xsl:text>
         </xsl:when>
      </xsl:choose>
      <xsl:call-template name="set-table-status">
         <xsl:with-param name="status" select="0"/>
      </xsl:call-template>
   </xsl:template>
   <xsl:template name="process-br">
      <xsl:variable name="table-status">
         <xsl:call-template name="get-table-status"/>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="$table-status=3">
            <xsl:text>&lt;/td&gt;&lt;/tr&gt;</xsl:text>
            <xsl:call-template name="set-table-status">
               <xsl:with-param name="status" select="1"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="$table-status=2">
            <xsl:text>&lt;/tr&gt;</xsl:text>
            <xsl:call-template name="set-table-status">
               <xsl:with-param name="status" select="1"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="$table-status=5">
            <xsl:variable name="header-temp">
               <xsl:call-template name="get-table-header"/>
            </xsl:variable>
            <xsl:call-template name="set-table-header">
               <xsl:with-param name="head">
                  <xsl:value-of select="concat($header-temp,'|')"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="set-table-status">
               <xsl:with-param name="status" select="0"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="$table-status=6">
            <xsl:call-template name="set-table-status">
               <xsl:with-param name="status" select="0"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="$table-status=0">
            <xsl:text>&lt;br/&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;</xsl:text>
         </xsl:when>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="replace-func">
      <xsl:param name="str"/>
      <xsl:param name="str-a"/>
      <xsl:param name="str-b"/>
      <xsl:choose>
         <xsl:when test="contains($str,$str-a)">
            <xsl:call-template name="replace-func">
               <xsl:with-param name="str"
                               select="concat(substring-before($str,$str-a),$str-b,substring-after($str,$str-a))"/>
               <xsl:with-param name="str-a" select="$str-a"/>
               <xsl:with-param name="str-b" select="$str-b"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$str"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <xsl:template name="parse-col">
      <xsl:param name="target-string"/>
      <xsl:param name="is-begin-with-slide" select="0"/>
      <xsl:choose>
         <xsl:when test="contains($target-string,'|')">
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:if test="$is-begin-with-slide=1">
                     <xsl:value-of select="concat('|',substring-before($target-string,'|'))"/>
                  </xsl:if>
                  <xsl:if test="$is-begin-with-slide=0">
                     <xsl:value-of select="substring-before($target-string,'|')"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string" select="substring-after($target-string,'|')"/>
               <xsl:with-param name="is-begin-with-slide" select="1"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:if test="$is-begin-with-slide=1">
                     <xsl:value-of select="concat('|',$target-string)"/>
                  </xsl:if>
                  <xsl:if test="$is-begin-with-slide=0">
                     <xsl:value-of select="$target-string"/>
                  </xsl:if>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
</xsl:stylesheet>