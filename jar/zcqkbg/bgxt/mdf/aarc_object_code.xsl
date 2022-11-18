<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="2.0">

<!-- 
!! File:        $JTLSHOME/script/xsl/aarc_object_code.xsl
!! Description: This stylesheet generates the files needed for the After Action
!!              Review Client (AARC). This includes the following files:
!!              1) $JTLSHOME/include/sdr/aar.h
!!              2) $JTLSHOME/src/cep/generated/*
!!              3) $JTLSHOME/src/aarc/src/generated/*
!!              4) $JTLSHOME/script/sdr/aar_tables_create.sql
!!              5) $JTLSHOME/script/sdr/aar_tables_drop.sql
!!              6) $JTLSHOME/script/sdr/aar_recover.sql
!!              7) $JTLSHOME/script/sdr/load/*
!!
!!              To run this stylesheet on the jds_protocol.xml file type:
!!              saxon jds_protocol.xml aarc_object_code.xsl jtlshome=$JTLSHOME
-->
<xsl:param name="jtlshome" select="'/home/jtlsdev'"/>

<xsl:output method="text"/>

<xsl:variable name="sdr_inc_dir" select="concat($jtlshome, '/include/sdr')"/>
<xsl:variable name="cep_code_dir" select="concat($jtlshome, '/src/cep/gen_code')"/>
<xsl:variable name="aarc_src_dir" select="concat($jtlshome, '/src/aarc/src/generated')"/>
<xsl:variable name="oracle_script_dir" select="concat($jtlshome, '/script/sdr')"/>
<xsl:variable name="oracle_load_dir" select="concat($jtlshome, '/script/sdr/load')"/>
<xsl:variable name="aarxmlhome" select="concat($jtlshome, '/src/aarc/xml')"/>

<!-- Variable definitions. -->
<xsl:variable name="copyright">
  <xsl:text>-- Copyright notification
--
--   Copyright 2012 by ROLANDS &amp; ASSOCIATES Corporation
</xsl:text>
</xsl:variable>

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

<xsl:variable name="bar" select="'|'"/>

<xsl:variable name="format_nodes">
  <classes>
    <class name="TIME" cep_type="double" cep_parameter="double" cep_format="%lf" sql_type="DATE" sql_length="" c_type="char" c_format="%s" c_length="MAX_AAR_DB_TIME_LENGTH"/>
    <class name="STRING" cep_type="char" cep_parameter="char *" cep_format="%s" sql_type="VARCHAR2" sql_length="DYNAMIC" c_type="char" c_format="%s" c_length="DYNAMIC"/>
    <class name="FLOAT" cep_type="double" cep_parameter="double" cep_format="%lf" sql_type="FLOAT" sql_length="" c_type="float" c_format="%f" c_length=""/>
    <class name="INT" cep_type="int" cep_parameter="int" cep_format="%d" sql_type="NUMBER" sql_length="10" c_type="int" c_format="%d" c_length=""/>
  </classes>
</xsl:variable>

<xsl:variable name="enumerated_nodes" select="/JTLS-Data-System-Protocol/enumerations/*"/>
<xsl:variable name="constant_nodes" select="/JTLS-Data-System-Protocol/constants/*[name() != 'description']"/>
<xsl:variable name="typedef_nodes" select="/JTLS-Data-System-Protocol/typedefs/*[name() != 'description']"/>

<!-- Create a tree fragment definition for the fixed AAR tables. The format for
    this matches the format for other tables in the JDSP -->
<xsl:variable name="other_table_nodes">
  <AAR_OBJECT_LOOKUP  routed="true">
    <description>
    This table allows the matching of an object's ID to its name and object
    type. It is filled by automatic triggers whenever a new object is inserted
    into any of the standard object tables (AAR_UNIT, AAR_AIR_MISSION, etc).
    </description>
    <common_knowledge>
      <object_id   type="UINT_32" db-is-primary-key="true" desc="The unique ID of the object."/>
      <object_type type="UINT_16" db-bitmap="true" desc="The type of the object as an integer. These integers are assigned automatically and may change. Programmers should use the AAR_OBJECT_ENUM enumerations from the C include file or the constants defined in the java jar file."/>
      <type        type="STRING"  db-column-width="MAX_AAR_OBJECT_NAME_LENGTH" db-bitmap="true" desc="The name of the object type. This column has a direct relationship to the object_type column."/>
      <name        type="STRING"  db-column-width="MAX_AAR_OBJECT_NAME_LENGTH" desc="The name of the object. In general the CEP provides the short name which is filed in this column. Non-CEP objects, such as engagements and detections do not have an associated name so their object_id is filed in this column."/>
    </common_knowledge>
  </AAR_OBJECT_LOOKUP>
  <AAR_CHECKPOINT  routed="true">
    <description>
    This table lists the checkpoints for the current game run.
    </description>
    <common_knowledge>
      <checkpoint   type="STRING"  db-column-width="MAX_AAR_CHKPT_LENGTH" desc="The name of the checkpoint. Checkpoint names are sequentially numbered starting at 0000 and always consist of 4 digits."/>
    </common_knowledge>
  </AAR_CHECKPOINT>
</xsl:variable>

<xsl:variable name="other_constant_nodes">
  <MAX_AAR_OBJECT_NAME_LENGTH type="INT_32" value="30"/>
  <MAX_AAR_HEADER_LENGTH      type="INT_32" value="60"/>
  <MAX_AAR_MODE_LENGTH        type="INT_32" value="15"/>
  <MAX_AAR_ARGUMENT_LENGTH    type="INT_32" value="20"/>
  <MAX_AAR_DB_TIME_LENGTH     type="INT_32" value="19"/>
  <MAX_AAR_CHKPT_LENGTH       type="INT_32" value="4"/>
</xsl:variable>

<!--
!! TEMPLATE:     match /JTLS-Data-System-Protocol
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This is the main driver template for generating the AAR code
!!               For each type of AAR object it opens a file and writes the code
!!               to it.
-->
<xsl:template match="/JTLS-Data-System-Protocol">

  <!-- Create an include file to be used for retrieval/insertion of objects
       into the AAR database -->
  <xsl:variable name="aar_filename" select="concat($sdr_inc_dir, '/aar.h')"/>
  <xsl:result-document method="text" href="{$aar_filename}">
    <xsl:call-template name="include-structures"/>
  </xsl:result-document>

  <!-- Generate a CEP source code file for each AAR object type -->
  <xsl:for-each select="protocol/post-processing-data/transient/*">

    <xsl:variable name="table_name" select="name()"/>

    <xsl:variable name="file_name">
      <xsl:call-template name="get-file-name">
         <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="filename" select="concat($cep_code_dir, '/', $file_name, '.c')"/>
    <xsl:result-document method="text" href="{$filename}">
      <xsl:call-template name="cep-header-data"/>
      <xsl:call-template name="cep-pass-record-to-joda"/>
      <xsl:call-template name="cep-save-record"/>
      <xsl:call-template name="cep-recover-record"/>
    </xsl:result-document>

  </xsl:for-each> <!-- AAR object type -->

  <!-- Generate a CEP source file to handle recovering CEP held objects -->
  <xsl:variable name="recover_filename" select="concat($cep_code_dir, '/aarRecover.c')"/>
  <xsl:result-document method="text" href="{$recover_filename}">
    <xsl:call-template name="cep-recover-handler">
      <xsl:with-param name="filename" select="$recover_filename"/>
    </xsl:call-template>
  </xsl:result-document>

  <!-- Generate AARC source code to handle receipt and handling of objects
       from the JODA -->
  <xsl:for-each select="protocol/post-processing-data/transient/*">

    <xsl:variable name="table_name" select="name()"/>

    <xsl:variable name="local_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="filename_h" select="concat($aarc_src_dir,'/',$local_name,'.h')"/>
    <xsl:result-document method="text" href="{$filename_h}">
      <xsl:call-template name="aarc-header-file">
        <xsl:with-param name="location" select="$filename_h"/>
      </xsl:call-template>
    </xsl:result-document>

    <xsl:variable name="filename_pc" select="concat($aarc_src_dir,'/',$local_name,'.pc')"/>
    <xsl:result-document method="text" href="{$filename_pc}">
      <xsl:call-template name="aarc-pro-c-file">
        <xsl:with-param name="location" select="$filename_pc"/>
        <xsl:with-param name="local_name" select="$local_name"/>
      </xsl:call-template>
    </xsl:result-document>

  </xsl:for-each>

  <!-- Generate header and source code to handle AARC receipt of data from
       the JODA -->
  <xsl:variable name="filename_pc" select="concat($aarc_src_dir, '/object.pc')"/>
  <xsl:result-document method="text" href="{$filename_pc}">
    <xsl:call-template name="aarc-object-proc-file"/>
  </xsl:result-document>

  <xsl:variable name="filename_h" select="concat($aarc_src_dir, '/object.h')"/>
  <xsl:result-document method="text" href="{$filename_h}">
    <xsl:call-template name="aarc-object-include-file"/>
  </xsl:result-document>

  <!-- Generate header and source code to handle AARC translations of table
       and event names to enumerations  -->
  <xsl:variable name="translatefile_pc" select="concat($aarc_src_dir, '/translate.pc')"/>
  <xsl:result-document method="text" href="{$translatefile_pc}">
    <xsl:call-template name="aarc-translate-proc-file"/>
  </xsl:result-document>

  <xsl:variable name="translatefile_h" select="concat($aarc_src_dir, '/translate.h')"/>
  <xsl:result-document method="text" href="{$translatefile_h}">
    <xsl:call-template name="aarc-translate-include-file"/>
  </xsl:result-document>

  <!-- Create an SQL script to create the tables -->
  <xsl:variable name="filename_create" select="concat($jtlshome, '/script/sdr/aar_tables_create.sql')"/>
  <xsl:result-document method="text" href="{$filename_create}">
    <xsl:call-template name="sql-create-script"/>
  </xsl:result-document>

  <!-- Create an sql script to destroy the tables from the database -->
  <xsl:variable name="filename_destroy" select="concat($jtlshome, '/script/sdr/aar_tables_drop.sql')"/>
  <xsl:result-document method="text" href="{$filename_destroy}">
    <xsl:call-template name="sql-destroy-script"/>
  </xsl:result-document>

  <!-- Create an sql script to re-establish sequences -->
  <xsl:variable name="filename_recover" select="concat($jtlshome, '/script/sdr/aar_recover.sql')"/>
  <xsl:result-document method="text" href="{$filename_recover}">
    <xsl:call-template name="sql-recover-script"/>
  </xsl:result-document>

  <!-- Create a load control file listing each of the control files to be
       called by the script that invokes the SQL*Loader -->
  <xsl:variable name="filename_loader" select="concat($jtlshome, '/script/sdr/load/load_ctl')"/>
  <xsl:result-document method="text" href="{$filename_loader}">
    <xsl:call-template name="sql-loader-control"/>
  </xsl:result-document>

  <!-- Create an SQL Loader control file for each AAR table -->
  <xsl:for-each select="protocol/post-processing-data/transient/*">

    <xsl:variable name="table_name" select="name()"/>

    <xsl:variable name="file_name">
      <xsl:call-template name="get-file-name">
         <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="filename_control" select="concat($jtlshome, '/script/sdr/load/', $file_name, '.ctl')"/>

    <xsl:result-document method="text" href="{$filename_control}">
      <xsl:call-template name="sql-loader-file"/>
    </xsl:result-document>

  </xsl:for-each> <!-- end for each transient object -->

</xsl:template> <!-- match /JTLS-Data-System-Protocol -->


<!--
!! TEMPLATE:     include-structures
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 1 August 2006
!! DESCRIPTION:  This template writes the code for the header files
!!               from the AAR objects and their attributes found in the
!!               jds protocol.
-->
<xsl:template name="include-structures">

  <!-- Create the header information -->
  <xsl:value-of select="concat('#ifndef __AAR_INCLUDE__', $cr)"/>
  <xsl:value-of select="concat('#define __AAR_INCLUDE__', $cr)"/>
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        aar.h', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This file contains structures that match the format of the AAR', $cr)"/>
  <xsl:value-of select="concat(' *              Oracle tables. These structures can be used to perform group', $cr)"/>
  <xsl:value-of select="concat(' *              retrieves of data from those tables.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Create a macro for each JDSP constant. These will be used in the length
       of string variables within the table structures -->
  <xsl:for-each select="constants/*[not(name()='description')] | $other_constant_nodes/*">
    <xsl:variable name="cons-name" select="name()"/>
    <xsl:variable name="num" select="@value"/>
    <xsl:value-of select="concat('#define AAR_', $cons-name, '  ', $num, $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="$cr"/>

  <!-- For every AAR object create a structure that matches the format used
       in the database tables and an indicator structure that does the same -->
  <xsl:for-each select="$other_table_nodes/* | protocol/post-processing-data/transient/*">

    <xsl:variable name="table_name" select="name()"/>

    <xsl:variable name="object_name">
      <xsl:call-template name="get-object-name">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="macro_name">
      <xsl:call-template name="get-macro-name">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="global_name">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="structure_name" select="concat('aar_', $object_name, '_table')"/>
    <xsl:variable name="structure_macro" select="concat('AAR_', $macro_name, '_TABLE')"/>
    <xsl:variable name="indicator_name" select="concat('aar_', $object_name, '_indicator')"/>
    <xsl:variable name="indicator_macro" select="concat('AAR_', $macro_name, '_INDICATOR')"/>

    <!-- Compose the primary structure -->
    <xsl:value-of select="concat('typedef struct ', $structure_name, ' {',$cr)"/>

    <!-- If this table has a sequence number then add it to the structure -->
    <xsl:if test="not(name() = 'AAR_OBJECT_LOOKUP') and count(common_knowledge/object_id) = 1">
      <xsl:value-of select="concat('   int sequenceNbr;', $cr)"/>
    </xsl:if>

    <!-- Read the object's attribute and type, and store it in a variable -->
    <xsl:for-each select="common_knowledge/*[not(name()='destination')]">
      <xsl:variable name="attribute" select="name()"/>
      <xsl:variable name="attr_type" select="@type"/>
      <xsl:variable name="max_len" select="@db-column-width"/>

      <xsl:variable name="attr">
        <xsl:call-template name="remove-underscores">
          <xsl:with-param name="base_name" select="$attribute"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="format_node">
        <xsl:call-template name="attribute-node-to-format-node"/>
      </xsl:variable>

      <xsl:variable name="length_string">
        <xsl:if test="string-length($format_node/class/@c_length) > 0">
          <xsl:value-of select="concat('[AAR_', $format_node/class/@c_length, '+1]')"/>
        </xsl:if>
      </xsl:variable>

      <!-- Add this attribute to the structure -->
      <xsl:value-of select="concat('   ', $format_node/class/@c_type, ' ', $attr, $length_string, ';', $cr)"/>

    </xsl:for-each> <!-- common knowledge attribute -->

    <xsl:value-of select="concat('} ',$structure_macro, ';',$cr, $cr)"/>

    <!-- Compose the indicator structure -->
    <xsl:value-of select="concat('typedef struct ', $indicator_name, ' {',$cr)"/>

    <!-- If this table has a sequence number then add it to the structure -->
    <xsl:if test="not(name() = 'AAR_OBJECT_LOOKUP') and count(common_knowledge/object_id) = 1">
      <xsl:value-of select="concat('   short sequenceNbr;', $cr)"/>
    </xsl:if>

    <xsl:for-each select="common_knowledge/*[not(name()='destination')]">
      <xsl:variable name="attribute" select="name()"/>

      <xsl:variable name="attr">
        <xsl:call-template name="remove-underscores">
          <xsl:with-param name="base_name" select="$attribute"/>
        </xsl:call-template>
      </xsl:variable>

      <!-- Add this attribute to the structure -->
      <xsl:value-of select="concat('    short ', $attr, ';', $cr)"/>

    </xsl:for-each> <!-- common knowledge attribute -->

    <xsl:value-of select="concat('} ',$indicator_macro, ';',$cr, $cr)"/>

  </xsl:for-each> <!-- transient post-processing object -->
  <xsl:value-of select="concat('#endif /* not defined __AAR_INCLUDE__ */', $cr)"/>

</xsl:template> <!-- include-structures  -->


<!--
!! TEMPLATE:     cep-header-data
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 09 August 2006
!! DESCRIPTION:  This template writes the common header information for the
!!               CEP file. This consists of include statements, externally
!!               and statically declared variables and functions.
-->
<xsl:template name="cep-header-data">

  <xsl:variable name="table_name" select="name()"/>

  <xsl:variable name="lower_table_name">
    <xsl:call-template name="to-lower">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="local_name">
    <xsl:call-template name="get-local-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="global_name">
    <xsl:call-template name="get-global-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="save_function" select="concat($lower_table_name, '_save_record')"/>
  <xsl:variable name="record_macro" select="concat($table_name, '_MAX_RECORD_LENGTH')"/>

  <!-- Write out the header information for the file -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        ', $cep_code_dir, '/aar', $global_name, '.c', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This module contains the functions to pass an', $cr)"/>
  <xsl:value-of select="concat(' *              ', $table_name, ' packet from the CEP to the JODA. This file', $cr)"/>
  <xsl:value-of select="concat(' *              is automatically generated when there are changes to the', $cr)"/>
  <xsl:value-of select="concat(' *              JDS Protocol. Changes should not be made to this file.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('#include &lt;stdio.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &lt;ctype.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &lt;float.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_public.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsconvert.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsin.h&quot;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('#define SIMDBL_TO_REAL32(x) (REAL_32)((x)==0.0?(x):((x)&lt;0.0?((x)&gt;-FLT_MIN?-FLT_MIN:(x)&lt;-FLT_MAX?-FLT_MAX:(x)):(x)&lt;FLT_MIN?FLT_MIN:(x)&gt;FLT_MAX?FLT_MAX:(x)))', $cr)"/>
  <xsl:value-of select="concat('#define ', $record_macro, ' 8192', $cr)"/>
  <xsl:for-each select="/JTLS-Data-System-Protocol/constants/*[not(name() = 'description')]">
    <xsl:value-of select="concat('#define ', name(), ' ', @value, $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('extern char *HUNIX_STRING_F( char * );', $cr)"/>
  <xsl:value-of select="concat('extern int RAAR_STORE_RECORD( int, double, char * );', $cr)"/>
  <xsl:value-of select="concat('extern void PrintOutput( char *, ... );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('extern double SimStateCurrentTime;', $cr)"/>
  <xsl:value-of select="concat('extern char AarPeerName[];', $cr)"/>
  <xsl:value-of select="concat('extern int AarCollectionFlag;', $cr)"/>
  <xsl:value-of select="concat('extern int AarReadyFlag;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('static void ', $save_function, '( ')"/>
  <xsl:for-each select="common_knowledge/*[not(name() = 'destination' or name() = 'time')]">

    <xsl:variable name="format_node">
     <xsl:call-template name="attribute-node-to-format-node"/>
    </xsl:variable>

    <xsl:value-of select="$format_node/class/@cep_parameter"/>
    <xsl:if test="not(position() = last())">
      <xsl:value-of select="','"/>
    </xsl:if>
    <xsl:value-of select="' '"/>
  </xsl:for-each>
  <xsl:value-of select="concat(');', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('static char aar', $global_name, 'EmptyString[] = &quot;&quot;;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- cep-header-data -->


<!--
!! TEMPLATE:     cep-pass-record-to-joda
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 09 August 2006
!! DESCRIPTION:  This template writes the code for the function that receives
!!               data from the CEP and passes it to the JODA.
-->
<xsl:template name="cep-pass-record-to-joda">

  <xsl:variable name="table_name" select="name()"/>

  <xsl:variable name="lower_table_name">
    <xsl:call-template name="to-lower">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="local_name">
    <xsl:call-template name="get-local-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="global_name">
    <xsl:call-template name="get-global-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="pointer_name" select="concat($local_name, 'Ptr')"/>
  <xsl:variable name="pass_function" select="$lower_table_name"/>
  <xsl:variable name="save_function" select="concat($lower_table_name, '_save_record')"/>

  <!-- Write out function header information -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    ', $pass_function, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function accepts the ', $table_name, ' package', $cr)"/>
  <xsl:value-of select="concat(' *              parameters from the CEP and passes them to the JODA.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('int ', $pass_function, '(', $cr)"/>

  <!-- Add each of the attributes to the function's parameter list -->
  <xsl:for-each select="common_knowledge/*[not(name() = 'destination' or name() = 'time')]">

    <xsl:variable name="attribute" select="name()"/>
    <xsl:variable name="attribute_type" select="@type"/>

    <xsl:variable name="attribute_local_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="$attribute"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="attribute_datatype_name" select="concat($attribute_local_name, 'DataType')"/>

    <xsl:variable name="format_node">
      <xsl:call-template name="attribute-node-to-format-node"/>
    </xsl:variable>

    <xsl:value-of select="concat('      ', $format_node/class/@cep_parameter, ' ')"/>
    <xsl:value-of select="$attribute_local_name"/>
    <xsl:choose>
      <xsl:when test="not(position() = last())">
        <xsl:value-of select="','"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="' ) {'"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$cr"/>

  </xsl:for-each> <!-- attribute for the parameter list -->
  <xsl:value-of select="$cr"/>

  <!-- Define and initialize variables -->
  <xsl:value-of select="concat('   static ', $table_name, '_CONTAINER ', $pointer_name, ' = NULL;', $cr)"/>
  <xsl:value-of select="concat('   int sendStatus;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Check for connectivity of AAR -->
  <xsl:value-of select="concat('   if ( ! AarCollectionFlag ) {', $cr)"/>
  <xsl:value-of select="concat('      return( 1 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Create the local static JODA structure -->
  <xsl:value-of select="concat('   if ( ! ', $pointer_name, ' ) {', $cr)"/>
  <xsl:value-of select="concat('      ', $pointer_name, ' = create_', $lower_table_name, '( );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Check for NULL character arguments and convert them to empty strings.
       This is done because Simscript passes an empty string as a null string
       and it is easier for the rest of the code to always assume there is a
       value in the strings -->
  <xsl:variable name="empty_string" select="concat('aar', $global_name, 'EmptyString')"/>
  <xsl:for-each select="common_knowledge/*[not(name() = 'destination' or name() = 'time') and @type = 'STRING']">

    <xsl:variable name="attribute_local_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('   if ( ! ', $attribute_local_name, ' ) {', $cr)"/>
    <xsl:value-of select="concat('      ', $attribute_local_name, ' = ', $empty_string, ';', $cr)"/>
    <xsl:value-of select="concat('   }', $cr)"/>
    <xsl:value-of select="$cr"/>

  </xsl:for-each> <!-- attribute for the parameter list -->
  <xsl:value-of select="$cr"/>

  <!-- Error handling in case the AAR Client is not connected -->
  <xsl:value-of select="concat('   if ( AarPeerName[0] == ', $apos, '\0', $apos, ' || ! AarReadyFlag || ! jds_is_connected ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      ', $save_function, '(', $cr)"/>
  <xsl:for-each select="common_knowledge/*[not(name() = 'destination' or name() = 'time')]">

    <xsl:variable name="attribute_local_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="attribute_datatype_name" select="concat($attribute_local_name, 'DataType')"/>

    <xsl:value-of select="concat('            ', $attribute_local_name)"/>
    <xsl:choose>
      <xsl:when test="position() = last()">
        <xsl:value-of select="' );'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="','"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$cr"/>

  </xsl:for-each> <!-- attribute for the parameter list -->
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('      if ( ! jds_is_connected ) {', $cr)"/>
  <xsl:value-of select="concat('         return( (long) SOCKET_JDS_NOT_CONNECTED );', $cr)"/>
  <xsl:value-of select="concat('      } else {', $cr)"/>
  <xsl:value-of select="concat('         return( 1 );', $cr)"/>
  <xsl:value-of select="concat('      }', $cr)"/>
  <xsl:value-of select="concat('   } /* end if there is no recipent for the packet */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Reset the JODA structure -->
  <xsl:value-of select="concat('   reset_', $lower_table_name, '( ', $pointer_name, ' );', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- we always should have destination and time attributes (destination
       being required since all AAR objects are transient objects sent to a
       single recipient). Both these attributes are set from external variables
       rather than being on the function's parameter list -->
  <xsl:value-of select="concat('   set_', $lower_table_name, '_destination( ', $pointer_name, ', (STRING) AarPeerName );', $cr)"/>
  <xsl:value-of select="concat('   set_', $lower_table_name, '_time( ', $pointer_name, ', SIMDBL_TO_REAL32( SimStateCurrentTime ) );', $cr)"/>

  <!-- for every attirbute set the data on the primary object -->
  <xsl:for-each select="common_knowledge/*[not(name() = 'destination' or name() = 'time')]">

    <xsl:variable name="attribute" select="name()"/>
    <xsl:variable name="attribute_type" select="@type"/>

    <xsl:variable name="attribute_local_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="$attribute"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="attribute_datatype_name" select="concat($attribute_local_name, 'DataType')"/>

    <xsl:choose>
      <xsl:when test="$attribute_type = 'REAL_32'">
        <xsl:value-of select="concat('   set_', $lower_table_name, '_', $attribute, '( ', $pointer_name, ', SIMDBL_TO_REAL32( ', $attribute_local_name, ' ) );', $cr)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('   set_', $lower_table_name, '_', $attribute, '( ', $pointer_name, ', (', $attribute_type, ') ', $attribute_local_name, ' );', $cr)"/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:for-each> <!-- attribute set -->

  <!-- Encode and send the info to the JODA and finialize the function -->
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   encode_', $lower_table_name, '( ', $pointer_name, ' );', $cr)"/>
  <xsl:value-of select="concat('   sendStatus = send_jds_packet( );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   return( (long) sendStatus );', $cr)"/>
  <xsl:value-of select="concat('} /* end of ', $pass_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- cep-pass-record-to-joda -->


<!--
!! TEMPLATE:     cep-save-record
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This template writes the code for the function that takes
!!               an AAR record, converts it into a string, and sends the
!!               string to the CEP for storage.
-->
<xsl:template name="cep-save-record">

  <xsl:variable name="table_name" select="name()"/>

  <xsl:variable name="lower_table_name">
    <xsl:call-template name="to-lower">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="local_name">
    <xsl:call-template name="get-local-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="save_function" select="concat($lower_table_name, '_save_record')"/>
  <xsl:variable name="record_macro" select="concat($table_name, '_MAX_RECORD_LENGTH')"/>

  <!-- Write function header -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    ', $save_function, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function converts an ', $table_name, ' record', $cr)"/>
  <xsl:value-of select="concat(' *              into a string which is then sent to the CEP for storage.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('static void ', $save_function, '(', $cr)"/>

  <!-- Add each of the attributes to the function's parameter list -->
  <xsl:for-each select="common_knowledge/*[not(name() = 'destination' or name() = 'time')]">

    <xsl:variable name="attribute" select="name()"/>
    <xsl:variable name="attribute_type" select="@type"/>

    <xsl:variable name="attribute_local_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="$attribute"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="attribute_datatype_name" select="concat($attribute_local_name, 'DataType')"/>

    <xsl:variable name="format_node">
      <xsl:call-template name="attribute-node-to-format-node"/>
    </xsl:variable>

    <xsl:value-of select="concat('      ', $format_node/class/@cep_parameter, ' ', $attribute_local_name)"/>
    <xsl:choose>
      <xsl:when test="not(position() = last())">
        <xsl:value-of select="','"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="' ) {'"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$cr"/>

  </xsl:for-each> <!-- attribute for the parameter list -->
  <xsl:value-of select="$cr"/>

  <!-- Define the local variables -->
  <xsl:value-of select="concat('   static char messageString[', $record_macro, '+1];', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Create a statement to write out the parameters to the local string -->
  <xsl:value-of select="concat('   snprintf( messageString, (size_t) ', $record_macro, '+1,', $cr)"/>
  <xsl:value-of select="'         &quot;'"/>
  <xsl:for-each select="common_knowledge/*[not(name() = 'destination' or name() = 'time')]">

    <xsl:variable name="format_node">
      <xsl:call-template name="attribute-node-to-format-node"/>
    </xsl:variable>

    <xsl:value-of select="concat($bar, $format_node/class/@cep_format, $bar, ' ')"/>
  </xsl:for-each> <!-- attribute print parameter-->
  <xsl:value-of select="concat('&quot;,', $cr)"/>

  <xsl:for-each select="common_knowledge/*[not(name() = 'destination' or name() = 'time')]">

    <xsl:variable name="attribute_local_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="attribute_datatype_name" select="concat($attribute_local_name, 'DataType')"/>

    <xsl:variable name="attribute_global_name">
      <xsl:call-template name="get-global-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('         ', $attribute_local_name)"/>
    <xsl:if test="not(position() = last())">
      <xsl:value-of select="concat(',', $cr)"/>
    </xsl:if>

  </xsl:for-each> <!-- attribute print listing -->
  <xsl:value-of select="concat(' );', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Check that the string did not exceed the buffer size we provided -->
  <xsl:value-of select="concat('   if ( strlen( messageString ) &gt;= ', $record_macro, ' ) {', $cr)"/>
  <xsl:value-of select="concat('      PrintOutput( &quot;\007\007\007Critical - ', $table_name, ' String Exceeds Maximum Record Length\n&quot; );', $cr)"/>
  <xsl:value-of select="concat('      PrintOutput( &quot;\007\007\007           AAR Record Not Stored !!\n&quot; );', $cr)"/>
  <xsl:value-of select="concat('      return;', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Call the CEP function to store this data -->
  <xsl:value-of select="concat('   RAAR_STORE_RECORD( ', position(), ', SimStateCurrentTime, HUNIX_STRING_F( messageString ) );', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Close out the function -->
  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $save_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- cep-save-record -->


<!--
!! TEMPLATE:     cep-recover-record
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 09 August 2006
!! DESCRIPTION:  This template writes the code for the function that reads
!!               an AAR data string and translates it to a record for
!!               re-submission to the JODA.
-->
<xsl:template name="cep-recover-record">

  <xsl:variable name="table_name" select="name()"/>

  <xsl:variable name="lower_table_name">
    <xsl:call-template name="to-lower">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="local_name">
    <xsl:call-template name="get-local-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="recover_function" select="concat($lower_table_name, '_recover_record')"/>
  <xsl:variable name="pass_function" select="$lower_table_name"/>

  <!-- Write function header and parameter list -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    ', $recover_function, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function receives a string ', $table_name, ' record', $cr)"/>
  <xsl:value-of select="concat(' *              from the CEP and re-submits it to the JODA. The function is', $cr)"/>
  <xsl:value-of select="concat(' *              called for stored records while the AAR was not connected.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('int ', $recover_function, '( double gameTime, char *messageString ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   double saveTime;', $cr)"/>
  <xsl:value-of select="concat('   int processStatus;', $cr)"/>
  <xsl:value-of select="concat('   char *posPtr = messageString;', $cr)"/>
  <xsl:value-of select="concat('   char dataToken[MAX_ORDER_LENGTH+1];', $cr)"/>
  <xsl:value-of select="concat('   char *dataPtr;', $cr)"/>

  <!-- for every attirbute define a local variable -->
  <xsl:for-each select="common_knowledge/*[not(name() = 'destination' or name() = 'time')]">

    <xsl:variable name="attribute_local_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="attribute_datatype_name" select="concat($attribute_local_name, 'DataType')"/>

    <xsl:variable name="format_node">
      <xsl:call-template name="attribute-node-to-format-node"/>
    </xsl:variable>

    <xsl:value-of select="concat('   ', $format_node/class/@cep_type, ' ', $attribute_local_name)"/>
    <xsl:if test="$format_node/class/@cep_type = 'char'">
       <xsl:value-of select="concat('[', $format_node/class/@c_length, '+1]')"/>
    </xsl:if>
    <xsl:value-of select="concat(';', $cr)"/>

  </xsl:for-each> <!-- attribute define -->
  <xsl:value-of select="$cr"/>

  <!-- For each expected variable, extract and assign a token -->
  <xsl:for-each select="common_knowledge/*[not(name() = 'destination' or name() = 'time')]">

    <xsl:variable name="attribute_local_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="attribute_datatype_name" select="concat($attribute_local_name, 'DataType')"/>

    <xsl:variable name="format_node">
      <xsl:call-template name="attribute-node-to-format-node"/>
    </xsl:variable>

    <xsl:value-of select="concat('   for ( ; *posPtr != ', $apos, '\0', $apos, ' &amp;&amp; isspace( (int) *posPtr ); posPtr++ );', $cr)"/>
    <xsl:value-of select="concat('   dataPtr = dataToken;', $cr)"/>
    <xsl:value-of select="concat('   for ( posPtr++; *posPtr != ', $apos, '\0', $apos, ' &amp;&amp; *posPtr != ', $apos, $bar, $apos, '; posPtr++, dataPtr++ ) {', $cr)"/>
    <xsl:value-of select="concat('      *dataPtr = *posPtr;', $cr)"/>
    <xsl:value-of select="concat('   }', $cr)"/>
    <xsl:value-of select="concat('   *dataPtr = ', $apos, '\0', $apos, ';', $cr)"/>
    <xsl:value-of select="concat('   posPtr++;', $cr)"/>

    <xsl:choose>
      <xsl:when test="$format_node/class/@cep_type = 'char'">
        <xsl:value-of select="concat('   strcpy( ', $attribute_local_name, ', dataToken );', $cr)"/>
      </xsl:when>
      <xsl:when test="$format_node/class/@cep_type = 'double' or $format_node/class/@cep_type = 'float'">
        <xsl:value-of select="concat('   ', $attribute_local_name, ' = atof( dataToken );', $cr)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('   ', $attribute_local_name, ' = atoi( dataToken );', $cr)"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$cr"/>

  </xsl:for-each> <!-- attribute to be extracted -->

  <!-- call the standard function to send the data to the JODA -->
  <xsl:value-of select="concat('   saveTime = SimStateCurrentTime;', $cr)"/>
  <xsl:value-of select="concat('   SimStateCurrentTime = gameTime;', $cr)"/>
  <xsl:value-of select="concat('   processStatus = ', $pass_function, '(', $cr)"/>
  <xsl:for-each select="common_knowledge/*[not(name() = 'destination' or name() = 'time')]">

    <xsl:variable name="attribute_local_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="attribute_datatype_name" select="concat($attribute_local_name, 'DataType')"/>

    <xsl:value-of select="concat('         ', $attribute_local_name)"/>
    <xsl:if test="not(position() = last())">
       <xsl:value-of select="concat(',', $cr)"/>
    </xsl:if>

  </xsl:for-each> <!-- attribute scan listing -->
  <xsl:value-of select="concat(' );', $cr)"/>
  <xsl:value-of select="concat('   SimStateCurrentTime = saveTime;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Set the return code -->
  <xsl:value-of select="concat('   if ( processStatus == 1 ) {', $cr)"/>
  <xsl:value-of select="concat('      return( 1 );', $cr)"/>
  <xsl:value-of select="concat('   } else {', $cr)"/>
  <xsl:value-of select="concat('      return( 0 );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $recover_function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- cep-recover-record -->


<!--
!! TEMPLATE:     cep-recover-handler
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 09 August 2006
!! DESCRIPTION:  This template writes the function that recieved an AAR Record
!!               from the CEP and passes the record to the appropriate object
!!               processing module.
-->
<xsl:template name="cep-recover-handler">
  <xsl:param name="filename"/>

  <xsl:variable name="function_name" select="'aar_recover_record'"/>

  <!-- Write out the header information for the file -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        ', $cep_code_dir, '/', $filename, '.c', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This module contains the function to receive and previously', $cr)"/>
  <xsl:value-of select="concat(' *              saved AAR record from the CEP and call the appropriate', $cr)"/>
  <xsl:value-of select="concat(' *              record processing function to submit it through the JODA.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Define as external each of the object processing functions -->
  <xsl:for-each select="protocol/post-processing-data/transient/*">

    <xsl:variable name="table_name" select="name()"/>

    <xsl:variable name="lower_table_name">
      <xsl:call-template name="to-lower">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="recover_function" select="concat($lower_table_name, '_recover_record')"/>
    <xsl:value-of select="concat('extern int ', $recover_function, '( double, char * );', $cr)"/>

  </xsl:for-each> <!-- AAR object type -->
  <xsl:value-of select="$cr"/>

  <!-- Write the recover function -->
  <xsl:value-of select="concat('int ', $function_name, '( int type, double gameTime, char *messageString ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   int status = 0;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   switch ( type ) {', $cr)"/>

  <xsl:for-each select="protocol/post-processing-data/transient/*">

    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="table_number" select="position()"/>

    <xsl:variable name="lower_table_name">
      <xsl:call-template name="to-lower">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="recover_function" select="concat($lower_table_name, '_recover_record')"/>
    <xsl:value-of select="concat('      case ', $table_number, ':', $cr)"/>
    <xsl:value-of select="concat('         status = ', $recover_function, '( gameTime, messageString );', $cr)"/>
    <xsl:value-of select="concat('         break;', $cr)"/>
    <xsl:value-of select="$cr"/>

  </xsl:for-each> <!-- AAR object type -->
  <xsl:value-of select="concat('   } /* end switch on record type */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   return( status );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $function_name, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- cep-recover-handler -->


<!--
!! TEMPLATE:     aarc-header-file
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 1 August 2006
!! DESCRIPTION:  This template writes the code for the header files
!!               from the AAR objects and their attributes found in the
!!               jds protocol.
-->
<xsl:template name="aarc-header-file">
  <xsl:param name="location"/>

  <xsl:variable name="table_name" select="name()"/>

  <xsl:variable name="object_name">
    <xsl:call-template name="get-object-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="global_name">
    <xsl:call-template name="get-global-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="macro_name">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:value-of select="concat('#ifndef __',$macro_name,'_INC__',$cr)"/>
  <xsl:value-of select="concat('#define __',$macro_name,'_INC__',$cr)"/>
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        ',$location,$cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This is an automatically generated PRO*C header file for the',$cr)"/>
  <xsl:value-of select="concat(' *              ',$global_name,' source code. Do not change this file manually,',$cr)"/>
  <xsl:value-of select="concat(' *              the contents will be overwritten the next time the JDS Protocol',$cr)"/>
  <xsl:value-of select="concat(' *              is modified.',$cr)"/>
  <xsl:value-of select="concat(' *---------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_client_object.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_bit_field.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;sdr/aar.h&quot;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('typedef ', $table_name, '_TABLE ', $macro_name, '_RECORD;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('#ifdef __',$macro_name,'_SRC__',$cr)"/>
  <xsl:value-of select="concat('#define __',$macro_name,'_TYPE',$cr,'#else',$cr)"/>
  <xsl:value-of select="concat('#define __',$macro_name,'_TYPE extern',$cr,'#endif',$cr,$cr)"/>
  <xsl:value-of select="concat('__',$macro_name,'_TYPE int   ',$global_name,'Open( char * );',$cr)"/>
  <xsl:value-of select="concat('__',$macro_name,'_TYPE void  ',$global_name,'Close( void );',$cr)"/>
  <xsl:value-of select="concat('__',$macro_name,'_TYPE void  ',$global_name,'ProcessRecord( PERSISTENT_CONTAINER );',$cr)"/>
  <xsl:value-of select="concat('__',$macro_name,'_TYPE int   ',$global_name,'InsertRecords( void );',$cr)"/>
  <xsl:value-of select="concat('__',$macro_name,'_TYPE float ',$global_name,'GetLastInsertTime( void );',$cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('#endif /* not defined __',$macro_name,'_INC__ */',$cr)"/>

</xsl:template> <!-- aarc-header-file  -->


<!--
!! TEMPLATE:     aarc-pro-c-file
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 1 August 2006
!! DESCRIPTION:  This template writes the Pro*C code from the
!!               AAR objects and their attributes found in the
!!               jds protocol.
-->
<xsl:template name="aarc-pro-c-file">
  <xsl:param name="location"/>
  <xsl:param name="local_name"/>

  <xsl:variable name="table_name" select="name()"/>

  <xsl:variable name="macro_name">
    <xsl:call-template name="get-macro-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="global_name">
    <xsl:call-template name="get-global-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="lower_name">
    <xsl:call-template name="to-lower">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        ',$location,$cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This is an automatically generated PRO*C source file that',$cr)"/>
  <xsl:value-of select="concat(' *              interacts with the ',$table_name,' table. Do not change this',$cr)"/>
  <xsl:value-of select="concat(' *              file manually, the contents will be overwritten the next time',$cr)"/>
  <xsl:value-of select="concat(' *              the JDS Protocol is modified.',$cr)"/>
  <xsl:value-of select="concat(' *---------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('#define __',$table_name,'_SRC__', $cr)"/>
  <xsl:value-of select="concat('#include &lt;stdio.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &lt;stdlib.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &lt;string.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsobj_', $lower_name, '.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_bit_field.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jtls/vocabulary.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jtls/simtime.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_net.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_logger.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_types.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;sdr/aar.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;sdr/aar_enumerations.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;aarc.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;database.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsComm.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;hash.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;object.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;filter.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;', $local_name, '.h&quot;', $cr, $cr)"/>
  <xsl:value-of select="concat('EXEC SQL INCLUDE SQLCA;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('EXEC SQL BEGIN DECLARE SECTION;',$cr)"/>
  <xsl:value-of select="concat('static int ',$local_name,'Count = 0;',$cr)"/>
  <xsl:value-of select="concat('static ',$macro_name,'_RECORD ',$local_name,'Records[DATABASE_MAX_RECORDS];',$cr)"/>
  <xsl:value-of select="concat('EXEC SQL END DECLARE SECTION;',$cr,$cr)"/>
  <xsl:value-of select="concat('static FILE *', $local_name, 'FilePtr = (FILE *) NULL;',$cr,$cr)"/>
  <xsl:value-of select="concat('static void ', $local_name, 'WriteRecords( void );', $cr)"/>
  <xsl:value-of select="concat('static void ', $local_name, 'ErrorRecord( ', $macro_name, '_RECORD * );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>

  <!-- Template call for each function to be written. -->

  <xsl:call-template name="aarc-function-open">
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
  </xsl:call-template>

  <xsl:call-template name="aarc-function-close">
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
  </xsl:call-template>

  <xsl:call-template name="aarc-function-process">
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="table_name" select="$table_name"/>
    <xsl:with-param name="macro_name" select="$macro_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
  </xsl:call-template>

  <xsl:call-template name="aarc-function-insert">
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="table_name" select="$table_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
    <xsl:with-param name="macro_name" select="$macro_name"/>
  </xsl:call-template>

  <xsl:call-template name="aarc-function-get-time">
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="table_name" select="$table_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
    <xsl:with-param name="macro_name" select="$macro_name"/>
  </xsl:call-template>

  <xsl:call-template name="aarc-function-write">
    <xsl:with-param name="global_name" select="$global_name"/>
    <xsl:with-param name="table_name" select="$table_name"/>
    <xsl:with-param name="local_name" select="$local_name"/>
    <xsl:with-param name="macro_name" select="$macro_name"/>
  </xsl:call-template>

  <xsl:call-template name="aarc-function-error-record">
    <xsl:with-param name="local_name" select="$local_name"/>
    <xsl:with-param name="macro_name" select="$macro_name"/>
  </xsl:call-template>
</xsl:template> <!-- aarc-pro-c-file  -->


<!--
!! TEMPLATE:     aarc-function-open
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 2 August 2006
!! DESCRIPTION:  This template writes the Pro*C code for the open function
!!               on each of AAR objects.
-->
<xsl:template name="aarc-function-open">
  <xsl:param name="global_name"/>
  <xsl:param name="local_name"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        ',$global_name,'Open',$cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function opens the optional output file used to store',$cr)"/>
  <xsl:value-of select="concat(' *              the AAR records. Success returns a 1, failure writes an error',$cr)"/>
  <xsl:value-of select="concat(' *              message and returns 0.',$cr)"/>
  <xsl:value-of select="concat(' *---------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('int ',$global_name,'Open( char *dirName ) {',$cr,$cr)"/>
  <xsl:value-of select="concat('   char filename[2048];',$cr,$cr)"/>
  <xsl:value-of select="concat('   snprintf( filename, 2048, &quot;%s/',$global_name,'.aar&quot;, dirName );',$cr)"/>
  <xsl:value-of select="concat('   ',$local_name,'FilePtr = fopen( filename, &quot;w+&quot; );',$cr)"/>
  <xsl:value-of select="concat('   if ( ! ',$local_name,'FilePtr ) {',$cr)"/>
  <xsl:value-of select="concat('      net_msg_all_consoles( &quot;Error Opening %s\n&quot;, filename );',$cr)"/>
  <xsl:value-of select="concat('      logger_error_msg( &quot;Error Opening %s\n&quot;, filename );',$cr)"/>
  <xsl:value-of select="concat('      return( 0 );',$cr,'   }',$cr,$cr,'   return( 1 );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ',$global_name,'Open */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- aarc-function-open  -->


<!--
!! TEMPLATE:     aarc-function-close
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 2 August 2006
!! DESCRIPTION:  This template writes the Pro*C code for the close function
!!               on each of AAR objects.
-->
<xsl:template name="aarc-function-close">
  <xsl:param name="global_name"/>
  <xsl:param name="local_name"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    ',$global_name,'Close',$cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function closes the optional output file used to store',$cr)"/>
  <xsl:value-of select="concat(' *              the AAR records.',$cr)"/>
  <xsl:value-of select="concat(' *---------------------------------------------------------------------------*/', $cr)"/> 
  <xsl:value-of select="concat('void ',$global_name,'Close( void ) {',$cr,$cr)"/>
  <xsl:value-of select="concat('   fclose( ',$local_name,'FilePtr );',$cr)"/>
  <xsl:value-of select="concat('   ',$local_name,'FilePtr = (FILE *) NULL;',$cr,$cr,'   return;',$cr)"/>
  <xsl:value-of select="concat('} /* end of function ',$global_name,'Close */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- aarc-function-close  -->


<!--
!! TEMPLATE:     aarc-function-process
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 2 August 2006
!! DESCRIPTION:  This template writes the Pro*C code for the process record
!!               function on each of AAR objects.
-->
<xsl:template name="aarc-function-process">
  <xsl:param name="global_name"/>
  <xsl:param name="table_name"/>
  <xsl:param name="macro_name"/>
  <xsl:param name="local_name"/>

  <xsl:variable name="acronym">
    <xsl:call-template name="get-acronym-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="object_enum_name">
    <xsl:call-template name="get-object-enum-name">
      <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="function" select="concat($global_name, 'ProcessRecord')"/>
  <xsl:variable name="container_macro" select="concat($table_name, '_CONTAINER')"/>
  <xsl:variable name="record_macro" select="concat($macro_name, '_RECORD')"/>
  <xsl:variable name="table_enum_macro" select="concat('AAR_TABLE_ENUM_', $macro_name)"/>
  <xsl:variable name="object_enum_macro" select="concat('AAR_OBJECT_ENUM_', $object_enum_name)"/>
  <xsl:variable name="local_ptr" select="concat($local_name, 'Ptr')"/>
  <xsl:variable name="object_count" select="concat($local_name, 'Count')"/>

  <!-- Write the header and variables for the function -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    ', $function ,$cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function processes an ',$table_name,' record from the',$cr)"/>
  <xsl:value-of select="concat(' *              JODA. This entails decoding the JODA data and storing the',$cr)"/>
  <xsl:value-of select="concat(' *              information on a local structure. The local structure has an',$cr)"/>
  <xsl:value-of select="concat(' *              exact match with the Oracle table so a group insert from an',$cr)"/>
  <xsl:value-of select="concat(' *              array of structures can be performed.',$cr)"/>
  <xsl:value-of select="concat(' *---------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('void ', $function, '( PERSISTENT_CONTAINER container ) {',$cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   ', $container_macro, ' containerPtr = ( ', $container_macro, ' ) container;', $cr)"/>
  <xsl:value-of select="concat('   ', $table_name,' objectPtr = ( (', $container_macro, ') container )-&gt;object_ptr;',$cr)"/>
  <xsl:value-of select="concat('   ', $record_macro, ' *', $local_ptr, ' = &amp;', $local_name, 'Records[', $object_count, '++];', $cr)"/>
  <xsl:value-of select="concat('   static char emptyStr[] = &quot;&quot;;', $cr)"/>
  <xsl:value-of select="concat('   char objectName[AAR_MAX_AAR_OBJECT_NAME_LENGTH+1];', $cr)"/>
  <xsl:value-of select="concat('   char *dataStr;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:if test="count(common_knowledge/unique_id) = 1">
    <xsl:value-of select="concat('   /* If we already know about this object do not insert it again */', $cr)"/>
    <xsl:value-of select="concat('   memset( objectName, 0, sizeof( objectName ) );', $cr)"/>
    <xsl:choose>
      <xsl:when test="count(common_knowledge/name) = 1">
        <xsl:value-of select="concat('   strncpy( objectName, objectPtr->name, AAR_MAX_AAR_OBJECT_NAME_LENGTH );', $cr)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('   snprintf( objectName, AAR_MAX_AAR_OBJECT_NAME_LENGTH, &quot;%d&quot;, (int) objectPtr->unique_id );', $cr)"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="concat('   if ( HashFind( ', $object_enum_macro, ', objectName, objectPtr->unique_id ) ) {', $cr)"/>
    <xsl:value-of select="concat('      ', $object_count, '--;', $cr)"/>
    <xsl:value-of select="concat('      return;', $cr)"/>
    <xsl:value-of select="concat('   }', $cr)"/>
  </xsl:if>

  <!-- Clear the local array location that will hold the data -->
  <xsl:value-of select="concat('   memset( ', $local_ptr, ', ', $apos, '\0', $apos, ', sizeof( ', $record_macro, ' ) );', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- if the object has an object_id attribute this is assumed to be an
       event history table. Check the bitmask for the object event -->
  <xsl:if test="count(common_knowledge/*[name() = 'object_id']) &gt; 0">
    <xsl:value-of select="concat('   if ( BITF_ISOFF( FilterEventOutputMask[', $object_enum_macro, '], objectPtr->event ) ) {', $cr)"/>
    <xsl:value-of select="concat('      ', $object_count, '--;', $cr)"/>
    <xsl:value-of select="concat('      return;', $cr)"/>
    <xsl:value-of select="concat('   }', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:if>

  <!-- If this table has a sequence number then load it into the structure -->
  <xsl:for-each select="common_knowledge/*[name() = 'object_id']">
    <xsl:variable name="sequence_name" select="concat('AAR_', $acronym, '_SEQ')"/>
    <xsl:value-of select="concat('   EXEC SQL SELECT ', $sequence_name, '.nextval INTO :', $local_ptr, '-&gt;sequenceNbr FROM DUAL;', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each>

  <!-- All common knowledge attributes are read and mangled for writing out. -->
  <xsl:for-each select="common_knowledge/*[not(name()='destination')]">
    <xsl:variable name="attribute" select="name()"/>
    <xsl:variable name="max_len" select="@db-column-width"/>

    <xsl:variable name="attr">
      <xsl:call-template name="remove-underscores">
        <xsl:with-param name="base_name" select="$attribute"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="macro_attr">
      <xsl:call-template name="get-macro-name">
        <xsl:with-param name="base_name" select="$attribute"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="local_attr">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="$attribute"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="format_node">
      <xsl:call-template name="attribute-node-to-format-node"/>
    </xsl:variable>

    <xsl:value-of select="concat('   if ( containerPtr-&gt;', $attribute, ' ) {',$cr)"/>
    <xsl:choose>
      <xsl:when test="string-length($format_node/class/@vocab) > 0">
        <xsl:value-of select="concat('      static VOCAB_GROUP vocabGroup = NULL;',$cr)"/>
        <xsl:value-of select="concat('      if ( vocabGroup == NULL ) {',$cr)"/>
        <xsl:value-of select="concat('          vocabGroup = vocabulary_get_group( &quot;', $format_node/class/@vocab,'&quot;, AarcSide );',$cr)"/>
        <xsl:value-of select="concat('      }',$cr)"/>
        <xsl:value-of select="concat('      if ( vocabGroup == NULL ) {',$cr)"/>
        <xsl:value-of select="concat('         dataStr = emptyStr;',$cr)"/>
        <xsl:value-of select="concat('      } else {',$cr)"/>
        <xsl:value-of select="concat('         dataStr = (char *) vocabulary_get_name( vocabGroup, objectPtr-&gt;', $macro_attr,' );',$cr)"/>
        <xsl:value-of select="concat('         if ( dataStr == NULL ) {', $cr)"/>
        <xsl:value-of select="concat('            dataStr = emptyStr;', $cr)"/>
        <xsl:value-of select="concat('         }', $cr)"/>
        <xsl:value-of select="concat('      }', $cr)"/>
        <xsl:value-of select="concat('      strncpy( ',$local_ptr, '-&gt;',$local_attr,', dataStr, AAR_', $max_len,' );',$cr)"/>
        <xsl:value-of select="concat('      ',$local_ptr, '-&gt;',$local_attr,'[AAR_',$max_len,'] = ',$apos,'\0',$apos,';', $cr)"/>
      </xsl:when>
      <xsl:when test="$format_node/class/@name = 'TIME'">
        <xsl:value-of select="concat('      simtime_db_snprintf( ',$local_ptr, '-&gt;', $local_attr, ', AAR_MAX_AAR_DB_TIME_LENGTH + 1, objectPtr-&gt;',$macro_attr, ' );', $cr)"/>
        <xsl:if test="$local_ptr = 'time'">
          <xsl:value-of select="concat('      /* Update the database time held by the system. Ideally we would do this',$cr)"/>
          <xsl:value-of select="concat('         when we actually insert the record; however, that would require us to',$cr)"/>
          <xsl:value-of select="concat('         convert the time back from a text into a float */',$cr)"/>
          <xsl:value-of select="concat('      AarcUpdateDatabaseTime( objectPtr->time );',$cr)"/>
        </xsl:if>
      </xsl:when>
      <xsl:when test="$format_node/class/@name = 'STRING'">
        <xsl:value-of select="concat('      strncpy( ',$local_ptr, '-&gt;',$local_attr,', objectPtr-&gt;',$macro_attr,', AAR_', $max_len,' );',$cr)"/>
        <xsl:value-of select="concat('      ',$local_ptr, '-&gt;',$local_attr,'[AAR_',$max_len,'] = ',$apos,'\0',$apos,';',$cr)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('      ',$local_ptr,'-&gt;',$local_attr,' = objectPtr-&gt;',$macro_attr,';',$cr)"/>
      </xsl:otherwise>
    </xsl:choose>
     <xsl:value-of select="concat('   }', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:for-each>

  <xsl:value-of select="concat('   /* If the array of structures is full insert all records into the', $cr)"/>
  <xsl:value-of select="concat('      database tables and output files */', $cr)"/>
  <xsl:value-of select="concat('   if ( ',$local_name,'Count == DATABASE_MAX_RECORDS ) {',$cr)"/>
  <xsl:value-of select="concat('      ObjectInsertQueuedRecords( );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   return;',$cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- aarc-function-process  -->


<!--
!! TEMPLATE:     aarc-function-insert
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 3 August 2006
!! DESCRIPTION:  This template writes the Pro*C code for the insert record
!!               function on each of AAR objects.
-->
<xsl:template name="aarc-function-insert">
  <xsl:param name="global_name"/>
  <xsl:param name="table_name"/>
  <xsl:param name="local_name"/>
  <xsl:param name="macro_name"/>

  <xsl:variable name="function_name" select="concat($global_name, 'InsertRecords')"/>
  <xsl:variable name="object_count" select="concat($local_name, 'Count')"/>
  <xsl:variable name="array_name" select="concat($local_name, 'Records')"/>
  <xsl:variable name="pointer_name" select="concat($local_name, 'Ptr')"/>
  <xsl:variable name="structure_name" select="concat($macro_name, '_RECORD')"/>
  <xsl:variable name="object_enum_macro" select="concat('AAR_OBJECT_ENUM_', $macro_name)"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    ', $function_name, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function takes the array of structures and inserts them',$cr)"/>
  <xsl:value-of select="concat(' *              into the ',$table_name,' table.',$cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('int ', $function_name, '( void ) {',$cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   int insertedRecords = 0;', $cr)"/>
  <xsl:value-of select="concat('   int unprocessedRecords = 0;', $cr)"/>
  <xsl:value-of select="concat('   int totalCount = 0;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   /* Perform the group insert if data is being written to the database */',$cr)"/>
  <xsl:value-of select="concat('   if ( AarcOutputDatabase &amp;&amp; ', $object_count, ' ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      int problemIndex = 0;', $cr)"/>
  <xsl:value-of select="concat('      int index;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      EXEC SQL FOR :',$object_count, ' INSERT INTO ',$table_name,$cr)"/>

  <!-- Create a list of column names. If this table has a sequence number then
       add it to the list -->
  <xsl:value-of select="'         ('"/>
  <xsl:for-each select="common_knowledge/*[name() = 'object_id']">
    <xsl:value-of select="'sequence_nbr, '"/>
  </xsl:for-each>
  <xsl:for-each select="common_knowledge/*[not(name()='destination')]">
    <xsl:value-of select="name()"/>
    <xsl:if test="position() != last()">
       <xsl:value-of select="', '"/>
    </xsl:if>
  </xsl:for-each> <!-- common knowledge attribute -->
  <xsl:value-of select="concat(')', $cr)"/>

  <xsl:value-of select="concat('         VALUES (:', $array_name, ');', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      /* If there was an error on the insert, records up to the problem record', $cr)"/>
  <xsl:value-of select="concat('         should have been inserted. We can identify the problem record. Adjust', $cr)"/>
  <xsl:value-of select="concat('         the count to reflect those records we want saved to the output file', $cr)"/>
  <xsl:value-of select="concat('         (if active) and we will re-invoke this function with the unprocessed', $cr)"/>
  <xsl:value-of select="concat('         records at the end */', $cr)"/>
  <xsl:value-of select="concat('      if ( sqlca.sqlcode &lt; 0 ) {', $cr)"/>
  <xsl:value-of select="concat('         char textTime[SIMTIME_DTG_LENGTH+1];', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('         simtime_snprintf( textTime, SIMTIME_DTG_LENGTH+1, AarcGameTime );', $cr)"/>
  <xsl:value-of select="concat('         problemIndex = sqlca.sqlerrd[2];',$cr)"/>
  <xsl:value-of select="concat('         net_msg_all_consoles( &quot;Unable to insert %s record (Game Time %s)\n&quot;, &quot;',$macro_name,'&quot;, textTime );',$cr)"/>
  <xsl:value-of select="concat('         logger_error_msg( &quot;Unable to insert %s record (Game Time %s)\n&quot;, &quot;',$macro_name,'&quot;, textTime );',$cr)"/>
  <xsl:value-of select="concat('         DatabaseSqlError( );', $cr)"/>
  <xsl:value-of select="concat('         ', $local_name, 'ErrorRecord( &amp;', $array_name, '[problemIndex] );',$cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('         insertedRecords = sqlca.sqlerrd[2];', $cr)"/>
  <xsl:value-of select="concat('         unprocessedRecords = ', $object_count, ' - insertedRecords - 1;', $cr)"/>
  <xsl:value-of select="concat('         totalCount = ', $object_count, ';', $cr)"/>
  <xsl:value-of select="concat('         ', $object_count, ' = insertedRecords;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      } else {', $cr)"/>
  <xsl:value-of select="concat('         insertedRecords = ', $object_count, ';', $cr)"/>
  <xsl:value-of select="concat('         DatabaseInsertsProcessed += insertedRecords;', $cr)"/>
  <xsl:value-of select="concat('      }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:if test="count(common_knowledge/unique_id) = 1">
    <xsl:value-of select="concat('      /* For those objects that were inserted, register them with the hash */', $cr)"/>
    <xsl:value-of select="concat('      for ( index = 0; index &lt; insertedRecords; index++ ) {', $cr)"/>
    <xsl:value-of select="concat('         char objectName[AAR_MAX_AAR_OBJECT_NAME_LENGTH+1];', $cr)"/>
    <xsl:value-of select="concat('         ', $structure_name, ' *', $pointer_name, ' = &amp;', $array_name, '[index];', $cr)"/>
    <xsl:value-of select="$cr"/>
    <xsl:value-of select="concat('         memset( objectName, 0, sizeof( objectName ) );', $cr)"/>
      <xsl:choose>
        <xsl:when test="count(common_knowledge/name) = 1">
          <xsl:value-of select="concat('         strncpy( objectName, ', $pointer_name, '->name, AAR_MAX_AAR_OBJECT_NAME_LENGTH );', $cr)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('         snprintf( objectName, AAR_MAX_AAR_OBJECT_NAME_LENGTH, &quot;%d&quot;, ', $pointer_name, '->uniqueId );', $cr)"/>
        </xsl:otherwise>
      </xsl:choose>
    <xsl:value-of select="concat('         HashInsert( ', $object_enum_macro, ', objectName, ', $pointer_name, '->uniqueId );', $cr)"/>
    <xsl:value-of select="concat('      }', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:if>

  <xsl:value-of select="concat('   } /* end if we are recording the information in the database */', $cr)"/>
  <xsl:value-of select="concat('   EXEC SQL COMMIT;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   /* Write the record to the output file if needed */', $cr)"/>
  <xsl:value-of select="concat('   if ( AarcOutputFile &amp;&amp; ', $object_count, ' ) {', $cr)"/>
  <xsl:value-of select="concat('      ', $local_name, 'WriteRecords( );', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   /* If there are records that were not processed due to an error, re-arrange', $cr)"/>
  <xsl:value-of select="concat('      the array to handle processing them */', $cr)"/>
  <xsl:value-of select="concat('   if ( unprocessedRecords ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      int index = 0;', $cr)"/>
  <xsl:value-of select="concat('      int count = insertedRecords + 1;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('      ', $object_count, ' = unprocessedRecords;', $cr)"/>
  <xsl:value-of select="concat('      for ( ; count &lt; totalCount; count++, index++ ) {', $cr)"/>
  <xsl:value-of select="concat('         memcpy( (void *) &amp;', $array_name, '[index], (void *) &amp;', $array_name, '[count], sizeof( ', $structure_name, ' ) );', $cr)"/>
  <xsl:value-of select="concat('      }', $cr)"/>
  <xsl:value-of select="concat('      ', $function_name, '( );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   } /* if there are records that were not inserted */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   /* Reset the mission counter to re-use the array of objects */', $cr)"/>
  <xsl:value-of select="concat('   ', $object_count, ' = 0;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   return( 1 );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $function_name, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- aarc-function-insert -->


<!--
!! TEMPLATE:     aarc-function-get-time
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 07 September 2011
!! DESCRIPTION:  This template writes the Pro*C code for the retrieval of the
!!               last insert time on each of the AAR objects.
-->
<xsl:template name="aarc-function-get-time">
  <xsl:param name="global_name"/>
  <xsl:param name="table_name"/>
  <xsl:param name="local_name"/>
  <xsl:param name="macro_name"/>

  <xsl:variable name="function_name" select="concat($global_name, 'GetLastInsertTime')"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    ', $function_name, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function takes the array of structures and inserts them',$cr)"/>
  <xsl:value-of select="concat(' *              into the ', $table_name , ' table.',$cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('float ', $function_name, '( void ) {',$cr)"/>
  <xsl:value-of select="concat('   EXEC SQL BEGIN DECLARE SECTION;',$cr)"/>
  <xsl:value-of select="concat('   char tableTime[AAR_MAX_AAR_DB_TIME_LENGTH+1];',$cr)"/>
  <xsl:value-of select="concat('   EXEC SQL END DECLARE SECTION;',$cr)"/>
  <xsl:value-of select="concat('   time_t unixTime;',$cr)"/>
  <xsl:value-of select="concat('   float timeInDays = 0.0;',$cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   EXEC SQL SELECT max(time) INTO :tableTime FROM ', $table_name, ';',$cr)"/>
  <xsl:value-of select="concat('   if ( sqlca.sqlcode == 0 ) {',$cr)"/>
  <xsl:value-of select="concat('      unixTime = simtime_get_db_time( tableTime );',$cr)"/>
  <xsl:value-of select="concat('      timeInDays = (float) simtime_get_days_from_time( unixTime );',$cr)"/>
  <xsl:value-of select="concat('   }',$cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   return( timeInDays );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $function_name, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- aarc-function-get-time -->


<!--
!! TEMPLATE:     aarc-function-write
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 3 August 2006
!! DESCRIPTION:  This template writes the Pro*C code for the write record
!!               function on each of AAR objects.
-->
<xsl:template name="aarc-function-write">
  <xsl:param name="global_name"/>
  <xsl:param name="table_name"/>
  <xsl:param name="local_name"/>
  <xsl:param name="macro_name"/>

  <xsl:variable name="function" select="concat($local_name, 'WriteRecords')"/>
  <xsl:variable name="object_ptr" select="concat($local_name, 'Ptr')"/>
  <xsl:variable name="object_count" select="concat($local_name, 'Count')"/>
  <xsl:variable name="file_ptr" select="concat($local_name, 'FilePtr')"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    ', $function, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function writes the data associated with the current',$cr)"/>
  <xsl:value-of select="concat(' *              ',$table_name,' object to the output file.',$cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('static void ', $function, '( void ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   int index = 0;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   if ( ! ',$local_name,'FilePtr ) {',$cr)"/>
  <xsl:value-of select="concat('      net_msg_all_consoles( &quot;%s file not open. %d Records lost.\n&quot;, &quot;', $table_name,'&quot;, ', $object_count, ' );',$cr)"/>
  <xsl:value-of select="concat('      logger_error_msg( &quot;%s file not open. %d Records lost.\n&quot;, &quot;', $table_name,'&quot;, ', $object_count, ' );',$cr)"/>
  <xsl:value-of select="concat('      return;', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   /* Write each record out */',$cr)"/>
  <xsl:value-of select="concat('   for ( ; index &lt; ', $object_count, '; index++ ) {', $cr)"/>
  <xsl:value-of select="concat('      ', $macro_name, '_RECORD *', $object_ptr, ' = &amp;', $local_name, 'Records[index];', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('      /* Write each component of the record to the file */',$cr)"/>

  <!-- If this table has a sequence number then write it out -->
  <xsl:for-each select="common_knowledge/*[name() = 'object_id']">
    <xsl:value-of select="concat('      fprintf( ', $file_ptr, ', &quot;%d &quot;, ', $object_ptr, '-&gt;sequenceNbr );', $cr)"/>
  </xsl:for-each>

  <!-- Write every other attribute -->
  <xsl:for-each select="common_knowledge/*[not(name()='destination')]">
    <xsl:variable name="attribute" select="name()"/>

    <xsl:variable name="local_attr">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="$attribute"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="format_node">
      <xsl:call-template name="attribute-node-to-format-node"/>
    </xsl:variable>

    <xsl:value-of select="concat('      fprintf( ', $file_ptr, ', &quot;', $format_node/class/@c_format, '&quot;, ', $object_ptr, '-&gt;', $local_attr, ' );', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="concat('      fprintf( ',$file_ptr, ', &quot;\n&quot; );', $cr)"/>
  <xsl:value-of select="concat('   } /* end for each record */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   ', $object_count, ' = 0;', $cr)"/>
  <xsl:value-of select="concat('   fflush( ', $file_ptr, ' );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   return;',$cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $function, ' */', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="$cr"/>
</xsl:template> <!-- aarc-function-write  -->


<!--
!! TEMPLATE:     aarc-function-error-record
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 01 May 2007
!! DESCRIPTION:  This template writes the Pro*C code for the AAR function that takes an object's
!!               structure and prints its elements and values to the error log.
-->
<xsl:template name="aarc-function-error-record">
  <xsl:param name="local_name"/>
  <xsl:param name="macro_name"/>

  <xsl:variable name="function" select="concat($local_name, 'ErrorRecord')"/>
  <xsl:variable name="object_ptr" select="concat($local_name, 'Ptr')"/>
  <xsl:variable name="object_record" select="concat($macro_name, '_RECORD')"/>

  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    ', $function, $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function write a ', $macro_name, ' object', $cr)"/>
  <xsl:value-of select="concat(' *              to the error log, with its element names and values.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('static void ', $function, '( ', $object_record, ' *', $object_ptr, ' ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   /* Write each component of the record to the file */', $cr)"/>

  <!-- If this table has a sequence number then write it out -->
  <xsl:for-each select="common_knowledge/*[name() = 'object_id']">
    <xsl:variable name="element_name" select="'sequenceNbr'"/>
    <xsl:value-of select="concat('   logger_error_msg( &quot;   ', $element_name, ' = %d\n&quot;, ', $object_ptr, '-&gt;sequenceNbr );', $cr)"/>
  </xsl:for-each>

  <!-- Write every other attribute -->
  <xsl:for-each select="common_knowledge/*[not(name()='destination')]">

    <xsl:variable name="element_name">
      <xsl:call-template name="get-local-name">
        <xsl:with-param name="base_name" select="name()"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="format_node">
      <xsl:call-template name="attribute-node-to-format-node"/>
    </xsl:variable>

    <xsl:variable name="newline">
      <xsl:if test="position() = last()">
        <xsl:value-of select="'\n'"/>
      </xsl:if>
    </xsl:variable>
      
    <xsl:value-of select="concat('   logger_error_msg( &quot;   ', $element_name, ' = ', $format_node/class/@c_format, $newline, '\n&quot;, ', $object_ptr, '-&gt;', $element_name, ' );', $cr)"/>

  </xsl:for-each>

  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   return;',$cr)"/>
  <xsl:value-of select="concat('} /* end of function ', $function, ' */', $cr)"/>
</xsl:template> <!-- aarc-function-error-record  -->


<!--
!! TEMPLATE:     aarc-object-proc-file
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 17 July 2006
!! DESCRIPTION:  This template writes out the data for the object.pc source
!!               file.
-->
<xsl:template name="aarc-object-proc-file">

  <!-- Write out the file header information -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        $JSOURCE/aarc/pro_c/object.pc', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This is an automatically generated PRO*C file that contains', $cr)"/>
  <xsl:value-of select="concat(' *              driver functions for the AAR records. Do not change this file', $cr)"/>
  <xsl:value-of select="concat(' *              manually, the contents will be overwritten the next time the', $cr)"/>
  <xsl:value-of select="concat(' *              JDS Protocol is modified.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('#define __OBJECT_SRC__', $cr)"/>
  <xsl:value-of select="concat('#include &lt;stdlib.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &lt;string.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;sdr/aar_enumerations.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;aarc.h&quot;', $cr)"/>

  <xsl:for-each select="protocol/post-processing-data/transient/*">
    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="local_name">
      <xsl:call-template name="get-local-name">
         <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('#include &quot;', $local_name, '.h&quot;', $cr)"/>
  </xsl:for-each>

  <xsl:value-of select="concat('#include &quot;translate.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;filter.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;object.h&quot;', $cr)"/>
  <xsl:value-of select="concat('EXEC SQL INCLUDE SQLCA;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Function ObjectTruncateTables is written -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    ObjectTruncateTables', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function truncates the database tables for each of the', $cr)"/>
  <xsl:value-of select="concat(' *              AAR object types.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('void ObjectTruncateTables( void ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:for-each select="protocol/post-processing-data/transient/*">
    <xsl:variable name="table_name" select="name()"/>
    <xsl:value-of select="concat('   EXEC SQL TRUNCATE TABLE ', $table_name, ';', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   EXEC SQL COMMIT;', $cr)"/>
  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ObjectTruncateTables */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Function ObjectInserQueueRecords is written -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:     ObjectInsertQueuedRecords', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION:  This function calls the database insert function for each', $cr)"/>
  <xsl:value-of select="concat(' *               of the AAR object types.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('void ObjectInsertQueuedRecords( void ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:for-each select="protocol/post-processing-data/transient/*">
    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="global_name">
      <xsl:call-template name="get-global-name">
         <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('   ', $global_name, 'InsertRecords( );', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   EXEC SQL COMMIT;', $cr)"/>
  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ObjectInsertQueuedRecords */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Function ObjectOpenFiles is written -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    ObjectOpenFiles', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function is the driver function to open the output file', $cr)"/>
  <xsl:value-of select="concat(' *              for each of the AAR object types.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('void ObjectOpenFiles( void ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   char dirname[OBJECT_FILE_LENGTH+1];', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('   sprintf( dirname, &quot;%s/%s/SDR&quot;, getenv( &quot;JGAME&quot; ), AarcScenarioName );', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:for-each select="protocol/post-processing-data/transient/*">
    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="global_name">
      <xsl:call-template name="get-global-name">
         <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('   ', $global_name, 'Open( dirname );', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ObjectOpenFiles */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Function ObjectCloseFiles is written -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    ObjectCloseFiles', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function is the driver function to close the output file', $cr)"/>
  <xsl:value-of select="concat(' *              for each of the AAR object types.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('void ObjectCloseFiles( void ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:for-each select="protocol/post-processing-data/transient/*">
    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="global_name">
      <xsl:call-template name="get-global-name">
         <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('   ', $global_name, 'Close();', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ObjectCloseFiles */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Function ObjectProcessCreate is written -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    ObjectProcessCreate', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function distributes an update packet to the proper', $cr)"/>
  <xsl:value-of select="concat(' *              parsing function.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('void ObjectProcessCreate( OBJECT_CLASS objClass, void *conPtr ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   PERSISTENT_CONTAINER container = (PERSISTENT_CONTAINER) conPtr;', $cr)"/>
  <xsl:value-of select="concat('   AAR_TABLE_ENUM table = TranslateObjectClassToTableEnum( objClass );', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   /* Check the table pass through filter to determine if we care about', $cr)"/>
  <xsl:value-of select="concat('      this specific object type */', $cr)"/>
  <xsl:value-of select="concat('   if ( BITF_ISOFF( FilterTableOutputMask, table ) ) {', $cr)"/>
  <xsl:value-of select="concat('      return;', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   switch ( objClass ) {', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:for-each select="protocol/post-processing-data/transient/*">

    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="global_name">
      <xsl:call-template name="get-global-name">
         <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('      case OBJECT_CLASS_', $table_name, ':', $cr)"/>
    <xsl:value-of select="concat('         ', $global_name, 'ProcessRecord( container );', $cr)"/>
    <xsl:value-of select="concat('         break;', $cr)"/>
    <xsl:value-of select="$cr"/>

  </xsl:for-each>
  <xsl:value-of select="concat('      default:', $cr)"/>
  <xsl:value-of select="concat('         break;', $cr)"/>
  <xsl:value-of select="concat('   } /* end switch on the object class */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   return;', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ObjectProcessCreate */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Function ObjectGetLastInsertTime is written -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    ObjectGetLastInsertTime', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function retrieves the last time that any record was', $cr)"/>
  <xsl:value-of select="concat(' *              inserted into the AAR tables. This is retrieved on a startup', $cr)"/>
  <xsl:value-of select="concat(' *              and is used to determine if the current database matches the', $cr)"/>
  <xsl:value-of select="concat(' *              simulation run.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('float ObjectGetLastInsertTime( void ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   float databaseTime = 0.0;', $cr)"/>
  <xsl:value-of select="concat('   float tableTime;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:for-each select="protocol/post-processing-data/transient/*">

    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="global_name">
      <xsl:call-template name="get-global-name">
         <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('   tableTime = ', $global_name, 'GetLastInsertTime( );', $cr)"/>
    <xsl:value-of select="concat('   if ( tableTime > databaseTime ) {', $cr)"/>
    <xsl:value-of select="concat('      databaseTime = tableTime;', $cr)"/>
    <xsl:value-of select="concat('   }', $cr)"/>
    <xsl:value-of select="$cr"/>

  </xsl:for-each>

  <xsl:value-of select="concat('   return( databaseTime );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function ObjectGetLastInsertTime */', $cr)"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- aarc-object-proc-file -->


<!--
!! TEMPLATE:     aarc-object-include-file
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 17 July 2006
!! DESCRIPTION:  This template writes out the data for the object.h header
!!               file. This consists of include files and function prototypes.
-->
<xsl:template name="aarc-object-include-file">
  <xsl:value-of select="concat('#ifndef __OBJECT_INC__', $cr)"/>
  <xsl:value-of select="concat('#define __OBJECT_INC__', $cr)"/>
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        $JSOURCE/aarc/generated/object.h', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This is an automatically generated PRO*C header file for the', $cr)"/>
  <xsl:value-of select="concat(' *              object source code. Do not change this file manually, the', $cr)"/>
  <xsl:value-of select="concat(' *              contents will be overwritten the next time the JDS Protocol', $cr)"/>
  <xsl:value-of select="concat(' *              is modified.', $cr)"/>
  <xsl:value-of select="concat(' *---------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_basic.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_public.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_event_dispatcher.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_net.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_peer.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsctl_peer_register.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_event_dispatcher.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_structures.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_enumerations.h&quot;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('#define OBJECT_FILE_LENGTH 1023', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('#ifdef __OBJECT_SRC__', $cr)"/>
  <xsl:value-of select="concat('#define __OBJECT_TYPE__ ', $cr)"/>
  <xsl:value-of select="concat('#else', $cr)"/>
  <xsl:value-of select="concat('#define __OBJECT_TYPE__ extern', $cr)"/>
  <xsl:value-of select="concat('#endif', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('__OBJECT_TYPE__ void ObjectTruncateTables( void );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE__ void ObjectInsertQueuedRecords( void );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE__ void ObjectOpenFiles( void );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE__ void ObjectCloseFiles( void );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE__ void ObjectProcessCreate( OBJECT_CLASS, void * );', $cr)"/>
  <xsl:value-of select="concat('__OBJECT_TYPE__ float ObjectGetLastInsertTime( void );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('#endif /* not defined __OBJECT_INC__ */', $cr)"/>

</xsl:template> <!-- aarc-object-include-file -->


<!--
!! TEMPLATE:     aarc-translate-proc-file
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 01 December 2011
!! DESCRIPTION:  This template writes out the data for the translate.pc source
!!               file.
-->
<xsl:template name="aarc-translate-proc-file">

  <xsl:variable name="table_nodes" select="protocol/post-processing-data/transient/*"/>
  <xsl:variable name="object_nodes" select="protocol/post-processing-data/transient/*[common_knowledge/*[name() = 'unique_id']]"/>
  <xsl:variable name="aarc_file" select="concat($aarxmlhome, '/aar_data.xml')"/>
  <xsl:variable name="aarc_fragment" select="document($aarc_file)"/>
  <xsl:variable name="event_nodes" select="$aarc_fragment/AAR-System-Data/Object-Events/Event"/>

  <!-- Write out the file header information -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        $JSOURCE/aarc/pro_c/translate.pc', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This is an automatically generated PRO*C file that contains', $cr)"/>
  <xsl:value-of select="concat(' *              provides translations between AAR table and event names and', $cr)"/>
  <xsl:value-of select="concat(' *              their corresponding AAR enumeration. Do not change this', $cr)"/>
  <xsl:value-of select="concat(' *              file manually, the contents will be overwritten the next time', $cr)"/>
  <xsl:value-of select="concat(' *              the JDS Protocol is modified.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('#define __AAR_TRANSLATE_SRC__', $cr)"/>
  <xsl:value-of select="concat('#include &lt;string.h&gt;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_enumerations.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;sdr/aar_enumerations.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;translate.h&quot;', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Function TranslateTableName is written -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    TranslateTableName', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function translates an AAR table name to an AAR_TABLE_ENUM', $cr)"/>
  <xsl:value-of select="concat(' *              enumeration. If the table name is not found a value of', $cr)"/>
  <xsl:value-of select="concat(' *              AAR_TABLE_ENUM_INVALID is returned.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('AAR_TABLE_ENUM TranslateTableName( char *tableName ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   if ( ! tableName ) {', $cr)"/>
  <xsl:value-of select="concat('      return( AAR_TABLE_ENUM_INVALID );', $cr)"/>
  <xsl:for-each select="$table_nodes">
    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="macro_name">
      <xsl:call-template name="get-macro-name">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('   } else if ( ! strcmp( tableName, &quot;', $table_name, '&quot; ) ) {', $cr)"/>
    <xsl:value-of select="concat('      return( AAR_TABLE_ENUM_', $macro_name, ' );', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   return( AAR_TABLE_ENUM_INVALID );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function TranslateTableName */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Function TranslateTableEnumToName is written -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    TranslateTableEnumToName', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function translates an AAR_TABLE_ENUM to an AAR table', $cr)"/>
  <xsl:value-of select="concat(' *              name. If the enumeration is invalid the string &quot;AAR_TABLE_INVALID&quot;', $cr)"/>
  <xsl:value-of select="concat(' *              is returned. The return value is a constant string which', $cr)"/>
  <xsl:value-of select="concat(' *              should not be modified or released by the calling function.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('const char *TranslateTableEnumToName( AAR_TABLE_ENUM tableEnum ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   switch ( tableEnum ) {', $cr)"/>
  <xsl:for-each select="$table_nodes">
    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="macro_name">
      <xsl:call-template name="get-macro-name">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('      case AAR_TABLE_ENUM_', $macro_name, ': return( &quot;', $table_name, '&quot; );', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="concat('      default: break;', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   return( &quot;AAR_TABLE_INVALID&quot; );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function TranslateTableEnumToName */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Function TranslateObjectName is written -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:   TranslateObjectName ', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function translates an AAR object name to an AAR_OBJECT_ENUM', $cr)"/>
  <xsl:value-of select="concat(' *              enumeration. If the object name is not found a value of', $cr)"/>
  <xsl:value-of select="concat(' *              AAR_OBJECT_ENUM_INVALID is returned.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('AAR_OBJECT_ENUM TranslateObjectName( char *objectName ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   if ( ! objectName ) {', $cr)"/>
  <xsl:value-of select="concat('      return( AAR_OBJECT_ENUM_INVALID );', $cr)"/>
  <xsl:for-each select="$object_nodes">
    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="macro_name">
      <xsl:call-template name="get-macro-name">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="object_name" select="concat('AAR_OBJECT_ENUM_', $macro_name)"/>
    <xsl:value-of select="concat('   } else if ( ! strcmp( objectName, &quot;', $macro_name, '&quot; ) ) {', $cr)"/>
    <xsl:value-of select="concat('      return( AAR_OBJECT_ENUM_', $macro_name, ' );', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   return( AAR_OBJECT_ENUM_INVALID );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function TranslateObjectName */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Function TranslateObjectEnumToName is written -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    TranslateObjectEnumToName', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function translates an AAR_OBJECT_ENUM enumeration to an AAR', $cr)"/>
  <xsl:value-of select="concat(' *               object name. If the enumeration is invalid the string', $cr)"/>
  <xsl:value-of select="concat(' *              &quot;AAR_OBJECT_ENUM_INVALID&quot; is returned. The return value', $cr)"/>
  <xsl:value-of select="concat(' *              is a constant string which should not be modified or released', $cr)"/>
  <xsl:value-of select="concat(' *              by the calling function.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('const char *TranslateObjectEnumToName( AAR_OBJECT_ENUM objectEnum ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   switch ( objectEnum ) {', $cr)"/>
  <xsl:for-each select="$object_nodes">
    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="macro_name">
      <xsl:call-template name="get-macro-name">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('      case AAR_OBJECT_ENUM_', $macro_name, ': return( &quot;', $macro_name, '&quot; );', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="concat('      default: break;', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   return( &quot;AAR_OBJECT_ENUM_INVALID&quot; );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function TranslateObjectEnumToName */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Function TranslateObjectNameToTable is written -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    TranslateObjectNameToTable', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function translates an AAR object name to an AAR_TABLE_ENUM', $cr)"/>
  <xsl:value-of select="concat(' *              enumeration. If the object name is not found a value of', $cr)"/>
  <xsl:value-of select="concat(' *              AAR_TABLE_ENUM_INVALID is returned.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('AAR_TABLE_ENUM TranslateObjectNameToTable( char *objectName ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   if ( ! objectName ) {', $cr)"/>
  <xsl:value-of select="concat('      return( AAR_TABLE_ENUM_INVALID );', $cr)"/>
  <xsl:for-each select="$object_nodes">
    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="macro_name">
      <xsl:call-template name="get-macro-name">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="object_name" select="concat('AAR_OBJECT_ENUM_', $macro_name)"/>
    <xsl:value-of select="concat('   } else if ( ! strcmp( objectName, &quot;', $macro_name, '&quot; ) ) {', $cr)"/>
    <xsl:value-of select="concat('      return( AAR_TABLE_ENUM_', $macro_name, ' );', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   return( AAR_TABLE_ENUM_INVALID );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function TranslateObjectNameToTable */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Function  is written -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    TranslateObjectClassToTableEnum', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function translates an AAR table name to an AAR_TABLE_ENUM', $cr)"/>
  <xsl:value-of select="concat(' *              enumeration. If the table name is not found a value of', $cr)"/>
  <xsl:value-of select="concat(' *              AAR_TABLE_ENUM_INVALID is returned.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('AAR_TABLE_ENUM TranslateObjectClassToTableEnum( OBJECT_CLASS objClass ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   switch ( objClass ) {', $cr)"/>
  <xsl:for-each select="$table_nodes">
    <xsl:variable name="table_name" select="name()"/>
    <xsl:variable name="macro_name">
      <xsl:call-template name="get-macro-name">
        <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="object_name" select="concat('OBJECT_CLASS_', $table_name)"/>
    <xsl:variable name="enum_name" select="concat('AAR_TABLE_ENUM_', $macro_name)"/>
    <xsl:value-of select="concat('      case ', $object_name, ': return( ', $enum_name, ' );', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="concat('      default: break;', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   return( AAR_TABLE_ENUM_INVALID );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function TranslateObjectClassToTableEnum */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Function TranslateEventName is written -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    TranslateEventName', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function translates an AAR event name to an AAR_EVENT_ENUM', $cr)"/>
  <xsl:value-of select="concat(' *              enumeration. If the table name is not found a value of', $cr)"/>
  <xsl:value-of select="concat(' *              AAR_EVENT_ENUM_INVALID is returned.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('AAR_EVENT_ENUM TranslateEventName( char *eventName ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   if ( ! eventName ) {', $cr)"/>
  <xsl:value-of select="concat('      return( AAR_EVENT_ENUM_INVALID );', $cr)"/>
  <xsl:for-each select="$event_nodes">
    <xsl:variable name="event_name" select="@Name"/>
    <xsl:variable name="event_enumeration" select="concat('AAR_EVENT_ENUM_', $event_name)"/>
    <xsl:value-of select="concat('   } else if ( ! strcmp( eventName, &quot;', $event_name, '&quot; ) ) {', $cr)"/>
    <xsl:value-of select="concat('      return( ', $event_enumeration, ' );', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   return( AAR_EVENT_ENUM_INVALID );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function TranslateEventName */', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- Function TranslateEventEnumToName is written -->
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FUNCTION:    TranslateEventEnumToName', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This function translates an AAR_EVENT_ENUM enumeration to an', $cr)"/>
  <xsl:value-of select="concat(' *              AAR event name. If the enumeration is invalid the string', $cr)"/>
  <xsl:value-of select="concat(' *              &quot;AAR_EVENT_ENUM_INVALID&quot; is returned. The return value', $cr)"/>
  <xsl:value-of select="concat(' *              is a constant string which should not be modified or released', $cr)"/>
  <xsl:value-of select="concat(' *              by the calling function.', $cr)"/>
  <xsl:value-of select="concat(' *--------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('const char *TranslateEventEnumToName( AAR_EVENT_ENUM eventEnum ) {', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   switch ( eventEnum ) {', $cr)"/>
  <xsl:for-each select="$event_nodes">
    <xsl:variable name="event_name" select="@Name"/>
    <xsl:value-of select="concat('      case AAR_EVENT_ENUM_', $event_name, ': return( &quot;', $event_name, '&quot; );', $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="concat('      default: break;', $cr)"/>
  <xsl:value-of select="concat('   }', $cr)"/>
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('   return( &quot;AAR_EVENT_ENUM_INVALID&quot; );', $cr)"/>
  <xsl:value-of select="concat('} /* end of function TranslateEventEnumToName */', $cr)"/>
  <xsl:value-of select="$cr"/>

</xsl:template> <!-- aarc-translate-proc-file -->


<!--
!! TEMPLATE:     aarc-translate-include-file
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 01 December 2011
!! DESCRIPTION:  This template writes out the data for the translate.h header
!!               file. This consists of include files and function prototypes.
-->
<xsl:template name="aarc-translate-include-file">
  <xsl:value-of select="concat('#ifndef __AAR_TRANSLATE_SRC__', $cr)"/>
  <xsl:value-of select="concat('#define __AAR_TRANSLATE_SRC__', $cr)"/>
  <xsl:value-of select="concat('/*----------------------------------------------------------------------------', $cr)"/>
  <xsl:value-of select="concat(' * FILE:        $JSOURCE/aarc/generated/translate.h', $cr)"/>
  <xsl:value-of select="concat(' * DESCRIPTION: This is an automatically generated PRO*C header file for the', $cr)"/>
  <xsl:value-of select="concat(' *              translate source code. Do not change this file manually, the', $cr)"/>
  <xsl:value-of select="concat(' *              contents will be overwritten the next time the JDS Protocol', $cr)"/>
  <xsl:value-of select="concat(' *              is modified.', $cr)"/>
  <xsl:value-of select="concat(' *---------------------------------------------------------------------------*/', $cr)"/>
  <xsl:value-of select="concat('#include &quot;sdr/aar_enumerations.h&quot;', $cr)"/>
  <xsl:value-of select="concat('#include &quot;jdsp_enumerations.h&quot;', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('#ifdef __AAR_TRANSLATE_SRC__', $cr)"/>
  <xsl:value-of select="concat('#define  __AAR_TRANSLATE_TYPE', $cr)"/>
  <xsl:value-of select="concat('#else', $cr)"/>
  <xsl:value-of select="concat('#define __AAR_TRANSLATE_TYPE extern', $cr)"/>
  <xsl:value-of select="concat('#endif', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('__AAR_TRANSLATE_TYPE AAR_TABLE_ENUM TranslateTableName( char * );', $cr)"/>
  <xsl:value-of select="concat('__AAR_TRANSLATE_TYPE AAR_TABLE_ENUM TranslateObjectNameToTable( char * );', $cr)"/>
  <xsl:value-of select="concat('__AAR_TRANSLATE_TYPE AAR_TABLE_ENUM TranslateObjectClassToTableEnum( OBJECT_CLASS );', $cr)"/>
  <xsl:value-of select="concat('__AAR_TRANSLATE_TYPE AAR_OBJECT_ENUM TranslateObjectName( char * );', $cr)"/>
  <xsl:value-of select="concat('__AAR_TRANSLATE_TYPE AAR_EVENT_ENUM TranslateEventName( char * );', $cr)"/>
  <xsl:value-of select="concat('__AAR_TRANSLATE_TYPE const char *TranslateTableEnumToName( AAR_TABLE_ENUM );', $cr)"/>
  <xsl:value-of select="concat('__AAR_TRANSLATE_TYPE const char *TranslateObjectEnumToName( AAR_OBJECT_ENUM );', $cr)"/>
  <xsl:value-of select="concat('__AAR_TRANSLATE_TYPE const char *TranslateEventEnumToName( AAR_EVENT_ENUM );', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('#endif /* not defined __AAR_TRANSLATE_SRC__ */', $cr)"/>

</xsl:template> <!-- aarc-translate-include-file -->


<!--
!! TEMPLATE:     sql-create-script
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: July 13, 2006
!! DESCRIPTION:  This template generates the create script for the Oracle
!!               tables.
-->
<xsl:template name="sql-create-script">

  <xsl:value-of select="concat('-- This sql script file is responsible for creating the AARC (After Action', $cr)"/>
  <xsl:value-of select="concat('-- Review Client) related tables within the Scenario Data Repository (SDR). ', $cr)"/>
  <xsl:value-of select="concat('-- This file is automatically generated from the JDS Protocol.', $cr)"/>
  <xsl:value-of select="concat('--', $cr)"/>
  <xsl:value-of select="$copyright"/>
  <xsl:value-of select="concat('--', $cr)"/>
  <xsl:value-of select="concat('-- Turn off verification. This suppresses listing substitution lines when', $cr)"/>
  <xsl:value-of select="concat('-- defines are replaced by their real values', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('SET VERIFY OFF', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- All string lengths within constants are read and written out -->
  <xsl:value-of select="concat('-- The following defines are used for variable character strings', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:for-each select="constants/*[not(name() = 'description')] | $other_constant_nodes/*">
    <xsl:value-of select="concat('DEFINE ', name(), ' = ', @value, $cr)"/>
  </xsl:for-each>
  <xsl:value-of select="$cr"/>

  <!-- For each of the object create a table and other associated database
       items. This is done in 3 passes. The non-JDSP tables are done first
       because other tables refer to the AAR_OBJECT_LOOKUP table. These are
       followed by the tables with a unique_id because they get assigned
       sequential numbers (based on their position). Lastly come those without
       a unqiue_id tag/attribute -->
  <xsl:for-each select="$other_table_nodes/*">
    <xsl:call-template name="sql-create-table"/>
  </xsl:for-each>
  <xsl:value-of select="concat('INSERT INTO AAR_OBJECT_LOOKUP values(0, 0, ', $apos, 'UNKNOWN', $apos, ', ', $apos, 'UNKNOWN', $apos, ');', $cr)"/>
  <xsl:value-of select="concat('INSERT INTO AAR_CHECKPOINT values(', $apos, '0000', $apos, ');', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:for-each select="protocol/post-processing-data/transient/*[count(common_knowledge/unique_id) = 1]">
    <xsl:call-template name="sql-create-table"/>
  </xsl:for-each>
  <xsl:for-each select="protocol/post-processing-data/transient/*[count(common_knowledge/unique_id) = 0]">
    <xsl:call-template name="sql-create-table"/>
  </xsl:for-each>
  <xsl:value-of select="concat('COMMIT;', $cr)"/>

  <xsl:value-of select="concat('-- DO NOT USE QUIT OR EXIT (called from within another sql script)', $cr)"/>

</xsl:template> <!-- sql-create-script -->


<!--
!! TEMPLATE:     sql-create-table
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: July 13, 2006
!! DESCRIPTION:  This template uses the data from the current node to write
!!               the definition of an SQL table.
-->
<xsl:template name="sql-create-table">

  <!-- Get data about this table and variables to manipulate it -->
  <xsl:variable name="table_name" select="name()"/>
  <xsl:variable name="table_number" select="position()"/>

  <xsl:variable name="macro_name">
    <xsl:call-template name="get-macro-name">
       <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="object_name">
    <xsl:call-template name="get-object-name">
       <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="local_name">
    <xsl:call-template name="get-local-name">
       <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="global_name">
    <xsl:call-template name="get-global-name">
       <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="acronym_name">
    <xsl:call-template name="get-acronym-name">
       <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:value-of select="concat('CREATE TABLE ', $table_name, ' (', $cr)"/>

  <!-- if the table has an object_id attribute then it is assumed to be an
       event history table and automatically gets a sequence number column
       to track the order of inserts -->
  <xsl:if test="not(name() = 'AAR_OBJECT_LOOKUP') and count(common_knowledge/object_id) = 1">
    <xsl:value-of select="concat('   sequence_nbr NUMBER(10),', $cr)"/>
  </xsl:if> <!-- object_id attribute -->

  <!-- All common knowledge names become columns within the table
       except for destination -->
  <xsl:for-each select="common_knowledge/*[not(name() = 'destination')]">

    <!-- get the database type for the attribute. If the attribute has a
         maximum length it is a string; Otherwise, if its a real we assign
         it as a float, anything else must be an integer -->
    <xsl:variable name="type">
      <xsl:choose>
        <xsl:when test="@db-column-width">
          <xsl:value-of select="concat('VARCHAR2(&amp;', @db-column-width, ')')"/>
        </xsl:when>
        <xsl:when test="@uom = 'days'">
          <xsl:value-of select="'DATE'"/>
        </xsl:when>
        <xsl:when test="@type='REAL_32'">
          <xsl:value-of select="'FLOAT'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'NUMBER(10)'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="name" select="name()"/>

    <!-- output the type and name for this attribute -->
    <xsl:value-of select="concat('   ', $name, ' ', $type)"/>

    <!-- if this attribiute is listed as a foreign key then create a
         foreign key constraint linking the column to the AAR_OBJECT_LOOKUP
         table -->
    <xsl:if test="@db-is-foreign-key='true'">
      <xsl:variable name="fk">
        <xsl:call-template name="to-lower">
          <xsl:with-param name="base_name" select="concat('AAR_', $acronym_name, '_', $name, '_fk')"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="concat(' CONSTRAINT ', $fk, ' REFERENCES AAR_OBJECT_LOOKUP(object_id)')"/>
    </xsl:if>

    <!-- primary keys need to be listed as such -->
    <xsl:if test="@db-is-primary-key='true'">
      <xsl:variable name="pk">
        <xsl:call-template name="to-lower">
          <xsl:with-param name="base_name" select="concat('AAR_', $acronym_name, '_', $name, '_pk')"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:value-of select="concat(' CONSTRAINT ', $pk, ' PRIMARY KEY')"/>
    </xsl:if>

    <!-- add on either a comma for the next column or an end table
         parenthesis -->
    <xsl:choose>
      <xsl:when test="position()=last()">
        <xsl:value-of select="concat(' );', $cr)"/>
      </xsl:when>        
      <xsl:otherwise>
        <xsl:value-of select="concat(',', $cr)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each> <!-- common_knowledge attribute -->

  <!-- Go through all columns again and create the bitmap indices for any
       columns that should have them -->
  <xsl:for-each select="common_knowledge/*[@db-bitmap = 'true']">
    <xsl:variable name="name" select="name()"/>
    <xsl:variable name="bitmap_idx">
      <xsl:call-template name="to-upper">
        <xsl:with-param name="base_name" select="concat('AAR_', $acronym_name, '_', $name, '_bidx')"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="concat('CREATE BITMAP INDEX ', $bitmap_idx, ' ON ', $table_name, '(', $name, ') NOLOGGING COMPUTE STATISTICS;', $cr)"/>
  </xsl:for-each> <!-- common_knowledge attribute -->
  <xsl:value-of select="$cr"/>

  <!-- If this object has a id field then we also want to create a
       trigger to load inserts into the AAR_OBJECT_LOOKUP table -->
  <xsl:variable name="exists">
     <xsl:for-each select="common_knowledge/*[name() = 'name']">
       <xsl:value-of select="'true'"/>
     </xsl:for-each>
  </xsl:variable>

  <xsl:if test="count(common_knowledge/unique_id) = 1">
    <xsl:value-of select="concat('CREATE TRIGGER ', $table_name, '_TRG', $cr)"/>
    <xsl:value-of select="concat('   AFTER INSERT ON ', $table_name, $cr)"/>
    <xsl:value-of select="concat('   FOR EACH ROW', $cr)"/>
    <xsl:value-of select="concat('   BEGIN', $cr)"/>
    <xsl:value-of select="concat('      INSERT INTO AAR_OBJECT_LOOKUP', $cr)"/>
    <xsl:choose>
      <xsl:when test="$exists = 'true'">
        <xsl:value-of select="concat('         VALUES(:new.unique_id, ', $table_number, ', ', $apos, $macro_name, $apos, ', :new.name);',  $cr)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="concat('         VALUES(:new.unique_id, ', $table_number, ', ', $apos, $macro_name, $apos, ', TO_CHAR(:new.unique_id));',  $cr)"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="concat('   END;', $cr)"/>
    <xsl:value-of select="concat('.', $cr)"/>
    <xsl:value-of select="concat('/', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:if> <!-- id attribute -->

  <!-- If this object is an event field then we also want to create a unique
       sequence number for it -->
  <xsl:if test="not(name() = 'AAR_OBJECT_LOOKUP') and count(common_knowledge/object_id) = 1">
    <xsl:variable name="sequence_name" select="concat('AAR_', $acronym_name, '_SEQ')"/>
    <xsl:value-of select="concat('CREATE SEQUENCE ', $sequence_name, ' START WITH 1;', $cr)"/>
    <xsl:value-of select="$cr"/>
  </xsl:if>

</xsl:template> <!-- sql-create-table -->


<!--
!! TEMPLATE:     sql-destroy-script
!! PROGRAMMER:   Rick kalinyak
!! DATE CREATED: 08 August 2006
!! DESCRIPTION:  This template generates the destroy script for the Oracle
!!               tables.
-->
<xsl:template name="sql-destroy-script">

  <xsl:value-of select="concat('-- This sql script file is responsible for dropping the AARC (After Action', $cr)"/>
  <xsl:value-of select="concat('-- Review Client) related tables within the Scenario Data Repository (SDR). ', $cr)"/>
  <xsl:value-of select="concat('-- This file is automatically generated from the JDS Protocol.', $cr)"/>
  <xsl:value-of select="concat('--', $cr)"/>
  <xsl:value-of select="$copyright"/>
  <xsl:value-of select="concat('--', $cr)"/>
  <xsl:value-of select="concat('-- Turn off verification. This suppresses listing substitution lines when', $cr)"/>
  <xsl:value-of select="concat('-- defines are replaced by their real values', $cr)"/>
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('SET VERIFY OFF', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- All objects within the AAR transient data represent tables that must
       be destroyed -->
  <xsl:for-each select="protocol/post-processing-data/transient/* | $other_table_nodes/*">

    <xsl:variable name="table_name" select="name()"/>

    <xsl:variable name="acronym_name">
      <xsl:call-template name="get-acronym-name">
         <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="concat('DROP TABLE ', $table_name, ';', $cr)"/>

    <!-- Determine if this table has an associated sequence number -->
    <xsl:if test="not(name() = 'AAR_OBJECT_LOOKUP') and count(common_knowledge/object_id) = 1">
      <xsl:variable name="sequence_name" select="concat('AAR_', $acronym_name, '_SEQ')"/>
      <xsl:value-of select="concat('DROP SEQUENCE ', $sequence_name, ';', $cr)"/>
    </xsl:if>

  </xsl:for-each> <!-- AAR object -->
  <xsl:value-of select="$cr"/>

  <xsl:value-of select="concat('-- DO NOT USE QUIT OR EXIT (called from within another sql script)', $cr)"/>

</xsl:template> <!-- sql-destroy-script -->


<!--
!! TEMPLATE:     sql-recover-script
!! PROGRAMMER:   Rick kalinyak
!! DATE CREATED: 01 February 2007
!! DESCRIPTION:  This template generates the recover script for the Oracle
!!               sequences.
-->
<xsl:template name="sql-recover-script">

  <xsl:value-of select="concat('-- This sql script file is responsible for recovering the AARC (After Action', $cr)"/>
  <xsl:value-of select="concat('-- Review Client) database items that were not saved as part of an export/import', $cr)"/>
  <xsl:value-of select="concat('-- procedure. This file is automatically generated from the JDS Protocol.', $cr)"/>
  <xsl:value-of select="concat('--', $cr)"/>
  <xsl:value-of select="$copyright"/>
  <xsl:value-of select="concat('--', $cr)"/>

  <!-- Go through each table and for those that have an associates sequence
       number create a procedure to handle recovery of the sequence -->
  <xsl:for-each select="protocol/post-processing-data/transient/*">

    <xsl:variable name="table_name" select="name()"/>

    <xsl:variable name="acronym_name">
      <xsl:call-template name="get-acronym-name">
         <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <!-- Determine if this table has an associated sequence number -->
    <xsl:for-each select="common_knowledge/*[name() = 'object_id']">
      <xsl:variable name="sequence_name" select="concat('AAR_', $acronym_name, '_SEQ')"/>
      <xsl:value-of select="concat('DECLARE', $cr)"/>
      <xsl:value-of select="concat('   startValue NUMBER;', $cr)"/>
      <xsl:value-of select="concat('BEGIN', $cr)"/>
      <xsl:value-of select="concat('   SELECT MAX(sequence_nbr) + 1 INTO startValue FROM ', $table_name, ';', $cr)"/>
      <xsl:value-of select="concat('   IF startValue > 0 THEN', $cr)"/>
      <xsl:value-of select="concat('      EXECUTE IMMEDIATE ', $apos, 'CREATE SEQUENCE ', $sequence_name, ' START WITH ', $apos, ' || startValue;', $cr)"/>
      <xsl:value-of select="concat('   ELSE', $cr)"/>
      <xsl:value-of select="concat('      EXECUTE IMMEDIATE ', $apos, 'CREATE SEQUENCE ', $sequence_name, ' START WITH 1', $apos, ';', $cr)"/>
      <xsl:value-of select="concat('   END IF;', $cr)"/>
      <xsl:value-of select="concat('END;', $cr)"/>
      <xsl:value-of select="concat('/', $cr)"/>
      <xsl:value-of select="$cr"/>
    </xsl:for-each>

  </xsl:for-each> <!-- AAR object -->
  <xsl:value-of select="$cr"/>
  <xsl:value-of select="concat('QUIT;', $cr)"/>


</xsl:template> <!-- sql-recover-script -->


<!--
!! TEMPLATE:     sql-loader-control
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 13 August 2006
!! DESCRIPTION:  This template generates a file that lists all the SQL*Loader
!!               control files for the AAR. This is designed to provide a
!!               listing of the files for the script that invokes the
!!               SQL*Loader.
-->
<xsl:template name="sql-loader-control">

  <xsl:value-of select="concat('#', $cr)"/>
  <xsl:value-of select="concat('# FILE:         $JTLSHOME/script/sdr/load/load_ctl', $cr)"/>
  <xsl:value-of select="concat('# DESCRIPTION:  This is an automatically generated file. It is generated every', $cr)"/>
  <xsl:value-of select="concat('#               time the JDS Protocol is changed. Changes should not be made', $cr)"/>
  <xsl:value-of select="concat('#               directly to this file.', $cr)"/>
  <xsl:value-of select="concat('#', $cr)"/>
  <xsl:value-of select="concat('#               This file contains the names of all the control files to', $cr)"/>
  <xsl:value-of select="concat('#               perform an AAR checkpoint load. The file is read by the', $cr)"/>
  <xsl:value-of select="concat('#               aar_load shell cript to determine the AAR files and to', $cr)"/>
  <xsl:value-of select="concat('#               invoke the SQL Loader for each control files. Control files', $cr)"/>
  <xsl:value-of select="concat('#               have as their prefix the same name as the AAR output file.', $cr)"/>
  <xsl:value-of select="concat('#', $cr)"/>
  <xsl:value-of select="$cr"/>

  <!-- List each SQL Loader control file (one for each AAR table) -->
  <xsl:for-each select="protocol/post-processing-data/transient/*">

    <xsl:variable name="table_name" select="name()"/>

    <xsl:variable name="file_name">
      <xsl:call-template name="get-file-name">
         <xsl:with-param name="base_name" select="$table_name"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="filename_control" select="concat($file_name, '.ctl')"/>
    <xsl:value-of select="concat($filename_control, $cr)"/>

  </xsl:for-each> <!-- end for each transient object -->
  <xsl:value-of select="$cr"/>
 
</xsl:template> <!-- sql-loader-control -->


<!--
!! TEMPLATE:     sql-loader-file
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 13 August 2006
!! DESCRIPTION:  This template generates a control script for an AAR database
!!               table. The control script is used by the SQL*Loader to load
!!               data from ASCII flat files into a database.
-->
<xsl:template name="sql-loader-file">

  <xsl:variable name="table_name" select="name()"/>

  <xsl:variable name="global_name">
    <xsl:call-template name="get-global-name">
       <xsl:with-param name="base_name" select="$table_name"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="input_filename" select="concat($global_name, '.aar')"/>

  <xsl:value-of select="concat('LOAD DATA', $cr)"/>
  <xsl:value-of select="concat('INFILE ', $apos, $input_filename, $apos, $cr)"/>
  <xsl:value-of select="concat('INTO TABLE ', $table_name, $cr)"/>
  <xsl:value-of select="concat('FIELDS TERMINATED BY WHITESPACE OPTIONALLY ENCLOSED BY ', $apos, '&amp;', $apos, $cr)"/>

  <!-- All common knowledge names are columns within the table except for
       destination -->
  <xsl:value-of select="'   ('"/>
  <xsl:for-each select="common_knowledge/*[not(name() = 'destination')]">

    <xsl:value-of select="name()"/>
    <xsl:choose>
      <xsl:when test="position() = last()">
        <xsl:value-of select="concat(')', $cr)"/>
      </xsl:when>        
      <xsl:otherwise>
        <xsl:value-of select="concat(',', $cr, '    ')"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each> <!-- common_knowledge attribute -->

</xsl:template> <!-- sql-loader-file -->


<!--
!! TEMPLATE:     attribute-node-to-format-node
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 05 February 2008
!! DESCRIPTION:  This template should only be called when the XPath is on a
!!               common attribute node. It matches the node to a class node
!!               and returns the class node.
-->
<xsl:template name="attribute-node-to-format-node">

  <xsl:variable name="max_length">
    <xsl:call-template name="find-db-column-width"/>
  </xsl:variable>

  <xsl:variable name="vocab">
    <xsl:call-template name="find-vocabulary-name"/>
  </xsl:variable>

  <xsl:variable name="class_name">
    <xsl:choose>
      <xsl:when test="@uom = 'days'">
        <xsl:value-of select="'TIME'"/>
      </xsl:when>
      <xsl:when test="@type = 'SHARED_STRING' or @type = 'STRING'">
        <xsl:value-of select="'STRING'"/>
      </xsl:when>
      <xsl:when test="string-length($max_length) > 0">
        <xsl:value-of select="'STRING'"/>
      </xsl:when>
      <xsl:when test="@type = 'REAL_32'">
        <xsl:value-of select="'FLOAT'"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'INT'"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="format_node" select="$format_nodes/classes/class[@name = $class_name]"/>

  <!-- Create a custom tailored class node for this attribute -->
  <xsl:variable name="tailored_node">
    <class>

      <xsl:attribute name="name"><xsl:value-of select="$format_node/@name"/></xsl:attribute>
      <xsl:attribute name="sql_type"><xsl:value-of select="$format_node/@sql_type"/></xsl:attribute>
      <xsl:attribute name="sql_length"><xsl:value-of select="$format_node/@sql_length"/></xsl:attribute>
      <xsl:attribute name="c_type"><xsl:value-of select="$format_node/@c_type"/></xsl:attribute>
      <xsl:attribute name="c_format"><xsl:value-of select="$format_node/@c_format"/></xsl:attribute>
      <xsl:attribute name="c_length"><xsl:value-of select="$format_node/@c_length"/></xsl:attribute>
      <xsl:attribute name="cep_type"><xsl:value-of select="$format_node/@cep_type"/></xsl:attribute>
      <xsl:attribute name="cep_format"><xsl:value-of select="$format_node/@cep_format"/></xsl:attribute>
      <xsl:attribute name="cep_parameter"><xsl:value-of select="$format_node/@cep_parameter"/></xsl:attribute>

      <!-- replace any DYNAMIC length fields with a proper value -->
      <xsl:if test="$format_node/@c_length = 'DYNAMIC'">
        <xsl:attribute name="c_length"><xsl:value-of select="$max_length"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="$format_node/@sql_length = 'DYNAMIC'">
        <xsl:attribute name="sql_length"><xsl:value-of select="$max_length"/></xsl:attribute>
      </xsl:if>

    <!-- If this field has been upgraded to a string but is actually transfered
         as an integer then over-ride the JDSP types -->
    <xsl:if test="$format_node/@name = 'STRING' and not(@type = 'STRING' or @type = 'SHARED_STRING')">
      <xsl:attribute name="cep_format"><xsl:value-of select="'%d'"/></xsl:attribute>
      <xsl:attribute name="cep_type"><xsl:value-of select="'int'"/></xsl:attribute>
      <xsl:attribute name="cep_parameter"><xsl:value-of select="'int'"/></xsl:attribute>
    </xsl:if>

    <!-- Add in a vocabulary if there is one -->
    <xsl:if test="string-length($vocab) > 0">
      <xsl:attribute name="vocab"><xsl:value-of select="$vocab"/></xsl:attribute>
    </xsl:if>

    </class>
  </xsl:variable>

  <xsl:copy-of select="$tailored_node"/>

</xsl:template> <!-- attribute-node-to-format-node -->


<!--
!! TEMPLATE:     find-db-column-width
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 10 May 2007
!! DESCRIPTION:  This template expects the current path to be pointing to a
!!               common knowledge subitem (an attribute) of an object. The
!!               template determines the max length that might be associated
!!               with the attribute. If there is no associated template then
!!               the value is "". Otherwise, it will be the max length name.
!!               Max lengths may be a variable of the attribute or a variable
!!               of the attirbute's type (enumeration or typedef). All places
!!               must be checked.
-->
<xsl:template name="find-db-column-width">

  <xsl:choose>
    <xsl:when test="not(string-length(@db-column-width) = 0)">
      <xsl:value-of select="@db-column-width"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="type" select="@type"/>
      <xsl:variable name="enum_count" select="count($enumerated_nodes[name()=$type])"/>
      <xsl:choose>
        <xsl:when test="@uom = 'days'">
          <xsl:value-of select="'MAX_AAR_DB_TIME_LENGTH'"/>
        </xsl:when>
        <xsl:when test="$enum_count != 0">
          <xsl:value-of select="$enumerated_nodes[name()=$type]/@db-column-width"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$typedef_nodes[name() = $type]/@db-column-width"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- find-db-column-width -->


<!--
!! TEMPLATE:     find-vocabulary-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 29 September 2006
!! DESCRIPTION:  This template expects the current path to be pointing to a
!!               common knowledge subitem (an attribute) of an AAR object. The
!!               template determines the vocabulary that might be associated
!!               with the attrbute. If there is no associated template then
!!               the value is "". Otherwise, it will be the vocabulary name.
!!               Vocabularies may be a variable of the attribute or may be
!!               a variable of the attirbutes type. Both places must be checked.
-->
<xsl:template name="find-vocabulary-name">

  <xsl:choose>
    <xsl:when test="not(string-length(@vocab) = 0)">
      <xsl:value-of select="@vocab"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="type" select="@type"/>
      <xsl:for-each select="/JTLS-Data-System-Protocol/enumerations/*[name()=$type]">
        <xsl:if test="not(string-length(@vocab) = 0)">
          <xsl:value-of select="@vocab"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:otherwise>
  </xsl:choose>

</xsl:template> <!-- find-vocabulary-name -->


<!--
!! TEMPLATE:     get-macro-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 31 July 2006
!! DESCRIPTION:  This template gets the macro name used with the AAR object.
!!               It expects the full object name and removes any "AAR_" prefix.
-->
<xsl:template name="get-macro-name">
  <xsl:param name="base_name"/>

  <xsl:choose>
    <xsl:when test="contains($base_name, 'AAR_')">
      <xsl:value-of select="substring-after($base_name, 'AAR_')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$base_name"/>
    </xsl:otherwise>
  </xsl:choose>
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
!! TEMPLATE:     get-object-enum-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 02 December 2011
!! DESCRIPTION:  This template gets the base name used within the AAR_OBJECT_ENUM
!!               enumeration list. This consists of the object name in upper
!!               case minus any "AAR_" prefix and "_EVENT" suffix. So table
!!               names AAR_UNIT and AAR_UNIT_EVENT will both translate to UNIT
!!               (we make an exception for AAR_DETECTION_EVENT).
-->
<xsl:template name="get-object-enum-name">
   <xsl:param name="base_name"/>
   <xsl:variable name="macro_name">
      <xsl:call-template name="get-macro-name">
         <xsl:with-param name="base_name" select="$base_name"/>
      </xsl:call-template>
   </xsl:variable>
  <xsl:choose>
    <xsl:when test="contains($macro_name, 'DETECTION_EVENT')">
      <xsl:value-of select="$macro_name"/>
    </xsl:when>
    <xsl:when test="contains($macro_name, '_EVENT')">
      <xsl:value-of select="substring-before($macro_name, '_EVENT')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$macro_name"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template> <!-- get-object-enum-name -->


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
!! TEMPLATE:     get-global-name-us
!! PROGRAMMER:   Jose M. Torres
!! DATE CREATED: 3 August 2006
!! DESCRIPTION:  This template gets the global variable name used for the object
!!               or attribute and keeps the underscore. An example is an object of
!!               AIR_MISSION which has a global name of Air_Mission.
-->
<xsl:template name="get-global-name-us">
  <xsl:param name="base_name"/>

  <xsl:choose>
    <xsl:when test="contains($base_name, '_')">
      <xsl:variable name="first" select="substring-before($base_name, '_')"/>
      <xsl:variable name="first_letter" select="substring($first, 1, 1)"/>
      <xsl:variable name="f_other_letters" select="substring($first, 2)"/>
      <xsl:variable name="f_rest" select="translate($f_other_letters, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
      <xsl:variable name="next" select="substring-after($base_name, '_')"/>

      <xsl:variable name="final">
        <xsl:call-template name="get-global-name-us">
          <xsl:with-param name="base_name" select="$next"/>
        </xsl:call-template>
      </xsl:variable>

      <xsl:value-of select="concat($first_letter,$f_rest,'_',$final)"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="f_letter" select="substring($base_name, 1, 1)"/>
      <xsl:variable name="f_o_letters" select="substring($base_name, 2)"/>
      <xsl:variable name="f_r" select="translate($f_o_letters, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
      <xsl:value-of select="concat($f_letter, $f_r)"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template> <!-- get-global-name-us -->


<!--
!! TEMPLATE:     get-file-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 09 August 2006
!! DESCRIPTION:  This template gets the file name used for the object
!!               or attribute. An example is an object of AAR_AIR_MISSION which
!!               has a file name of aarAirMission.
-->
<xsl:template name="get-file-name">
   <xsl:param name="base_name"/>
   <xsl:variable name="lower_name">
      <xsl:call-template name="to-lower">
         <xsl:with-param name="base_name" select="$base_name"/>
      </xsl:call-template>
   </xsl:variable>
   <xsl:variable name="file_name">
      <xsl:call-template name="remove-underscores">
         <xsl:with-param name="base_name" select="$lower_name"/>
      </xsl:call-template>
   </xsl:variable>
   <xsl:value-of select="$file_name"/>
</xsl:template> <!-- get-file-name -->


<!--
!! TEMPLATE:     get-acronym-name
!! PROGRAMMER:   Rick Kalinyak
!! DATE CREATED: 04 January 2007
!! DESCRIPTION:  This template gets the acronym name used for the object or
!!               attribute. An example is an object of AAR_AIR_MISSION_EVENT
!!               which has an acronym name of AME (for Air Mission Event).
-->
<xsl:template name="get-acronym-name">
   <xsl:param name="base_name"/>

   <xsl:variable name="macro_name">
      <xsl:call-template name="get-macro-name">
         <xsl:with-param name="base_name" select="$base_name"/>
      </xsl:call-template>
   </xsl:variable>

   <xsl:variable name="first" select="substring($macro_name, 1, 1)"/>

   <xsl:variable name="result">
      <xsl:if test="contains($macro_name, '_')">
         <xsl:call-template name="get-acronym-name">
            <xsl:with-param name="base_name" select="substring-after($macro_name, '_')"/>
         </xsl:call-template>
      </xsl:if>
   </xsl:variable>

   <xsl:value-of select="concat($first, $result)"/>

</xsl:template> <!-- get-acronym-name -->


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
