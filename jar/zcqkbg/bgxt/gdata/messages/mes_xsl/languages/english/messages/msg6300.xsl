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
         <xsl:with-param name="target-string">编队两栖行动情况报告&lt;/p&gt;</xsl:with-param>
         <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
      </xsl:call-template>
      <xsl:for-each select="S2">
         <xsl:call-template name="process-br"/>
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
            <xsl:with-param name="target-string">最后波次兵力抢滩上陆完成，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">该部队现在可离开登陆点并执行作战命令。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S3">
         <xsl:call-template name="process-br"/>
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
            <xsl:with-param name="target-string">最后波次两栖搭载行动已开始，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">该部队现已全部搭载在</xsl:with-param>
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
            <xsl:with-param name="target-string">编队的舰船上。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S4">
         <xsl:call-template name="process-br"/>
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
            <xsl:with-param name="target-string">的两栖装载已全部完成。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">尽管该部队已被标识到新的位置，但尚未完成航渡。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">当两栖行动全部完成后，您将会得到通知。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
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
            <xsl:with-param name="target-string">编队当前正位于海上补给卸载点，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="S1">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">等待</xsl:with-param>
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
               <xsl:with-param name="target-string">给予补给。等待截止时间：</xsl:with-param>
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
         <xsl:for-each select="S2">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">等待下一个部队给予补给，等待截止时间：</xsl:with-param>
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
               <xsl:with-param name="target-string">。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
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
            <xsl:with-param name="target-string">编队当前正位于海上补给装载点，等待</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">被输送部队或补给物资到达后，继续尔后的海上补给行动。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">等待截止时间：</xsl:with-param>
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
            <xsl:with-param name="target-string">。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S7">
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
               <xsl:with-param name="target-string">编队遭敌方攻击造成所有补给物资损失，两栖行动中止。</xsl:with-param>
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
               <xsl:with-param name="target-string">编队的两栖行动中止。</xsl:with-param>
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
               <xsl:with-param name="target-string">编队所有具有输送能力的舰船被毁，两栖行动中止。</xsl:with-param>
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
               <xsl:with-param name="target-string">编队最后一艘舰船被毁，两栖行动中止。</xsl:with-param>
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
               <xsl:with-param name="target-string">编队的两栖行动中止。</xsl:with-param>
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
               <xsl:with-param name="target-string">编队接到取消海上任务命令，海上补给行动中止</xsl:with-param>
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
               <xsl:with-param name="target-string">编队的两栖行动中止。</xsl:with-param>
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
               <xsl:with-param name="target-string">编队两栖行动中止。</xsl:with-param>
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
               <xsl:with-param name="target-string">编队在两栖行动初始阶段的航线问题，两栖行动中止。</xsl:with-param>
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
               <xsl:with-param name="target-string">编队的两栖行动中止。</xsl:with-param>
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
               <xsl:with-param name="target-string">编队的两栖行动中止。</xsl:with-param>
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
               <xsl:with-param name="target-string">编队的两栖行动中止。</xsl:with-param>
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
               <xsl:with-param name="target-string">编队的舰艇不具备扫雷能力，两栖行动中止。</xsl:with-param>
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
               <xsl:with-param name="target-string">编队的两栖行动中止。</xsl:with-param>
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
               <xsl:with-param name="target-string">编队的舰船不具备布雷能力，两栖行动中止。</xsl:with-param>
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
               <xsl:with-param name="target-string">编队没有水雷，两栖行动中止。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
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
            <xsl:with-param name="target-string">编队当前正位于两栖行动装载点，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">但该编队没有装载所有指定部队的能力，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">无法装载以下部队：</xsl:with-param>
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
                  <xsl:call-template name="unit_name_transform_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
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