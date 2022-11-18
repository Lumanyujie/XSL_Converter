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
                  <xsl:value-of select="/M/D/@C"/>
               </xsl:with-param>
            </xsl:call-template>
         </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="parse-col">
         <xsl:with-param name="target-string">与</xsl:with-param>
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
         <xsl:with-param name="target-string">交战毁伤情况报告&lt;/p&gt;</xsl:with-param>
         <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
      </xsl:call-template>
      <xsl:for-each select="S1">
         <xsl:for-each select="S1">
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
               <xsl:with-param name="target-string">实施火力突击，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">预期弹着点：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="LOCATION_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@D"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="/M/D/@E"/>
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
               <xsl:with-param name="target-string">由外部事件造成的火力打击，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">预期弹着点：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="LOCATION_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@D"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="/M/D/@E"/>
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
               <xsl:with-param name="target-string">
                  <xsl:value-of select="' '"/>
               </xsl:with-param>
               <xsl:with-param name="is-begin-with-slide" select="0"/>
            </xsl:call-template>
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
               <xsl:with-param name="target-string">实施火力突击，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">预期弹着点：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="LOCATION_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@D"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="/M/D/@E"/>
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
      <xsl:for-each select="S2">
         <xsl:for-each select="S1">
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
               <xsl:with-param name="target-string">发射导弹，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">预期弹着点：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="LOCATION_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@D"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="/M/D/@E"/>
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
               <xsl:with-param name="target-string">由外部事件引起的导弹发射，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">预期弹着点：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="LOCATION_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@D"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="/M/D/@E"/>
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
      <xsl:for-each select="S3">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">某特战分队与</xsl:with-param>
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
            <xsl:with-param name="target-string">在</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="LOCATION_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@D"/>
                  </xsl:with-param>
                  <xsl:with-param name="arg2">
                     <xsl:value-of select="/M/D/@E"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">展开交战。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S4">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">某特战分队与</xsl:with-param>
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
            <xsl:with-param name="target-string">在</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="LOCATION_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@D"/>
                  </xsl:with-param>
                  <xsl:with-param name="arg2">
                     <xsl:value-of select="/M/D/@E"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">展开交战。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S5">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">在两栖作战中，实施炮火打击，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">预期弹着点：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="LOCATION_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@D"/>
                  </xsl:with-param>
                  <xsl:with-param name="arg2">
                     <xsl:value-of select="/M/D/@E"/>
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
         <xsl:for-each select="S1">
            <xsl:call-template name="process-br"/>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">由</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@C"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">抽组的</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="get-vocab-value">
                     <xsl:with-param name="vocab">Aircraft_Type</xsl:with-param>
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="D/@B"/>
                     </xsl:with-param>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">空中编队（批号：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">），</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">火力突击弹着点：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="LOCATION_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@D"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="/M/D/@E"/>
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
               <xsl:with-param name="target-string">由外部事件引起的空中火力突击，</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">预期弹着点：</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:call-template name="LOCATION_FUN">
                     <xsl:with-param name="arg1">
                        <xsl:value-of select="/M/D/@D"/>
                     </xsl:with-param>
                     <xsl:with-param name="arg2">
                        <xsl:value-of select="/M/D/@E"/>
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
      <xsl:for-each select="S7">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">一艘舰艇在穿越雷区时，</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">在</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:call-template name="LOCATION_FUN">
                  <xsl:with-param name="arg1">
                     <xsl:value-of select="/M/D/@D"/>
                  </xsl:with-param>
                  <xsl:with-param name="arg2">
                     <xsl:value-of select="/M/D/@E"/>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">水域触雷。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S8">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">使用以下弹药：</xsl:with-param>
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
                     <xsl:with-param name="vocab">Targetable_Weapon</xsl:with-param>
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
            <xsl:call-template name="display_cur_text">
               <xsl:with-param name="in_string">
                  <xsl:value-of select="D/@A"/>
               </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="parse-col">
               <xsl:with-param name="target-string">枚（发）</xsl:with-param>
               <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
            </xsl:call-template>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S9">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">该编队交战结果如下：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S10">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">—未指定目标：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S11">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">—</xsl:with-param>
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
      </xsl:for-each>
      <xsl:for-each select="S12">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">—</xsl:with-param>
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
      </xsl:for-each>
      <xsl:for-each select="S13">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">—空中</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="display_cur_text">
            <xsl:with-param name="in_string">
               <xsl:value-of select="D/@A"/>
            </xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">编队  ：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S14">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">—由</xsl:with-param>
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
            <xsl:with-param name="target-string">派出的运输队：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S15">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">—目标点坐标：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S16">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">—突击方位/距离：</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S17">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">—</xsl:with-param>
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
      </xsl:for-each>
      <xsl:for-each select="S18">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">—目标定位点</xsl:with-param>
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
      </xsl:for-each>
      <xsl:for-each select="S19">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">——未知。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S20">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">——无毁伤，导弹掠地飞行时自毁。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S21">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">——无毁伤，导弹掠海飞行时自毁。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S22">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">——无毁伤，导弹飞出地形匹配区时自毁。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S23">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">——无毁伤。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S24">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">——无毁伤，巡航导弹遭防空拦截。</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
      </xsl:for-each>
      <xsl:for-each select="S30">
         <xsl:for-each select="G1/R">
            <xsl:for-each select="S1">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">——</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Targetable_Weapon</xsl:with-param>
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
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">——雷场。</xsl:with-param>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">SLP_Category_Name</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@D"/>
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
                     <xsl:call-template name="SLP_SC_AMT_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@D"/>
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
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="SLP_SC_UOM_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@D"/>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">CSP_System_Name</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@E"/>
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
                  <xsl:with-param name="target-string">损失</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个，毁伤</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@D"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个。</xsl:with-param>
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
                  <xsl:with-param name="target-string">船体受损，出现</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">处破裂口。</xsl:with-param>
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
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">弹射器毁坏, </xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个弹射器失效。</xsl:with-param>
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
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">小型艇受损，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">艘</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Small_Boat</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">损失。</xsl:with-param>
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
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">损失</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个，战损率</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:variable name="out-string">
                  <xsl:call-template name="format-float-right">
                     <xsl:with-param name="str">
                        <xsl:value-of select="D/@C"/>
                     </xsl:with-param>
                     <xsl:with-param name="width" select="2"/>
                     <xsl:with-param name="precision" select="4"/>
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
            <xsl:for-each select="S9">
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">SLP_Category_Name</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="D/@C"/>
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
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="D/@C"/>
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
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
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
            <xsl:for-each select="S10">
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
                  <xsl:with-param name="target-string">损失装卸设施</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">套，战损率</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:variable name="out-string">
                  <xsl:call-template name="format-float-right">
                     <xsl:with-param name="str">
                        <xsl:value-of select="D/@C"/>
                     </xsl:with-param>
                     <xsl:with-param name="width" select="2"/>
                     <xsl:with-param name="precision" select="4"/>
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
            <xsl:for-each select="S11">
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
                  <xsl:with-param name="target-string">的运输分队，损失</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Transportation_Class</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">辆（节）。</xsl:with-param>
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
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">的机降编队，损失</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Aircraft_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@C"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">架。</xsl:with-param>
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
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">SLP_Category_Name</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="D/@B"/>
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
                           <xsl:value-of select="D/@D"/>
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
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="SLP_SC_UOM_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@D"/>
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
            <xsl:for-each select="S14">
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">CSP_System_Name</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@D"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">：损失</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个，无毁伤。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S15">
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
                  <xsl:with-param name="target-string">的未知项目：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，类型：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，数量：</xsl:with-param>
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
                  <xsl:with-param name="target-string">武器：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@E"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，击毁概率：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:variable name="out-string">
                  <xsl:call-template name="format-float-right">
                     <xsl:with-param name="str">
                        <xsl:value-of select="D/@F"/>
                     </xsl:with-param>
                     <xsl:with-param name="width" select="2"/>
                     <xsl:with-param name="precision" select="2"/>
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
            <xsl:for-each select="S16">
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
                  <xsl:with-param name="target-string">，损失发射架</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个，战损率</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:variable name="out-string">
                  <xsl:call-template name="format-float-right">
                     <xsl:with-param name="str">
                        <xsl:value-of select="D/@C"/>
                     </xsl:with-param>
                     <xsl:with-param name="width" select="2"/>
                     <xsl:with-param name="precision" select="2"/>
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
            <xsl:for-each select="S17">
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
                  <xsl:with-param name="target-string">，损失火控雷达</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个，战损率</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:variable name="out-string">
                  <xsl:call-template name="format-float-right">
                     <xsl:with-param name="str">
                        <xsl:value-of select="D/@C"/>
                     </xsl:with-param>
                     <xsl:with-param name="width" select="2"/>
                     <xsl:with-param name="precision" select="2"/>
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
            <xsl:for-each select="S18">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">——目标定位点</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，遭打击损毁。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S19">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">——外部武器。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S30">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">——错误，请通知技术人员。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S31">
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
                  <xsl:with-param name="target-string">的未知项目：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，类型：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，数量：</xsl:with-param>
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
                  <xsl:with-param name="target-string">武器：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@E"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，击毁概率：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:variable name="out-string">
                  <xsl:call-template name="format-float-right">
                     <xsl:with-param name="str">
                        <xsl:value-of select="D/@F"/>
                     </xsl:with-param>
                     <xsl:with-param name="width" select="2"/>
                     <xsl:with-param name="precision" select="2"/>
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
      <xsl:for-each select="S31">
         <xsl:call-template name="process-br"/>
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">更多毁伤可能由联合冲突战术仿真系统造成。</xsl:with-param>
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