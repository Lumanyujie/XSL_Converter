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
         <xsl:with-param name="target-string">&lt;p class='title'&gt;外部事件列表&lt;/p&gt;</xsl:with-param>
         <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
      </xsl:call-template>
      <xsl:for-each select="S1">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">没有需要报告的外部事件。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S2">
         <xsl:call-template name="save-header">
            <xsl:with-param name="header-string">序列号|时间|事件内容</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="process-br"/>
         <xsl:for-each select="G1/R">
            <xsl:for-each select="S1">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">调整目标</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">位置至</xsl:with-param>
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
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">到达时间：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@F"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S2">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">在</xsl:with-param>
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
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">创建新目标</xsl:with-param>
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
               <xsl:for-each select="S1">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">没有提供补给。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:for-each select="S4">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">在该目标处卸载下列补给：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:for-each select="G1/R">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">&lt;br&gt;——</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">，</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="get-vocab-value">
                                 <xsl:with-param name="vocab">SLP_Category_Name</xsl:with-param>
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../../D/@A"/>
                                 </xsl:with-param>
                                 <xsl:with-param name="arg2">
                                    <xsl:value-of select="D/@A"/>
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
                              <xsl:call-template name="SLP_SC_AMT_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../../D/@A"/>
                                 </xsl:with-param>
                                 <xsl:with-param name="arg2">
                                    <xsl:value-of select="D/@A"/>
                                 </xsl:with-param>
                                 <xsl:with-param name="arg3">
                                    <xsl:value-of select="D/@B"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:call-template name="SLP_SC_UOM_FUN">
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../../D/@A"/>
                                 </xsl:with-param>
                                 <xsl:with-param name="arg2">
                                    <xsl:value-of select="D/@A"/>
                                 </xsl:with-param>
                              </xsl:call-template>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:for-each select="S5">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">没有卸载的补给。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S3">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">区域报告，接收集团：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
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
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">该区域由以下坐标点围成：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="G1/R">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">&lt;br&gt;——</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="LOCATION_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:value-of select="D/@B"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">&lt;br&gt;该事件基本发现概率：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">对部队</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@D"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">对目标</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@E"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">对空</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@F"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">&lt;br&gt;情报平均延迟时间：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="DURATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@G"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>%.2Tm</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">分钟。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">&lt;br&gt;该事件一次性发生，其来源为</xsl:with-param>
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
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">&lt;br&gt;该事件每</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="DURATION_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:text>%.2Th</xsl:text>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">小时发生一次，其来源为</xsl:with-param>
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
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S3">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">&lt;br&gt;该事件将持续发生直至被取消。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S4">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">&lt;br&gt;下一个事件为最后事件。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S5">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">&lt;br&gt;该事件将持续到</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="GTIME_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">为止。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S6">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">&lt;br&gt;此为超视距传感器区域报告。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S4">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">部队报告，接收集团：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">部队列表：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="G1/R">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">&lt;br&gt;——</xsl:with-param>
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
               </xsl:for-each>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S5">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">装备设施报告：接收集团：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">装备设施列表：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="G1/R">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">&lt;br&gt;——</xsl:with-param>
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
               </xsl:for-each>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S6">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">改变目标</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">的效能，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">新效能比率：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@D"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">原比率：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@E"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S8">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">毁伤</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">的</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">CSP_System_Name</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@G"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="D/@D"/>
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
                     <xsl:value-of select="D/@E"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">台（套、个），</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">原因：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@F"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S9">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">毁伤</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">补给：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">SLP_Category_Name</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@G"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="D/@D"/>
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
                     <xsl:call-template name="UOM_AMT_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>DRY_WEIGHT</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">吨，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">原因：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@F"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S10">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">武器毁伤评估，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">发射方：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">No_Force_Side</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@C"/>
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
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Targetable_Weapon</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@D"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">枚（发），</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">覆盖半径</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@F"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">米，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">打击位置：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="LOCATION_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:value-of select="D/@B"/>
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
                     <xsl:with-param name="target-string">打击部队：</xsl:with-param>
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
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S3">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">打击目标：</xsl:with-param>
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
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S11">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">创建雷场，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">-</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@D"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">枚，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">布设位置：</xsl:with-param>
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
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S12">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">改变</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">战斗力，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">新战斗力比率：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@D"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">%，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">其所属部队随之改变，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">其所属部队不改变，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S3">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">其所属目标随之改变，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S4">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">其所属目标不改变，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:for-each select="S5">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">变化原因是：</xsl:with-param>
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
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S13">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">卫星过境侦察，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">设备名：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">覆盖带起点：</xsl:with-param>
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
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">覆盖带终点：</xsl:with-param>
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
                  <xsl:with-param name="target-string">传感器：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Sensor_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@I"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">每次过境最大搜索区数量：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@J"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">最小指定搜索区完成任务时间：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="DURATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@H"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>%d天%h小时%Rm分钟</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">过境周期：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="DURATION_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:text>%d天%h小时%Rm分钟</xsl:text>
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
                     <xsl:with-param name="target-string">过境仅一次。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
               <xsl:call-template name="process-br"/>
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