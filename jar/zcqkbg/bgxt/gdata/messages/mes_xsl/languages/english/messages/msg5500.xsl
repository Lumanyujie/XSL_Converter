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
         <xsl:with-param name="target-string">&lt;p class='title'&gt;导调情报汇总报告&lt;/p&gt;</xsl:with-param>
         <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
      </xsl:call-template>
      <xsl:for-each select="S1">
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
                  <xsl:with-param name="target-string">名称：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">所属集团：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，敏感目标标识：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@F"/>
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
                           <xsl:value-of select="../D/@G"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，主体情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">附加情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，与前次情报相比：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Change_Code</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@N"/>
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
                  <xsl:with-param name="target-string">名称：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">所属集团：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，敏感目标标识：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@F"/>
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
                           <xsl:value-of select="../D/@G"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，主体情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">附加情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，与前次情报相比：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Change_Code</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@N"/>
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
                  <xsl:with-param name="target-string">名称：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">所属集团：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，敏感目标标识：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@F"/>
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
                           <xsl:value-of select="../D/@G"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，主体情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">附加情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，与前次情报相比：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Change_Code</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@N"/>
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
                  <xsl:with-param name="target-string">防空阵地（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
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
                  <xsl:with-param name="target-string">），配备</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个发射装置。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S5">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Bridge_Class</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，具有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S6">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Tunnel_Class</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，具有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S7">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Sensor_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">阵地。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S8">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">跑道（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">），配备</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Runway_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个飞机机库。 </xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S9">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Interdiction_Point_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，具有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S10">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">存储点（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Supply_Storage_Area</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">）。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S11">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Surface_Surface_Missile</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，装备</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个发射装置。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S12">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Facility_Type</xsl:with-param>
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
            <xsl:for-each select="S13">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Aircraft_Shelter_Type</xsl:with-param>
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
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S14">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">装卸设施（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">MHE_Facility</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">），具备同时执行</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">项任务能力。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S15">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">标准雷场</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S16">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Pumping_Station_Class</xsl:with-param>
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
            <xsl:for-each select="S17">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Jammer_Type</xsl:with-param>
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
            <xsl:for-each select="S18">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Comm_Site_Type</xsl:with-param>
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
            <xsl:for-each select="S19">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">舰艇（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Ship_Unit_Prototype</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">）。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S20">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Combat_Arms_Type</xsl:with-param>
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
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">台、套。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S21">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Transportation_Class</xsl:with-param>
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
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">台、套。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S22">
               <xsl:call-template name="process-br"/>
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
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
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
            <xsl:for-each select="S23">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">两栖输送工具（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Small_Boat</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">），</xsl:with-param>
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
            <xsl:for-each select="S24">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">补给（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Supply_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">）。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S25">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Graphics_Symbol</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，处于</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Unit_Posture</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">态势。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">人员、装备情况如下：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="save-header">
                     <xsl:with-param name="header-string">类型|数量</xsl:with-param>
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
                           <xsl:with-param name="target-string"/>
                           <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:value-of select="../D/@A"/>
                           </xsl:with-param>
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
                              <xsl:call-template name="get-vocab-value">
                                 <xsl:with-param name="vocab">Combat_System</xsl:with-param>
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@B"/>
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
                              <xsl:value-of select="../D/@A"/>
                           </xsl:with-param>
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
                              <xsl:call-template name="get-vocab-value">
                                 <xsl:with-param name="vocab">Aircraft_Type</xsl:with-param>
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@B"/>
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
                              <xsl:value-of select="../D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="process-br"/>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:call-template name="stop-table"/>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:for-each select="S1">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">舰艇吃水较浅，</xsl:with-param>
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
                     <xsl:call-template name="process-br"/>
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
                     <xsl:call-template name="process-br"/>
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
                        <xsl:with-param name="target-string">。 </xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S4">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">舰艇起火，可看到</xsl:with-param>
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
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">可看到</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
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
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">舰艇周边</xsl:with-param>
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
                     <xsl:call-template name="process-br"/>
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
            <xsl:for-each select="S31">
               <xsl:for-each select="G1/R">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">标识：</xsl:with-param>
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
                              <xsl:value-of select="../../../D/@G"/>
                           </xsl:with-param>
                           <xsl:with-param name="arg2">
                              <xsl:value-of select="../../../D/@H"/>
                           </xsl:with-param>
                        </xsl:call-template>
                     </xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">，注释：</xsl:with-param>
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
      <xsl:for-each select="S2">
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">&lt;p class='title1'&gt;已侦察部队情报&lt;/p&gt;</xsl:with-param>
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
                  <xsl:with-param name="target-string">名称：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">所属集团：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，敏感目标标识：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@F"/>
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
                           <xsl:value-of select="../D/@G"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，主体情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">附加情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，与前次情报相比：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Change_Code</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@N"/>
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
                  <xsl:with-param name="target-string">该部队（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Graphics_Symbol</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">），处于</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Unit_Posture</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@B"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">状态。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">人员、装备情况如下：</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
                  <xsl:call-template name="save-header">
                     <xsl:with-param name="header-string">类型|数量</xsl:with-param>
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
                           <xsl:with-param name="target-string"/>
                           <xsl:with-param name="is-begin-with-slide">1</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="display_cur_text">
                           <xsl:with-param name="in_string">
                              <xsl:value-of select="../D/@A"/>
                           </xsl:with-param>
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
                              <xsl:call-template name="get-vocab-value">
                                 <xsl:with-param name="vocab">Combat_System</xsl:with-param>
                                 <xsl:with-param name="arg1">
                                    <xsl:value-of select="../D/@B"/>
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
                              <xsl:value-of select="../D/@A"/>
                           </xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="process-br"/>
                     </xsl:for-each>
                  </xsl:for-each>
                  <xsl:call-template name="stop-table"/>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:for-each select="S1">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">舰艇吃水较浅，</xsl:with-param>
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
                     <xsl:call-template name="process-br"/>
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
                     <xsl:call-template name="process-br"/>
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
                        <xsl:with-param name="target-string">。 </xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
                  </xsl:for-each>
                  <xsl:for-each select="S4">
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">舰艇起火，可看到</xsl:with-param>
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
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">可看到</xsl:with-param>
                        <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                     </xsl:call-template>
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
                     <xsl:call-template name="process-br"/>
                     <xsl:call-template name="parse-col">
                        <xsl:with-param name="target-string">舰艇周边</xsl:with-param>
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
                     <xsl:call-template name="process-br"/>
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
      <xsl:for-each select="S3">
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">&lt;p class='title1'&gt;已毁伤目标情报&lt;/p&gt;</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="G1/R">
            <xsl:for-each select="S2">
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
                  <xsl:with-param name="target-string">名称：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">所属集团：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，敏感目标标识：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@F"/>
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
                           <xsl:value-of select="../D/@G"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，主体情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">附加情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，与前次情报相比：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Change_Code</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@N"/>
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
                  <xsl:with-param name="target-string">名称：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">所属集团：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，敏感目标标识：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@F"/>
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
                           <xsl:value-of select="../D/@G"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，主体情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">附加情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，与前次情报相比：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Change_Code</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@N"/>
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
                  <xsl:with-param name="target-string">防空阵地（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
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
                  <xsl:with-param name="target-string">），配备</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个发射单元，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个发射装置毁坏，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@D"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个火控雷达毁坏。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">发射装置将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前修复。 </xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S2">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">火控雷达将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前修复。 </xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体恢复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。 </xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S5">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Bridge_Class</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路关闭。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S6">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Tunnel_Class</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路关闭。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S7">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">损毁阵地（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Sensor_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">）。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S8">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">跑道（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Runway_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">），有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">处明显损毁。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S9">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Interdiction_Point_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路已关闭。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S10">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">存储点（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Supply_Storage_Area</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">）。 </xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S11">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Surface_Surface_Missile</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，装备</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个发射装置，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个损毁。 </xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S12">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Facility_Type</xsl:with-param>
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
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S13">
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">
                     <xsl:value-of select="' '"/>
                  </xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide" select="0"/>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">机堡（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Aircraft_Shelter_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">）</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个损毁。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S14">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">装卸设施（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">MHE_Facility</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">）</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">套，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">套损毁。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S15">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">失效雷场。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S16">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Pumping_Station_Class</xsl:with-param>
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
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S17">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Jammer_Type</xsl:with-param>
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
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S18">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Comm_Site_Type</xsl:with-param>
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
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S19">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">舰艇（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Ship_Unit_Prototype</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">）。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S20">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Combat_Arms_Type</xsl:with-param>
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
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">台、套，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">损毁。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S21">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Transportation_Class</xsl:with-param>
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
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">台、套，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">损毁。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S22">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
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
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">架，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">架损毁。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S23">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">两栖输送工具（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Small_Boat</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">），</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">艘，其中</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@C"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">艘损坏。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">开始维修。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主体修复工程将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无修复记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S24">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">补给（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Supply_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">）。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:for-each select="G1/R">
                     <xsl:for-each select="S1">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前开始补充。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                     <xsl:for-each select="S3">
                        <xsl:call-template name="parse-col">
                           <xsl:with-param name="target-string">主要工作将于</xsl:with-param>
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
                           <xsl:with-param name="target-string">前完成。</xsl:with-param>
                           <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                        </xsl:call-template>
                     </xsl:for-each>
                  </xsl:for-each>
               </xsl:for-each>
               <xsl:for-each select="S2">
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">无补给记录。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
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
            <xsl:for-each select="S34"/>
         </xsl:for-each>
      </xsl:for-each>
      <xsl:for-each select="S4">
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">&lt;p class='title1'&gt;未毁伤目标情报&lt;/p&gt;</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="G1/R">
            <xsl:for-each select="S2">
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
                  <xsl:with-param name="target-string">名称：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">所属集团：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，敏感目标标识：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@F"/>
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
                           <xsl:value-of select="../D/@G"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，主体情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">附加情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，与前次情报相比：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Change_Code</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@N"/>
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
                  <xsl:with-param name="target-string">名称：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@D"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">所属集团：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="unit_name_transform_FUN">
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@E"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，敏感目标标识：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@F"/>
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
                           <xsl:value-of select="../D/@G"/>
                        </xsl:with-param>
                        <xsl:with-param name="arg2">
                           <xsl:value-of select="../D/@H"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，主体情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">附加情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，与前次情报相比：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Change_Code</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="../D/@N"/>
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
                  <xsl:with-param name="target-string">防空阵地（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
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
                  <xsl:with-param name="target-string">），配备</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个发射装置。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S5">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Bridge_Class</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，具有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S6">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Tunnel_Class</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，具有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S7">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Sensor_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">阵地。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S8">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">跑道（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">），配备</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Runway_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个飞机机库。 </xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S9">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Interdiction_Point_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，具有</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">条通路。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S10">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">存储点（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Supply_Storage_Area</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">）。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S11">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Surface_Surface_Missile</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，装备</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个发射装置。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S12">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Facility_Type</xsl:with-param>
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
            <xsl:for-each select="S13">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Aircraft_Shelter_Type</xsl:with-param>
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
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S14">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">装卸设施（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">MHE_Facility</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">），具备同时执行</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">项任务能力。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S15">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">标准雷场</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">个。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S16">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Pumping_Station_Class</xsl:with-param>
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
            <xsl:for-each select="S17">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Jammer_Type</xsl:with-param>
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
            <xsl:for-each select="S18">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Comm_Site_Type</xsl:with-param>
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
            <xsl:for-each select="S19">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">舰艇（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Ship_Unit_Prototype</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">）。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S20">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Combat_Arms_Type</xsl:with-param>
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
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">台、套。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S21">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Transportation_Class</xsl:with-param>
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
                     <xsl:value-of select="D/@B"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">台、套。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S22">
               <xsl:call-template name="process-br"/>
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
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">，</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
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
            <xsl:for-each select="S23">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">两栖输送工具（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Small_Boat</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">），</xsl:with-param>
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
            <xsl:for-each select="S24">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">补给（</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">Supply_Type</xsl:with-param>
                        <xsl:with-param name="arg1">
                           <xsl:value-of select="D/@A"/>
                        </xsl:with-param>
                     </xsl:call-template>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">）。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
            <xsl:for-each select="S31">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">补给运输队。</xsl:with-param>
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
      <xsl:for-each select="S5">
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">&lt;p class='title1'&gt;陆上飞机编队情报&lt;/p&gt;</xsl:with-param>
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
                  <xsl:with-param name="target-string">，主体情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">附加情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，与前次情报相比：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Change_Code</xsl:with-param>
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
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">&lt;p class='title1'&gt;作战系统残骸情报&lt;/p&gt;</xsl:with-param>
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
                  <xsl:with-param name="target-string">主体情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">附加情况：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，与前次情报相比：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:call-template name="get-vocab-value">
                        <xsl:with-param name="vocab">IIR_Change_Code</xsl:with-param>
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
      <xsl:for-each select="S7">
         <xsl:call-template name="parse-col">
            <xsl:with-param name="target-string">&lt;p class='title1'&gt;不再现目标情报&lt;/p&gt;</xsl:with-param>
            <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
         </xsl:call-template>
         <xsl:for-each select="G1/R">
            <xsl:for-each select="S5">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">——编号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">没有部队可报，敏感目标标识：</xsl:with-param>
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
                  <xsl:with-param name="target-string">坐标：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，侦察时间：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
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
                  <xsl:with-param name="target-string">没有再出现。</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:for-each select="S1">
                  <xsl:call-template name="process-br"/>
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">消失飞机机型：</xsl:with-param>
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
                  <xsl:call-template name="parse-col">
                     <xsl:with-param name="target-string">。</xsl:with-param>
                     <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
                  </xsl:call-template>
               </xsl:for-each>
            </xsl:for-each>
            <xsl:for-each select="S8">
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">——编号：</xsl:with-param>
                  <xsl:with-param name="is-begin-with-slide">0</xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="display_cur_text">
                  <xsl:with-param name="in_string">
                     <xsl:value-of select="../D/@A"/>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:call-template name="process-br"/>
               <xsl:call-template name="parse-col">
                  <xsl:with-param name="target-string">没有目标可报，敏感目标标识：</xsl:with-param>
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
                  <xsl:with-param name="target-string">坐标：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，侦察时间：</xsl:with-param>
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
                  <xsl:with-param name="target-string">，</xsl:with-param>
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
                  <xsl:with-param name="target-string">没有再出现。</xsl:with-param>
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