<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:exsl="http://exslt.org/common"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0">
    
    <!-- chapter-first pagina -->
    <xsl:template name="processTopicChapter" >
        <xsl:variable name="id" select="@id"/>
        <xsl:comment>id = <xsl:value-of select="@id"/></xsl:comment>
        <xsl:variable name="isFrontMatter" select="if (//*[@id eq $id][1][contains(@class, ' topic/notices ')]) then true() else false()"/>
        
        <fo:page-sequence xsl:use-attribute-sets="__force__page__count">
            <xsl:attribute name="master-reference" select="if ($isFrontMatter) then 'front-matter' else 'body-sequence'"/>
            <xsl:call-template name="startPageNumbering"/>
            <xsl:call-template name="insertBodyStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:if test="not(ancestor::*[contains(@class, ' topic/topic ')])">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:number format="1"/>
                        </fo:marker>
                        <fo:marker marker-class-name="current-header">
                            <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                                <xsl:apply-templates select="." mode="getTitle"/>
                            </xsl:for-each>
                        </fo:marker>
                    </xsl:if>
                    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]"/>
                    <fo:block>
                        <xsl:call-template name="topic.title"/>
                        <xsl:call-template name="insertChapterFirstpageStaticContent">
                            <xsl:with-param name="type" select="'chapter'"/>
                        </xsl:call-template>
                        <xsl:call-template name="pullPrologIndexTerms"/>
                        <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                            <xsl:apply-templates select="." mode="getTitle"/>
                        </xsl:for-each>
                    </fo:block>
                    <xsl:choose>
                        <xsl:when test="$chapterLayout='BASIC'">
                            <xsl:apply-templates select="*[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                contains(@class, ' topic/prolog '))]"/>
                            <xsl:apply-templates select="." mode="buildRelationships"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:apply-templates select="*[contains(@class,' topic/topic ')]"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>
    
    <!-- chapter title -->
    <xsl:template name="insertChapterFirstpageStaticContent">
        <xsl:param name="type"/>
        <fo:inline>
            <xsl:attribute name="id">
                <xsl:call-template name="generate-toc-id"/>
            </xsl:attribute>
            <xsl:choose>
                <xsl:when test="$type = 'chapter'">
                    <fo:inline xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID" select="'Chapter with number'"/>
                            <xsl:with-param name="theParameters">
                                <number>
                                    <fo:inline xsl:use-attribute-sets="__chapter__frontmatter__number__container">
                                        <xsl:apply-templates select="key('map-id', @id)[1]" mode="topicTitleNumber"/>
                                    </fo:inline>
                                </number>
                            </xsl:with-param>
                        </xsl:call-template>
                    </fo:inline>
                </xsl:when>
                <xsl:when test="$type = 'appendix'">
                    <fo:inline xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID" select="'Appendix with number'"/>
                            <xsl:with-param name="theParameters">
                                <number>
                                    <fo:block xsl:use-attribute-sets="__chapter__frontmatter__number__container">
                                        <xsl:apply-templates select="key('map-id', @id)[1]" mode="topicTitleNumber"/>
                                    </fo:block>
                                </number>
                            </xsl:with-param>
                        </xsl:call-template>
                    </fo:inline>
                </xsl:when>               
                <xsl:when test="$type = 'part'">
                    <fo:inline xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID" select="'Part with number'"/>
                            <xsl:with-param name="theParameters">
                                <number>
                                    <fo:block xsl:use-attribute-sets="__chapter__frontmatter__number__container">
                                        <xsl:apply-templates select="key('map-id', @id)[1]" mode="topicTitleNumber"/>
                                    </fo:block>
                                </number>
                            </xsl:with-param>
                        </xsl:call-template>
                    </fo:inline>
                </xsl:when>
                <xsl:when test="$type = 'preface'">
                    <fo:online xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID" select="'Preface title'"/>
                        </xsl:call-template>
                    </fo:online>
                </xsl:when>
                <xsl:when test="$type = 'notices'"/>
                <xsl:when test="$type = 'notices.org'">
                    <fo:inline xsl:use-attribute-sets="__chapter__frontmatter__name__container">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID" select="'Notices title'"/>
                        </xsl:call-template>
                    </fo:inline>
                </xsl:when>
            </xsl:choose>
        </fo:inline>
    </xsl:template>
    
    
    <!-- topic titles must be dependant on @outputclass -->
    <!-- this custom template processTopicTitle does no longer use processAttrSetReflection to determine topic level for attribute set -->
    <xsl:template match="*" mode="processTopicTitle">
        <xsl:variable name="level" as="xs:integer">
            <!-- level is first based on suffix of outputclass = HeadingX, otherwise DITA-style count ancestors -->
            <xsl:choose>
                <xsl:when test="starts-with(@outputclass,'Heading')">
                    <xsl:value-of select="number(substring-after(@outputclass,'Heading'))"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="." mode="get-topic-level"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <fo:block >
            <xsl:call-template name="commonattributes"/>
            <xsl:choose>
                <xsl:when test="$level = 1"><xsl:call-template name="topic.title"/></xsl:when>
                <xsl:when test="$level = 2"><xsl:call-template name="topic.topic.title"/></xsl:when>
                <xsl:when test="$level = 3"><xsl:call-template name="topic.topic.topic.title"/></xsl:when>
                <xsl:when test="$level = 4"><xsl:call-template name="topic.topic.topic.topic.title"/> </xsl:when>
                <xsl:when test="$level = 5"><xsl:call-template name="topic.topic.topic.topic.topic.title"/></xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="topic.topic.topic.topic.topic.topic.title"></xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>
            <fo:block>
                <xsl:choose>
                    <xsl:when test="$level = 1"><xsl:call-template name="topic.title__content"/></xsl:when>
                    <xsl:when test="$level = 2"><xsl:call-template name="topic.topic.title__content"/></xsl:when>
                    <xsl:when test="$level = 3"><xsl:call-template name="topic.topic.topic.title__content"/></xsl:when>
                    <xsl:when test="$level = 4"><xsl:call-template name="topic.topic.topic.topic.title__content"/> </xsl:when>
                    <xsl:when test="$level = 5"><xsl:call-template name="topic.topic.topic.topic.topic.title__content"/></xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="topic.topic.topic.topic.topic.topic.title__content"></xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="$level = 1">
                    <fo:marker marker-class-name="current-header">
                        <xsl:apply-templates select="." mode="getTitle"/>
                    </fo:marker>
                </xsl:if>
                <xsl:if test="$level = 2">
                    <fo:marker marker-class-name="current-h2">
                        <xsl:apply-templates select="." mode="getTitle"/>
                    </fo:marker>
                </xsl:if>
                <fo:inline id="{parent::node()/@id}"/>
                <fo:inline>
                    <xsl:attribute name="id">
                        <xsl:call-template name="generate-toc-id">
                            <xsl:with-param name="element" select=".."/>
                        </xsl:call-template>
                    </xsl:attribute>
                </fo:inline>
                <!-- added by William on 2009-07-02 for indexterm bug:2815485 start-->
                <xsl:call-template name="pullPrologIndexTerms"/>
                <!-- added by William on 2009-07-02 for indexterm bug:2815485 end-->
                <xsl:apply-templates select="." mode="getTitle"/>
            </fo:block>
        </fo:block>
    </xsl:template>
    
    
    <!-- numbering before section titles, glossentries not numbered -->
    <xsl:template match="*" mode="getTitle">
        <xsl:variable name="level" select="count(ancestor::*[contains(@class,' topic/topic ')])"/>
        <xsl:if test="$level = 2 and not(contains(@class,' glossentry/glossterm ') or contains(@outputclass,'AVpFAQ'))">
            <!-- only count the topics that have titles that have a @outputclass that contains 'Heading'
            to skip the frontmatter topics like copyright -->
            <xsl:number count="*[contains(@class, ' topic/topic ')][child::*[contains(@class,' topic/title ')][contains(@outputclass,'Heading')]]" 
                level="multiple"/>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    
</xsl:stylesheet>