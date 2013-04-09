<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- index -->
    <xsl:attribute-set name="__index__label">
        <xsl:attribute name="space-before">20pt</xsl:attribute>
        <xsl:attribute name="space-after">20pt</xsl:attribute>
        <xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
        <xsl:attribute name="font-size">20pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="span">all</xsl:attribute>
        <!-- added -->
        <xsl:attribute name="font-family">Univers</xsl:attribute>
        <xsl:attribute name="border-bottom">solid black 1.5pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__index__letter-group">
        <xsl:attribute name="font-family">Univers</xsl:attribute>
        <xsl:attribute name="font-size">13pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <!-- changed -->
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="space-after">2pt</xsl:attribute>
        <!-- added -->
        <xsl:attribute name="space-before">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- space before index letter group -->
    <xsl:attribute-set name="index.entry">
        <!--<xsl:attribute name="space-after">2pt</xsl:attribute>
        <xsl:attribute name="font-size">9pt</xsl:attribute>-->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="index.term">
        <xsl:attribute name="font-size">8pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="index.entry__content">
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <!-- changed -->
        <!--<xsl:attribute name="start-indent">3.5mm</xsl:attribute>-->
        <!-- added -->
        <!--<xsl:attribute name="text-indent">3.5mm</xsl:attribute>-->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__index__page__link">
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="page-number-treatment">link</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="index-indents">
        <xsl:attribute name="end-indent">5pt</xsl:attribute>
        <!--<xsl:attribute name="font-size">8pt</xsl:attribute>-->
        <!-- changed -->
        <xsl:attribute name="start-indent">3.5mm</xsl:attribute>
        <xsl:attribute name="text-indent">-3.5mm</xsl:attribute>
        <xsl:attribute name="last-line-end-indent">3.5mm</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="index-indent-indents">
        <!--<xsl:attribute name="font-size">8pt</xsl:attribute>-->
        <!-- changed -->
        <xsl:attribute name="start-indent">7mm</xsl:attribute>
        <xsl:attribute name="text-indent">-3.5mm</xsl:attribute>
        <xsl:attribute name="last-line-end-indent">7mm</xsl:attribute>
    </xsl:attribute-set>
    
</xsl:stylesheet>