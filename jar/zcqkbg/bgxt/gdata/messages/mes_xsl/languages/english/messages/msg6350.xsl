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
         <xsl:with-param name="target-string">&lt;p class='title'&gt;</xsl:with-param>
         <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="display_cur_text">
         <xsl:with-param name="in_string">
            <xsl:call-template name="unit_name_transform_FUN">
               <xsl:with-param name="arg1">
                  <xsl:value-of select="/M/D/@B"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="parse-col">
         <xsl:with-param name="target-string">海运行动情况报告&lt;/p&gt;</xsl:with-param>
         <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
      </xsl:call-template>
      <xsl:for-each select="S1">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="unit_name_transform_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">无法在卸载地点使用装卸设施，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">此设施是海运和</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">所有海上补给行动必需的设备。该海运行动已取消。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S2">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="unit_name_transform_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">正运用隶属于</xsl:with-param>
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
            <xsl:with-param name="target-string">的物资装卸设备，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">将补给物资卸载给</xsl:with-param>
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
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">预计完成时间： </xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="GTIME_FUN">
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
      </xsl:for-each>
      <xsl:for-each select="S3">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="unit_name_transform_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">正在卸载补给给</xsl:with-param>
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
            <xsl:with-param name="target-string">预计完成时间：</xsl:with-param>
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
      <xsl:for-each select="S4">
         <xsl:for-each select="S1">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">正处于海运装载点。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:for-each select="S1">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">由于该编队现在没有液货补给物资装载能力，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">海运不能完成，因此海运行动中止。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S2">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">由于该编队现在没有干货补给物资装载能力，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">海运不能完成，因此海运行动中止。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
         </xsl:for-each>
         <xsl:for-each select="S2">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">正处于海运卸载点。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:for-each select="S1">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">由于该编队现在没有液货补给物资卸载能力，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">海运不能完成，因此海运行动中止。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S2">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">由于该编队现在没有干货补给物资卸载能力，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">海运不能完成，因此海运行动中止。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S5">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="unit_name_transform_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">正在海运装载点等待</xsl:with-param>
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
            <xsl:with-param name="target-string">该部队未到达此地且尚未机动，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">海运命令取消。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S6">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="unit_name_transform_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">正在海运装载点等待</xsl:with-param>
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
            <xsl:with-param name="target-string">该部队未到达此地且尚未机动，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">海运命令取消。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S7">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="unit_name_transform_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">在装载地域，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">无物资装卸设备可用，而这种设备是海运和</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">所有补给行动所必需的，因此海运行动中止。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S8">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="unit_name_transform_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">没有足够的输送能力来输送命令所要求的补给物资，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队的输送能力仅为所要求输送能力的</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@A"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">%。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">因此海运行动中止。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S9">
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
            <xsl:with-param name="target-string">没有足够补给物资来满足海运申请，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">该部仅有需求补给量的</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@B"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">%。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">而且既没有待收补给物资，也无法从其保障部队处得到足够补给物资，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">因此，海运行动中止。具体情况：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">&lt;p class='table_name'&gt;补给物资需求明细&lt;/p&gt;</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="process-br"/>
         <xsl:for-each select="G1/R">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">｜</xsl:with-param>
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
               <xsl:with-param name="target-string">｜</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="get-vocab-value">
                     <xsl:with-param name="vocab">SLP_Category_Name</xsl:with-param>
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../../D/@C"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">｜</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="SLP_SC_AMT_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../../D/@C"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg3">
                        <xsl:value-of select="D/@C"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">｜</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="SLP_SC_AMT_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../../D/@C"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg3">
                        <xsl:value-of select="D/@D"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="SLP_SC_UOM_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../../D/@C"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="process-br"/>
         </xsl:for-each>
         <xsl:call-template name="stop-table"/>
      </xsl:for-each>
      <xsl:for-each select="S10">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="unit_name_transform_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">已开始装载指定的海运补给。具体情况：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">&lt;p class='table_name'&gt;装载补给物资明细&lt;/p&gt;</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="process-br"/>
         <xsl:for-each select="G1/R">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">｜</xsl:with-param>
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
               <xsl:with-param name="target-string">｜</xsl:with-param>
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
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">｜</xsl:with-param>
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
                        <xsl:value-of select="D/@C"/>
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
            <xsl:call-template name="process-br"/>
         </xsl:for-each>
         <xsl:call-template name="stop-table"/>
         <xsl:for-each select="S1">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">装载将耗时</xsl:with-param>
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
               <xsl:with-param name="target-string">。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S11">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="unit_name_transform_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">在两栖行动地域无物资装卸设备可用，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">而这些设备是两栖行动和所有海运补给行动所必需的，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">因此该两栖行动中止。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S12">
         <xsl:call-template name="process-br"/>
         <xsl:for-each select="S1">
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">遭敌方攻击造成补给物资损失殆尽，海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
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
               <xsl:with-param name="target-string">从装载点到卸载点出现航线问题，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
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
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">所有具有输送能力的舰船被毁，海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
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
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">最后一艘舰船被毁，海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
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
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">没有适于装卸补给物资的港口设施，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
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
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">接到取消海上任务命令，海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
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
               <xsl:with-param name="target-string">由于没有通行航线，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S8">
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S9">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">由于</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">在两栖行动初始阶段的航线问题，海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
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
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">由于缺乏两栖行动必需的装备设施，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S11">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">在装载点没有被输送部队和装载物资，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S12">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">接到命令，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S13">
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">的舰艇不具备扫雷能力，海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S14">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">该区域没有敌方雷场，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S15">
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">的舰船不具备布雷能力，海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S16">
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">没有水雷，海上补给行动中止，物资已调配给</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../D/@A"/>
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
      <xsl:for-each select="S15">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="unit_name_transform_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">于</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@A"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">完成卸载，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">主要运输了以下补给物资：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="G1/R">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">——</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="get-vocab-value">
                     <xsl:with-param name="vocab">SLP_Category_Name</xsl:with-param>
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../../D/@B"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="SLP_SC_AMT_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../../D/@B"/>
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
                        <xsl:value-of select="../../D/@B"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S16">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="unit_name_transform_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">已从</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@A"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">处接收指定的海运补给物资，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">正向卸载地域航渡。补给物资分别有：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">&lt;p class='tablename'&gt;补给物资明细&lt;/p&gt;</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="process-br"/>
         <xsl:for-each select="G1/R">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">｜</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="get-vocab-value">
                     <xsl:with-param name="vocab">SLP_Category_Name</xsl:with-param>
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../../D/@B"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">｜</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="SLP_SC_AMT_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../../D/@B"/>
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
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">｜</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="SLP_SC_AMT_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../../D/@B"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg3">
                        <xsl:value-of select="D/@C"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="SLP_SC_UOM_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="../../D/@B"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="process-br"/>
         </xsl:for-each>
         <xsl:call-template name="stop-table"/>
         <xsl:for-each select="S1">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">没有涉及装载时间，因为这由编队内部完成。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
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