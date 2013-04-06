<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    
    <!-- toc -->
    <xsl:attribute-set name="__toc__header" use-attribute-sets="topic.title">
        <xsl:attribute name="space-before">0pt</xsl:attribute>
        <xsl:attribute name="space-after">16.8pt</xsl:attribute>
        <xsl:attribute name="font-size">20pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="padding-top">16.8pt</xsl:attribute>
        <xsl:attribute name="border-bottom">solid black 1.5pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__leader">
        <xsl:attribute name="leader-pattern">space</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__chapter__content" use-attribute-sets="__toc__topic__content">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <!-- changed -->
        <xsl:attribute name="padding-top">0pt</xsl:attribute>
        <!-- added -->
        <xsl:attribute name="space-before">6pt</xsl:attribute>
        <xsl:attribute name="space-after">2pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__topic__content">
        <xsl:attribute name="last-line-end-indent">-22pt</xsl:attribute>
        <xsl:attribute name="end-indent">22pt</xsl:attribute>
        <xsl:attribute name="text-indent">-<xsl:value-of select="$toc.text-indent"/></xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
        <xsl:attribute name="text-align-last">justify</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
                <xsl:when test="$level = 1">12pt</xsl:when>
                <xsl:otherwise><xsl:value-of select="$default-font-size"/></xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="font-weight">
            <xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
                <xsl:when test="$level = 1">bold</xsl:when>
                <xsl:otherwise>normal</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="font-family">
            <xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:choose>
                <xsl:when test="$level = 1">Univers</xsl:when>
                <xsl:otherwise>serif</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <!-- added -->
        <xsl:attribute name="space-before">1pt</xsl:attribute>
        <xsl:attribute name="space-after">1pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:variable name="toc.text-indent" select="$standard-indent"/>
    <xsl:variable name="toc.toc-indent" select="'30pt'"/>
        
</xsl:stylesheet>