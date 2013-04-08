<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rx="http://www.renderx.com/XSL/Extensions"
    xmlns:exsl="http://exslt.org/common"
    xmlns:exslf="http://exslt.org/functions"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:comparer="com.idiominc.ws.opentopic.xsl.extension.CompareStrings"
    extension-element-prefixes="exsl"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    exclude-result-prefixes="opentopic-index exsl comparer rx opentopic-func exslf"
    version="2.0">
    
    <!-- page size -->
    <!-- The default of 215.9mm x 279.4mm is US Letter size (8.5x11in) -->
    <xsl:variable name="page-width">210.0mm</xsl:variable>
    <xsl:variable name="page-height">297.0mm</xsl:variable>
    
    <!-- page margins -->
    <xsl:variable name="page-margin-top">57mm</xsl:variable>
    <xsl:variable name="page-margin-bottom">60mm</xsl:variable>
    <xsl:variable name="page-margin-inside">25mm</xsl:variable>
    <xsl:variable name="page-margin-outside">15mm</xsl:variable>
    
    <xsl:template name="createDefaultLayoutMasters">
        <fo:layout-master-set>
            <!-- definition of blank -->
            <fo:simple-page-master master-name="blank" xsl:use-attribute-sets="simple-page-master">
                <fo:region-body region-name="region.body" display-align="center"/>
            </fo:simple-page-master>
            
            <!-- Frontmatter simple masters -->
            <fo:simple-page-master master-name="front-matter-first" xsl:use-attribute-sets="simple-page-master">
                <fo:region-body xsl:use-attribute-sets="region-body__frontmatter.odd"/>
            </fo:simple-page-master>
            <fo:simple-page-master master-name="front-matter-last" xsl:use-attribute-sets="simple-page-master">
                <fo:region-body xsl:use-attribute-sets="region-body__frontmatter.even"/>
                <fo:region-before  region-name="last-frontmatter-header" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="last-frontmatter-footer" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>
            <xsl:if test="$mirror-page-margins">
                <fo:simple-page-master master-name="front-matter-even" xsl:use-attribute-sets="simple-page-master">
                    <fo:region-body xsl:use-attribute-sets="region-body__frontmatter.even"/>
                    <fo:region-before region-name="even-frontmatter-header" xsl:use-attribute-sets="region-before"/>
                    <fo:region-after region-name="even-frontmatter-footer" xsl:use-attribute-sets="region-after"/>
                </fo:simple-page-master>
            </xsl:if>
            <fo:simple-page-master master-name="front-matter-odd" xsl:use-attribute-sets="simple-page-master">
                <fo:region-body xsl:use-attribute-sets="region-body__frontmatter.odd"/>
                <fo:region-before region-name="odd-frontmatter-header" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="odd-frontmatter-footer" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>
            <!--TOC simple masters-->
            <xsl:if test="$mirror-page-margins">
                <fo:simple-page-master master-name="toc-even" xsl:use-attribute-sets="simple-page-master">
                    <fo:region-body xsl:use-attribute-sets="region-body.even"/>
                    <fo:region-before region-name="even-toc-header" xsl:use-attribute-sets="region-before"/>
                    <fo:region-after region-name="even-toc-footer" xsl:use-attribute-sets="region-after"/>
                </fo:simple-page-master>
            </xsl:if>
            <fo:simple-page-master master-name="toc-odd" xsl:use-attribute-sets="simple-page-master">
                <fo:region-body xsl:use-attribute-sets="region-body.odd"/>
                <fo:region-before region-name="odd-toc-header" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="odd-toc-footer" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>
            <fo:simple-page-master master-name="toc-last" xsl:use-attribute-sets="simple-page-master">
                <fo:region-body xsl:use-attribute-sets="region-body.even"/>
                <fo:region-before region-name="even-toc-header" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="even-toc-footer" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>
            <fo:simple-page-master master-name="toc-first" xsl:use-attribute-sets="simple-page-master">
                <fo:region-body xsl:use-attribute-sets="region-body.odd"/>
                <fo:region-before region-name="odd-toc-header" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="odd-toc-footer" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>
            
            <!--BODY simple masters-->
            <fo:simple-page-master master-name="body-first" xsl:use-attribute-sets="simple-page-master">
                <fo:region-body xsl:use-attribute-sets="region-body.odd"/>
                <fo:region-before region-name="first-body-header" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="first-body-footer" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>
            <xsl:if test="$mirror-page-margins">
                <fo:simple-page-master master-name="body-even" xsl:use-attribute-sets="simple-page-master">
                    <fo:region-body xsl:use-attribute-sets="region-body.even"/>
                    <fo:region-before region-name="even-body-header" xsl:use-attribute-sets="region-before"/>
                    <fo:region-after region-name="even-body-footer" xsl:use-attribute-sets="region-after"/>
                </fo:simple-page-master>
            </xsl:if>
            <fo:simple-page-master master-name="body-odd" xsl:use-attribute-sets="simple-page-master">
                <fo:region-body xsl:use-attribute-sets="region-body.odd"/>
                <fo:region-before region-name="odd-body-header" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="odd-body-footer" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>
            <fo:simple-page-master master-name="body-last" xsl:use-attribute-sets="simple-page-master">
                <fo:region-body xsl:use-attribute-sets="region-body.even"/>
                <fo:region-before region-name="last-body-header" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="last-body-footer" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>
            
            <!--INDEX simple masters-->
            <fo:simple-page-master master-name="index-first" xsl:use-attribute-sets="simple-page-master">
                <fo:region-body xsl:use-attribute-sets="region-body__index.odd"/>
                <fo:region-before region-name="odd-index-header" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="odd-index-footer" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>
            <xsl:if test="$mirror-page-margins">
                <fo:simple-page-master master-name="index-even" xsl:use-attribute-sets="simple-page-master">
                    <fo:region-body xsl:use-attribute-sets="region-body__index.even"/>
                    <fo:region-before region-name="even-index-header" xsl:use-attribute-sets="region-before"/>
                    <fo:region-after region-name="even-index-footer" xsl:use-attribute-sets="region-after"/>
                </fo:simple-page-master>
            </xsl:if>
            <fo:simple-page-master master-name="index-odd" xsl:use-attribute-sets="simple-page-master">
                <fo:region-body xsl:use-attribute-sets="region-body__index.odd"/>
                <fo:region-before region-name="odd-index-header" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="odd-index-footer" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>            
            
            <!--GLOSSARY simple masters-->
            <fo:simple-page-master master-name="glossary-first" xsl:use-attribute-sets="simple-page-master">
                <fo:region-body xsl:use-attribute-sets="region-body.odd"/>
                <fo:region-before region-name="odd-glossary-header" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="odd-glossary-footer" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>
            <xsl:if test="$mirror-page-margins">
                <fo:simple-page-master master-name="glossary-even" xsl:use-attribute-sets="simple-page-master">
                    <fo:region-body xsl:use-attribute-sets="region-body.even"/>
                    <fo:region-before region-name="even-glossary-header" xsl:use-attribute-sets="region-before"/>
                    <fo:region-after region-name="even-glossary-footer" xsl:use-attribute-sets="region-after"/>
                </fo:simple-page-master>
            </xsl:if>
            <fo:simple-page-master master-name="glossary-odd" xsl:use-attribute-sets="simple-page-master">
                <fo:region-body xsl:use-attribute-sets="region-body.odd"/>
                <fo:region-before region-name="odd-glossary-header" xsl:use-attribute-sets="region-before"/>
                <fo:region-after region-name="odd-glossary-footer" xsl:use-attribute-sets="region-after"/>
            </fo:simple-page-master>
            
            <!--Sequences-->
            <xsl:call-template name="generate-page-sequence-master">
                <xsl:with-param name="master-name" select="'toc-sequence'"/>
                <xsl:with-param name="master-reference" select="'toc'"/>
            </xsl:call-template>
            <xsl:call-template name="generate-page-sequence-master">
                <xsl:with-param name="master-name" select="'body-sequence'"/>
                <xsl:with-param name="master-reference" select="'body'"/>
                <xsl:with-param name="first" select="true()"/>
            </xsl:call-template>
            <xsl:call-template name="generate-page-sequence-master">
                <xsl:with-param name="master-name" select="'ditamap-body-sequence'"/>
                <xsl:with-param name="master-reference" select="'body'"/>
                <xsl:with-param name="first" select="true()"/>
            </xsl:call-template>
            <xsl:call-template name="generate-page-sequence-master-index">
                <xsl:with-param name="master-name" select="'index-sequence'"/>
                <xsl:with-param name="master-reference" select="'index'"/>
                <xsl:with-param name="last" select="true()"/>
            </xsl:call-template>
            <xsl:call-template name="generate-page-sequence-master">
                <xsl:with-param name="master-name" select="'front-matter'"/>
                <xsl:with-param name="master-reference" select="'front-matter'"/>
                <xsl:with-param name="first" select="true()"/>
            </xsl:call-template>
            <xsl:call-template name="generate-page-sequence-master">
                <xsl:with-param name="master-name" select="'glossary-sequence'"/>
                <xsl:with-param name="master-reference" select="'glossary'"/>
                <xsl:with-param name="last" select="false()"/>
            </xsl:call-template>
        </fo:layout-master-set>
    </xsl:template>

    <!-- Generate a page sequence master -->
    <xsl:template name="generate-page-sequence-master-index">
        <xsl:param name="master-name"/>
        <xsl:param name="master-reference"/>
        <xsl:param name="first" select="true()"/>
        <xsl:param name="last" select="true()"/>
        <fo:page-sequence-master master-name="{$master-name}">
            <fo:repeatable-page-master-alternatives>
                <xsl:if test="$first">
                    <fo:conditional-page-master-reference master-reference="{$master-reference}-first"
                        odd-or-even="odd"
                        page-position="first"/>
                </xsl:if>
                <xsl:if test="$last">
                    <fo:conditional-page-master-reference master-reference="blank" blank-or-not-blank="blank"/>
                </xsl:if>
                <xsl:choose>
                    <xsl:when test="$mirror-page-margins">
                        <fo:conditional-page-master-reference master-reference="{$master-reference}-odd"
                            odd-or-even="odd"/>
                        <fo:conditional-page-master-reference master-reference="{$master-reference}-even"
                            odd-or-even="even"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <fo:conditional-page-master-reference master-reference="{$master-reference}-odd"/>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:repeatable-page-master-alternatives>
        </fo:page-sequence-master>
        
    </xsl:template>
    
    <!-- force page counts on different page sequences 
    param page-sequence-master is the "type of page" (toc, frontmatter. body, index, glossary)
    -->
    <xsl:template name="force_page_counts">
        <xsl:param name="page-sequence-master" select="'body'"/>
        <xsl:attribute name="force-page-count">
            <xsl:choose>
                <xsl:when test="$page-sequence-master = 'frontmatter'">auto</xsl:when>
                <xsl:when test="$page-sequence-master = 'toc'">end-on-even</xsl:when>
                <xsl:when test="$page-sequence-master = 'body'">end-on-even</xsl:when>
                <xsl:when test="$page-sequence-master = 'index'">end-on-even</xsl:when>
                <xsl:otherwise>end-on-even</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>
    
    
    <!-- frontmatter -->
    <xsl:template name="createFrontMatter_1.0">
        <fo:page-sequence master-reference="front-matter">
            <xsl:call-template name="force_page_counts">
                <xsl:with-param name="page-sequence-master">frontmatter</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="insertFrontMatterStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="__frontmatter">
                    <!-- set the title -->
                    <fo:block xsl:use-attribute-sets="__frontmatter__title">
                        <xsl:choose>
                            <xsl:when test="$map/*[contains(@class,' topic/title ')][1]">
                                <xsl:apply-templates select="$map/*[contains(@class,' topic/title ')][1]"/>
                            </xsl:when>
                            <xsl:when test="$map//*[contains(@class,' bookmap/mainbooktitle ')][1]">
                                <xsl:apply-templates select="$map//*[contains(@class,' bookmap/mainbooktitle ')][1]"/>
                            </xsl:when>
                            <xsl:when test="//*[contains(@class, ' map/map ')]/@title">
                                <xsl:value-of select="//*[contains(@class, ' map/map ')]/@title"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="/descendant::*[contains(@class, ' topic/topic ')][1]/*[contains(@class, ' topic/title ')]"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:block>
                    
                    <!-- logo: absoluut gepositioneerd op 220mm 125mm. 
                      -  logobestand staat in artwork-folder
                      -  tekst erboven komt uit vars.xsl "logoCaption"
                      -  font-size 7pt
                    -->
                    <fo:block-container absolute-position="fixed" top="220mm" left="125mm">
                        <fo:block margin-left="20mm" font-size="7pt" font-family="Sans">
                            <xsl:call-template name="insertVariable">
                                <xsl:with-param name="theVariableID" select="'logoCaption'"/>
                            </xsl:call-template>
                        </fo:block>
                        <fo:block>
                            <fo:external-graphic  
                                src="url({concat($artworkPrefix,'Customization/OpenTopic/common/artwork/',$frontpageLogo)})"
                                content-width="55mm"/>
                        </fo:block>
                    </fo:block-container>
                    <fo:block xsl:use-attribute-sets="__frontmatter__owner">
                        <xsl:apply-templates select="$map//*[contains(@class,' bookmap/bookmeta ')]"/>
                    </fo:block>
                    <!-- set the subtitle -->
                    <xsl:apply-templates select="$map//*[contains(@class,' bookmap/booktitlealt ')]"/>              
                </fo:block>
                <!--<xsl:call-template name="createPreface"/>-->
            </fo:flow>
        </fo:page-sequence>
        <xsl:if test="not($retain-bookmap-order)">
            <xsl:call-template name="createNotices"/>
        </xsl:if>
    </xsl:template>
    
    <!-- body first heading no running header -->
    <xsl:template name="insertBodyFirstHeader">
         <fo:static-content flow-name="first-body-header">
            <fo:block xsl:use-attribute-sets="__body__first__header">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'Body first header'"/>
                    <xsl:with-param name="theParameters">
                        <pagenum>
                            <fo:inline xsl:use-attribute-sets="__body__first__header__pagenum">
                                <fo:page-number/>
                            </fo:inline>
                        </pagenum>
                    </xsl:with-param>
                </xsl:call-template>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
    <!-- toc -->
    <xsl:template name="createToc">
        <xsl:variable name="toc">
            <xsl:choose>
                <xsl:when test="($ditaVersion &gt;= 1.1) and $map//*[contains(@class,' bookmap/toc ')][@href]"/>
                <xsl:when test="($ditaVersion &gt;= 1.1) and $map//*[contains(@class,' bookmap/toc ')]">
                    <xsl:apply-templates select="/" mode="toc"/>
                </xsl:when>
                <xsl:when test="($ditaVersion &gt;= 1.1) and /*[contains(@class,' map/map ')][not(contains(@class,' bookmap/bookmap '))]">
                    <xsl:apply-templates select="/" mode="toc"/>
                </xsl:when>
                <xsl:when test="$ditaVersion &gt;= 1.1"/>
                <xsl:otherwise>
                    <xsl:apply-templates select="/" mode="toc"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:if test="count(exsl:node-set($toc)/*) > 0">
            <fo:page-sequence master-reference="toc-sequence">
                <xsl:call-template name="force_page_counts">
                    <xsl:with-param name="page-sequence-master">toc</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="insertTocStaticContents"/>           
                <fo:flow flow-name="xsl-region-body">
                    <xsl:call-template name="createTocHeader"/>
                    <fo:block>
                        <fo:marker marker-class-name="current-header">
                            <xsl:call-template name="insertVariable">
                                <xsl:with-param name="theVariableID" select="'Table of Contents'"/>
                            </xsl:call-template>
                        </fo:marker>
                        <xsl:copy-of select="exsl:node-set($toc)"/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </xsl:if>
    </xsl:template>
    
    <!-- index -->
    <xsl:template name="createIndex">
        <xsl:if test="(//opentopic-index:index.groups//opentopic-index:index.entry) and (count($index-entries//opentopic-index:index.entry) &gt; 0)">
            <fo:page-sequence master-reference="index-sequence">
                <xsl:call-template name="force_page_counts">
                    <xsl:with-param name="page-sequence-master">index</xsl:with-param>
                </xsl:call-template>
                <xsl:call-template name="insertIndexStaticContents"/>
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates select="/" mode="index-postprocess"/>
                </fo:flow>
            </fo:page-sequence>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="/" mode="index-postprocess">
        <fo:block xsl:use-attribute-sets="__index__label" id="{$id.index}">
            <xsl:call-template name="insertVariable">
                <xsl:with-param name="theVariableID" select="'Index'"/>
            </xsl:call-template>
        </fo:block>
        
        <rx:flow-section column-count="3">
            <xsl:apply-templates select="//opentopic-index:index.groups" mode="index-postprocess"/>
        </rx:flow-section>
        
    </xsl:template>
</xsl:stylesheet>