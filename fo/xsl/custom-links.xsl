<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:exsl="http://exslt.org/common"
    xmlns:exslf="http://exslt.org/functions"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    exclude-result-prefixes="xs opentopic-func exslf exsl"
    version="2.0">
    
    <!-- xref -->
<!--    <xsl:template match="*[contains(@class,' topic/xref ')][@outputclass = 'AVcCommand']">
        <fo:inline>
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="xref.AVcCommand"/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
-->    
    <xsl:template match="*[contains(@class,' topic/xref ')]" priority="2">
        <xsl:variable name="destination" select="opentopic-func:getDestinationId(@href)"/>
        <xsl:variable name="element" select="key('key_anchor',$destination)[1]"/>
        <xsl:variable name="referenceTitle">
            <xsl:apply-templates select="." mode="insertReferenceTitle">
                <xsl:with-param name="href" select="@href"/>
                <xsl:with-param name="titlePrefix" select="''"/>
                <xsl:with-param name="destination" select="$destination"/>
                <xsl:with-param name="element" select="$element"/>
            </xsl:apply-templates>
        </xsl:variable>
        
        <fo:basic-link xsl:use-attribute-sets="xref">
            <xsl:choose>
                <xsl:when test="@outputclass = 'AVcCommand'">
                    <xsl:call-template name="xref.AVcCommand"/>
                </xsl:when>
            </xsl:choose>
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="buildBasicLinkDestination">
                <xsl:with-param name="scope" select="@scope"/>
                <xsl:with-param name="format" select="@format"/>
                <xsl:with-param name="href" select="@href"/>
            </xsl:call-template>
            
            <xsl:choose>
                <xsl:when test="not(@scope = 'external' or @format = 'html') and not($referenceTitle = '')">
                    <xsl:copy-of select="$referenceTitle"/>
                </xsl:when>
                <xsl:when test="not(@scope = 'external' or @format = 'html') and not(@outputclass='AVcCommand')">
                    <xsl:call-template name="insertPageNumberCitation">
                        <xsl:with-param name="isTitleEmpty" select="'yes'"/>
                        <xsl:with-param name="destination" select="$destination"/>
                        <xsl:with-param name="element" select="$element"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="*[not(contains(@class,' topic/desc '))] | text()">
                            <xsl:apply-templates select="*[not(contains(@class,' topic/desc '))] | text()" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@href"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </fo:basic-link>
        
        <!--
				Disable because of the CQ#8102 bug
				<xsl:if test="*[contains(@class,' topic/desc ')]">
					<xsl:call-template name="insertLinkDesc"/>
				</xsl:if>
		-->
        
        <xsl:if test="not(@scope = 'external' or @format = 'html') and not($referenceTitle = '') and not($element[contains(@class, ' topic/fn ')])">
            <!-- SourceForge bug 1880097: should not include page number when xref includes author specified text -->
            <xsl:if test="processing-instruction()[name()='ditaot'][.='usertext'] and not(@outputclass='AVcCommand')">
            <!--<xsl:if test="not(processing-instruction()[name()='ditaot'][.='usertext'])">-->
                    <xsl:call-template name="insertPageNumberCitationAVpSeeAlso">
                    <xsl:with-param name="destination" select="$destination"/>
                    <xsl:with-param name="element" select="$element"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <!-- related links 
    links inline in same block as prefix "related links"
    only for outputclass = AVpSeeAlso
    -->
    <xsl:template match="*[contains(@class,' topic/related-links ')][@outputclass='AVpSeeAlso']">
        <xsl:if test="normalize-space($includeRelatedLinkRoles)">
            <xsl:variable name="topicType">
                <xsl:for-each select="parent::*">
                    <xsl:call-template name="determineTopicType"/>
                </xsl:for-each>
            </xsl:variable>
            <xsl:if test="child::link">
                <fo:block xsl:use-attribute-sets="related-links">
                    <fo:block xsl:use-attribute-sets="related-links.title">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID" select="'Related Links'"/>
                        </xsl:call-template>
                        <fo:inline xsl:use-attribute-sets="related-links__content">
                            <xsl:apply-templates>
                                <xsl:with-param name="topicType" select="$topicType"/>
                            </xsl:apply-templates>
                        </fo:inline>
                    </fo:block>
                </fo:block>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' topic/link ')][ancestor::*[@outputclass='AVpSeeAlso']]">
        <xsl:param name="topicType">
            <xsl:for-each select="ancestor::*[contains(@class,' topic/topic ')][1]">
                <xsl:call-template name="determineTopicType"/>
            </xsl:for-each>
        </xsl:param>
        <xsl:choose>
            <xsl:when test="(@role and not(contains($includeRelatedLinkRoles, concat(' ', @role, ' ')))) or
                (not(@role) and not(contains($includeRelatedLinkRoles, ' #default ')))"/>
            <xsl:when test="@role='child' and $chapterLayout='MINITOC' and
                ($topicType='topicChapter' or $topicType='topicAppendix' or $topicType='topicPart')">
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="processLink"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' topic/link ')][ancestor::*[@outputclass='AVpSeeAlso']]" mode="processLink">
        <xsl:variable name="destination" select="opentopic-func:getDestinationId(@href)"/>
        <xsl:variable name="element" select="key('key_anchor',$destination)[1]"/>
        <xsl:variable name="referenceTitle">
            <xsl:apply-templates select="." mode="insertReferenceTitle">
                <xsl:with-param name="href" select="@href"/>
                <xsl:with-param name="titlePrefix" select="''"/>
                <xsl:with-param name="destination" select="$destination"/>
                <xsl:with-param name="element" select="$element"/>
            </xsl:apply-templates>
        </xsl:variable>
        <xsl:variable name="linkScope">
            <xsl:call-template name="getLinkScope"/>
        </xsl:variable>
        <fo:inline xsl:use-attribute-sets="link.AVpSeeAlso">
            <!--<xsl:text>&#x2022; </xsl:text>-->
            <fo:inline xsl:use-attribute-sets="link__content.AVpSeeAlso">
                <fo:basic-link>
                    <xsl:call-template name="buildBasicLinkDestination">
                        <xsl:with-param name="scope" select="$linkScope"/>
                        <xsl:with-param name="href" select="@href"/>
                    </xsl:call-template>
                    <xsl:choose>
                        <xsl:when test="not($linkScope = 'external') and not($referenceTitle = '')">
                            <xsl:copy-of select="$referenceTitle"/>
                        </xsl:when>
                        <xsl:when test="not($linkScope = 'external')">
                            <xsl:call-template name="insertPageNumberCitationAVpSeeAlso">
                                <xsl:with-param name="isTitleEmpty" select="'yes'"/>
                                <xsl:with-param name="destination" select="$destination"/>
                                <xsl:with-param name="element" select="$element"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates/>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:basic-link>
            </fo:inline>
            <xsl:if test="not($linkScope = 'external') and not($referenceTitle = '')">
                <xsl:call-template name="insertPageNumberCitationAVpSeeAlso">
                    <xsl:with-param name="destination" select="$destination"/>
                    <xsl:with-param name="element" select="$element"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:call-template name="insertLinkShortDesc">
                <xsl:with-param name="destination" select="$destination"/>
                <xsl:with-param name="element" select="$element"/>
                <xsl:with-param name="linkScope" select="$linkScope"/>
            </xsl:call-template>
            
            <!-- comma after all but last link -->
            <xsl:if test="following-sibling::*[contains(@class,' topic/link ')]">
                <xsl:text>,&#160;</xsl:text>
            </xsl:if>
        </fo:inline>
    </xsl:template>
    
    <!-- brackets around page num -->
    <xsl:template name="insertPageNumberCitationAVpSeeAlso">
        <xsl:param name="isTitleEmpty"/>
        <xsl:param name="destination"/>
        <xsl:param name="element"/>
        <xsl:choose>
            <xsl:when test="not($element) or ($destination = '')"/>
            <xsl:when test="$isTitleEmpty">
                <fo:inline>
                    <xsl:text>&#160;(</xsl:text>
                    <xsl:call-template name="insertVariable">
                        <xsl:with-param name="theVariableID" select="'Page AVpSeeAlso'"/>
                        <xsl:with-param name="theParameters">
                            <pagenum>
                                <fo:inline>
                                    <fo:page-number-citation ref-id="{$destination}"/>
                                </fo:inline>
                            </pagenum>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:text>)</xsl:text>
                </fo:inline>
            </xsl:when>
            <xsl:otherwise>
                <fo:inline>
                    <xsl:text>&#160;(</xsl:text>
                    <xsl:call-template name="insertVariable">
                        <xsl:with-param name="theVariableID" select="'On the page AVpSeeAlso'"/>
                        <xsl:with-param name="theParameters">
                            <pagenum>
                                <fo:inline>
                                    <fo:page-number-citation ref-id="{$destination}"/>
                                </fo:inline>
                            </pagenum>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:text>)</xsl:text>
                </fo:inline>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>