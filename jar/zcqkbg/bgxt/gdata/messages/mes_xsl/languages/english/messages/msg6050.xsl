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
         <xsl:with-param name="target-string">&lt;p class='title'&gt;海军</xsl:with-param>
         <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="display_cur_text">
         <xsl:with-param name="in_string">
            <xsl:call-template name="trans_word_FUN">
               <xsl:with-param name="arg1">
                  <xsl:text>Order</xsl:text>
               </xsl:with-param>
               <xsl:with-param name="arg2">
                  <xsl:value-of select="/M/D/@B"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="parse-col">
         <xsl:with-param name="target-string">命令执行情况报告&lt;/p&gt;</xsl:with-param>
         <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
      </xsl:call-template>
      <xsl:for-each select="S1">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@A"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队收到海上补给命令。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="S1">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">装载货物的尺寸超过</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="../D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">的当前容量。当编队到达装载地点时，海上补给任务将取消。当前编队的可携载容量是</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">的干货运输量与</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@B"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">的液货运输量。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S2">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">将于</xsl:with-param>
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
               <xsl:with-param name="target-string">离开装载点；</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">预计抵达装载点时间为：</xsl:with-param>
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
               <xsl:with-param name="target-string">；</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">预计完成装载时间为：</xsl:with-param>
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
               <xsl:with-param name="target-string">；</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">预计抵达卸载点时间为：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="GTIME_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@D"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">；</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">预计完成补给任务时间为：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="GTIME_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@E"/>
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
               <xsl:with-param name="target-string">备注：这些预估时间是基于编队的当前运力给出的，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">已分配给编队、但尚未加入到编队的船只已计算在内，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">在抵达装载点前增加或减少船只将影响上述完成时间。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S2">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@A"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队收到两栖装载命令。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="S1">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">以下部队不执行该项任务：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="save-header">
               <xsl:with-param name="header-string">名称|原因</xsl:with-param>
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
                     <xsl:with-param name="target-string">已经在执行另一项两栖任务</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
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
                     <xsl:with-param name="target-string">未搭载编队舰船</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                  </xsl:call-template>
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
                     <xsl:with-param name="target-string">已搭载另一编队舰船</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                  </xsl:call-template>
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
                     <xsl:with-param name="target-string">已遭重创</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                  </xsl:call-template>
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
                     <xsl:with-param name="target-string">已被列入集运名单</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                  </xsl:call-template>
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
                     <xsl:with-param name="target-string">尚未进入战区</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:call-template name="stop-table"/>
         </xsl:for-each>
         <xsl:for-each select="S2">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">由于装载地域条件所限，此次两栖装载将不采取命令中指定的抵滩或港口装载方式。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S3">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">由于编队中没有直升机，此次两栖装载将不采取命令中指定的直升机装载方式。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S4">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">由于编队中没有符合该装载点装载要求的船艇，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">此次两栖装载将不采取命令中指定的两栖船装载方式。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S5">
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">编队当前没有足够运力完成命令中要求的两栖装载任务。建议开始装载前</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">尽快加强舰船力量，否则某些或所有部队将无法装载。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S6">
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">编队正接近装载点，展开两栖装载。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S7">
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">编队将于</xsl:with-param>
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
               <xsl:with-param name="target-string">出发执行两栖任务。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S8">
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">编队预计将于</xsl:with-param>
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
               <xsl:with-param name="target-string">抵达两栖装载点。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S3">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@A"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队收到两栖攻击命令。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="S1">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">以下部队不执行该项任务：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="save-header">
               <xsl:with-param name="header-string">名称|原因</xsl:with-param>
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
                     <xsl:with-param name="target-string">已经在执行另一项两栖任务</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
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
                     <xsl:with-param name="target-string">未搭载编队舰船</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                  </xsl:call-template>
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
                     <xsl:with-param name="target-string">已搭载另一编队舰船</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                  </xsl:call-template>
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
                     <xsl:with-param name="target-string">已遭重创</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                  </xsl:call-template>
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
                     <xsl:with-param name="target-string">已被列入集运名单</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                  </xsl:call-template>
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
                     <xsl:with-param name="target-string">尚未进入战区</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="process-br"/>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:call-template name="stop-table"/>
         </xsl:for-each>
         <xsl:for-each select="S2">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">由于登陆地域条件所限，此次两栖攻击将不采取命令中指定的抵滩或港口登陆方式。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S3">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">由于编队中没有直升机，此次两栖攻击将不采取命令中指定的直升机登陆方式。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S4">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">由于编队中没有符合该登陆点要求的船艇，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">此次两栖登陆将不采取命令中指定的两栖船登陆方式。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S5">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">底层编码不一致，这是一条虚假信息。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S6">
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">编队正接近登陆点，展开两栖攻击。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S7">
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">编队将于</xsl:with-param>
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
               <xsl:with-param name="target-string">出发展开两栖攻击。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S8">
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">编队预计将于</xsl:with-param>
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
               <xsl:with-param name="target-string">抵达登陆点。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S4">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@A"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队已撤销，任何机动的舰船原地待命。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S5">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">下列舰艇已接到命令加入</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@A"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="save-header">
            <xsl:with-param name="header-string">舰艇名称|当前状态|当前航速|预计到达时间|可否穿越国境线</xsl:with-param>
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
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">不能加入（部队已装载）|—|—|—</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
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
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">不能加入（正实施海运）|—|—|—</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S3">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
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
                  <xsl:with-param name="target-string">不能加入（正展开攻击）|—|—|—</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S4">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
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
                  <xsl:with-param name="target-string">不能加入（正组织装载）|—|—|—</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S5">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">不能加入（不在演习区）|—|—|—</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S6">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
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
                  <xsl:with-param name="target-string">不能加入（无通行路线）|—|—|—</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
            <xsl:for-each select="S7">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
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
                  <xsl:with-param name="target-string">不能加入（已退出演习）|—|—|—</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
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
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">加入编队|</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="UOM_AMT_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>NAVAL_SPEED</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="UOM_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>NAVAL_SPEED</xsl:text>
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
                     <xsl:call-template name="GTIME_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">允许</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
         </xsl:for-each>
         <xsl:call-template name="stop-table"/>
      </xsl:for-each>
      <xsl:for-each select="S6">
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
            <xsl:with-param name="target-string">已启航，现在位于</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="LOCATION_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
                  <xsl:with-param name="arg2">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">，正按既定线路航行，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">当前速度为</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="UOM_AMT_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:text>NAVAL_SPEED</xsl:text>
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
                     <xsl:text>NAVAL_SPEED</xsl:text>
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
            <xsl:with-param name="target-string">已按命令加入</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@B"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队，当前速度为</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="UOM_AMT_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:text>NAVAL_SPEED</xsl:text>
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
                     <xsl:text>NAVAL_SPEED</xsl:text>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">，预计到达时间为</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="GTIME_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="D/@D"/>
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
            <xsl:with-param name="target-string">已启航，拟在</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="LOCATION_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
                  <xsl:with-param name="arg2">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="S1">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">布设</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">枚</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="get-vocab-value">
                     <xsl:with-param name="vocab">Targetable_Weapon</xsl:with-param>
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">水雷。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S2">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">采取</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="get-vocab-value">
                     <xsl:with-param name="vocab">Mining_Type</xsl:with-param>
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">方式组织扫雷。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S10">
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
            <xsl:with-param name="target-string">收到机动命令，拟于</xsl:with-param>
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
            <xsl:with-param name="target-string">出发。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S11">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">收到变换阵位命令（编号</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="/M/D/@B"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">），执行情况如下：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">&lt;p class='table_name'&gt;命令执行情况明细&lt;/p&gt;</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="save-header">
            <xsl:with-param name="header-string"> 名称 | 编队 | 方位选项 | 方位角 | 与基准舰距离 | 预计抵达时间</xsl:with-param>
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
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">未加入编队|——|——|——|——</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
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
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">未指定阵位|——|——|——|—— n</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S3">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
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
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@E"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Station_Keeping_Method</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@C"/>
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
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="UOM_AMT_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>DISTANCE</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="D/@A"/>
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
                  <xsl:with-param name="target-string"/>
                  <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="DURATION_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:text>%.2Th</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">小时</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
            </xsl:for-each>
         </xsl:for-each>
         <xsl:call-template name="stop-table"/>
      </xsl:for-each>
      <xsl:for-each select="S12">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@A"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队与</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@B"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队合并，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@A"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队所有舰艇已加入</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@B"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">每艘舰当前阵位与原编队一致，如需调整可下达变换阵位命令。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@B"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队现由下列舰船组成：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">&lt;p class='table_name'&gt;编队现有舰艇明细&lt;/p&gt;</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="save-header">
            <xsl:with-param name="header-string">名称|方位角（方位选项）|与基准舰距离</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="process-br"/>
         <xsl:for-each select="G1/R">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string"/>
               <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
            </xsl:call-template>
            <xsl:variable name="out-string">
               <xsl:call-template name="format-string-left">
                  <xsl:with-param name="str">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="width" select="20"/>
                  <xsl:with-param name="trim" select="20"/>
               </xsl:call-template>
            </xsl:variable>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string" select="$out-string"/>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string"/>
               <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
            </xsl:call-template>
            <xsl:variable name="out-string">
               <xsl:call-template name="format-string-left">
                  <xsl:with-param name="str">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
                  <xsl:with-param name="width" select="3"/>
                  <xsl:with-param name="trim" select="3"/>
               </xsl:call-template>
            </xsl:variable>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string" select="$out-string"/>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">（</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:variable name="out-string">
               <xsl:call-template name="format-string-left">
                  <xsl:with-param name="str">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Station_Keeping_Method</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="width" select="8"/>
                  <xsl:with-param name="trim" select="8"/>
               </xsl:call-template>
            </xsl:variable>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string" select="$out-string"/>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">）|</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:variable name="out-string">
               <xsl:call-template name="format-string-left">
                  <xsl:with-param name="str">
                     <xsl:call-template name="UOM_AMT_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>DISTANCE</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="width" select="8"/>
                  <xsl:with-param name="trim" select="8"/>
               </xsl:call-template>
            </xsl:variable>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string" select="$out-string"/>
            </xsl:call-template>
            <xsl:variable name="out-string">
               <xsl:call-template name="format-string-left">
                  <xsl:with-param name="str">
                     <xsl:call-template name="UOM_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>DISTANCE</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
                  <xsl:with-param name="width" select="3"/>
                  <xsl:with-param name="trim" select="3"/>
               </xsl:call-template>
            </xsl:variable>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string" select="$out-string"/>
            </xsl:call-template>
            <xsl:call-template name="process-br"/>
         </xsl:for-each>
         <xsl:call-template name="stop-table"/>
         <xsl:for-each select="S1">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="../D/@B"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">编队当前正在执行</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="get-vocab-value">
                     <xsl:with-param name="vocab">Formation_Posture</xsl:with-param>
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">行动，原</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="../D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">编队舰船已参与其中。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S13">
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
            <xsl:with-param name="target-string">收到调整机动命令（编号</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="/M/D/@B"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">），</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="S1">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">正调整航速为</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="UOM_AMT_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:text>NAVAL_SPEED</xsl:text>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="UOM_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:text>NAVAL_SPEED</xsl:text>
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
               <xsl:with-param name="target-string">正调整占位航速为</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="UOM_AMT_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:text>NAVAL_SPEED</xsl:text>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="UOM_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:text>NAVAL_SPEED</xsl:text>
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
               <xsl:with-param name="target-string">正调整航向，按新航线航行。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S4">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">编队完成两栖任务后，将按指定航线撤离。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S5">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">编队将在装载点与卸载点间，按命令要求建立新的海上补给线。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S6">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">正在执行，新的投送地点为</xsl:with-param>
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
               <xsl:with-param name="target-string">，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">接收补给部队为</xsl:with-param>
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
               <xsl:with-param name="target-string">。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S7">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">新航线包含下列节点，并保持相应航速：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="UOM_AMT_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>NAVAL_SPEED</xsl:text>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">
                     <xsl:value-of select="' '"/>
                  </xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide" select="0"/>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="UOM_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:text>NAVAL_SPEED</xsl:text>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S14">
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
            <xsl:with-param name="target-string">收到指令，拟于</xsl:with-param>
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
            <xsl:with-param name="target-string">离开编队。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S15">
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
            <xsl:with-param name="target-string">收到评估</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@B"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队完成两栖</xsl:with-param>
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
            <xsl:with-param name="target-string">任务所需时间的命令，正在执行，将尽快上报。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S16">
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
            <xsl:with-param name="target-string">收到评估</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@B"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队完成海上补给任务所需时间的命令，正在执行，将尽快上报。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S18">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">收到海军编队分批命令（编号</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="/M/D/@B"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">），</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@A"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队已从</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@B"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队中分离出来。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="S1">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="../D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">编队包括以下舰船，以及已完成装载或正在装载的地面部队：</xsl:with-param>
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
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="G1/R">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">————</xsl:with-param>
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
         </xsl:for-each>
         <xsl:for-each select="S2">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="../D/@B"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">编队包括以下舰船，以及已完成装载或正在装载的地面部队：</xsl:with-param>
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
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="G1/R">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">————</xsl:with-param>
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
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S19">
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
            <xsl:with-param name="target-string">已经接管</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="/M/D/@C"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队的指挥权。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S20">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">下达给</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="unit_name_transform_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队的战略补给计划收到，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="S1">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">所有站点同意。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S2">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">下列站点拒绝：</xsl:with-param>
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
                        <xsl:call-template name="unit_name_transform_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">：拒绝，国际民航组织（ICAO）</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">不存在。</xsl:with-param>
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
                     <xsl:with-param name="target-string">：拒绝，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:for-each select="S1">
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">与 </xsl:with-param>
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
                        <xsl:with-param name="target-string">保持联系的国际民航组织</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">（ICAO）</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="display_cur_text">
                        <xsl:with-param name="in_string">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">已退出演习。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S2">
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
                        <xsl:with-param name="target-string">已退出演习。</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
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
                     <xsl:with-param name="target-string">：拒绝，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">该地域（ </xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string">
                        <xsl:call-template name="LOCATION_FUN">
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@B"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:value-of select="D/@C"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">）达不到通行舰船的水深要求。</xsl:with-param>
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
                     <xsl:with-param name="target-string">：拒绝，</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">已列入补给计划，站点序列号为</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:variable name="out-string">
                     <xsl:call-template name="format-string-right">
                        <xsl:with-param name="str">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                        <xsl:with-param name="width" select="5"/>
                        <xsl:with-param name="trim" select="5"/>
                     </xsl:call-template>
                  </xsl:variable>
                  <xsl:call-template name="display_cur_text">
                     <xsl:with-param name="in_string" select="$out-string"/>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
         </xsl:for-each>
         <xsl:for-each select="S3">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">所有剩余的站点同意。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S4">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">拒绝执行该命令。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S23">
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
            <xsl:with-param name="target-string">位于</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="LOCATION_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
                  <xsl:with-param name="arg2">
                     <xsl:value-of select="D/@D"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">，正在下沉。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="S1">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">准备弃船并乘坐救生艇离开。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S2">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">准备于</xsl:with-param>
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
               <xsl:with-param name="target-string">弃船。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S3">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">舰上没有配备可用的救生艇。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S4">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">船上没有可用的救生艇。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S5">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">舰上已有</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">艘救生艇下水。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S6">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">停止部署展开救生艇总计</xsl:with-param>
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
         <xsl:for-each select="S7">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">没有停止部署展开救生艇。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S24">
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
            <xsl:with-param name="target-string">收到调整潜艇深度命令，执行情况：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="S1">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">当前潜艇处于</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="get-vocab-value">
                     <xsl:with-param name="vocab">Depth_State</xsl:with-param>
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">状态。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S2">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">潜艇将于</xsl:with-param>
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
               <xsl:with-param name="target-string">调整为</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="get-vocab-value">
                     <xsl:with-param name="vocab">Depth_State</xsl:with-param>
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">状态。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S3">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">潜艇将于</xsl:with-param>
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
               <xsl:with-param name="target-string">恢复为</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="get-vocab-value">
                     <xsl:with-param name="vocab">Depth_State</xsl:with-param>
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">状态。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S4">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">潜艇的动力类型是</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="get-vocab-value">
                     <xsl:with-param name="vocab">Ship_Propulsion_Type</xsl:with-param>
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
               <xsl:with-param name="target-string">只有柴电动力潜艇要求在通气管</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">或水上状态充电，因此，充电命令已取消。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S5">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">潜艇正在充电，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">电池剩余量为</xsl:with-param>
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
         </xsl:for-each>
         <xsl:for-each select="S6">
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">潜艇尚未充电，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">电池剩余量为</xsl:with-param>
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
         </xsl:for-each>
         <xsl:for-each select="S7">
            <xsl:for-each select="S1">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">打开被动式搜索传感器</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">功能：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:variable name="out-string">
                  <xsl:call-template name="format-string-left">
                     <xsl:with-param name="str">
                        <xsl:call-template name="get-vocab-value">
                           <xsl:with-param name="vocab">Sensor_Function</xsl:with-param>
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@B"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                     <xsl:with-param name="width" select="15"/>
                     <xsl:with-param name="trim" select="15"/>
                  </xsl:call-template>
               </xsl:variable>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string" select="$out-string"/>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">信息采集模式：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:variable name="out-string">
                  <xsl:call-template name="format-string-left">
                     <xsl:with-param name="str">
                        <xsl:call-template name="get-vocab-value">
                           <xsl:with-param name="vocab">Sensor_Collection_Mode</xsl:with-param>
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@C"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                     <xsl:with-param name="width" select="9"/>
                     <xsl:with-param name="trim" select="9"/>
                  </xsl:call-template>
               </xsl:variable>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string" select="$out-string"/>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
         </xsl:for-each>
         <xsl:for-each select="S8">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">所有被动式地面、空中搜索传感器关闭。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S9">
            <xsl:for-each select="S1">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">打开主动式搜索传感器</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">功能：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:variable name="out-string">
                  <xsl:call-template name="format-string-left">
                     <xsl:with-param name="str">
                        <xsl:call-template name="get-vocab-value">
                           <xsl:with-param name="vocab">Sensor_Function</xsl:with-param>
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@B"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                     <xsl:with-param name="width" select="15"/>
                     <xsl:with-param name="trim" select="15"/>
                  </xsl:call-template>
               </xsl:variable>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string" select="$out-string"/>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">信息采集模式：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:variable name="out-string">
                  <xsl:call-template name="format-string-left">
                     <xsl:with-param name="str">
                        <xsl:call-template name="get-vocab-value">
                           <xsl:with-param name="vocab">Sensor_Collection_Mode</xsl:with-param>
                           <xsl:with-param name="arg1">
                              <xsl:value-of select="D/@C"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                     <xsl:with-param name="width" select="9"/>
                     <xsl:with-param name="trim" select="9"/>
                  </xsl:call-template>
               </xsl:variable>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string" select="$out-string"/>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S2">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">艇上没有地面或空中搜索雷达。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
         </xsl:for-each>
         <xsl:for-each select="S10">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">所有主动式地面与空中搜索雷达关闭。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S11">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">艇上缺乏充电必需的</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="get-vocab-value">
                     <xsl:with-param name="vocab">Supply_Category</xsl:with-param>
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@A"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">，无法充电。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S12">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">潜艇电池目前电量充足，不需充电。</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
         <xsl:for-each select="S13">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">潜艇电池电量已耗尽，不能下潜。</xsl:with-param>
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