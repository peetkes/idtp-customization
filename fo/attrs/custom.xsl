<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    version="2.0">

    <!-- basic settings -->

    <!--The side column width is the amount the body text is indented relative to the margin. -->
    <xsl:variable name="side-col-width">0mm</xsl:variable>
    
    <!-- mirrored pages TRUE -->
    <xsl:variable name="mirror-page-margins" select="true()"/>
    
    <!-- do not start all chapters on even pages
    refer also to custom-page-layouts.xsl, template name force_page_counts-->
    <xsl:attribute-set name="__force__page__count">
        <xsl:attribute name="force-page-count">
            <xsl:value-of select="'end-on-even'"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <!-- font size -->
    <xsl:variable name="default-font-size">9pt</xsl:variable>
    
    <!-- standard indent -->
    <xsl:variable name="standard-indent">6mm</xsl:variable>
    <xsl:variable name="double-indent">12mm</xsl:variable>
    
    <!-- paragraph-like blocks -->
    <xsl:attribute-set name="common.block">
        <xsl:attribute name="space-before">1pt</xsl:attribute>
        <xsl:attribute name="space-after">1pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:template name="common.block">
        <xsl:attribute name="space-before">1pt</xsl:attribute>
        <xsl:attribute name="space-after">1pt</xsl:attribute>
    </xsl:template>

    <!-- header margins -->
    <xsl:attribute-set name="odd__header">
        <xsl:attribute name="padding-top">45mm</xsl:attribute>
        <xsl:attribute name="text-align">end</xsl:attribute>
        <xsl:attribute name="end-indent">15mm</xsl:attribute>
        <xsl:attribute name="space-before">0pt</xsl:attribute>
        <xsl:attribute name="space-before.conditionality">retain</xsl:attribute>
        <xsl:attribute name="font-family">Univers</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="even__header">
        <xsl:attribute name="padding-top">45mm</xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
        <xsl:attribute name="start-indent">15mm</xsl:attribute>
        <xsl:attribute name="space-before">0pt</xsl:attribute>
        <xsl:attribute name="space-before.conditionality">retain</xsl:attribute>
        <xsl:attribute name="font-family">Univers</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="odd__footer">
        <xsl:attribute name="margin-bottom">0mm</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="even__footer">
        <xsl:attribute name="margin-bottom">0mm</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="pagenum">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- font -->
   <xsl:attribute-set name="__fo__root">   
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
   </xsl:attribute-set>
    
    <xsl:attribute-set name="base-font">
       <xsl:attribute name="font-family">serif</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="common.title">
        <xsl:attribute name="font-family">Univers</xsl:attribute>
    </xsl:attribute-set>
    <xsl:template name="common.title">
        <xsl:attribute name="font-family">Univers</xsl:attribute>
    </xsl:template>
    
    <!-- colors -->
    <xsl:variable name="grey05">#F2F2F2</xsl:variable>
    <xsl:variable name="grey10">#E5E5E5</xsl:variable>
    <xsl:variable name="grey12">#DEDEDE</xsl:variable><!-- alternative #E0E0E0 -->
    
    <!-- static images -->
    <xsl:variable name="frontpageLogo">VISMA_Master_4f.jpg</xsl:variable>
    <xsl:variable name="faqIcon">faq.png</xsl:variable>
    
    <!-- front matter -->
    <xsl:attribute-set name="__frontmatter">
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__frontmatter__title" use-attribute-sets="common.title">
        <xsl:attribute name="space-before">80mm</xsl:attribute>
        <xsl:attribute name="space-before.conditionality">retain</xsl:attribute>
        <xsl:attribute name="font-size">22pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="line-height">140%</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__frontmatter__mainbooktitle"  use-attribute-sets="common.title">
        <xsl:attribute name="font-size">40pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__frontmatter__subtitle" use-attribute-sets="common.title">
        <xsl:attribute name="font-size">24pt</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- toc -->
    <xsl:attribute-set name="__toc__header" use-attribute-sets="topic.title">
        <xsl:attribute name="space-before">0pt</xsl:attribute>
        <xsl:attribute name="space-after">16.8pt</xsl:attribute>
        <xsl:attribute name="font-size">20pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="padding-top">16.8pt</xsl:attribute>
        <xsl:attribute name="border-bottom-width">1.5pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__leader">
        <xsl:attribute name="leader-pattern">space</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__chapter__content" use-attribute-sets="__toc__topic__content">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="padding-top">20pt</xsl:attribute>
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
    </xsl:attribute-set>
    
    <xsl:variable name="toc.text-indent" select="$standard-indent"/>
    <xsl:variable name="toc.toc-indent" select="'30pt'"/>
    
    
    <!-- topic titles-->
    <!-- titles are by default rendered based on the level of the title (DITA-style)
    but iin fo/xsl/custom the mapping to outputclass is configured also-->

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
    
    <xsl:template name="topic.title">
        <xsl:call-template name="common.title"/>
        <xsl:attribute name="margin-top">2pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">20pt</xsl:attribute>
        <xsl:attribute name="font-size">20pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="padding-top">1.4pc</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">1.5pt</xsl:attribute>
        <xsl:attribute name="margin-left"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="keep-with-next">always</xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
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
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">1pt</xsl:attribute>
        <xsl:attribute name="border-bottom-color">black</xsl:attribute>
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
    
    <!-- indents -->
    <xsl:template name="p.AVpNormalIndent">
        <xsl:attribute name="margin-left"><xsl:value-of select="$standard-indent"/></xsl:attribute>
    </xsl:template>
    
    <xsl:template name="p.AVpNormalDoubleIndent">
        <xsl:attribute name="margin-left"><xsl:value-of select="$double-indent"/></xsl:attribute>
    </xsl:template>
    
    <!--inlines-->
    <xsl:template name="ph.AVcModule">
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:template>
    <xsl:template name="ph.AVcCode">
        <xsl:attribute name="font-family">Monospaced</xsl:attribute>
    </xsl:template>   
    <xsl:template name="uicontrol.AVcField">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:template>
    <xsl:template name="uicontrol.AVcScreen">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:template>
    <xsl:template name="i.AVcEmphasis">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:template>
    <xsl:template name="xref.AVcSeeAlso">
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:template>
    <xsl:template name="xref.AVcCommand">
        <xsl:attribute name="font-weigth">bold</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
    </xsl:template>
    <xsl:attribute-set name="common.link">
        <xsl:attribute name="color">black</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="codeph" use-attribute-sets="base-font">
        <xsl:attribute name="font-family">Monospaced</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="codeblock" use-attribute-sets="common.block">
        <xsl:attribute name="font-family">Monospaced</xsl:attribute>
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
        <xsl:attribute name="start-indent"><xsl:value-of select="$standard-indent"/></xsl:attribute>
        <xsl:attribute name="end-indent">0pt</xsl:attribute>
        <xsl:attribute name="padding">6pt</xsl:attribute>
        <xsl:attribute name="background-color">white</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="codeblock__top">
        <xsl:attribute name="leader-pattern">space</xsl:attribute>
        <xsl:attribute name="leader-length">100%</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="codeblock__bottom">
        <xsl:attribute name="leader-pattern">space</xsl:attribute>
        <xsl:attribute name="leader-length">100%</xsl:attribute>
    </xsl:attribute-set>
 
    <!-- lists -->
    <xsl:attribute-set name="ul.li">
        <xsl:attribute name="space-after">1.5pt</xsl:attribute>
        <xsl:attribute name="space-before">1.5pt</xsl:attribute>
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.li">
        <xsl:attribute name="space-after">1.5pt</xsl:attribute>
        <xsl:attribute name="space-before">1.5pt</xsl:attribute>
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.li__label__content">
        <xsl:attribute name="text-align">start</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.li__body">
        <xsl:attribute name="start-indent"><xsl:value-of select="$standard-indent"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li__label__content">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- figures (AVpCaptionText) -->
    <xsl:attribute-set name="fig.title" use-attribute-sets="base-font common.title">
        <xsl:attribute name="font-family">Univers</xsl:attribute>
        <xsl:attribute name="font-size">9pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="space-before">2pt</xsl:attribute>
        <xsl:attribute name="space-after">4pt</xsl:attribute>
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="image__float">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="image__block">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="image__inline">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="image">
        <!-- scale image if too large -->
        <xsl:attribute name="content-height">scale-down-to-fit</xsl:attribute>
        <xsl:attribute name="content-width">scale-down-to-fit</xsl:attribute>
    </xsl:attribute-set>
    
           
    <!-- tables (AVpCaptionText) -->
    <xsl:attribute-set name="table.title" use-attribute-sets="base-font common.title">
        <xsl:attribute name="font-family">Univers</xsl:attribute>
        <xsl:attribute name="font-size">9pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="space-before">2pt</xsl:attribute>
        <xsl:attribute name="space-after">4pt</xsl:attribute>
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- set all table frames to standard-border 0.75 white solid
        table frames do not use attribute sets common.border 
    -->
    <xsl:variable name="standard-border">0.75pt white solid</xsl:variable>
    <xsl:variable name="standard-border-width">0.75pt</xsl:variable>
    <xsl:variable name="standard-border-color">white</xsl:variable>
    <xsl:attribute-set name="standard-border-atts">
        <xsl:attribute name="border"><xsl:value-of select="$standard-border"/></xsl:attribute>
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
        <xsl:attribute name="border-top-width"><xsl:value-of select="$standard-border-width"/></xsl:attribute>
        <xsl:attribute name="border-top-color"><xsl:value-of select="$standard-border-color"/></xsl:attribute>
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width"><xsl:value-of select="$standard-border-width"/></xsl:attribute>
        <xsl:attribute name="border-bottom-color"><xsl:value-of select="$standard-border-color"/></xsl:attribute>
        <xsl:attribute name="border-right-style">solid</xsl:attribute>
        <xsl:attribute name="border-right-width"><xsl:value-of select="$standard-border-width"/></xsl:attribute>
        <xsl:attribute name="border-right-color"><xsl:value-of select="$standard-border-color"/></xsl:attribute>
        <xsl:attribute name="border-left-style">solid</xsl:attribute>
        <xsl:attribute name="border-left-width"><xsl:value-of select="$standard-border-width"/></xsl:attribute>
        <xsl:attribute name="border-left-color"><xsl:value-of select="$standard-border-color"/></xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="__tableframe__none" use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="__tableframe__top" use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="__tableframe__bottom"  use-attribute-sets="standard-border-atts">
        <xsl:attribute name="border-after-width.conditionality">retain</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="thead__tableframe__bottom"  use-attribute-sets="standard-border-atts" />
    <xsl:attribute-set name="__tableframe__left"  use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="__tableframe__right"  use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="table__tableframe__top"  use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="table__tableframe__bottom" use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="table__tableframe__right" use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="table__tableframe__left" use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="__tableframe__top" use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="__tableframe__bottom" use-attribute-sets="standard-border-atts">
        <xsl:attribute name="border-after-width.conditionality">retain</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="thead__tableframe__bottom" use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="__tableframe__left" use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="__tableframe__right" use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="table__tableframe__top" use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="table__tableframe__bottom" use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="table__tableframe__sides" use-attribute-sets="table__tableframe__right table__tableframe__left">
    </xsl:attribute-set>
    <xsl:attribute-set name="table__tableframe__right" use-attribute-sets="standard-border-atts"/>
    <xsl:attribute-set name="table__tableframe__left" use-attribute-sets="standard-border-atts"/>
    
    <xsl:attribute-set name="thead.row.entry">
        <!--head cell-->
        <xsl:attribute name="background-color"><xsl:value-of select="$grey10"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="tbody.row.entry">
        <!--body cell-->
        <xsl:attribute name="background-color"><xsl:value-of select="$grey05"/></xsl:attribute>
        <xsl:attribute name="border"><xsl:value-of select="$standard-border"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="table.row">
        <xsl:attribute name="keep-together.within-page">always</xsl:attribute>
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:template name="table.row.entry.atts">
        <xsl:attribute name="margin-left">2mm</xsl:attribute>
    </xsl:template>
    
    <xsl:template name="table.row.entry__content">
        <xsl:attribute name="margin-left">2mm</xsl:attribute>
    </xsl:template>
    
    <!-- FAQ -->
    <xsl:template name="common.note.block">
        <xsl:attribute name="space-before">2pt</xsl:attribute>
        <xsl:attribute name="space-after">2pt</xsl:attribute>
    </xsl:template>
    <xsl:attribute-set name="common.note.block">
        <xsl:attribute name="space-before">2pt</xsl:attribute>
        <xsl:attribute name="space-after">2pt</xsl:attribute>
    </xsl:attribute-set>
    

    <xsl:template name="faq.section">
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
    </xsl:template>
    
    <xsl:template name="faq_table">
        <xsl:call-template name="common.note.block"/>
    </xsl:template>
    <xsl:attribute-set name="faq__image__column" use-attribute-sets="note__image__column"/>
    <xsl:attribute-set name="faq__image__entry" use-attribute-sets="note__image__entry"/>
    <xsl:attribute-set name="faq__text__column" >
        <xsl:attribute name="column-number">2</xsl:attribute>
        <xsl:attribute name="padding-top">1pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="faq__text__entry" use-attribute-sets="note__text__entry"/>
    
    <!-- notes -->
    <xsl:attribute-set name="note" use-attribute-sets="common.note.block">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__table" use-attribute-sets="common.note.block">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__image__column">
        <xsl:attribute name="column-number">1</xsl:attribute>
        <xsl:attribute name="column-width"><xsl:value-of select="$double-indent"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__text__column">
        <xsl:attribute name="column-number">2</xsl:attribute>
    </xsl:attribute-set>  
    
    <xsl:attribute-set name="note__image__entry">
        <xsl:attribute name="padding-right">5pt</xsl:attribute>
        <xsl:attribute name="start-indent">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__text__entry">
        <xsl:attribute name="start-indent">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label">
        <xsl:attribute name="border-left-width">0pt</xsl:attribute>
        <xsl:attribute name="border-right-width">0pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label__note">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label__notice">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label__tip">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label__fastpath">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label__restriction">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label__important">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label__remember">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label__attention">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label__caution">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label__danger">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label__warning">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label__other">
    </xsl:attribute-set>
    
    <!-- quotes -->
    <xsl:attribute-set name="q">
        <!-- small caps not supported in FOP 
        <xsl:attribute name="font-variant">small-caps</xsl:attribute> -->
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="lq">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="space-before">1em</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
        <xsl:attribute name="color">red</xsl:attribute>
        <xsl:attribute name="padding-left">1em</xsl:attribute>
        <xsl:attribute name="start-indent">0pt</xsl:attribute>
        <xsl:attribute name="end-indent">0pt</xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
        <xsl:attribute name="border-style">none</xsl:attribute>
        <xsl:attribute name="border-color">none</xsl:attribute>
        <xsl:attribute name="border-width">0pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="lq_simple">
        <xsl:attribute name="border-color">none</xsl:attribute>
        <xsl:attribute name="border-style">none</xsl:attribute>
        <xsl:attribute name="border-width">0pt</xsl:attribute>
        <xsl:attribute name="end-indent">0pt</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
        <xsl:attribute name="margin-left">1em<!--<xsl:value-of select="$side-col-width"/>--></xsl:attribute>
        <xsl:attribute name="padding-left">0pt</xsl:attribute>
        <xsl:attribute name="space-after">1em</xsl:attribute>
        <xsl:attribute name="space-before">1em</xsl:attribute>
        <xsl:attribute name="start-indent">0pt</xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- related links -->
    <xsl:attribute-set name="related-links__content">
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="link.AVpSeeAlso" use-attribute-sets="link__content.AVpSeeAlso"/>
    
    <xsl:attribute-set name="link__content.AVpSeeAlso">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
    </xsl:attribute-set>
    
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