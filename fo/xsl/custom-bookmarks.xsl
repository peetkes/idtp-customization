<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    exclude-result-prefixes="xs opentopic-index ot-placeholder"
    version="2.0">

    <xsl:template name="createBookmarks">
        <xsl:variable name="bookmarks" as="element()*">
            <xsl:choose>
                <xsl:when test="$retain-bookmap-order">
                    <xsl:apply-templates select="/" mode="bookmark"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:for-each select="/*/*[contains(@class, ' topic/topic ')]">
                        <xsl:variable name="topicType">
                            <xsl:call-template name="determineTopicType"/>
                        </xsl:variable>
                        <xsl:if test="$topicType = 'topicNotices'">
                            <xsl:apply-templates select="." mode="bookmark"/>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:choose>
                        <xsl:when test="($ditaVersion &gt;= 1.1) and $map//*[contains(@class,' bookmap/toc ')][@href]"/>
                        <xsl:when test="($ditaVersion &gt;= 1.1) and ($map//*[contains(@class,' bookmap/toc ')]
                            or /*[contains(@class,' map/map ')][not(contains(@class,' bookmap/bookmap '))])">
                            <fo:bookmark internal-destination="{$id.toc}">
                                <fo:bookmark-title>
                                    <xsl:call-template name="insertVariable">
                                        <xsl:with-param name="theVariableID" select="'Table of Contents'"/>
                                    </xsl:call-template>
                                </fo:bookmark-title>
                            </fo:bookmark>
                        </xsl:when>
                        <xsl:when test="$ditaVersion &gt;= 1.1"/>
                        <xsl:otherwise>
                            <fo:bookmark internal-destination="{$id.toc}">
                                <fo:bookmark-title>
                                    <xsl:call-template name="insertVariable">
                                        <xsl:with-param name="theVariableID" select="'Table of Contents'"/>
                                    </xsl:call-template>
                                </fo:bookmark-title>
                            </fo:bookmark>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:for-each select="/*/*[contains(@class, ' topic/topic ')] |
                        /*/ot-placeholder:glossarylist |
                        /*/ot-placeholder:tablelist |
                        /*/ot-placeholder:figurelist">
                        <xsl:variable name="topicType">
                            <xsl:call-template name="determineTopicType"/>
                        </xsl:variable>
                        <xsl:if test="not($topicType = 'topicNotices')">
                            <xsl:apply-templates select="." mode="bookmark"/>
                        </xsl:if>
                    </xsl:for-each>
                    <xsl:if test="//opentopic-index:index.groups//opentopic-index:index.entry">
                        <fo:bookmark internal-destination="{$id.index}">
                            <fo:bookmark-title>
                                <xsl:call-template name="insertVariable">
                                    <xsl:with-param name="theVariableID" select="'Index'"/>
                                </xsl:call-template>
                            </fo:bookmark-title>
                        </fo:bookmark>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:if test="exists($bookmarks)">
            <fo:bookmark-tree>
                <xsl:copy-of select="$bookmarks"/>
            </fo:bookmark-tree>
        </xsl:if>
    </xsl:template>
        
</xsl:stylesheet>