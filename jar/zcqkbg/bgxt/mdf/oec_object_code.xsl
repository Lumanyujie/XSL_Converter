<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet  version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- 
!! FILE:        $JTLSHOME/script/xsl/oec_object_code.xsl
!! DESCRIPTION: This stylesheet transforms the ordersdef.xml file into the
!!              Oracle script and PRO*C source code files necessary to interact
!!              with the Order Entry CLient (OEC). The following files are
!!              created:
!!              1) SQL create table script
!!              2) SQL drop table script
!!              3) Individual *.pc and *.h files for each order/utility
!!              4) An order.pc and order.h file to manage relationships between
!!                 order numbers and individual order functions
!!
!!              This stylesheet is normally run with the create_ordersdef script
!!              which will create a single XML file to process. If the input XML
!!              file exists the script can also be run with:
!!              saxon <xml_file> oec_object_code.xsl jtlshome=$JTLSHOME
-->
<xsl:param name="jtlshome" select="'/home/jtlsdev'"/>

<xsl:output method="text"/>

<xsl:variable name="oec_code_dir" select="concat($jtlshome,'/src/oec/src/generated/')"/>
<xsl:variable name="sql_script_dir" select="concat($jtlshome,'/script/sdr/')"/>
<xsl:variable name="include_dir" select="concat($jtlshome,'/include/sdr/')"/>

<!-- new line text variables -->
<xsl:variable name="cr">
  <xsl:text>
</xsl:text>
</xsl:variable>

<xsl:variable name="tab">
  <xsl:text>	</xsl:text>
</xsl:variable>

<xsl:variable name="apos">
  <xsl:text>'</xsl:text>
</xsl:variable>

<xsl:variable name="cep_time_format">
  <xsl:value-of select="concat($apos, 'DDHH24MI&quot;Z&quot;MONRR', $apos)"/>
</xsl:variable>

<xsl:variable name="count_buffer_length" select="'4'"/>

<!-- set up information for the different class types for order fields -->
<xsl:variable name="format_nodes">
  <classes>
    <class name="UT"                sql_type="VARCHAR2" sql_length="20"      c_type="char"  c_format="%s" c_length="20"/>
    <class name="FACTION"           sql_type="VARCHAR2" sql_length="15"      c_type="char"  c_format="%s" c_length="15"/>
    <class name="FORM"              sql_type="VARCHAR2" sql_length="15"      c_type="char"  c_format="%s" c_length="15"/>
    <class name="MSN"               sql_type="VARCHAR2" sql_length="15"      c_type="char"  c_format="%s" c_length="15"/>
    <class name="MSN_NAME"          sql_type="VARCHAR2" sql_length="15"      c_type="char"  c_format="%s" c_length="15"/>
    <class name="PIPE"              sql_type="VARCHAR2" sql_length="15"      c_type="char"  c_format="%s" c_length="15"/>
    <class name="DMPI"              sql_type="VARCHAR2" sql_length="15"      c_type="char"  c_format="%s" c_length="15"/>
    <class name="GENERIC_OBJECT"    sql_type="VARCHAR2" sql_length="15"      c_type="char"  c_format="%s" c_length="15"/>
    <class name="UTILITY"           sql_type="VARCHAR2" sql_length="25"      c_type="char"  c_format="%s" c_length="25"/>
    <class name="POLYGON"           sql_type="VARCHAR2" sql_length="25"      c_type="char"  c_format="%s" c_length="25"/>
    <class name="RECTANGLE"         sql_type="VARCHAR2" sql_length="25"      c_type="char"  c_format="%s" c_length="25"/>
    <class name="TIME"              sql_type="DATE"     sql_length=""        c_type="char"  c_format="%s" c_length="12"/>
    <class name="TG"                sql_type="VARCHAR2" sql_length="20"      c_type="char"  c_format="%s" c_length="20"/>
    <class name="QUOTED_TEXT"       sql_type="VARCHAR2" sql_length="DYNAMIC" c_type="char"  c_format="\&quot;%s\&quot;" c_length="DYNAMIC"/>
    <class name="TEXT"              sql_type="VARCHAR2" sql_length="DYNAMIC" c_type="char"  c_format="%s" c_length="DYNAMIC"/>
    <class name="PLAYER_MIP"        sql_type="VARCHAR2" sql_length="30"      c_type="char"  c_format="%s" c_length="30"/>
    <class name="STATIC_V"          sql_type="NUMBER"   sql_length="10"      c_type="int"   c_format="%d" c_length=""/>
    <class name="DATA_V"            sql_type="NUMBER"   sql_length="10"      c_type="int"   c_format="%d" c_length=""/>
    <class name="INTEGER"           sql_type="NUMBER"   sql_length="10"      c_type="int"   c_format="%d" c_length=""/>
    <class name="BEARING"           sql_type="NUMBER"   sql_length="3"       c_type="int"   c_format="%d" c_length=""/>
    <class name="REAL"              sql_type="NUMBER"   sql_length="12,7"    c_type="float" c_format="%f" c_length=""/>
    <class name="DURATION"          sql_type="NUMBER"   sql_length="12,7"    c_type="float" c_format="%f" c_length=""/>
    <class name="FRACTION"          sql_type="NUMBER"   sql_length="DYNAMIC" c_type="float" c_format="%f" c_length=""/>
    <class name="FLAG"              sql_type="NUMBER"   sql_length="10"      c_type="int"   c_format="%d" c_length=""/>
    <class name="BE_FACILITY"       sql_type="VARCHAR2" sql_length="10"      c_type="char"  c_format="%s" c_length="10"/>
    <class name="POLITICAL_COUNTRY" sql_type="VARCHAR2" sql_length="15"      c_type="char"  c_format="%s" c_length="15"/>
  </classes>
</xsl:variable>

<xsl:variable name="compound_nodes">
  <types>
    <type is="LOCATION">
      <class label="Lat" sql_label="_lat" default="NE" is="REAL" max="90.00" min="-90" precision="3" uom="NE"/>
      <class label="Lon" sql_label="_lon" default="NE" is="REAL" max="180.00" min="-180" precision="3" uom="NE"/>
    </type>
  </types>
</xsl:variable>


<!--
!! TEMPLATE:     match /orders-def
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: February 21, 2005
!! DESCRIPTION:  This is the main driver template for generating the OEC code
!!               For each type of order. It opens a file and writes the code
!!               to it.
-->
<xsl:template match="/orders-def">

  <!-- create SQL scripts to create and destroy all order/utility tables -->
  <xsl:variable name="filename_create" select="concat($sql_script_dir, 'order_tables_create.sql')"/>
  <xsl:result-document method="text" href="{$filename_create}">
    <xsl:call-template name="sql-create-file"/>
  </xsl:result-document>

  <xsl:variable name="filename_drop" select="concat($sql_script_dir, 'order_tables_drop.sql')"/>
  <xsl:result-document method="text" href="{$filename_drop}">
    <xsl:call-template name="sql-drop-file"/>
  </xsl:result-document>

  <!-- Write an include file of strtuctures to match the Oracle tables -->
  <xsl:variable name="filename_include" select="concat($include_dir, 'oec.h')"/>
  <xsl:result-document method="text" href="{$filename_include}">
    <xsl:call-template name="include-structure-file"/>
  </xsl:result-document>

  <!-- determine the highest order number -->
  <xsl:variable name="nbr_of_orders">
    <xsl:for-each select="utility/order | orders/order">
      <xsl:sort select="@number" data-type="number" order="ascending"/>
      <xsl:if test="position() = last()">
        <xsl:value-of select="@number"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>

  <!--write order.h and order.pc files -->
  <xsl:variable name="order_header" select="concat($oec_code_dir, 'order.h')"/>
  <xsl:result-document method="text" href="{$order_header}">
    <xsl:call-template name="order-include-file"/>
  </xsl:result-document>

  <xsl:variable name="order_source" select="concat($oec_code_dir, 'order.pc')"/>
  <xsl:result-document method="text" href="{$order_source}">
    <xsl:call-template name="order-source-file">
      <xsl:with-param name="nbr" select="$nbr_of_orders"/>
    </xsl:call-template>
  </xsl:result-document>

  <!-- for each of the orders/utilities create a header and PRO*C source file
       to retrieve and manage the objects from the Oracle database -->
  <xsl:for-each select="utility/order | orders/order">

    <xsl:variable name="order_type" select="name(../.)"/>

    <xsl:variable name="sql_name">
      <xsl:call-template name="get-sql-name">
        <xsl:with-param name="base_name" select="@short-name"/> 
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="filename_h" select="concat($oec_code_dir, $sql_name, 'sdr.h')"/>
    <xsl:result-document method="text" href="{$filename_h}">
      <xsl:call-template name="source-header-file">
        <xsl:with-param name="order_type" select="$order_type"/>
      </xsl:call-template>
    </xsl:result-document>

    <xsl:variable name="filename_pc" select="concat($oec_code_dir, $sql_name, 'sdr.pc')"/>
    <xsl:result-document method="text" href="{$filename_pc}">
      <xsl:call-template name="source-proc-file">
        <xsl:with-param name="order_type" select="$order_type"/>
      </xsl:call-template>
    </xsl:result-document>

  </xsl:for-each> <!-- for each order/utility -->

</xsl:template> <!-- process-orders -->


<!--
!! TEMPLATE:     include-structure-file
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: February 21, 2005
!! DESCRIPTION:  This template writes a header file containing structures for
!!               all orders and utilities that match the tables within the OEC
!!               database.
-->
<xsl:template name="include-structure-file">

  <xsl:variable name="include_define" select="'__OEC_INCLUDE__'"/>

  <xsl:value-of select="concat('#ifndef ', $include_define, $cr)"/>
  <xsl:value-of select="concat('#define ', $include_define, $cr)"/>
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        oec.h', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This file contains structures that match the format of the OEC', $cr)"/>
  <xsl:value-of select="concat(' *              Oracle tables. These structures can be used to perform group', $cr)"/>
  <xsl:value-of select="concat(' *              retrieves of data from those tables.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Create the structures that mimic the format of the Oracle table -->
  <xsl:for-each select="utility/order | orders/order">

    <xsl:variable name="order_type" select="name(../.)"/>

    <xsl:variable name="struct_name">
      <xsl:call-template name="get-sql-name">
        <xsl:with-param name="base_name" select="concat('oec_', @name, '_TABLE')"/> 
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="struct_macro">
      <xsl:call-template name="get-macro-name">
        <xsl:with-param name="base_name" select="$struct_name"/> 
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="indicator_name">
      <xsl:call-template name="get-sql-name">
        <xsl:with-param name="base_name" select="concat('oec_', @name, '_INDICATOR')"/> 
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="indicator_macro">
      <xsl:call-template name="get-macro-name">
        <xsl:with-param name="base_name" select="$indicator_name"/> 
      </xsl:call-template>
    </xsl:variable>

    <!-- Create the structure that mimics the format of the Oracle table -->
    <xsl:value-of select="concat('typedef struct ', $struct_name, ' {', $cr)"/>
    <xsl:if test="$order_type = 'utility'">
      <xsl:value-of select="concat('   int sequenceNumber;', $cr)"/>
    </xsl:if>
    <xsl:value-of select="concat('   char clientName[31];', $cr)"/>
    <xsl:value-of select="concat('   char reference[26];', $cr)"/>

    <xsl:for-each select="fields/field | silent-fields/silent-field">

      <xsl:variable name="column_name">
        <xsl:call-template name="get-sql-name">
          <xsl:with-param name="base_name" select="@label"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="field_name">
        <xsl:call-template name="get-local-name">
          <xsl:with-param name="base_name" select="$column_name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="field_node" select="."/>
      <xsl:variable name="compound_node">
        <xsl:call-template name="field-node-to-compound-node-set"/>
      </xsl:variable>

      <xsl:variable name="printable">
        <xsl:call-template name="field-node-is-printable">
          <xsl:with-param name="reason" select="'standard'"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:for-each select="$compound_node/*[$printable = 'true']">
        <xsl:variable name="compound_name" select="concat($field_name, @label)"/>

        <xsl:variable name="format_node">
          <xsl:call-template name="class-node-to-format-node"/>
        </xsl:variable>

        <xsl:variable name="length_string">
          <xsl:if test="$format_node/class/@c_type = 'char'">
            <xsl:value-of select="concat('[', $format_node/class/@c_length, '+1]')"/>
          </xsl:if>
        </xsl:variable>

        <xsl:value-of select="concat('   ', $format_node/class/@c_type, ' ', $compound_name, $length_string, ';', $cr)"/>
      </xsl:for-each>

    </xsl:for-each> <!-- field -->
    <xsl:value-of select="concat('} ', $struct_macro, ';', $cr)"/>
    <xsl:value-of select="$cr"/>

    <!-- Create the matching indicator structure -->
    <xsl:value-of select="concat('typedef struct ', $indicator_name, ' {', $cr)"/>
    <xsl:if test="$order_type = 'utility'">
      <xsl:value-of select="concat('   short sequenceNumber;', $cr)"/>
    </xsl:if>
    <xsl:value-of select="concat('   short clientName;', $cr)"/>
    <xsl:value-of select="concat('   short reference;', $cr)"/>

    <xsl:for-each select="fields/field | silent-fields/silent-field">

      <xsl:variable name="column_name">
        <xsl:call-template name="get-sql-name">
          <xsl:with-param name="base_name" select="@label"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="field_name">
        <xsl:call-template name="get-local-name">
          <xsl:with-param name="base_name" select="$column_name"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="field_node" select="."/>
      <xsl:variable name="compound_node">
        <xsl:call-template name="field-node-to-compound-node-set"/>
      </xsl:variable>

      <xsl:variable name="printable">
        <xsl:call-template name="field-node-is-printable">
          <xsl:with-param name="reason" select="'standard'"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:for-each select="$compound_node/*[$printable = 'true']">
        <xsl:variable name="compound_name" select="concat($field_name, @label)"/>

        <xsl:variable name="format_node">
          <xsl:call-template name="class-node-to-format-node"/>
        </xsl:variable>

        <xsl:value-of select="concat('   short ', $compound_name, ';', $cr)"/>
      </xsl:for-each>

    </xsl:for-each> <!-- field -->
    <xsl:value-of select="concat('} ', $indicator_macro, ';', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each> <!-- for each order/utility -->

  <xsl:value-of select="concat('#endif /* not defined ', $include_define, ' */', $cr)"/>

</xsl:template> <!-- include-structure-file -->


<!--
!! TEMPLATE:     source-header-file
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: February 21, 2005
!! DESCRIPTION:  This template writes the header file for a utility/order.
!! PARAMETERS:   order_type: 'utility' or 'orders'
-->
<xsl:template name="source-header-file">
  <xsl:param name="order_type"/>

  <xsl:variable name="short_name">
    <xsl:call-template name="to-lower">
      <xsl:with-param name="base_name" select="@short-name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="global_name">
    <xsl:call-template name="get-global-name">
      <xsl:with-param name="base_name" select="$short_name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="macro_name">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="$short_name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="long_name">
    <xsl:call-template name="to-lower">
      <xsl:with-param name="base_name" select="@name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="oec_macro">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="concat('OEC_', $long_name, '_TABLE')"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="struct_macro">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="concat($long_name, '_SDR')"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="oec_indicator">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="concat('OEC_', $long_name, '_INDICATOR')"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="indicator_macro">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="concat($long_name, '_IND')"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="compose_function" select="concat($global_name, 'ComposeOrder')"/>
  <xsl:variable name="truncate_function" select="concat($global_name, 'TruncateTable')"/>
  <xsl:variable name="define_string" select="concat('__', $macro_name, '_INCLUDE__')"/>
  <xsl:variable name="source_string" select="concat('__', $macro_name, '_SOURCE__')"/>
  <xsl:variable name="extern_string" select="concat('__', $macro_name, '_EXTERN')"/>

  <xsl:value-of select="concat('#ifndef ', $define_string, $cr)"/>
  <xsl:value-of select="concat('#define ', $define_string, $cr)"/>
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        ', $oec_code_dir, $short_name, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This file is automatically generated by the style sheet. It', $cr)"/>
  <xsl:value-of select="concat(' *              defines the structures and function prototypes to retrieve', $cr)"/>
  <xsl:value-of select="concat(' *              the ', @short-name, ' orders from the Scenario Data Repository', $cr)"/>
  <xsl:value-of select="concat(' *              (SDR) tables.', $cr)"/>
  <xsl:value-of select="concat(' *', $cr)"/>
  <xsl:value-of select="concat(' *              Changes should not be made to this file, since the file will', $cr)"/>
  <xsl:value-of select="concat(' *              be re-generated by the style sheet when changes are made to the', $cr)"/> 
  <xsl:value-of select="concat(' *              JTLS orders/', @short-name, '.xml file.', $cr)"/> 
  <xsl:value-of select="concat(' *---------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('#include &quot;sdr/oec.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_logger.h&quot;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Create the structure that mimics the format of the Oracle table -->
  <xsl:value-of select="concat('typedef ', $oec_macro, ' ', $struct_macro, ';', $cr)"/>
  <xsl:value-of select="concat('typedef ', $oec_indicator, ' ', $indicator_macro, ';', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Take care of the function prototypes -->
  <xsl:value-of select="concat('#ifdef ', $source_string, $cr)"/>
  <xsl:value-of select="concat('#define ', $extern_string, $cr)"/>
  <xsl:value-of select="concat('#else', $cr)"/>
  <xsl:value-of select="concat('#define ', $extern_string, ' extern', $cr)"/>
  <xsl:value-of select="concat('#endif', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat($extern_string, ' int  ', $compose_function, '( char *, char *, char *, size_t );', $cr)"/>
  <xsl:value-of select="concat($extern_string, ' void ', $truncate_function, '( void );', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Close out the file -->
  <xsl:value-of select="concat('#endif /* not defined ', $define_string, ' */', $cr)"/>

</xsl:template> <!-- source-header-file -->


<!--
!! TEMPLATE:     source-proc-file
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: February 21, 2005
!! DESCRIPTION:  This template writes the PRO*C source code for a utility/order.
!! PARAMETERS:   order_type: 'utility' or 'orders'
-->
<xsl:template name="source-proc-file">
  <xsl:param name="order_type"/>

  <xsl:variable name="short_name">
    <xsl:call-template name="to-lower">
      <xsl:with-param name="base_name" select="@short-name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="global_name">
    <xsl:call-template name="get-global-name">
      <xsl:with-param name="base_name" select="$short_name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="local_name">
    <xsl:call-template name="get-local-name">
      <xsl:with-param name="base_name" select="$short_name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="macro_name">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="$short_name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="long_name">
    <xsl:call-template name="to-lower">
      <xsl:with-param name="base_name" select="@name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="struct_name">
    <xsl:call-template name="get-sql-name">
      <xsl:with-param name="base_name" select="concat($long_name, '_sdr')"/> 
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="struct_macro">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="$struct_name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="indicator_name">
    <xsl:call-template name="get-sql-name">
      <xsl:with-param name="base_name" select="concat($long_name, '_ind')"/> 
    </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="indicator_macro">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="$indicator_name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="table_name">
    <xsl:call-template name="get-table-name">
      <xsl:with-param name="base_name" select="@name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="compose_function" select="concat($global_name, 'ComposeOrder')"/>
  <xsl:variable name="truncate_function" select="concat($global_name, 'TruncateTable')"/>
  <xsl:variable name="retrieve_function" select="concat($local_name, 'RetrieveOrder')"/>
  <xsl:variable name="format_function" select="concat($local_name, 'FormatOrder')"/>
  <xsl:variable name="source_string" select="concat('__', $macro_name, '_SOURCE__')"/>
  <xsl:variable name="buffer_define" select="concat($macro_name, '_COUNT_BUFFER')"/>

  <!-- Write out the header information and standard include files -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        ', $oec_code_dir, $short_name, 'sdr.pc', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This file is automatically generated by the style sheet. It', $cr)"/>
  <xsl:value-of select="concat(' *              contains the source code to retrieve, format, and send the', $cr)"/>
  <xsl:value-of select="concat(' *              ', $macro_name, ' orders from the Scenario Data Repository', $cr)"/>
  <xsl:value-of select="concat(' *             (SDR) tables.', $cr)"/>
  <xsl:value-of select="concat(' *', $cr)"/>
  <xsl:value-of select="concat(' *              Changes should not be made to this file, since the file will', $cr)"/>
  <xsl:value-of select="concat(' *              be re-generated by the style sheet when changes are made to the', $cr)"/> 
  <xsl:value-of select="concat(' *              JTLS orders/', $macro_name, '.xml file.', $cr)"/> 
  <xsl:value-of select="concat(' *---------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('#define ', $source_string, $cr)"/>
  <xsl:value-of select="concat('#include &lt;stdio.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &lt;stdlib.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &lt;string.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_net.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_logger.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;ovl/strings.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;oec.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;database.h&quot;', $cr)"/>

  <!-- write out include files for each utility that is a field type and for
       polygon retrieval if any fields are polygons -->
  <xsl:for-each select="fields/field[class/@is = 'UTILITY'] | silent-fields/silent-field[class/@is = 'UTILITY']">
    <xsl:variable name="utility_name">
      <xsl:call-template name="to-lower">
        <xsl:with-param name="base_name" select="class/@name"/> 
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('#include &quot;', $utility_name, 'sdr.h&quot;', $cr)"/>
  </xsl:for-each>
  <xsl:if test="count(fields/field[class/@is = 'POLYGON' or class/@is = 'RECTANGLE'] | silent-fields/silent-field[class/@is = 'POLYGON' or class/@is = 'RECTANGLE']) > 0">
    <xsl:value-of select="concat('#include &quot;polygon.h&quot;', $cr)"/>
  </xsl:if>
  <xsl:value-of select="concat('#include &quot;', $short_name, 'sdr.h&quot;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- write out the SQL instruction lines -->
  <xsl:value-of select="concat('EXEC SQL INCLUDE SQLCA;', $cr)"/>
  <xsl:value-of select="concat('EXEC SQL WHENEVER SQLERROR CONTINUE;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Group defines -->
  <xsl:value-of select="concat('#define ', $buffer_define, ' ', $count_buffer_length, $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- write out the static function prototypes -->
  <xsl:value-of select="concat('static int ', $retrieve_function)"/>
  <xsl:choose>
    <xsl:when test="$order_type = 'utility'">
      <xsl:value-of select="concat('( char *, char *, char *, size_t );', $cr)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="concat('( char *, char *, ', $struct_macro, ' *,', $indicator_macro, ' * );', $cr)"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="concat('static int ', $format_function, '( char *, ', $struct_macro, ' *, ', $indicator_macro, ' *, char *, size_t );', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Write the function that composes the order/utility. There are too many
       differences between the order version and the utility version. Therefore
       handle them separately -->
  <xsl:choose>
    <xsl:when test="$order_type = 'utility'">
      <xsl:call-template name="source-compose-utility-function"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="source-compose-order-function"/>
    </xsl:otherwise>
  </xsl:choose>

  <!-- Write the function to truncate tables -->
  <xsl:value-of select="concat('void ', $truncate_function, '( void ) {', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL TRUNCATE TABLE ', $table_name, ';', $cr)"/>
  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('   } /* end of function ', $truncate_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Write the function that retrieves the order/utility. There are too many
       differences between the order version and the utility version. Therefore
       handle them separately -->
  <xsl:choose>
    <xsl:when test="$order_type = 'utility'">
      <xsl:call-template name="source-retrieve-utility-function"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="source-retrieve-order-function"/>
    </xsl:otherwise>
  </xsl:choose>

  <!-- write the function to format the order/utility -->
  <xsl:call-template name="source-format-function"/>

</xsl:template> <!-- source-proc-file -->


<!--
!! TEMPLATE:     source-compose-order-function
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: February 21, 2005
!! DESCRIPTION:  This template writes the ComposeOrder function for an order.
!!               The ComposeOrder function is part of the PRO*C source code
!!               for managing the function's Oracle table.
-->
<xsl:template name="source-compose-order-function">

  <xsl:variable name="long_name">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="@name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="local_name">
    <xsl:call-template name="get-local-name"> 
      <xsl:with-param name="base_name" select="@short-name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="global_name">
    <xsl:call-template name="get-global-name"> 
      <xsl:with-param name="base_name" select="@short-name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="compose_function" select="concat($global_name, 'ComposeOrder')"/>
  <xsl:variable name="retrieve_function" select="concat($local_name, 'RetrieveOrder')"/>
  <xsl:variable name="format_function" select="concat($local_name, 'FormatOrder')"/>
  <xsl:variable name="struct_macro" select="concat($long_name, '_SDR')"/> 
  <xsl:variable name="indicator_macro" select="concat($long_name, '_IND')"/> 

  <xsl:value-of select="concat('int ', $compose_function, '( char *clientName, char *orderRef, char *orderString, size_t bufferLength ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   ', $struct_macro, ' order;', $cr)"/>
  <xsl:value-of select="concat('   ', $indicator_macro, ' indicator;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   memset( &amp;order, 0, sizeof( order ) );', $cr)"/>
  <xsl:value-of select="concat('   memset( &amp;indicator, 0, sizeof( indicator ) );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   if ( ! ', $retrieve_function, '( clientName, orderRef, &amp;order, &amp;indicator ) ) {', $cr)"/>
  <xsl:value-of select="concat('      return( 0 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="concat('   if ( ! ', $format_function, '( clientName, &amp;order, &amp;indicator, orderString, bufferLength ) ) {', $cr)"/>
  <xsl:value-of select="concat('      return( 0 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   return( 1 );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $compose_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- source-compose-order-function -->


<!--
!! TEMPLATE:     source-compose-utility-function
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: February 21, 2005
!! DESCRIPTION:  This template writes the ComposeOrder function for a utility.
!!               The ComposeOrder function is part of the PRO*C source code
!!               for managing the function's Oracle table.
-->
<xsl:template name="source-compose-utility-function">

  <xsl:variable name="table_name">
    <xsl:call-template name="get-table-name">
      <xsl:with-param name="base_name" select="@name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="long_name">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="@name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="macro_name">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="@short-name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="lower_name">
    <xsl:call-template name="get-local-name"> 
      <xsl:with-param name="base_name" select="@short-name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="local_name">
    <xsl:call-template name="get-local-name"> 
      <xsl:with-param name="base_name" select="@short-name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="global_name">
    <xsl:call-template name="get-global-name"> 
      <xsl:with-param name="base_name" select="@short-name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="compose_function" select="concat($global_name, 'ComposeOrder')"/>
  <xsl:variable name="retrieve_function" select="concat($local_name, 'RetrieveOrder')"/>
  <xsl:variable name="format_function" select="concat($local_name, 'FormatOrder')"/>
  <xsl:variable name="struct_macro" select="concat($long_name, '_SDR')"/> 
  <xsl:variable name="indicator_macro" select="concat($long_name, '_IND')"/> 
  <xsl:variable name="buffer_define" select="concat($macro_name, '_COUNT_BUFFER')"/> 

  <xsl:value-of select="concat('int ', $compose_function, '( char *clientName, char *orderRef, char *orderString, size_t bufferLength ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   char *posPtr = orderString;', $cr)"/>
  <xsl:value-of select="concat('   int  nbrRetrieved;', $cr)"/>
  <xsl:value-of select="concat('   size_t countLength = bufferLength &lt; (size_t) ( ', $buffer_define, ' + 1 ) ? bufferLength : ', $buffer_define, ' + 1;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   bufferLength -= countLength;', $cr)"/>
  <xsl:value-of select="concat('   posPtr += countLength;', $cr)"/>
  <xsl:value-of select="concat('   nbrRetrieved = ', $retrieve_function, '( clientName, orderRef, posPtr, bufferLength );', $cr)"/>
  <xsl:value-of select="concat('   if ( nbrRetrieved > DATABASE_MAX_UTILITIES ) {', $cr)"/>
  <xsl:value-of select="concat('      DatabaseRetrievalError( &quot;Client %s Utility %s Contains Too Many Records, %d, In Table ', $table_name, '\n&quot;,', $cr)"/>
  <xsl:value-of select="concat('            clientName, orderRef, nbrRetrieved );', $cr)"/>
  <xsl:value-of select="concat('      return( 0 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="concat('   if ( ! nbrRetrieved ) {', $cr)"/>
  <xsl:value-of select="concat('      DatabaseRetrievalError( &quot;Client %s Utility %s Contains No Records In Table ', $table_name, '\n&quot;,', $cr)"/>
  <xsl:value-of select="concat('            clientName, orderRef );', $cr)"/>
  <xsl:value-of select="concat('      return( 0 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   snprintf( orderString, countLength, &quot;%-', $count_buffer_length, 'd&quot;, nbrRetrieved );', $cr)"/>
  <xsl:value-of select="concat('   orderString[countLength-1] = ', $apos, ' ', $apos, ';', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   return( 1 );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $compose_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- source-compose-utility-function -->


<!--
!! TEMPLATE:     source-retrieve-order-function
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: February 21, 2005
!! DESCRIPTION:  This template writes the RetrieveOrder function for an order.
!!               The RetrieveOrder function function is responsible for
!!               retrieving records from the order's Oracle table.
-->
<xsl:template name="source-retrieve-order-function">

  <xsl:variable name="table_name">
    <xsl:call-template name="get-table-name">
      <xsl:with-param name="base_name" select="@name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="long_name">
    <xsl:call-template name="get-global-name">
      <xsl:with-param name="base_name" select="@name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="macro_name">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="@name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="local_name">
    <xsl:call-template name="get-local-name"> 
      <xsl:with-param name="base_name" select="@short-name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="global_name">
    <xsl:call-template name="get-global-name"> 
      <xsl:with-param name="base_name" select="@short-name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="retrieve_function" select="concat($local_name, 'RetrieveOrder')"/>
  <xsl:variable name="struct_macro" select="concat($macro_name, '_SDR')"/> 
  <xsl:variable name="indicator_macro" select="concat($macro_name, '_IND')"/> 

  <xsl:value-of select="concat('static int ', $retrieve_function, '( char *clientName, char *orderRef,', $cr)"/>
  <xsl:value-of select="concat('      ', $struct_macro, ' *orderPtr, ', $indicator_macro, ' *indicatorPtr ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL BEGIN DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="concat('   char lClientName[DATABASE_CLIENT_NAME+1];', $cr)"/>
  <xsl:value-of select="concat('   char lOrderRef[DATABASE_REFERENCE+1];', $cr)"/>
  <xsl:value-of select="concat('   ', $struct_macro, ' lOrder;', $cr)"/>
  <xsl:value-of select="concat('   ', $indicator_macro, ' lIndicator;', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL END DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   strcpy( lClientName, clientName );', $cr)"/>
  <xsl:value-of select="concat('   strcpy( lOrderRef, orderRef );', $cr)"/>
  <xsl:value-of select="concat('   memset( &amp;lOrder, 0, sizeof( lOrder ) );', $cr)"/>
  <xsl:value-of select="concat('   memset( &amp;lIndicator, 0, sizeof( lIndicator ) );', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- write the select statement. A comma gets added after the reference only
       if there are other fields in the order -->
  <xsl:variable name="comma">
    <xsl:if test="count(fields/field | silent-fields/silent-field) != 0">
      <xsl:value-of select="','"/>
    </xsl:if>
  </xsl:variable>

  <xsl:value-of select="concat('   EXEC SQL SELECT', $cr)"/>
  <xsl:value-of select="concat('      client_name,', $cr)"/>
  <xsl:value-of select="concat('      reference', $comma, $cr)"/>

  <xsl:for-each select="fields/field | silent-fields/silent-field">

    <xsl:variable name="field_is_last" select="position() = last()"/>

    <xsl:variable name="field_name">
      <xsl:call-template name="get-sql-name">
        <xsl:with-param name="base_name" select="@label"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="compound_node">
      <xsl:call-template name="field-node-to-compound-node-set"/>
    </xsl:variable>

    <xsl:variable name="printable">
      <xsl:call-template name="field-node-is-printable">
        <xsl:with-param name="reason" select="'standard'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:for-each select="$compound_node/*[$printable = 'true']">
      <xsl:variable name="column_name" select="concat($field_name, @sql_label)"/>
      <xsl:variable name="column_comma">
        <xsl:if test="$field_is_last = false() or position() != last()">
          <xsl:value-of select="','"/>
        </xsl:if>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="@is = 'TIME'">
          <xsl:value-of select="concat('      TO_CHAR(', $column_name, ', ', $cep_time_format, ')', $column_comma, $cr)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('      ', $column_name, $column_comma, $cr)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>

  </xsl:for-each> <!-- field -->
  <xsl:value-of select="concat('      INTO :lOrder', $cr)"/>
  <xsl:value-of select="concat('      INDICATOR :lIndicator', $cr)"/>
  <xsl:value-of select="concat('      FROM ', $table_name, $cr)"/>
  <xsl:value-of select="concat('      WHERE reference = :lOrderRef AND client_name = :lClientName;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   if ( sqlca.sqlcode ) {', $cr)"/>
  <xsl:value-of select="concat('      DatabaseRetrievalError( &quot;Failed To Retrieve ', $macro_name, ' Order %s For Client %s From Table ', $table_name, '\n&quot;, orderRef, clientName );', $cr)"/>
  <xsl:value-of select="concat('      return( 0 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   memcpy( orderPtr, &amp;lOrder, sizeof( lOrder ) );', $cr)"/>
  <xsl:value-of select="concat('   memcpy( indicatorPtr, &amp;lIndicator, sizeof( lIndicator ) );', $cr)"/>
  <xsl:value-of select="concat('   StrStripBlanks( orderPtr->reference );', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- for each text field write code to check that an entry was made, and if
       so check that the entry actually contains something other than space -->
  <xsl:for-each select="fields/field | silent-fields/silent-field">

    <xsl:variable name="field_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="@label"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="compound_node">
      <xsl:call-template name="field-node-to-compound-node-set"/>
    </xsl:variable>

    <xsl:variable name="printable">
      <xsl:call-template name="field-node-is-printable">
        <xsl:with-param name="reason" select="'standard'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:for-each select="$compound_node/*[$printable = 'true']">

      <xsl:variable name="format_node">
        <xsl:call-template name="class-node-to-format-node"/>
      </xsl:variable>

      <xsl:if test="$format_node/class/@c_type = 'char'">
        <xsl:variable name="compound_name" select="concat($field_name, @label)"/>

        <xsl:value-of select="concat('   if ( indicatorPtr-&gt;', $compound_name, ' == 0 ) {', $cr)"/>
        <xsl:value-of select="concat('      StrStripBlanks( orderPtr-&gt;', $compound_name, ' );', $cr)"/>
        <xsl:value-of select="concat('      if ( orderPtr->', $compound_name, '[0] == ', $apos, '\0', $apos, ' ) {', $cr)"/>
        <xsl:value-of select="concat('         indicatorPtr-&gt;', $compound_name, ' = 1;', $cr)"/>
        <xsl:value-of select="concat('      }', $cr)"/>
        <xsl:value-of select="concat('   }', $cr)"/>
        <xsl:value-of select="$cr"/>
      </xsl:if>

    </xsl:for-each>

  </xsl:for-each> <!-- field -->

  <xsl:value-of select="concat('   return( 1 );', $cr)"/> 
  <xsl:value-of select="concat('} /* end of function ', $retrieve_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- source-retrieve-order-function -->


<!--
!! TEMPLATE:     source-retrieve-utility-function
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: February 21, 2005
!! DESCRIPTION:  This template writes the RetrieveOrder function for a utility.
!!               The RetrieveOrder function function is responsible for
!!               retrieving records from the utility's Oracle table.
-->
<xsl:template name="source-retrieve-utility-function">

  <xsl:variable name="table_name">
    <xsl:call-template name="get-table-name">
      <xsl:with-param name="base_name" select="@name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="long_name">
    <xsl:call-template name="get-global-name">
      <xsl:with-param name="base_name" select="@name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="macro_name">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="@name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="local_name">
    <xsl:call-template name="get-local-name"> 
      <xsl:with-param name="base_name" select="@short-name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="global_name">
    <xsl:call-template name="get-global-name"> 
      <xsl:with-param name="base_name" select="@short-name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="retrieve_function" select="concat($local_name, 'RetrieveOrder')"/>
  <xsl:variable name="format_function" select="concat($local_name, 'FormatOrder')"/>
  <xsl:variable name="struct_macro" select="concat($macro_name, '_SDR')"/> 
  <xsl:variable name="indicator_macro" select="concat($macro_name, '_IND')"/> 
  <xsl:variable name="cursor_name" select="concat($local_name, '_cursor')"/> 

  <xsl:value-of select="concat('static int ', $retrieve_function, '( char *clientName, char *orderRef, char *orderStr, size_t bufferLength ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL BEGIN DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="concat('   char lClientName[DATABASE_CLIENT_NAME+1];', $cr)"/>
  <xsl:value-of select="concat('   char lOrderRef[DATABASE_REFERENCE+1];', $cr)"/>
  <xsl:value-of select="concat('   ', $struct_macro, ' lUtil[DATABASE_FETCH_SIZE];', $cr)"/>
  <xsl:value-of select="concat('   ', $indicator_macro, ' lIndicator[DATABASE_FETCH_SIZE];', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL END DECLARE SECTION;', $cr)"/>
  <xsl:value-of select="concat('   int nbrRetrieved;', $cr)"/>
  <xsl:value-of select="concat('   char *posPtr = orderStr;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   strcpy( lClientName, clientName );', $cr)"/>
  <xsl:value-of select="concat('   strcpy( lOrderRef, orderRef );', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- write the fetch cursor. A comma gets added after the reference only
       if there are other fields in the order -->
  <xsl:variable name="comma">
    <xsl:if test="count(fields/field | silent-fields/silent-field) != 0">
      <xsl:value-of select="','"/>
    </xsl:if>
  </xsl:variable>

  <xsl:value-of select="concat('   EXEC SQL DECLARE ', $cursor_name, ' CURSOR FOR', $cr)"/>
  <xsl:value-of select="concat('      SELECT', $cr)"/>
  <xsl:value-of select="concat('         sequence_number,', $cr)"/>
  <xsl:value-of select="concat('         client_name,', $cr)"/>
  <xsl:value-of select="concat('         reference', $comma, $cr)"/>

  <xsl:for-each select="fields/field | silent-fields/silent-field">

    <xsl:variable name="field_is_last" select="position() = last()"/>

    <xsl:variable name="field_name">
      <xsl:call-template name="get-sql-name">
        <xsl:with-param name="base_name" select="@label"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="compound_node">
      <xsl:call-template name="field-node-to-compound-node-set"/>
    </xsl:variable>

    <xsl:variable name="printable">
      <xsl:call-template name="field-node-is-printable">
        <xsl:with-param name="reason" select="'standard'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:for-each select="$compound_node/*[$printable = 'true']">
      <xsl:variable name="column_name" select="concat($field_name, @sql_label)"/>
      <xsl:variable name="column_comma">
        <xsl:if test="$field_is_last = false() or position() != last()">
          <xsl:value-of select="','"/>
        </xsl:if>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="@is = 'TIME'">
          <xsl:value-of select="concat('         TO_CHAR(', $column_name, ', ', $cep_time_format, ')', $column_comma, $cr)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('         ', $column_name, $column_comma, $cr)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>

  </xsl:for-each> <!-- field -->
  <xsl:value-of select="concat('      FROM ', $table_name, $cr)"/>
  <xsl:value-of select="concat('      WHERE reference = :lOrderRef AND client_name = :lClientName', $cr)"/>
  <xsl:value-of select="concat('      ORDER BY sequence_number;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Write the code to execute the cursor in a loop -->
  <xsl:value-of select="concat('   EXEC SQL OPEN ', $cursor_name, ';', $cr)"/>
  <xsl:value-of select="concat('   for ( nbrRetrieved = 0; ; ) {', $cr)"/>
  <xsl:value-of select="concat('      int index = 0;', $cr)"/>
  <xsl:value-of select="concat('      int fetchSize = 0;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      memset( &amp;lUtil, 0, sizeof( lUtil ) );', $cr)"/>
  <xsl:value-of select="concat('      memset( &amp;lIndicator, 0, sizeof( lIndicator ) );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      EXEC SQL FOR :DATABASE_FETCH_SIZE FETCH ', $cursor_name, ' INTO :lUtil INDICATOR :lIndicator;', $cr)"/>
  <xsl:value-of select="concat('      fetchSize = sqlca.sqlerrd[2] - nbrRetrieved;', $cr)"/>
  <xsl:value-of select="concat('      nbrRetrieved += fetchSize;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      if ( ! fetchSize ) {', $cr)"/>
  <xsl:value-of select="concat('         break;', $cr)"/>
  <xsl:value-of select="concat('      }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      for ( ; index &lt; fetchSize; index++ ) {', $cr)"/>
  <xsl:value-of select="concat('         size_t partialLength;', $cr)"/>
  <xsl:value-of select="concat('         ', $struct_macro, ' *utilityPtr = &amp;lUtil[index];', $cr)"/>
  <xsl:value-of select="concat('         ', $indicator_macro, ' *indicatorPtr = &amp;lIndicator[index];', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- for each text field write code to check that an entry was made, and if
       so check that the entry actually contains something other than space -->
  <xsl:for-each select="fields/field | silent-fields/silent-field">

    <xsl:variable name="field_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="@label"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="compound_node">
      <xsl:call-template name="field-node-to-compound-node-set"/>
    </xsl:variable>

    <xsl:variable name="printable">
      <xsl:call-template name="field-node-is-printable">
        <xsl:with-param name="reason" select="'standard'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:for-each select="$compound_node/*[$printable = 'true']">

      <xsl:variable name="format_node">
        <xsl:call-template name="class-node-to-format-node"/>
      </xsl:variable>

      <xsl:if test="$format_node/class/@c_type = 'char'">
        <xsl:variable name="compound_name" select="concat($field_name, @label)"/>

        <xsl:value-of select="concat('         if ( indicatorPtr-&gt;', $compound_name, ' == 0 ) {', $cr)"/>
        <xsl:value-of select="concat('            StrStripBlanks( utilityPtr-&gt;', $compound_name, ' );', $cr)"/>
        <xsl:value-of select="concat('            if ( utilityPtr->', $compound_name, '[0] == ', $apos, '\0', $apos, ' ) {', $cr)"/>
        <xsl:value-of select="concat('               indicatorPtr-&gt;', $compound_name, ' = 1;', $cr)"/>
        <xsl:value-of select="concat('            }', $cr)"/>
        <xsl:value-of select="concat('         }', $cr)"/>
        <xsl:value-of select="$cr"/>
      </xsl:if>

    </xsl:for-each>

  </xsl:for-each> <!-- field -->

  <xsl:value-of select="concat('         snprintf( posPtr, bufferLength, &quot;{ &quot; );', $cr)"/>
  <xsl:value-of select="concat('         partialLength = strlen( posPtr );', $cr)"/>
  <xsl:value-of select="concat('         bufferLength -= partialLength;', $cr)"/>
  <xsl:value-of select="concat('         posPtr += partialLength;', $cr)"/>
  <xsl:value-of select="concat('         if ( ! ', $format_function, '( clientName, utilityPtr, indicatorPtr, posPtr, bufferLength ) ) {', $cr)"/>
  <xsl:value-of select="concat('            return( 0 );', $cr)"/>
  <xsl:value-of select="concat('         }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('         partialLength = strlen( posPtr );', $cr)"/>
  <xsl:value-of select="concat('         bufferLength -= partialLength;', $cr)"/>
  <xsl:value-of select="concat('         posPtr += partialLength;', $cr)"/>
  <xsl:value-of select="concat('         snprintf( posPtr, bufferLength, &quot;} &quot; );', $cr)"/>
  <xsl:value-of select="concat('         partialLength = strlen( posPtr );', $cr)"/>
  <xsl:value-of select="concat('         bufferLength -= partialLength;', $cr)"/>
  <xsl:value-of select="concat('         posPtr += partialLength;', $cr)"/>
  <xsl:value-of select="concat('      } /* end for each fetched index */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      if ( fetchSize &lt; DATABASE_FETCH_SIZE ) {', $cr)"/>
  <xsl:value-of select="concat('         break;', $cr)"/>
  <xsl:value-of select="concat('      }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   } /* end for fetch loop */', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL CLOSE ', $cursor_name, ';', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   return( nbrRetrieved );', $cr)"/> 
  <xsl:value-of select="concat('} /* end of function ', $retrieve_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- source-retrieve-utility-function -->


<!--
!! TEMPLATE:     source-format-function
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: 20 September 2005
!! DESCRIPTION:  This template writes out the Oracle SQL file that is
!!               responsible for formatting the order/utility into an order
!!               string.
-->
<xsl:template name="source-format-function">

  <xsl:variable name="local_name">
    <xsl:call-template name="get-local-name">
      <xsl:with-param name="base_name" select="@short-name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="long_name">
    <xsl:call-template name="to-lower">
      <xsl:with-param name="base_name" select="@name"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="struct_macro">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="concat($long_name, '_SDR')"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="indicator_macro">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="concat($long_name, '_IND')"/> 
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="format_function" select="concat($local_name, 'FormatOrder')"/>
  <xsl:variable name="field_set" select="fields/field | silent-fields/silent-field"/>

  <xsl:value-of select="concat('static int ', $format_function, '( char *clientName, ', $struct_macro, ' *orderPtr,', $cr)"/>
  <xsl:value-of select="concat('      ', $indicator_macro, ' *indicatorPtr, char *orderStr, size_t bufferLength ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   char *stringPtr = orderStr;', $cr)"/>
  <xsl:value-of select="concat('   size_t partialLength;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- check each field to determine if it contains data, and if it does
       format its portion of the order string -->
  <xsl:for-each select="$field_set">

    <xsl:variable name="label" select="@label"/>

    <xsl:variable name="field_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="$label"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="field_node" select="."/>
    <xsl:variable name="compound_node">
      <xsl:call-template name="field-node-to-compound-node-set"/>
    </xsl:variable>

    <xsl:variable name="printable">
      <xsl:call-template name="field-node-is-printable">
        <xsl:with-param name="reason" select="'format'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:for-each select="$compound_node/*[$printable = 'true']">

      <xsl:variable name="format_node">
        <xsl:call-template name="class-node-to-format-node"/>
      </xsl:variable>

      <xsl:variable name="compound_name" select="concat($field_name, @label)"/>

      <xsl:if test="position() = 1">
        <xsl:value-of select="concat('   if ( indicatorPtr->', $compound_name, ' == 0 ) {', $cr)"/>
      </xsl:if>

      <xsl:if test="position() = 1 and $format_node/class/@name != 'FLAG'">
        <xsl:value-of select="concat('      snprintf( stringPtr, bufferLength, &quot;', $field_node/@name, ' &quot; );', $cr)"/>
        <xsl:value-of select="concat('      partialLength = strlen( stringPtr );', $cr)"/>
        <xsl:value-of select="concat('      bufferLength -= partialLength;', $cr)"/>
        <xsl:value-of select="concat('      stringPtr += partialLength;', $cr)"/>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="$format_node/class/@name = 'POLYGON' or $format_node/class/@name = 'RECTANGLE'">
          <xsl:value-of select="concat('      if ( ! PolygonComposeOrder( clientName, orderPtr->', $compound_name, ', stringPtr, bufferLength ) ) {', $cr)"/>
          <xsl:value-of select="concat('         return( 0 );', $cr)"/>
          <xsl:value-of select="concat('      }', $cr)"/>
        </xsl:when>
        <xsl:when test="$format_node/class/@name = 'UTILITY'">
          <xsl:variable name="utility_name">
            <xsl:call-template name="get-global-name">
              <xsl:with-param name="base_name" select="@name"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="utility_function" select="concat($utility_name, 'ComposeOrder')"/>
          <xsl:value-of select="concat('      if ( ! ', $utility_function, '( clientName, orderPtr->', $compound_name, ', stringPtr, bufferLength ) ) {', $cr)"/>
          <xsl:value-of select="concat('         return( 0 );', $cr)"/>
          <xsl:value-of select="concat('      }', $cr)"/>
        </xsl:when>
        <xsl:when test="$format_node/class/@name = 'FLAG'">
          <xsl:value-of select="concat('      int value = orderPtr->', $compound_name, ';', $cr)"/>
          <xsl:value-of select="$cr"/>
          <xsl:for-each select="$field_set[@label = $label and class/@is = 'FLAG']">
            <xsl:choose>
              <xsl:when test="position() = 1">
                <xsl:value-of select="concat('      if ( value == ', class/@default, ' ) {', $cr)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="concat('      } else if ( value == ', class/@default, ' ) {', $cr)"/>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="concat('         snprintf( stringPtr, bufferLength, &quot;', @name, ' %d &quot;, orderPtr->', $compound_name, ' );', $cr)"/>
            <xsl:if test="position() = last()">
              <xsl:value-of select="concat('      } else { /* This is an error in the order */', $cr)"/>
              <xsl:value-of select="concat('         snprintf( stringPtr, bufferLength, &quot;', @name, ' %d &quot;, orderPtr->', $compound_name, ' );', $cr)"/>
              <xsl:value-of select="concat('      }', $cr)"/>
            </xsl:if>
          </xsl:for-each>
        </xsl:when>
        <xsl:when test="$format_node/class/@name = 'TIME'">
          <xsl:value-of select="concat('      if ( ! strcmp( orderPtr->', $compound_name, ', OEC_ASAP_ZULU_TIME ) ) {', $cr)"/>
          <xsl:value-of select="concat('         snprintf( stringPtr, bufferLength, &quot;ASAP &quot; );', $cr)"/>
          <xsl:value-of select="concat('      } else {', $cr)"/>
          <xsl:value-of select="concat('         snprintf( stringPtr, bufferLength, &quot;', $format_node/class/@c_format, ' &quot;, orderPtr->', $compound_name, ' );', $cr)"/>
          <xsl:value-of select="concat('      }', $cr)"/>
        </xsl:when>
        <xsl:otherwise> <!-- standard simple entry-->
          <xsl:value-of select="concat('      snprintf( stringPtr, bufferLength, &quot;', $format_node/class/@c_format, ' &quot;, orderPtr->', $compound_name, ' );', $cr)"/>
        </xsl:otherwise>
      </xsl:choose> <!-- class type -->
      <xsl:value-of select="concat('      partialLength = strlen( stringPtr );', $cr)"/>
      <xsl:value-of select="concat('      bufferLength -= partialLength;', $cr)"/>
      <xsl:value-of select="concat('      stringPtr += partialLength;', $cr)"/>

      <xsl:if test="position() = last()">
        <xsl:value-of select="concat('   }', $cr)"/>
        <xsl:value-of select="$cr"/>
      </xsl:if>

    </xsl:for-each> <!-- compound field -->

  </xsl:for-each> <!-- field and silent field -->

  <xsl:value-of select="concat('   return( 1 );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $format_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- source-format-function -->


<!--
!! TEMPLATE:     sql-create-file
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: 20 September 2005
!! DESCRIPTION:  This template writes out the Oracle SQL file that is
!!               responsible for creating each of the OEC order tables.
-->
<xsl:template name="sql-create-file">

  <!-- write out the header for the script -->
  <xsl:value-of select="concat(' -- This sql script file is automatically generated by the OPP. Changes to this', $cr)"/>
  <xsl:value-of select="concat(' -- file will be lost the next time the OPP generates scripts and code for the', $cr)"/>
  <xsl:value-of select="concat(' -- SDR and the Order Client.', $cr)"/>
  <xsl:value-of select="concat(' --', $cr)"/>
  <xsl:value-of select="concat(' -- This script is responsible for defining and creating all the order tables', $cr)"/>
  <xsl:value-of select="concat(' -- for a JTLS Scenario Data Repository (SDR) database.', $cr)"/>
  <xsl:value-of select="concat(' --', $cr)"/>
  <xsl:value-of select="concat(' -- Copyright notification', $cr)"/>
  <xsl:value-of select="concat(' --', $cr)"/>
  <xsl:value-of select="concat(' -- Copyright 2005 by ROLANDS &amp; ASSOCIATES Corporation', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- for each of the orders/utilities create a table -->
  <xsl:for-each select="orders/order | utility/order">
    <xsl:sort select="@number" data-type="number" order="ascending"/>

    <xsl:variable name="order_type" select="name(../.)"/>

    <xsl:variable name="table_name">
      <xsl:call-template name="get-table-name">
        <xsl:with-param name="base_name" select="@name"/> 
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="local_name">
      <xsl:call-template name="get-sql-name">
        <xsl:with-param name="base_name" select="@short-name"/> 
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="constraint_name" select="concat('oec_', $local_name, 'sdr_unq')"/>

    <xsl:value-of select="concat('-- Table for ', @name, ' (', @short-name, ')', $cr)"/>
    <xsl:value-of select="concat('CREATE TABLE ', $table_name, $cr)"/>

    <!-- utiltiies have a sequence number as first element, orders don't -->
    <xsl:choose>
      <xsl:when test="$order_type = 'utility'">
        <xsl:value-of select="concat('   (sequence_number  NUMBER(10) NOT NULL,', $cr)"/>
        <xsl:value-of select="concat('    client_name  VARCHAR2(30) NOT NULL,', $cr)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('   (client_name  VARCHAR2(30) NOT NULL,', $cr)"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="concat('    reference  VARCHAR2(25) NOT NULL,', $cr)"/>

    <!-- go through each field of the order and define a matching element -->
    <xsl:for-each select="fields/field | silent-fields/silent-field">

      <xsl:variable name="column_name">
        <xsl:call-template name="get-sql-name">
          <xsl:with-param name="base_name" select="@label"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="field_node" select="."/>
      <xsl:variable name="compound_node">
        <xsl:call-template name="field-node-to-compound-node-set"/>
      </xsl:variable>

      <xsl:variable name="printable">
        <xsl:call-template name="field-node-is-printable">
          <xsl:with-param name="reason" select="'standard'"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:for-each select="$compound_node/*[$printable = 'true']">
        <xsl:variable name="compound_name" select="concat($column_name, @sql_label)"/>

        <xsl:variable name="format_node">
          <xsl:call-template name="class-node-to-format-node"/>
        </xsl:variable>

        <xsl:variable name="format_length">
          <xsl:if test="string-length($format_node/class/@sql_length) > 0">
             <xsl:value-of select="concat('(', $format_node/class/@sql_length, ')')"/>
          </xsl:if>
        </xsl:variable>

        <xsl:value-of select="concat('    ', $compound_name, '  ', $format_node/class/@sql_type, $format_length, ',', $cr)"/>
      </xsl:for-each>

    </xsl:for-each> <!-- field -->

    <!--write out the constraint and close the table definition -->
    <xsl:value-of select="concat('    CONSTRAINT ', $constraint_name, ' UNIQUE ')"/>
    <xsl:choose>
      <xsl:when test="$order_type = 'utility'">
        <xsl:value-of select="concat('(client_name, reference, sequence_number));', $cr)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('(client_name, reference));', $cr)"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$cr"/>

  </xsl:for-each> <!-- order and utility -->

  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('-- QUIT', $cr)"/>

</xsl:template> <!-- sql-create-file -->


<!--
!! TEMPLATE:     sql-drop-file
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: 20 September 2005
!! DESCRIPTION:  This template writes out the Oracle SQL file that is
!!               responsible for dropping each of the OEC order tables.
-->
<xsl:template name="sql-drop-file">

  <xsl:value-of select="concat(' -- This sql script file is automatically generated by the OPP. Changes to this', $cr)"/>
  <xsl:value-of select="concat(' -- file will be lost the next time the OPP generates scripts and code for the ', $cr)"/>
  <xsl:value-of select="concat(' -- SDR and the Order Client.', $cr)"/>
  <xsl:value-of select="concat(' -- ', $cr)"/>
  <xsl:value-of select="concat(' -- This script is responsible for dropping all the order tables for a ', $cr)"/>
  <xsl:value-of select="concat(' -- JTLSL 3.1 - Scenario Data Repository (SDR) database.', $cr)"/>
  <xsl:value-of select="concat(' -- ', $cr)"/>
  <xsl:value-of select="concat(' -- Copyright notification ', $cr)"/>
  <xsl:value-of select="concat(' -- ', $cr)"/>
  <xsl:value-of select="concat(' -- Copyright 2005 by ROLANDS &amp; ASSOCIATES Corporation ', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- print the drop statement for each order/utility -->
  <xsl:for-each select="utility/order | orders/order">

    <xsl:variable name="table_name">
      <xsl:call-template name="get-table-name">
        <xsl:with-param name="base_name" select="@name"/> 
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('DROP TABLE ', $table_name, ';', $cr)"/>

  </xsl:for-each>

  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('-- QUIT', $cr)"/>

</xsl:template>  <!-- sql-drop-file -->


<!--
!! TEMPLATE:     order-include-file
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: March 18, 2005
!! DESCRIPTION:  This template writes order.h file
-->
<xsl:template name="order-include-file">

  <xsl:value-of select="concat('#ifndef __ORDER_INCLUDE__', $cr)"/>
  <xsl:value-of select="concat('#define __ORDER_INCLUDE__', $cr)"/>
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        /home/jtls/src/oec/generated/order.h', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This file is automatically generated by the style sheet. It contains', $cr)"/>
  <xsl:value-of select="concat(' *              the header data for the generic order information.', $cr)"/>
  <xsl:value-of select="concat(' *', $cr)"/>
  <xsl:value-of select="concat(' *              Changes should not be made to this file, since the file will', $cr)"/>
  <xsl:value-of select="concat(' *              be re-generated by the style sheet when changes are made to the', $cr)"/> 
  <xsl:value-of select="concat(' *              JTLS orders xml file.', $cr)"/> 
  <xsl:value-of select="concat(' *---------------------------------------------------------------------------*/', $cr)"/>

  <!-- add the include files for each order/utility -->
  <xsl:for-each select="orders/order | utility/order">
    <xsl:variable name="order_name">
      <xsl:call-template name="to-lower">
        <xsl:with-param name="base_name" select="@short-name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('#include &quot;', $order_name, 'sdr.h&quot;', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('#ifdef __ORDER_SOURCE', $cr)"/>
  <xsl:value-of select="concat('#define __ORDER_TYPE', $cr)"/>
  <xsl:value-of select="concat('#define __ORDER_INIT(x) = x', $cr)"/>
  <xsl:value-of select="concat('#else', $cr)"/>
  <xsl:value-of select="concat('#define __ORDER_TYPE extern', $cr)"/>
  <xsl:value-of select="concat('#define __ORDER_INIT(x)', $cr)"/>
  <xsl:value-of select="concat('#endif', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('__ORDER_TYPE int OrderNbrOrders __ORDER_INIT( 0 );', $cr)"/>
  <xsl:value-of select="concat('__ORDER_TYPE void OrderInitializeData( void );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('#endif /* not defined __ORDER_INCLUDE__ */', $cr)"/>

</xsl:template> <!-- order-include-file -->


<!--
!! TEMPLATE:     order-source-file
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: March 18, 2005
!! DESCRIPTION:  This template writes order.pc file
!! PARAMETERS:   nbr - highest number associated with an order
-->
<xsl:template name="order-source-file">
  <xsl:param name="nbr"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        /home/jtls/src/oec/generated/order.pc', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This file is automatically generated by the style sheet. It contains', $cr)"/>
  <xsl:value-of select="concat(' *              the code that initializes the lookup for the order tables.', $cr)"/>
  <xsl:value-of select="concat(' *', $cr)"/>
  <xsl:value-of select="concat(' *              Changes should not be made to this file, since the file will', $cr)"/>
  <xsl:value-of select="concat(' *              be re-generated by the style sheet when changes are made to the', $cr)"/> 
  <xsl:value-of select="concat(' *              JTLS orders xml file.', $cr)"/> 
  <xsl:value-of select="concat(' *---------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('#define __ORDER_SOURCE', $cr)"/> 
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('#include &lt;stdio.h&gt;', $cr)"/> 
  <xsl:value-of select="concat('#include &lt;stdlib.h&gt;', $cr)"/> 
  <xsl:value-of select="concat('#include &quot;database.h&quot;', $cr)"/> 
  <xsl:value-of select="concat('#include &quot;order.h&quot;', $cr)"/> 
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('void OrderInitializeData( void ) {', $cr)"/> 
  <xsl:value-of select="$cr"/> 
  <xsl:value-of select="concat('   if ( DatabaseTableInfo ) {', $cr)"/> 
  <xsl:value-of select="concat('      free( DatabaseTableInfo );', $cr)"/> 
  <xsl:value-of select="concat('   }', $cr)"/> 
  <xsl:value-of select="concat('   DatabaseTableInfo = NULL;', $cr)"/> 
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   OrderNbrOrders = ', $nbr, ';', $cr)"/> 
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   DatabaseTableInfo = (DATABASE_TABLE *)', $cr)"/> 
  <xsl:value-of select="concat('         calloc( (size_t) OrderNbrOrders + 1, sizeof( DATABASE_TABLE ) );', $cr)"/> 
  <xsl:value-of select="concat('   if ( ! DatabaseTableInfo ) {', $cr)"/> 
  <xsl:value-of select="concat('      fprintf( stderr, &quot;Can Not Allocate Memory For Order Table\n&quot; );', $cr)"/> 
  <xsl:value-of select="concat('      exit( 0 );', $cr)"/> 
  <xsl:value-of select="concat('   }', $cr)"/> 
  <xsl:value-of select="$cr"/>

  <!-- for each order/utility write out the order information -->
  <xsl:for-each select="orders/order | utility/order">
    <xsl:variable name="global_name">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="@short-name"/> 
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="retrieve_name">
      <xsl:value-of select="concat($global_name, 'ComposeOrder')"/>
    </xsl:variable>

    <xsl:variable name="truncate_name">
      <xsl:value-of select="concat($global_name, 'TruncateTable')"/>
    </xsl:variable>

    <xsl:value-of select="concat('   DatabaseTableInfo[', @number, '].orderName = &quot;', @name, '&quot;;', $cr)"/>
    <xsl:value-of select="concat('   DatabaseTableInfo[', @number, '].retrieve = ', $retrieve_name, ';', $cr)"/>
    <xsl:value-of select="concat('   DatabaseTableInfo[', @number, '].truncate = ', $truncate_name, ';', $cr)"/>
    <xsl:value-of select="$cr"/>
    </xsl:for-each> <!-- order/utility -->

  <xsl:value-of select="concat('   return;', $cr)"/> 
  <xsl:value-of select="concat('} /* end of function OrderInitializeData */', $cr)"/> 

</xsl:template> <!-- order-source-file -->


<!--
!! TEMPLATE:     field-node-is-printable
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 07 November 2007
!! DESCRIPTION:  This template expects the path to be at a field node. It
!!               'true' if the field should be treated as an independent field.
!!               Otherwise, it returns 'false' which are for the following
!!               types of fields:
!!               1) Fields whose name is 'reference' since we assign such
!!                  a field to every order.
!!               2) FLAG fields which have a successor FLAG field with the same
!!                  name
!! PARAMETERS:   reason - if 'format' fields named reference are allowed
-->
<xsl:template name="field-node-is-printable">
  <xsl:param name="reason"/>

  <xsl:variable name="position" select="position()"/>
  <xsl:variable name="label_name" select="@label"/>
  <xsl:variable name="column_name">
    <xsl:call-template name="get-sql-name">
      <xsl:with-param name="base_name" select="$label_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="field_name">
    <xsl:call-template name="get-local-name">
      <xsl:with-param name="base_name" select="$column_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="class" select="class/@is"/>

  <xsl:choose>
    <xsl:when test="$field_name = 'reference' and $reason != 'format'">
      <xsl:value-of select="'false'"/>
    </xsl:when>

    <xsl:when test="$class = 'FLAG' and count(../*[@label = $label_name and position() > $position]) > 0">
      <xsl:value-of select="'false'"/>
    </xsl:when>

    <xsl:otherwise> <!-- must be printable -->
      <xsl:value-of select="'true'"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- field-node-is-printable -->


<!--
!! TEMPLATE:     field-node-to-compound-node-set
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 07 November 2007
!! DESCRIPTION:  This template expects the path to be at a field node. If
!!               the field class is a simple data type it returns the node of
!!               the class. If the field class is a compound data type (such as
!!               LOCATION) it returns the node set of the compound classes.
-->
<xsl:template name="field-node-to-compound-node-set">

  <xsl:variable name="class" select="class/@is"/>
  <xsl:choose>
    <xsl:when test="count($compound_nodes/types/type[@is = $class]) > 0">
      <xsl:copy-of select="$compound_nodes/types/type[@is = $class]/*"/>
    </xsl:when>

    <xsl:otherwise> <!-- must be a simple type -->
      <xsl:copy-of select="./class"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- field-node-to-compound-node-set -->


<!--
!! TEMPLATE:     class-node-to-format-node
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 06 February 2008
!! DESCRIPTION:  This template expects the path to be at a field's class node.
!!               It determines the matching class description node for the
!!               field, makes a copy, tailors it for the class, and returns it.
-->
<xsl:template name="class-node-to-format-node">

  <xsl:variable name="length">
    <xsl:call-template name="class-node-to-custom-length"/>
  </xsl:variable>

  <xsl:variable name="class_type">
    <xsl:choose>
      <xsl:when test="@is = 'TEXT' and @allow-spaces = 'true'">
        <xsl:value-of select="'QUOTED_TEXT'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@is"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="format_node" select="$format_nodes/classes/class[@name = $class_type]"/>

  <!-- Create a custom tailored class node for this field -->
  <xsl:variable name="tailored_node">
    <class>
      <xsl:attribute name="name"><xsl:value-of select="$format_node/@name"/></xsl:attribute>
      <xsl:attribute name="sql_type"><xsl:value-of select="$format_node/@sql_type"/></xsl:attribute>
      <xsl:attribute name="sql_length"><xsl:value-of select="$format_node/@sql_length"/></xsl:attribute>
      <xsl:attribute name="c_type"><xsl:value-of select="$format_node/@c_type"/></xsl:attribute>
      <xsl:attribute name="c_format"><xsl:value-of select="$format_node/@c_format"/></xsl:attribute>
      <xsl:attribute name="c_length"><xsl:value-of select="$format_node/@c_length"/></xsl:attribute>

      <!-- replace any DYNAMIC length fields with a proper value -->
      <xsl:if test="$format_node/@sql_length = 'DYNAMIC'">
        <xsl:attribute name="sql_length"><xsl:value-of select="$length"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="$format_node/@c_length = 'DYNAMIC'">
        <xsl:attribute name="c_length"><xsl:value-of select="$length"/></xsl:attribute>
      </xsl:if>

    </class>
  </xsl:variable>

  <xsl:copy-of select="$tailored_node"/>

</xsl:template> <!-- class-node-to-format-node -->


<!--
!! TEMPLATE:     class-node-to-custom-length
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 07 November 2007
!! DESCRIPTION:  This template expects the XPath to be on a field node. It
!!               determines an over-ride value for the class's length of the
!!               field.
-->
<xsl:template name="class-node-to-custom-length">

  <xsl:choose>
    <xsl:when test="@is = 'FRACTION'">
      <xsl:value-of select="concat(@precision+2, ',', @precision)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="@max-length"/>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- class-node-to-custom-length -->


<!--
!! TEMPLATE:     get-sql-name
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: February 21, 2005
!! DESCRIPTION:  This template is designed to take a word, remove special
!!               characters and produce a name that can be used in Oracle.
-->
<xsl:template name="get-sql-name">
  <xsl:param name="base_name"/>
  
  <xsl:variable name="lower_name">
    <xsl:call-template name="to-lower">
      <xsl:with-param name="base_name" select="$base_name"/>
    </xsl:call-template>
  </xsl:variable>
  
  <!-- Convert some special characters to spaces or remove them. -->
  <xsl:variable name="translated_name" select="translate($lower_name, '[]()/.-:?%#', '           ')"/>
  
  <!-- Convert some special characters to spaces or remove them. -->
  <xsl:variable name="normalized_name" select="normalize-space($translated_name)"/>
  
  <!-- replace the reamining spaces with underscores. -->
  <xsl:variable name="final_name" select="translate($normalized_name, ' ', '_')"/>

  <xsl:value-of select="$final_name"/>
</xsl:template>  <!-- get-sql-name -->


<!--
!! TEMPLATE:     get-table-name
!! PROGRAMMER:   Etsuko Lippi
!! DATE CREATED: February 21, 2005
!! DESCRIPTION:  This template converts a string into the equivalent Oracle
!!               table name for the OEC.
-->
<xsl:template name="get-table-name">
  <xsl:param name="base_name"/>

  <xsl:variable name="sql_name">
    <xsl:call-template name="get-sql-name">
      <xsl:with-param name="base_name" select="$base_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:value-of select="concat('oec_', $sql_name)"/>

</xsl:template>  <!-- get-table-name -->


<!--
!! TEMPLATE:     get-macro-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This template gets the macro name used with the OEC object.
!!               It expects the full object name and converts it to uppercase.
-->
<xsl:template name="get-macro-name">
  <xsl:param name="base_name"/>

  <xsl:variable name="sql_name">
    <xsl:call-template name="get-sql-name">
      <xsl:with-param name="base_name" select="$base_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:call-template name="to-upper">
    <xsl:with-param name="base_name" select="$sql_name"/>
  </xsl:call-template>

</xsl:template> <!-- get-macro-name -->


<!--
!! TEMPLATE:     get-object-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This template gets the name used within the code for an object.
!!               This consists of the object name in lower case minus any
!!               "aar_" prefix.
-->
<xsl:template name="get-object-name">
   <xsl:param name="base_name"/>
   <xsl:variable name="macro_name">
      <xsl:call-template name="get-macro-name">
         <xsl:with-param name="base_name" select="$base_name"/>
      </xsl:call-template>
   </xsl:variable>
   <xsl:value-of select="translate($macro_name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
</xsl:template> <!-- get-object-name -->


<!--
!! TEMPLATE:     get-local-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This template gets the local variable name used for the object
!!               or attribute. An example is an object of AAR_AIR_MISSION which
!!               has a local name of airMission.
-->
<xsl:template name="get-local-name">
   <xsl:param name="base_name"/>
   <xsl:variable name="object_name">
      <xsl:call-template name="get-object-name">
         <xsl:with-param name="base_name" select="$base_name"/>
      </xsl:call-template>
   </xsl:variable>
   <xsl:variable name="local_name">
      <xsl:call-template name="remove-underscores">
         <xsl:with-param name="base_name" select="$object_name"/>
      </xsl:call-template>
   </xsl:variable>
   <xsl:value-of select="$local_name"/>
</xsl:template> <!-- get-local-name -->


<!--
!! TEMPLATE:     get-global-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This template gets the global variable name used for the object
!!               or attribute. An example is an object of AAR_AIR_MISSION which
!!               has a global name of AirMission.
-->
<xsl:template name="get-global-name">
   <xsl:param name="base_name"/>
   <xsl:variable name="local_name">
      <xsl:call-template name="get-local-name">
         <xsl:with-param name="base_name" select="$base_name"/>
      </xsl:call-template>
   </xsl:variable>
   <xsl:variable name="first_raw" select="substring($local_name, 1, 1)"/>
   <xsl:variable name="first" select="translate($first_raw, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
   <xsl:variable name="last" select="substring($local_name, 2)"/>
   <xsl:value-of select="concat($first, $last)"/>
</xsl:template> <!-- get-global-name -->


<!--
!! TEMPLATE:     remove-underscores
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This template removes underscores from the passed in parameter
!!               and capitalizes the first letter after each underscore. This
!!               is a recursive call so all underscores will be affected. As
!!               an example air_mission_event becomes airMissionEvent.
-->
<xsl:template name="remove-underscores">
  <xsl:param name="base_name"/>
  <xsl:choose>
    <xsl:when test="contains($base_name, '_')">
      <xsl:variable name="first" select="substring-before($base_name, '_')"/>
      <xsl:variable name="end" select="substring-after($base_name, '_')"/>
      <xsl:variable name="middle_lower" select="substring($end, 1, 1)"/>
      <xsl:variable name="middle" select="translate($middle_lower, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
      <xsl:variable name="last" select="substring($end, 2)"/>
      <xsl:variable name="final">
        <xsl:call-template name="remove-underscores">
          <xsl:with-param name="base_name" select="concat($first, $middle, $last)"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="$final"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$base_name"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template> <!-- remove-underscores -->


<!--
!! TEMPLATE:     to-lower
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This template returns the passed in parameter with all upper
!!               case alphabetics replaced with lower case.
-->
<xsl:template name="to-lower">
  <xsl:param name="base_name"/>
  <xsl:variable name="lower_name" select="translate($base_name, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
  <xsl:value-of select="$lower_name"/>
</xsl:template> <!-- to-lower -->


<!--
!! TEMPLATE:     to-upper
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 04 January 2007
!! DESCRIPTION:  This template returns the passed in parameter with all lower
!!               case alphabetics replaced with upper case.
-->
<xsl:template name="to-upper">
  <xsl:param name="base_name"/>
  <xsl:variable name="upper_name" select="translate($base_name, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
  <xsl:value-of select="$upper_name"/>
</xsl:template> <!-- to-upper -->

</xsl:stylesheet>
