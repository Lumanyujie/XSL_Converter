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
         <xsl:with-param name="target-string">&lt;p class='title'&gt;当前两栖作战行动汇总报告&lt;/p&gt;</xsl:with-param>
         <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
      </xsl:call-template>
      <xsl:for-each select="S1">
         <xsl:for-each select="G1/R">
            <xsl:for-each select="S1">
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
                  <xsl:with-param name="target-string">编队当前态势：前往装载。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S2">
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
                  <xsl:with-param name="target-string">编队当前态势：前往攻击。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S3">
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
                  <xsl:with-param name="target-string">编队当前态势：位于装载点。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S4">
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
                  <xsl:with-param name="target-string">编队当前态势：位于攻击点。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S5">
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
                  <xsl:with-param name="target-string">编队当前态势：无两栖作战行动。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S6">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">&lt;p class='table_name'&gt;编队舰艇和搭载部队明细&lt;/p&gt;</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="save-header">
                  <xsl:with-param name="header-string">舰艇名称|搭载部队|装载干货重量|装载液货体积</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:for-each select="G1/R">
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
                        <xsl:call-template name="unit_name_transform_FUN">
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
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="UOM_AMT_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:text>DRY_WEIGHT</xsl:text>
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
                              <xsl:text>DRY_WEIGHT</xsl:text>
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
                        <xsl:call-template name="UOM_AMT_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:text>WET_WEIGHT</xsl:text>
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
                              <xsl:text>WET_WEIGHT</xsl:text>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
               </xsl:for-each>
               <xsl:call-template name="stop-table"/>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S7">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">&lt;p class='table_name'&gt;编队可用运输工具明细&lt;/p&gt;</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">         已装载</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="save-header">
                  <xsl:with-param name="header-string">部队/舰艇|船艇类型|数量</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:for-each select="G1/R">
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
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string"/>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@C"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
               </xsl:for-each>
               <xsl:call-template name="stop-table"/>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S8">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">下列部队奉命执行当前作战任务：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="G1/R">
                  <xsl:for-each select="S1">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：准备攻击</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：准备装载</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：前往装载点, 距其</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_AMT_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>DISTANCE</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>DISTANCE</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S4">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：距装载点</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_AMT_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>DISTANCE</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>DISTANCE</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，且并未向装载点机动</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S5">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：攻击马上结束</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S6">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：攻击尚未开始</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S7">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：已开始攻击</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S8">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：装载马上完成</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S9">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：装载尚未开始,部队已到达装载点，准备装载</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S10">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：装载尚未开始，部队距装载点</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_AMT_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>DISTANCE</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>DISTANCE</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，正前往装载点</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S11">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：装载尚未开始，部队距装载点</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_AMT_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>DISTANCE</xsl:text>
                              </xsl:with-param>
                              <xsl:with-param name="arg2">
                                 <xsl:value-of select="D/@B"/>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:call-template name="UOM_FUN">
                              <xsl:with-param name="arg1">
                                 <xsl:text>DISTANCE</xsl:text>
                              </xsl:with-param>
                           </xsl:call-template>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">，尚未前往装载点</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S12">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：装载已开始</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S13">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：出现错误，请通知技术人员</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S9">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">大约还需要</xsl:with-param>
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
                  <xsl:with-param name="target-string">小时抵滩，预计到达时间：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
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
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S10">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">下列部队预期完成任务时间如下：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="G1/R">
                  <xsl:for-each select="S1">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">空中编队，出现错误，请告知技术人员在SIMU52.DAT文件中发现错误数据</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
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
                  </xsl:for-each>
                  <xsl:for-each select="S3">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">——</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">：没有拟制任务计划，出现错误，请告知技术人员</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
               </xsl:for-each>
            </xsl:for-each>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S2">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">当前没有两栖作战行动。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S3">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">备注：以上评估依据编队当前实力，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">行动结束前，实力损毁可能会使计划时间延长，而加强舰船力量可能会使计划时间缩短。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
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