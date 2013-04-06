<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- index -->
    <xsl:attribute-set name="__index__letter-group">
        <xsl:attribute name="font-family">Univers</xsl:attribute>
        <xsl:attribute name="font-size">13pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">auto</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="index.term">
        <xsl:attribute name="font-size">8pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="index.entry__content">
        <xsl:attribute name="start-indent"><xsl:value-of select="$standard-indent"/></xsl:attribute>
        <xsl:attribute name="font-size">8pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__index__page__link">
        <xsl:attribute name="font-style">normal</xsl:attribute>
        <xsl:attribute name="page-number-treatment">link</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="index-indents">
        <xsl:attribute name="end-indent">5pt</xsl:attribute>
        <xsl:attribute name="last-line-end-indent">0pt</xsl:attribute>
        <xsl:attribute name="start-indent">0pt</xsl:attribute>
        <xsl:attribute name="text-indent">0pt</xsl:attribute>
        <xsl:attribute name="font-size">8pt</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>