<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:math="http://exslt.org/math"
                exclude-result-prefixes="math">

<!-- Should read these from scenario.ter_def and assign. -->
<xsl:variable name="EARTH-SEMI-MAJOR-AXIS" select="6378135.0"/>
<xsl:variable name="EARTH-SEMI-MINOR-AXIS" select="6356750.1"/>

<!-- UTM constants -->
<xsl:variable name="locEccentricitySquared"
select="($EARTH-SEMI-MAJOR-AXIS * $EARTH-SEMI-MAJOR-AXIS - $EARTH-SEMI-MINOR-AXIS * $EARTH-SEMI-MINOR-AXIS) div ($EARTH-SEMI-MAJOR-AXIS * $EARTH-SEMI-MAJOR-AXIS)"/>

<xsl:variable name="locEccentricity"
select="math:sqrt($locEccentricitySquared)"/>

<xsl:variable name="locEccentricityFourth"
select="$locEccentricitySquared * $locEccentricitySquared"/>

<xsl:variable name="locEccentricitySixth"
select="$locEccentricityFourth * $locEccentricitySquared"/>

<xsl:variable name="loc2ndEccentricitySquared"
select="$locEccentricitySquared div (1.0 - $locEccentricitySquared)"/>

<xsl:variable name="loc2ndEccentricityFourth"
select="$loc2ndEccentricitySquared * $loc2ndEccentricitySquared"/>

<xsl:variable name="loc2ndEccentricity"
select="math:sqrt($loc2ndEccentricitySquared)"/>

<xsl:variable name="locMadAfactor"
select="1.0 + 3.0 * $locEccentricitySquared div 4.0 + 45.0 * $locEccentricityFourth div 64.0 + 175.0 * $locEccentricitySixth div 256.0"/>

<xsl:variable name="locMadBfactor"
select="3.0 * $locEccentricitySquared div 4.0 + 15.0 * $locEccentricityFourth div 16.0 + 525.0 * $locEccentricitySixth div 512.0"/>

<xsl:variable name="locMadCfactor"
select="15.0 * $locEccentricityFourth div 64.0 + 105.0 * $locEccentricitySixth div 256.0"/>

<!-- more constants -->
<xsl:variable name="ALMOST-80-SOUTH"
select="79.999999999"/>
<xsl:variable name="ALMOST-180-WEST"
select="179.999999999"/>
<xsl:variable name="ALMOST-ZERO"
select="0.000001"/>
<xsl:variable name="TEN-TO-THE-MINUS-FOUR"
select="0.0001"/>
<xsl:variable name="TEN-TO-THE-FOURTH"
select="10000.0"/>
<xsl:variable name="TEN-TO-THE-TWELFTH"
select="1000000000000.0"/>
<xsl:variable name="TEN-TO-THE-SIXTEENTH"
select="10000000000000000.0"/>
<xsl:variable name="TEN-TO-THE-TWENTIETH"
select="100000000000000000000.0"/>
<xsl:variable name="TEN-TO-THE-TWENTY-FOURTH"
select="1000000000000000000000000.0"/>
<xsl:variable name="SECONDS-PER-DEGREE"
select="3600.0"/>
<xsl:variable name="RADIANS-PER-SECOND"
select="0.0000048481368110954"/>
<xsl:variable name="RADIANS-PER-SECOND-SQUARED"
select="$RADIANS-PER-SECOND * $RADIANS-PER-SECOND"/>
<xsl:variable name="RADIANS-PER-SECOND-CUBED"
select="$RADIANS-PER-SECOND * $RADIANS-PER-SECOND-SQUARED"/>
<xsl:variable name="RADIANS-PER-SECOND-TO-THE-FOURTH"
select="$RADIANS-PER-SECOND * $RADIANS-PER-SECOND-CUBED"/>
<xsl:variable name="RADIANS-PER-SECOND-TO-THE-FIFTH"
select="$RADIANS-PER-SECOND * $RADIANS-PER-SECOND-TO-THE-FOURTH"/>
<xsl:variable name="RADIANS-PER-SECOND-TO-THE-SIXTH"
select="$RADIANS-PER-SECOND * $RADIANS-PER-SECOND-TO-THE-FIFTH"/>
<xsl:variable name="UTM-CONVERSION-SCALE-FACTOR"
select="0.9996"/>

<!-- The following are used in UTM to Lat/Lon -->
<!--
<xsl:variable name="xn-factor"
select="($EARTH-SEMI-MAJOR-AXIS - $EARTH-SEMI-MINOR-AXIS) div ($EARTH-SEMI-MAJOR-AXIS + $EARTH-SEMI-MINOR-AXIS)"/>

<xsl:variable name="xn-sq"
select="$xn-factor * $xn-factor"/>

<xsl:variable name="xn-cu"
select="$xn-sq * $xn-factor"/>

<xsl:variable name="xn-fourth"
select="$xn-cu * $xn-factor"/>

<xsl:variable name="xn-fifth"
select="$xn-fourth * $xn-factor"/>

<xsl:variable name="locationApFactor"
select="$EARTH-SEMI-MAJOR-AXIS * (1.0 - $xn-factor + 1.25 * ($xn-sq - $xn-cu) + 1.265625 * ($xn-fourth - $xn-fifth))"/>

<xsl:variable name="locationBpFactor"
select="1.5 * $EARTH-SEMI-MAJOR-AXIS * ($xn-factor - $xn-sq + 0.875 * ($xn-cu - $xn-fourth) + 0.859375 * $xn-fifth)"/>

<xsl:variable name="locationCpFactor"
select="0.9375 * $EARTH-SEMI-MAJOR-AXIS * ($xn-sq - $xn-cu + 0.75 * ($xn-fourth - $xn-fifth))"/>

<xsl:variable name="locationDpFactor"
select="0.729166666 * $EARTH-SEMI-MAJOR-AXIS * ($xn-cu - $xn-fourth + 0.6875 * $xn-fifth)"/>
-->

<!-- UTM conversion template
     Takes decimal latitude and longitude.
     translated from locationToUtm by Reenah Kang
     programmer: Humberto Yeverino
-->
<xsl:template name="location-to-UTM">
  <xsl:param name="dec-lat"/>
  <xsl:param name="dec-long"/>
  <!-- Check for a valid grid -->
  <xsl:choose>
    <xsl:when test="$dec-lat &gt; 84.0 or $dec-lat &lt; -80.0">
      <xsl:text>No.Valid.Grid</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="adj-lat">
        <xsl:choose>
          <xsl:when test="$dec-lat = 0.0">
            <xsl:value-of select="$ALMOST-ZERO"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$dec-lat"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="major-zone"
        select="floor(($dec-long + $ALMOST-180-WEST) div 6.0) + 1"/>
      <xsl:variable name="zone-alpha-index">
        <xsl:variable name="t-alpha-index"
          select="floor(($adj-lat + $ALMOST-80-SOUTH) div 8.0) + 1"/>
        <xsl:choose>
          <xsl:when test="$t-alpha-index &gt; 20">
            <xsl:text>20</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$t-alpha-index"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="lat-sec"
        select="$adj-lat * $SECONDS-PER-DEGREE"/>
      <xsl:variable name="lon-sec"
        select="$dec-long * $SECONDS-PER-DEGREE"/>
      <xsl:variable name="lat-rad"
        select="$lat-sec * $RADIANS-PER-SECOND"/>
      <xsl:variable name="cent-meridian-deg"
        select="($major-zone - 31) * 6 + 3"/>
      <xsl:variable name="meridian-sec"
        select="$cent-meridian-deg * $SECONDS-PER-DEGREE"/>
      <xsl:variable name="lon-diff-sec"
        select="$lon-sec - $meridian-sec"/>
      <xsl:variable name="p-factor"
        select="$lon-diff-sec * $TEN-TO-THE-MINUS-FOUR"/>
      <xsl:variable name="p-factor-sq"
        select="$p-factor * $p-factor"/>
      <xsl:variable name="p-factor-cu"
        select="$p-factor * $p-factor-sq"/>
      <xsl:variable name="p-factor-fourth"
        select="$p-factor * $p-factor-cu"/>
      <xsl:variable name="p-factor-fifth"
        select="$p-factor * $p-factor-fourth"/>
      <xsl:variable name="p-factor-sixth"
        select="$p-factor * $p-factor-fifth"/>
      <!-- Trig computations -->
      <xsl:variable name="sin-lat-rad"
        select="math:sin($lat-rad)"/>
      <xsl:variable name="sin-lat-rad-sq"
        select="$sin-lat-rad * $sin-lat-rad"/>
      <xsl:variable name="cos-lat-rad"
        select="math:cos($lat-rad)"/>
      <xsl:variable name="cos-lat-rad-sq"
        select="$cos-lat-rad * $cos-lat-rad"/>
      <xsl:variable name="cos-lat-rad-cu"
        select="$cos-lat-rad * $cos-lat-rad-sq"/>
      <xsl:variable name="cos-lat-rad-fourth"
        select="$cos-lat-rad * $cos-lat-rad-cu"/>
      <xsl:variable name="cos-lat-rad-fifth"
        select="$cos-lat-rad * $cos-lat-rad-fourth"/>
      <xsl:variable name="tan-lat-rad"
        select="$sin-lat-rad div $cos-lat-rad"/>
      <xsl:variable name="tan-lat-rad-sq"
        select="$tan-lat-rad * $tan-lat-rad"/>
      <xsl:variable name="tan-lat-rad-fourth"
        select="$tan-lat-rad-sq * $tan-lat-rad-sq"/>
        <xsl:variable name="tan-lat-rad-fifth"
        select="$tan-lat-rad * $tan-lat-rad-fourth"/>
      
      <!-- Coefficient I -->
      <xsl:variable name="meridian-arc-distance">
        <xsl:variable name="temp-one"
          select="$EARTH-SEMI-MAJOR-AXIS * (1.0 - $locEccentricitySquared)"/>
        <xsl:variable name="temp-two"
          select="$locMadAfactor * $lat-rad - 0.5 * $locMadBfactor * math:sin(2.0 * $lat-rad)"/>
        <xsl:variable name="temp-three"
          select="0.25 * $locMadCfactor * math:sin(4.0 * $lat-rad)"/>
        <xsl:value-of select="$temp-one * ($temp-two + $temp-three)"/>
      </xsl:variable>
      <xsl:variable name="coeff-i"
        select="$UTM-CONVERSION-SCALE-FACTOR * $meridian-arc-distance"/>
      
      <!-- Coefficient II -->
      <xsl:variable name="transverse-roc"
        select="$EARTH-SEMI-MAJOR-AXIS div math:sqrt(1.0 - $locEccentricitySquared * $sin-lat-rad-sq)"/>
      <xsl:variable name="coeff-ii">
        <xsl:variable name="temp-one"
          select="0.5 * $transverse-roc * $sin-lat-rad * $cos-lat-rad * $RADIANS-PER-SECOND-SQUARED"/>
        <xsl:value-of
          select="$temp-one * $UTM-CONVERSION-SCALE-FACTOR * $TEN-TO-THE-FOURTH * $TEN-TO-THE-FOURTH"/>
      </xsl:variable>
      
      <!-- Coefficient III -->
      <xsl:variable name="coeff-iii">
        <xsl:variable name="temp-one"
          select="(1.0 div 24.0) * $RADIANS-PER-SECOND-TO-THE-FOURTH * $sin-lat-rad * $cos-lat-rad-cu"/>
        <xsl:variable name="temp-two"
          select="5.0 - $tan-lat-rad * $tan-lat-rad + (9.0 * $loc2ndEccentricitySquared * $cos-lat-rad-sq)"/>
        <xsl:variable name="temp-three"
          select="$temp-two + (4.0 * $loc2ndEccentricityFourth * $cos-lat-rad-sq * $cos-lat-rad-sq)"/>
        <xsl:value-of
          select="$temp-one * $temp-three * $UTM-CONVERSION-SCALE-FACTOR * $TEN-TO-THE-SIXTEENTH"/>
      </xsl:variable>
      
      <!-- Coefficient IV -->
      <xsl:variable name="coeff-iv"
        select="$transverse-roc * $cos-lat-rad * $RADIANS-PER-SECOND * $UTM-CONVERSION-SCALE-FACTOR * $TEN-TO-THE-FOURTH"/>
      
      <!-- Coefficient V -->
      <xsl:variable name="coeff-v">
        <xsl:variable name="temp-one"
          select="1.0 div 6.0 * $RADIANS-PER-SECOND-CUBED * $cos-lat-rad-cu * $UTM-CONVERSION-SCALE-FACTOR"/>
        <xsl:value-of
          select="$temp-one * $TEN-TO-THE-TWELFTH * (1.0 - $tan-lat-rad-sq + $loc2ndEccentricitySquared * $cos-lat-rad-sq)"/>
      </xsl:variable>
      
      <!-- A Bar -->
      <xsl:variable name="a-bar">
        <xsl:variable name="temp1"
          select="1.0 div 720.0 * $p-factor-sixth * $RADIANS-PER-SECOND-TO-THE-SIXTH * $transverse-roc"/>
        <xsl:variable name="temp2"
          select="$sin-lat-rad * $cos-lat-rad-fifth * $UTM-CONVERSION-SCALE-FACTOR * $TEN-TO-THE-TWENTY-FOURTH"/> 
        <xsl:variable name="temp3"
          select="61.0 - 58.0 * $tan-lat-rad-sq + $tan-lat-rad-fifth"/> 
        <xsl:variable name="temp4"
          select="270.0 * $loc2ndEccentricitySquared * $cos-lat-rad-sq"/>
        <xsl:variable name="temp5"
          select="330.0 * $loc2ndEccentricitySquared * $sin-lat-rad-sq"/>
        <xsl:value-of
          select="$temp1 * $temp2 * ($temp3 + $temp4 - $temp5)"/>
      </xsl:variable>
      
      <!-- B Bar -->
      <xsl:variable name="b-bar">
        <xsl:variable name="temp1"
          select="1.0 div 120.0 * $p-factor-fifth * $RADIANS-PER-SECOND-TO-THE-FIFTH * $transverse-roc"/>
        <xsl:variable name="temp2"
          select="$cos-lat-rad-fifth * $UTM-CONVERSION-SCALE-FACTOR * $TEN-TO-THE-TWENTIETH"/> 
        <xsl:variable name="temp3"
          select="5.0 - 18.0 * $tan-lat-rad-sq + $tan-lat-rad-fourth"/> 
        <xsl:variable name="temp4"
          select="14.0 * $loc2ndEccentricitySquared * $cos-lat-rad-sq"/>
        <xsl:variable name="temp5"
          select="58.0 * $loc2ndEccentricitySquared * $sin-lat-rad-sq"/>
        <xsl:value-of
          select="$temp1 * $temp2 * ($temp3 + $temp4 - $temp5)"/>
      </xsl:variable>
      
      <xsl:variable name="grid-northing"
        select="$coeff-i + $coeff-ii * $p-factor-sq + $coeff-iii * $p-factor-fourth + $a-bar"/>
      <xsl:variable name="northing-in-meters">
        <xsl:choose>
          <xsl:when test="$adj-lat &lt; 0.0">
            <xsl:value-of select="$grid-northing + 10000000.0"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$grid-northing"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="grid-easting"
        select="$coeff-iv * $p-factor + $coeff-v * $p-factor-cu + $b-bar"/>
      <xsl:variable name="easting-in-meters"
        select="$grid-easting + 500000.0"/>
      <xsl:variable name="zone-alpha"
        select="substring('CDEFGHJKLMNPQRSTUVWX',$zone-alpha-index,1)"/>
      <xsl:variable name="easting-index"
        select="floor($easting-in-meters * 0.00001)"/>
      <xsl:variable name="easting-entry"
        select="$easting-index + 8 * (($major-zone + 2) mod 3)"/>
      <xsl:variable name="east-100k-grid-square"
        select="substring('ABCDEFGHJKLMNPQRSTUVWXYZ',$easting-entry,1)"/>
      <xsl:variable name="easting-in-grid-square"
        select="$easting-in-meters - (100000.0 * $easting-index)"/>
      <xsl:variable name="four-digit-easting">
        <xsl:variable name="temp"
          select="floor($easting-in-grid-square div 10.0)"/>
        <xsl:choose>
          <xsl:when test="$temp &gt; 9999">
            <xsl:text>9999</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$temp"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="meters-north-of-restart">
        <xsl:variable name="temp" select="$northing-in-meters mod 2000000"/>
        <xsl:choose>
          <xsl:when test="$temp = 0">
            <xsl:text>2000000</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$temp"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="northing-index"
        select="floor($meters-north-of-restart * 0.00001) + 1"/>
      <xsl:variable name="north-100k-grid-square">
        <xsl:choose>
          <xsl:when test="$major-zone div 2.0 = floor($major-zone div 2.0)">
            <xsl:value-of select="substring('FGHJKLMNPQRSTUVABCDE',$northing-index,1)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="substring('ABCDEFGHJKLMNPQRSTUV',$northing-index,1)"/>
          </xsl:otherwise>
       </xsl:choose>
      </xsl:variable>
      <xsl:variable name="northing-in-grid-square"
        select="$meters-north-of-restart - (($northing-index - 1) * 100000.0)"/>
      <xsl:variable name="four-digit-northing">
        <xsl:variable name="temp" select="floor($northing-in-grid-square div 10.0)"/>
        <xsl:choose>
          <xsl:when test="$temp &gt; 9999">
            <xsl:text>9999</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$temp"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <!-- Finally print the UTM location -->
      <xsl:value-of
        select="concat($major-zone,$zone-alpha,$east-100k-grid-square,$north-100k-grid-square)"/>
      <xsl:value-of
        select="concat($four-digit-easting,$four-digit-northing)"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
