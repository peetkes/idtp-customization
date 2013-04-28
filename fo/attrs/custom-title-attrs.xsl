<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- topic titles-->
    <!-- titles are by default rendered based on the level of the title (DITA-style)
    but in fo/xsl/custom the mapping to outputclass is configured also-->
    
    <!-- Heading 1 chapter title -->
    <xsl:attribute-set name="__chapter__frontmatter__name__container">
        <!-- contains the chapter number -->
        <xsl:attribute name="font-family">Univers</xsl:attribute>
        <xsl:attribute name="font-size">20pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="border-top-style">none</xsl:attribute>
        <xsl:attribute name="border-top-width">0pt</xsl:attribute>
        <xsl:attribute name="border-bottom-style">none</xsl:attribute>
        <xsl:attribute name="border-bottom-width">0pt</xsl:attribute>
        <xsl:attribute name="padding-top">10pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__chapter__frontmatter__number__container">
        <xsl:attribute name="font-size">20pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.title" use-attribute-sets="common.title">
        <xsl:attribute name="border-bottom">1.5pt solid black</xsl:attribute>
        <xsl:attribute name="space-before">2pt</xsl:attribute>
        <xsl:attribute name="space-after">20pt</xsl:attribute>
        <xsl:attribute name="font-size">20pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="padding-top">1.4pc</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="margin-left"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:template name="topic.title">
        <xsl:call-template name="common.title"/>
        <xsl:attribute name="font-size">20pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="padding-top">1.4pc</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="margin-left"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="keep-with-next">always</xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
        <!-- changed -->
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="border-bottom">solid black 1.5pt</xsl:attribute>
        <!-- added -->
        <xsl:attribute name="space-before">2pt</xsl:attribute>
        <xsl:attribute name="space-after">20pt</xsl:attribute>
    </xsl:template>

    <xsl:template name="topic.title__content">
        <xsl:attribute name="line-height">100%</xsl:attribute>
        <xsl:attribute name="border-left-width">0pt</xsl:attribute>
        <xsl:attribute name="border-right-width">0pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:template>
    
    <!-- heading 2 -->
    <xsl:template name="topic.topic.title">
        <xsl:call-template name="common.title"/>
        <xsl:attribute name="space-before">8pt</xsl:attribute>
        <xsl:attribute name="space-after">2pt</xsl:attribute>
        <xsl:attribute name="font-size">16pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="padding-top">8pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <!-- changed -->
        <xsl:attribute name="border-bottom">solid 1pt black</xsl:attribute>
    </xsl:template>
    
    <xsl:template name="topic.topic.title__content">
        <xsl:attribute name="border-left-width">0pt</xsl:attribute>
        <xsl:attribute name="border-right-width">0pt</xsl:attribute>
    </xsl:template>
    
    <!-- heading 3 -->
    <xsl:template name="topic.topic.topic.title">
        <xsl:call-template name="common.title"/>
        <xsl:attribute name="space-before">6pt</xsl:attribute>
        <xsl:attribute name="space-after">0pt</xsl:attribute>
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:template>
    <xsl:template name="topic.topic.topic.title__content"></xsl:template>
    
    <!-- heading 4 -->
    <xsl:template name="topic.topic.topic.topic.title">
        <xsl:call-template name="common.title"/>
        <xsl:attribute name="space-before">4pt</xsl:attribute>
        <xsl:attribute name="font-size">11pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <!-- added -->
        <xsl:attribute name="space-after">0pt</xsl:attribute>
    </xsl:template>
    
    <xsl:template name="topic.topic.topic.topic.title__content"></xsl:template>
    
    <!-- heading 5 -->
    <xsl:template name="topic.topic.topic.topic.topic.title">
        <xsl:call-template name="common.title"/>
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="font-size">9pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="background-color"><xsl:value-of select="$grey12"/></xsl:attribute>
        <!-- added -->
        <xsl:attribute name="padding-top">2pt</xsl:attribute>
        <xsl:attribute name="space-before">4pt</xsl:attribute>
        <xsl:attribute name="space-after">0pt</xsl:attribute>
    </xsl:template>
    <xsl:template name="topic.topic.topic.topic.topic.title__content">
    </xsl:template>
    
    <!-- heading 6 -->   
    <xsl:template name="topic.topic.topic.topic.topic.topic.title">
        <xsl:call-template name="common.title"/>
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:template>
    <xsl:template name="topic.topic.topic.topic.topic.topic.title__content">
    </xsl:template>
    
</xsl:stylesheet>