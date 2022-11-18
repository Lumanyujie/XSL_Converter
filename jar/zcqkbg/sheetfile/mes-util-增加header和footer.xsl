<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:jtls="http://xml.apache.org/xalan/java/com.rolands.xms.XmsMessageFunctions">
	<!--
!! This Stylesheet contains utility templates for formatting data. When the
!! Message Definition File (MDF) is processed into individual message
!! stylsheets, those styelsheets make calls to the templates contained within
!! this file. Each function that may appear in the MDF has a matching template
!! here. These templates are named after the MDF function with "_FUNC"
!! appended (for example the LOCATION function has a matching LOCATION_FUNC
!! template in this file). In addition, templates exist for character case
!! conversions (which are specified in the MDF file), vocabulary translations,
!! and formatting capability (%-3.3s in the MDF). The argument list for these
!! templates matches the argument list for the MDF functions and the MDF
!! documentation should be consulted for details.
!!
!! It should be noted that the mes-util.xsl stylesheet specifies MDF function
!! arguments as parameter names arg1, arg2, arg3, ... etc within the
!! equivalent stylesheet. Therefore, all stylesheets that are designed to
!! match a MDF function should follow this parameter naming scheme.
!!
!! The implementation of this set of templates allows for flexibility
!! in the kind of XSL transformer required to view a message.
!!
!! This version implements the utility templates using the Xalan XSL
!! transformer and is designed to be used with the JTLS Java libraries. The
!! Java libraries are responsible for providing the following stylesheet
!! extensions:
!!    jtls:classification()
!!    jtls:clock(string($arg1))
!!    jtls:duration(string($arg1),string($arg2))
!!    jtls:getVocabValue(string($vocab),number($arg1),number($arg2))
!!    jtls:gtime(string($arg1),string($arg2))
!!    jtls:location(number($arg1),number($arg2),string($arg3))
!!    jtls:number(string($arg1),string($arg2),string($arg3))
!!    jtls:number_stream(string($stream-name),number($first-value),number($max-value),string($int-format))
!!    jtls:replace(string($arg1),string($arg2),string($arg3),string($arg4),string($arg5),string($arg6),string($arg7),string($arg8),string($arg9))
!!    jtls:scenario()
!!    jtls:slpScAmt(number($arg1),number($arg2),number($arg3))
!!    jtls:slpScUom(number($arg1),number($arg2))
!!    jtls:stripAfter(string($arg1),string($arg2))
!!    jtls:subcatName(number($arg1),number($arg2))
!!    jtls:uom(string($arg1))
!!    jtls:uomAmt(string($arg1),number($arg2))
!!    jtls:variable(string($arg1))
!!    jtls:wrap(string($arg1),string($arg2),number($arg3))
!!    jtls:formatStringLeft(string($str),number($width),number($trim))
!!    jtls:formatStringRight(string($str),number($width),number($trim))
!!    jtls:formatIntegerLeft(string($arg1),number($width),number($precision),number($sign))
!!    jtls:formatIntegerRight(string($arg1),number($width),number($precision),number($sign))
!!    jtls:formatFloatLeft(string($arg1),number($width),number($precision),number($sign))
!!    jtls:formatFloatRight(string($arg1),number($width),number($precision),number($sign))
-->
	<!-- The newline character. -->
	<xsl:variable name="cr">
		<xsl:text>
</xsl:text>
	</xsl:variable>
	<!-- Create default values for optional format values on some of the MDF
     functions (for example the LOCATION function always has arguments for
     latitude and longitude and may have an argument for format. In the
     absence of the format argument use LOCATION_FORMAT_DEF). -->
	<xsl:variable name="LOCATION_FORMAT_DEF">
		<xsl:text>%-2.2D-%-2.2M-%04.1FS%N %-3.3d-%-2.2m-%04.1Fs%E</xsl:text>
	</xsl:variable>
	<xsl:variable name="DURATION_FORMAT_DEF">
		<xsl:text>%-2.2dD %-2.2hH %-2.2mM</xsl:text>
	</xsl:variable>
	<xsl:variable name="GTIME_FORMAT_DEF">
		<xsl:text>%d%H%MZ%b%y</xsl:text>
	</xsl:variable>
	<xsl:variable name="CLOCK_FORMAT_DEF">
		<xsl:text>%d%H%MZ%b%y</xsl:text>
	</xsl:variable>
	<!--
!! TEMPLATE:    SCENARIO_FUN
!! DESCRIPTION: This is the template to handle the MDF SCENARIO() function.
!!              It returns the name of the scenario.
-->
	<xsl:template name="SCENARIO_FUN">
		<xsl:value-of select="jtls:scenario()"/>
	</xsl:template>
	<!--
!! TEMPLATE:    CLASSIFICATION_FUN
!! DESCRIPTION: This is the template to handle the MDF CLASSIFICATION()
!!              function. It returns the classification of the scenario.
-->
	<xsl:template name="CLASSIFICATION_FUN">
		<xsl:value-of select="jtls:classification()"/>
	</xsl:template>
	<!--
!! TEMPLATE:    VARIABLE_FUN
!! DESCRIPTION: This is the template to handle the MDF VARIABLE() function. It
!!              returns the value of the specified variable.
!! PARAMETERS:
!!   arg1       Literal variable name being requested. 
-->
	<xsl:template name="VARIABLE_FUN">
		<xsl:param name="arg1"/>
		<xsl:value-of select="jtls:variable(string($arg1))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    DURATION_FUN
!! DESCRIPTION: This is the template to handle the MDF DURATION() function.
!!              It converts a duration in decimal days into a text string.
!! PARAMETERS:
!!   arg1       Decimal number of days
!!   arg2       Optional duration format
-->
	<xsl:template name="DURATION_FUN">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2" select="$DURATION_FORMAT_DEF"/>
		<xsl:value-of select="jtls:duration(string($arg1),string($arg2))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    LOCATION_FUN
!! DESCRIPTION: This is the template to handle the MDF LOCATION() function.
!!              It converts a decimal latitude and decimal longitude into a
!!              text string.
!! PARAMETERS:
!!   arg1       Decimal latitude
!!   arg2       Decimal longitude
!!   arg3       Optional output format string
-->
	<xsl:template name="LOCATION_FUN">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2"/>
		<xsl:param name="arg3" select="$LOCATION_FORMAT_DEF"/>
		<xsl:value-of select="jtls:location(number($arg1),number($arg2),string($arg3))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    SLP_SC_UOM_FUN
!! DESCRIPTION: This is the template to handle the MDF SLP_SC_UOM() function.
!!              It converts an SLP and Supply Category index to the user-
!!              specified Unit Of Measure (UOM) used for supplies.
!! PARAMETERS:
!!    arg1      Integer index of the SLP
!!    arg2      Integer index of the Supply Category
-->
	<xsl:template name="SLP_SC_UOM_FUN">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2"/>
		<xsl:value-of select="jtls:slpScUom(number($arg1),number($arg2))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    SLP_SC_AMT_FUN
!! DESCRIPTION: This is the template to handle the MDF SLP_SC_AMT() function.
!!              It converts an SLP index, Supply Category index, and supply
!!              amount in the default scenario UOM into a supply amount in
!!              the user spicified UOM for the SLP and Supply Category.
!! PARAMETERS:
!!   arg1       Integer index of the SLP
!!   arg2       Integer index of the Supply Category
!!   arg3       Decimal amount of supplies in the scenario's base UOM
-->
	<xsl:template name="SLP_SC_AMT_FUN">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2"/>
		<xsl:param name="arg3"/>
		<xsl:value-of select="jtls:slpScAmt(number($arg1),number($arg2),number($arg3))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    UOM_FUN
!! DESCRIPTION: This is the template to handle the MDF UOM() function. It
!!              returns the user-specified UOM for a specified measurement
!!              type, such as SPPED or DISTANCE.
!! PARAMETERS:
!!   arg1       Literal string that specifies the type of MEASUREMENT (e.g SPEED)
-->
	<xsl:template name="UOM_FUN">
		<xsl:param name="arg1"/>
		<xsl:value-of select="jtls:uom(string($arg1))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    UOM_AMT_FUN
!! DESCRIPTION: This is the template to handle the MDF UOM_AMT() function. It
!!              coverts an amount of a specified measurement (such as SPEED)
!!              into the user-specified UOM amount.
!! PARAMETERS:
!!   arg1       Literal string that specifies the type of measurement (e.g. SPEED)
!!   arg2       Decimal amount in the scenario's baseline UOM
-->
	<xsl:template name="UOM_AMT_FUN">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2"/>
		<xsl:value-of select="jtls:uomAmt(string($arg1),number($arg2))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    REPLACE_FUN
!! DESCRIPTION: This is the template to handle the MDF REPLACE() function. It
!!              replaces within arg1 occurences of arg2 with arg3, occurences
!!              of arg4 with arg5, etc. It output the converted string.
!! PARAMETERS:
!!   arg1       The base string which is to be converted
!!   arg2       A string within arg1 that is to be replaced
!!   arg3       A string with which to replace arg2 within arg1
!!   arg4       Optional additional string within arg1 that is to be replaced
!!   arg5       Optional string with which to replace arg4 within arg1
!!   arg6       Optional additional string within arg1 that is to be replaced
!!   arg7       Optional string with which to replace arg6 within arg1
!!   arg8       Optional additional string within arg1 that is to be replaced
!!   arg9       Optional string with which to replace arg8 within arg1
-->
	<xsl:template name="REPLACE_FUN">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2"/>
		<xsl:param name="arg3" select="' '"/>
		<xsl:param name="arg4" select="' '"/>
		<xsl:param name="arg5" select="''"/>
		<xsl:param name="arg6" select="''"/>
		<xsl:param name="arg7" select="''"/>
		<xsl:param name="arg8" select="''"/>
		<xsl:param name="arg9" select="''"/>
		<xsl:value-of select="jtls:replace(string($arg1),string($arg2),string($arg3),string($arg4),string($arg5),string($arg6),string($arg7),string($arg8),string($arg9))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    STRIP_AFTER_FUN
!! DESCRIPTION: This is the template to handle the MDF STRIP_AFTER() function.
!!              Truncates a string after the first occurence of another string.
!! PARAMETERS:
!!   arg1       String which is to be truncated
!!   arg2       String that may appear in arg1 after which arg1 should be
!!              trunacted
-->
	<xsl:template name="STRIP_AFTER_FUN">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2"/>
		<xsl:value-of select="jtls:stripAfter(string($arg1),string($arg2))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    WRAP_FUN
!! DESCRIPTION: This is the template to handle the MDF WRAP() function. Its
!!              purpose is to hold the number of characters/line to a specified
!!              number. arg2 will be inserted after each inserted carriage
!!              return. The template will attempt to break the string at
!!              words.
!!              
!! PARAMETERS:
!!   arg1       String that is to be broken into multiple lines
!!   arg2       String to start each new line with
!!   arg3       Number of characters from arg1/line (does not include characters
!!              from arg2)
-->
	<xsl:template name="WRAP_FUN">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2"/>
		<xsl:param name="arg3"/>
		<xsl:value-of select="jtls:wrap(string($arg1),string($arg2),number($arg3))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    GTIME_FUN
!! DESCRIPTION: This is the template to handle the MDF GTIME() function. The
!!              function converts decimal days since game start into a time
!!              string.
!! PARAMETERS:
!!   arg1       Decimal days since game start
!!   arg2       Optional output format string
-->
	<xsl:template name="GTIME_FUN">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2" select="$GTIME_FORMAT_DEF"/>
		<xsl:value-of select="jtls:gtime(string($arg1),string($arg2))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    CLOCK_FUN
!! DESCRIPTION: This is the template to handle the MDF CLOCK() function. It
!!              provides the current time from the system clock.
!! PARAMETERS:
!!   arg1       Optional output format string
-->
	<xsl:template name="CLOCK_FUN">
		<xsl:param name="arg1" select="$CLOCK_FORMAT_DEF"/>
		<xsl:value-of select="jtls:clock(string($arg1))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    NUMBER_FUN
!! DESCRIPTION: This is the template to handle the MDF NUMBER() function.
!!              This template is designed to return a number from a specified
!!              number stream.
!! PARAMETERS:
!!   arg1       String name of a stream
!!   arg2       String NEW or CURRENT to represent that a NEW number should
!!              be returned or the CURRENT number returned.
!!   arg3       C format string of how the output should be foratted
-->
	<xsl:template name="NUMBER_FUN">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2"/>
		<xsl:param name="arg3"/>
		<xsl:value-of select="jtls:number(string($arg1),string($arg2),string($arg3))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    NUMBER_STREAM_FUN
!! DESCRIPTION: This is the template to handle the MDF .NUMBER_STREAM modifier.
!!              This modifier defines a data stream to use when a unique number is
!!              requested.
!! PARAMETERS:
!!   stream-name Name for the stream
!!   first-value Optional initial value of the stream
!!   max-value   Maximum value for the stream
!!   int-format  Optional default output format for stream integers
-->
	<xsl:template name="NUMBER_STREAM_FUN">
		<xsl:param name="stream-name" select="default"/>
		<xsl:param name="first-value" select="1"/>
		<xsl:param name="max-value" select="2147483647"/>
		<xsl:param name="int-format" select="'%d'"/>
		<xsl:value-of select="jtls:number_stream(string($stream-name),number($first-value),number($max-value),string($int-format))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    SUBCAT_NAME_FUN
!! DESCRIPTION: This is the template to handle the MDF SUBCAT_NAME{} capability.
!!              At this level it is treated just link any other MDF function.
!!              This template returns the name for the associated target
!!              category and subcategory.
!! PARAMETERS:
!!   tg-index   The category index of the target
!!   cat-index  The subcategory index of the target
-->
	<xsl:template name="SUBCAT_NAME_FUN">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2"/>
		<xsl:value-of select="jtls:subcatName(number($arg1),number($arg2))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    UPPER_FUN
!! DESCRIPTION: Converts a string to uppercase. This is invoked within the
!!              MDF file by specifying the .CHARACTER_CASE(UPPER|LOWER)
!!              modifier.
!! PARAMETERS:
!!   arg1       The string to be converted to uppercase
-->
	<xsl:template name="UPPER_FUN">
		<xsl:param name="arg1"/>
		<xsl:value-of select="translate($arg1,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
	</xsl:template>
	<!--
!! TEMPLATE:    LOWER_FUN
!! DESCRIPTION: Converts a string to lowercase. This is invoked within the
!!              MDF file by specifying the .CHARACTER_CASE(UPPER|LOWER)
!!              modifier.
!! PARAMETERS:
!!   arg1       The string to be converted to lowercase
-->
	<xsl:template name="LOWER_FUN">
		<xsl:param name="arg1"/>
		<xsl:value-of select="translate($arg1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/>
	</xsl:template>
	<!--
!! TEMPLATE:    get-vocab-value
!! DESCRIPTION: Retrieve a vocabulary item (static or dynamic). All vocabulary
!!              references within the MDF files are translated into calls to
!!              this function.
!! PARAMETERS:
!!   vocab      The vocabulary group name
!!   arg1       The first index to be translated
!!   arg2       The second index within a group to be translated. This is only
!!              used by two dimensional translation such as CSP CS Names.
-->
	<xsl:template name="get-vocab-value">
		<xsl:param name="vocab"/>
		<xsl:param name="arg1"/>
		<xsl:param name="arg2" select="3.14"/>
		<xsl:value-of select="jtls:getVocabValue(string($vocab),number($arg1),number($arg2))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    format-string-right
!! DESCRIPTION: This template trims the string to a specified size and then
!!              left pads it so it is the specified width. Either or both of a
!!              trim and width variable must be provided. This template is
!!              designed to mimic the C string format of %17.15s where width=17
!!              and trim=15.
!! PARAMETERS:
!!   str        String to be right justified
!!   width      The maximum width of the resultant output
!!   trim       The maximum width of the input string to show
-->
	<xsl:template name="format-string-right">
		<xsl:param name="str"/>
		<xsl:param name="width" select="0"/>
		<xsl:param name="trim" select="0"/>
		<xsl:value-of select="jtls:formatStringRight(string($str),number($width),number($trim))"/>
	</xsl:template>
	<!-- 
!! TEMPLATE:    format-string-left
!! DESCRIPTION: This template trims the string to a specified size and then
!!              right pads it so it is the specified width. Either or both of a
!!              trim and width variable must be provided. This template is
!!              designed to mimic the C string format of %-17.15s where width=17
!!              and trim=15.
!! PARAMETERS:
!!   str        String to be right justified
!!   width      The maximum width of the resultant output
!!   trim       The maximum width of the input string to show
-->
	<xsl:template name="format-string-left">
		<xsl:param name="str"/>
		<xsl:param name="width" select="0"/>
		<xsl:param name="trim" select="0"/>
		<xsl:value-of select="jtls:formatStringLeft(string($str),number($width),number($trim))"/>
	</xsl:template>
	<xsl:template name="set-table-status">
		<xsl:param name="status"/>
		<xsl:value-of select="jtls:setTableStatus(string($status))"/>
	</xsl:template>
	<xsl:template name="get-table-status">
		<xsl:value-of select="jtls:getTableStatus()"/>
	</xsl:template>
	<xsl:template name="get-caption">
		<xsl:value-of select="jtls:getCaption()"/>
	</xsl:template>
	<xsl:template name="set-table-header">
		<xsl:param name="head"/>
		<xsl:value-of select="jtls:setTableHeader(string($head))"/>
	</xsl:template>
	<xsl:template name="set-caption">
		<xsl:param name="caption"/>
		<xsl:value-of select="jtls:setCaption(string($caption))"/>
	</xsl:template>
	<xsl:template name="get-table-header">
		<xsl:value-of select="jtls:getTableHeader()"/>
	</xsl:template>
	<xsl:template name="unit_name_transform_FUN">
		<xsl:param name="arg1"/>
		<xsl:value-of select="jtls:transUnitName('Unit_Name', string($arg1))"/>
	</xsl:template>
	<xsl:template name="trans_word_FUN">
		<xsl:param name="arg1"/>
		<xsl:param name="arg2"/>
		<xsl:value-of select="jtls:transWord(string($arg1), string($arg2))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    format-integer-right
!! DESCRIPTION: This template is meant to mimic the C formatting of an
!!              integer It mimics %+07.6d as %<sign>0<width>.<precision>
!!              where the presence of a <sign> value of "yes" will cause
!!              the sign to be displayed even for positive integers, <width>
!!              is a minimum field width, and <precision> is the minimum
!!              number of digits (padded w/leading zeros if needed) to print.
!! PARAMETERS:
!!   str        Integer value as a string
!!   sign       yes|no should the sign always be displayed
!!   width      minimum width of the field. This is optional, and if absent
!!              the size of the integer string (with possible +/-) will be
!!              used.
!!   precision  minimum number of digits to display. If zero no left padding
!!              of the result with the "0" character occurs
-->
	<xsl:template name="format-integer-right">
		<xsl:param name="str"/>
		<xsl:param name="sign" select="'no'"/>
		<xsl:param name="width" select="0"/>
		<xsl:param name="precision" select="0"/>
		<xsl:variable name="sign_int">
			<xsl:choose>
				<xsl:when test="$sign = 'yes'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="jtls:formatIntegerRight(string($str), number($width), number($precision), number($sign_int))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    format-integer-left
!! DESCRIPTION: This template is meant to mimic the C formatting of an
!!              integer It mimics %-+07.6d as %<sign>0<width>.<precision>
!!              where the presence of a <sign> value of "yes" will cause
!!              the sign to be displayed even for positive integers, <width>
!!              is a minimum field width, and <precision> is the minimum
!!              number of digits (padded w/leading zeros if needed) to print.
!! PARAMETERS:
!!   str        Integer value as a string
!!   sign       yes|no should the sign always be displayed
!!   width      minimum width of the field. This is optional, and if absent
!!              the size of the integer string (with possible +/-) will be
!!              used.
!!   precision  minimum number of digits to display. If zero no left padding
!!              of the result with the "0" character occurs
-->
	<xsl:template name="format-integer-left">
		<xsl:param name="str"/>
		<xsl:param name="sign" select="'no'"/>
		<xsl:param name="width" select="0"/>
		<xsl:param name="precision" select="0"/>
		<xsl:variable name="sign_int">
			<xsl:choose>
				<xsl:when test="$sign = 'yes'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="jtls:formatIntegerLeft(string($str), number($width), number($precision), number($sign_int))"/>
	</xsl:template>
	<!--
!! TEMPLATE:    format-float-right
!! DESCRIPTION: This template is meant to mimic the C formatting of a
!!              float. It mimics %+7.6f as %<sign><width>.<precision>.
!!              See the format-float-value template for additional details.
!! PARAMETERS:
!!   str        float value as a string
!!   sign       yes|no should the sign always be displayed
!!   width      minimum width of the field. This is optional, and if absent
!!              the size of the float string (with possible +/-) will be
!!              used.
!!   precision  number of digits to display after the decimal point
-->
	<xsl:template name="format-float-right">
		<xsl:param name="str"/>
		<xsl:param name="sign" select="'no'"/>
		<xsl:param name="width" select="'0'"/>
		<xsl:param name="precision" select="'0'"/>
		<xsl:variable name="sign_int">
			<xsl:choose>
				<xsl:when test="$sign = 'yes'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="jtls:formatFloatRight(string($str), number($width), number($precision), number($sign_int))"/>
	</xsl:template>
	<!-- format-float-right -->
	<!--
!! TEMPLATE:    format-float-left
!! DESCRIPTION: This template is meant to mimic the C formatting of a
!!              float. It mimics %-+7.6f as %-<sign><width>.<precision>.
!!              See the format-float-value template for additional details.
!! PARAMETER:
!!   str        float value as a string
!!   sign       yes|no should the sign always be displayed
!!   width      minimum width of the field. This is optional, and if absent
!!              the size of the float string (with possible +/-) will be
!!              used.
!!   precision  number of digits to display after the decimal point
-->
	<xsl:template name="format-float-left">
		<xsl:param name="str"/>
		<xsl:param name="sign" select="'no'"/>
		<xsl:param name="width" select="'0'"/>
		<xsl:param name="precision" select="'0'"/>
		<xsl:variable name="sign_int">
			<xsl:choose>
				<xsl:when test="$sign = 'yes'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:value-of select="jtls:formatFloatLeft(string($str), number($width), number($precision), number($sign_int))"/>
	</xsl:template>
	<!-- format-float-left -->
	<!--
!! TEMPLATE:    format-string
!! DESCRIPTION: RICK - I DO NOT THINK THIS TEMPLATE IS EVER CALLED
!! PARAMETERS:
!!   str        
!!   width      
!!   trim       
!!   align      
-->
	<xsl:template name="format-string">
		<xsl:param name="str"/>
		<xsl:param name="width"/>
		<xsl:param name="trim" select="$width"/>
		<xsl:param name="align" select="'left'"/>
		<xsl:variable name="trimed" select="substring($str,1,$trim)"/>
		<xsl:variable name="spaces" select="'                              '"/>
		<xsl:variable name="pad" select="substring($spaces,1,$width - string-length($trimed))"/>
		<xsl:if test="$align = 'right'">
			<xsl:value-of select="$pad"/>
		</xsl:if>
		<xsl:value-of select="$trimed"/>
		<xsl:if test="$align = 'left'">
			<xsl:value-of select="$pad"/>
		</xsl:if>
	</xsl:template>
	
	<!-- 新增翻译函数 -->	
	<xsl:template name="get-play-code">
		<xsl:value-of select="jtls:getPlaycode()"/>
	</xsl:template>
	<xsl:template name="get-sec-leave">
		<xsl:value-of select="jtls:getSecL()"/>
	</xsl:template>
	<xsl:template name="get-exercise-title">
		<xsl:value-of select="jtls:getExerciseTitle()"/>
	</xsl:template>
	
	<!-- 新增的翻译头尾的函数-->
	<xsl:template name="render-header">
		<xsl:text>&lt;div class='headDiv'&gt;</xsl:text>
		<xsl:call-template name="GTIME_FUN">
			<xsl:with-param name="arg1">
				<xsl:value-of select="/M/D/@A"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:text>&lt;/div&gt;</xsl:text>
		<xsl:text>&lt;div class='task'&gt;</xsl:text>
		<xsl:text>演习课题：</xsl:text>
		<xsl:call-template name="get-exercise-title"/>
		<xsl:text>&lt;/div&gt;</xsl:text>
		<xsl:text>&lt;div class='playcode'&gt;</xsl:text>
		<xsl:text>代 号：</xsl:text>
		<xsl:call-template name="get-play-code"/>
		<xsl:text>&lt;/div&gt;</xsl:text>
		<xsl:text>&lt;div class='secl'&gt;</xsl:text>
		<xsl:text>密 级：</xsl:text>
		<xsl:call-template name="get-sec-leave"/>
		<xsl:text>&lt;/div&gt;</xsl:text>
	</xsl:template>
	<xsl:template name="render-footer">
		<xsl:value-of select="$NL"/>
		<xsl:text>       </xsl:text>
		<xsl:value-of select="$NL"/>
	</xsl:template>
</xsl:stylesheet>
