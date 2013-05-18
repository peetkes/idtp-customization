<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    version="2.0">


    <xsl:include href="custom-toc-attrs.xsl"/>
    
    <xsl:include href="custom-title-attrs.xsl"/>
    
    <xsl:include href="custom-index-attrs.xsl"/>
    
    <!-- basic settings -->

    <!--The side column width is the amount the body text is indented relative to the margin. -->
    <xsl:variable name="side-col-width">0mm</xsl:variable>
    
    <!-- mirrored pages TRUE -->
    <xsl:variable name="mirror-page-margins" select="true()"/>
    
    <xsl:variable name="line-height" select="$default-line-height"/>
    
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

    <xsl:template name="standard-outdent-block">
        <xsl:attribute name="margin-left">-6mm</xsl:attribute>
    </xsl:template>
    <xsl:template name="double-outdent-block">
        <xsl:attribute name="margin-left">-12mm</xsl:attribute>
    </xsl:template>

    <!-- paragraph-like blocks -->
    <xsl:attribute-set name="common.block">
        <xsl:attribute name="space-before">4pt</xsl:attribute>
        <xsl:attribute name="space-after">4pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:template name="common.block">
        <xsl:attribute name="space-before">4pt</xsl:attribute>
        <xsl:attribute name="space-after">4pt</xsl:attribute>
    </xsl:template>
    
    <xsl:attribute-set name="section" use-attribute-sets="base-font">
        <xsl:attribute name="line-height"><xsl:value-of select="$default-line-height"/></xsl:attribute>
        <xsl:attribute name="space-before">0pt</xsl:attribute>
    </xsl:attribute-set>
    
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
        <xsl:attribute name="font-size">10pt</xsl:attribute>
    </xsl:attribute-set>
        
    <!-- font -->
   <xsl:attribute-set name="__fo__root">   
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
       <xsl:attribute name="line-height">1.2</xsl:attribute>
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
    <xsl:variable name="faqIcon">vraagteken_250.png</xsl:variable>
    
    <!-- front matter -->
    <xsl:attribute-set name="__frontmatter">
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__frontmatter__title" use-attribute-sets="common.title">
        <xsl:attribute name="space-before">40mm</xsl:attribute>
        <xsl:attribute name="space-before.conditionality">retain</xsl:attribute>
        <xsl:attribute name="font-size">40pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="line-height">140%</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__frontmatter__mainbooktitle"  use-attribute-sets="common.title">
        <xsl:attribute name="font-size">40pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__frontmatter__subtitle" use-attribute-sets="common.title">
        <xsl:attribute name="font-size">24pt</xsl:attribute>
    </xsl:attribute-set>
 
    <xsl:attribute-set name="__frontmatter__owner" use-attribute-sets="common.title">
        <xsl:attribute name="space-before">18mm</xsl:attribute>
        <xsl:attribute name="font-size">11pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="line-height">normal</xsl:attribute>
    </xsl:attribute-set>
 
    <xsl:attribute-set name="__frontmatter__logocaption">
        <xsl:attribute name="font-stretch">ultra-condensed</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="font-size">18pt</xsl:attribute>
        <xsl:attribute name="font-family">Sans</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- TOC -->
    <xsl:attribute-set name="__toc__indent__index">
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/> + <xsl:value-of select="$toc.text-indent"/></xsl:attribute>
        <xsl:attribute name="space-before">10pt</xsl:attribute>
        <xsl:attribute name="space-after">10pt</xsl:attribute>
        <xsl:attribute name="start-indent">
            <xsl:variable name="level" select="1"/>
            <xsl:value-of select="concat($side-col-width, ' + (', string($level - 1), ' * ', $toc.toc-indent, ') + ', $toc.text-indent)"/>
        </xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__topic__content__index" use-attribute-sets="__toc__topic__content">
        <xsl:attribute name="font-family">Univers</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="__toc__link">
        <xsl:attribute name="line-height">100%</xsl:attribute>
        <!--xsl:attribute name="font-size">
            <xsl:variable name="level" select="count(ancestor-or-self::*[contains(@class, ' topic/topic ')])"/>
            <xsl:value-of select="concat(string(20 - number($level) - 4), 'pt')"/>
        </xsl:attribute-->
    </xsl:attribute-set>
    
    <!-- indents -->
    <xsl:template name="p.AVpNormalIndent">
        <xsl:attribute name="margin-left"><xsl:value-of select="$standard-indent"/></xsl:attribute>
    </xsl:template>
    
    <xsl:template name="p.AVpNormalDoubleIndent">
        <xsl:attribute name="margin-left"><xsl:value-of select="$double-indent"/></xsl:attribute>
    </xsl:template>
    
    <xsl:attribute-set name="p.AVpRefCondition">
        <xsl:attribute name="space-before">2pt</xsl:attribute>
        <xsl:attribute name="space-after">2pt</xsl:attribute>
    </xsl:attribute-set>
    
    <!--inlines-->
    <xsl:attribute-set name="menucascade-separator">
        <xsl:attribute name="font-style">normal</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:template name="ph.AVcModule">
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:template>
    <xsl:template name="ph.AVcCode">
        <xsl:attribute name="font-family">Monospaced</xsl:attribute>
    </xsl:template>  
    <xsl:template name="ph.AVcKey">
    </xsl:template>  
    <xsl:template name="ph.AVcCommand">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:template>  
    
    <xsl:template name="ph.AVpListBullet">
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
    </xsl:template>  
    
    <xsl:template name="ph.AVpListBulletIndent">
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
        <xsl:attribute name="margin-left"><xsl:value-of select="$standard-indent"/></xsl:attribute>
    </xsl:template>  
    
    <xsl:template name="ph.AVpAttention">
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
    </xsl:template>  
    
    <xsl:template name="ph.AVpExample">
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
    </xsl:template>  

    <xsl:template name="ph.AVpNB">
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
    </xsl:template>  

    <!--<xsl:attribute-set name="uicontrol">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="line-height">100%</xsl:attribute>
    </xsl:attribute-set>-->
    
    <!--<xsl:attribute-set name="wintitle">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>-->
    
    <xsl:template name="wintitle.AVcKey">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
    </xsl:template>
    <xsl:template name="wintitle.AVcField">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:template>
    <xsl:template name="wintitle.AVcScreen">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:template>

    <xsl:template name="uicontrol.AVcKey">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
    </xsl:template>
    <xsl:template name="uicontrol.AVcField">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:template>
    <xsl:template name="uicontrol.AVcScreen">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:template>
    
    <xsl:template name="i.AVcEmphasis">
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:template>
    
    <xsl:template name="xref.AVcSeeAlso">
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:template>
    <xsl:template name="xref.AVcCommand">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
    </xsl:template>
    <xsl:attribute-set name="common.link">
        <xsl:attribute name="color">black</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="link__shortdesc" use-attribute-sets="base-font">
        <xsl:attribute name="margin-left">0pt</xsl:attribute>
        <xsl:attribute name="space-after">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="codeph" use-attribute-sets="base-font">
        <xsl:attribute name="font-family">Monospaced</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="pre" use-attribute-sets="base-font common.block">
        <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
        <xsl:attribute name="white-space-collapse">true</xsl:attribute>
        <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
        <xsl:attribute name="wrap-option">no-wrap</xsl:attribute>
        <xsl:attribute name="font-family">monospace</xsl:attribute>
        <xsl:attribute name="line-height">100%</xsl:attribute>
        <xsl:attribute name="space-before">1pt</xsl:attribute>
        <xsl:attribute name="space-after">1pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="codeblock" use-attribute-sets="common.block">
        <xsl:attribute name="font-family">Monospaced</xsl:attribute>
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
        <xsl:attribute name="start-indent"><xsl:value-of select="$standard-indent"/></xsl:attribute>
        <xsl:attribute name="end-indent">0pt</xsl:attribute>
        <xsl:attribute name="padding">0pt</xsl:attribute>
        <xsl:attribute name="background-color">white</xsl:attribute>
        <xsl:attribute name="space-before">1pt</xsl:attribute>
        <xsl:attribute name="space-after">1pt</xsl:attribute>
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
    <xsl:attribute-set name="ul" use-attribute-sets="common.block">
        <xsl:attribute name="provisional-distance-between-starts"><xsl:value-of select="$standard-indent"/></xsl:attribute>
        <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li">
        <!-- changed -->
        <xsl:attribute name="space-after">0pt</xsl:attribute>
        <xsl:attribute name="space-before">0pt</xsl:attribute>
        <!-- added -->
        <xsl:attribute name="keep-with-previous.within-page">auto</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li__label">
        <xsl:attribute name="end-indent">label-end()</xsl:attribute>
        <!-- changed -->
        <xsl:attribute name="keep-together.within-line">auto</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-line">auto</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li__label__content">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="text-align">start</xsl:attribute>
    </xsl:attribute-set>
        
    <xsl:attribute-set name="ul.li__body">
        <!--<xsl:attribute name="start-indent"><xsl:value-of select="$standard-indent"/></xsl:attribute>-->
        <xsl:attribute name="start-indent">body-start()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol" use-attribute-sets="common.block">
        <xsl:attribute name="provisional-distance-between-starts"><xsl:value-of select="$standard-indent"/></xsl:attribute>
        <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.li">
        <!-- changed -->
        <xsl:attribute name="space-after">0pt</xsl:attribute>
        <xsl:attribute name="space-before">0pt</xsl:attribute>
        <!-- added -->
        <xsl:attribute name="keep-with-previous.within-page">auto</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.li__label__content">
        <xsl:attribute name="text-align">start</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.li__body">
        <xsl:attribute name="start-indent"><xsl:value-of select="$standard-indent"/></xsl:attribute>
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
    
    <xsl:attribute-set name="custom.table.body.entry">
        <xsl:attribute name="padding-left">3pt</xsl:attribute>
        <xsl:attribute name="padding-right">3pt</xsl:attribute>
        <xsl:attribute name="padding-top">1pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="custom.table.head.entry">
        <xsl:attribute name="padding-left">3pt</xsl:attribute>
        <xsl:attribute name="padding-right">3pt</xsl:attribute>
        <xsl:attribute name="padding-top">2pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="thead.row.entry" use-attribute-sets="custom.table.head.entry">
        <!--head cell-->
        <xsl:attribute name="background-color"><xsl:value-of select="$grey10"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="thead.row.entry__content" use-attribute-sets="AVpTableHeading">
        <!--head cell contents-->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="tbody.row.entry" use-attribute-sets="custom.table.body.entry">
        <!--body cell-->
        <xsl:attribute name="background-color"><xsl:value-of select="$grey05"/></xsl:attribute>
        <xsl:attribute name="border"><xsl:value-of select="$standard-border"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="tbody.row.entry__content" use-attribute-sets="AVpTableText">
        <!--body cell contents-->
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
    
    <xsl:attribute-set name="AVpTableHeading">
        <xsl:attribute name="font-family">Univers</xsl:attribute>
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="space-before">0pt</xsl:attribute>
        <xsl:attribute name="space-after">0pt</xsl:attribute>
        <xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="AVpTableText">
        <xsl:attribute name="font-family">serif</xsl:attribute>
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="space-before">1pt</xsl:attribute>
        <xsl:attribute name="space-before.conditionality">retain</xsl:attribute>
        <xsl:attribute name="space-after">1pt</xsl:attribute>
        <xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
    </xsl:attribute-set>
    
    <!-- FAQ -->
    <xsl:attribute-set name="faq.icon">
        <xsl:attribute name="content-height">2em</xsl:attribute>
        <xsl:attribute name="content-width">2em</xsl:attribute>
    </xsl:attribute-set>
    
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
        <xsl:attribute name="space-before">2pt</xsl:attribute>
        <xsl:attribute name="space-after">2pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
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
    <xsl:attribute-set name="note.icon">
        <xsl:attribute name="content-height">2em</xsl:attribute>
        <xsl:attribute name="content-width">2em</xsl:attribute>
    </xsl:attribute-set>

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
        <xsl:attribute name="padding-right">0pt</xsl:attribute>
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
    <xsl:attribute-set name="related-links">
        <xsl:attribute name="keep-with-previous">always</xsl:attribute>
        <xsl:attribute name="space-after">10pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="related-links__content">
        <xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="link.AVpSeeAlso" use-attribute-sets="link__content.AVpSeeAlso"/>
    
    <xsl:attribute-set name="link__content.AVpSeeAlso">
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="font-style">normal</xsl:attribute>
    </xsl:attribute-set>
    
</xsl:stylesheet>
