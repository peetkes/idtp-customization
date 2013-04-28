<?xml version='1.0'?>
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
    
    <!-- page layouts -->
    <xsl:include href="custom-page-layouts.xsl"/>
    
    <!-- headings -->
    <xsl:include href="custom-headings.xsl"/>
    
    <!-- bookmarks -->
    <xsl:include href="custom-bookmarks.xsl"/>
    
    <!-- index -->
    <xsl:include href="custom-index.xsl"/>
    
    <!-- common -->
    <xsl:template name="commonattributes">
        <xsl:apply-templates select="@id"/>
    </xsl:template>
    
    <!-- toc -->
    <xsl:param name="tocMaximumLevel">3</xsl:param> 
    <xsl:param name="chapterLayout">
        <xsl:choose>
            <xsl:when test="$antArgsChapterLayout!=''"><xsl:value-of select="$antArgsChapterLayout"/></xsl:when>
            <xsl:otherwise>BASIC</xsl:otherwise>
        </xsl:choose>
    </xsl:param>
    
    <xsl:template match="opentopic-index:index.groups" mode="toc">
        <xsl:if test="//*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/title ' )]">
            <fo:block xsl:use-attribute-sets="__toc__indent__index">
                <fo:block xsl:use-attribute-sets="__toc__topic__content__index">
                    <fo:basic-link internal-destination="{$id.index}" xsl:use-attribute-sets="__toc__link">
                        
                        <fo:inline xsl:use-attribute-sets="__toc__title">
                            <xsl:call-template name="insertVariable">
                                <xsl:with-param name="theVariableID" select="'Index'"/>
                            </xsl:call-template>
                        </fo:inline>
                        
                        <fo:inline xsl:use-attribute-sets="__toc__page-number">
                            <fo:leader xsl:use-attribute-sets="__toc__leader"/>
                            <fo:page-number-citation ref-id="{$id.index}"/>
                        </fo:inline>
                        
                    </fo:basic-link>
                </fo:block>
            </fo:block>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/topic ')]" mode="toc">
        <xsl:param name="include"/>
        <xsl:variable name="topicLevel" as="xs:integer">
            <xsl:apply-templates select="." mode="get-topic-level"/>
        </xsl:variable>
        <xsl:if test="$topicLevel &lt; $tocMaximumLevel">
            <xsl:variable name="mapTopicref" select="key('map-id', @id)[1]"/>
            <xsl:choose>
                <!-- In a future version, suppressing Notices in the TOC should not be hard-coded. -->
                <xsl:when test="$mapTopicref/self::*[contains(@class, ' bookmap/notices ')]"/>
                <xsl:when test="$mapTopicref[@toc = 'yes' or not(@toc)] or
                    (not($mapTopicref) and $include = 'true')">
                    <fo:block xsl:use-attribute-sets="__toc__indent">
                        <xsl:variable name="tocItemContent">
                            <fo:basic-link xsl:use-attribute-sets="__toc__link">
                                <xsl:attribute name="internal-destination">
                                    <xsl:call-template name="generate-toc-id"/>
                                </xsl:attribute>
                                <xsl:apply-templates select="$mapTopicref" mode="tocPrefix"/>
                                <fo:inline xsl:use-attribute-sets="__toc__title">
                                    <xsl:call-template name="getNavTitle" />
                                </fo:inline>
                                <fo:inline xsl:use-attribute-sets="__toc__page-number">
                                    <fo:leader xsl:use-attribute-sets="__toc__leader"/>
                                    <fo:page-number-citation>
                                        <xsl:attribute name="ref-id">
                                            <xsl:call-template name="generate-toc-id"/>
                                        </xsl:attribute>
                                    </fo:page-number-citation>
                                </fo:inline>
                            </fo:basic-link>
                        </xsl:variable>
                        <xsl:choose>
                            <xsl:when test="not($mapTopicref)">
                                <xsl:apply-templates select="." mode="tocText">
                                    <xsl:with-param name="tocItemContent" select="$tocItemContent"/>
                                    <xsl:with-param name="currentNode" select="."/>
                                </xsl:apply-templates>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates select="$mapTopicref" mode="tocText">
                                    <xsl:with-param name="tocItemContent" select="$tocItemContent"/>
                                    <xsl:with-param name="currentNode" select="."/>
                                </xsl:apply-templates>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:block>
                    <xsl:apply-templates mode="toc">
                        <xsl:with-param name="include" select="'true'"/>
                    </xsl:apply-templates>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates mode="toc">
                        <xsl:with-param name="include" select="'true'"/>
                    </xsl:apply-templates>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
       
    <!-- indents -->
    <xsl:template match="*[contains(@class, ' topic/p ')]">
        <xsl:choose>
            <xsl:when test="preceding-sibling::ph[@outputclass='AVpAttention']">
                <fo:block>
                    <xsl:call-template name="ph.AVpAttention"/>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:when>
            <xsl:when test="preceding-sibling::ph[@outputclass='AVpExample']">
                <fo:block>
                    <xsl:call-template name="ph.AVpExample"/>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:when>
            <xsl:when test="preceding-sibling::ph[@outputclass='AVpNB']">
                <fo:block>
                    <xsl:call-template name="ph.AVpNB"/>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:when>
            <xsl:when test="preceding-sibling::ph[@outputclass='AVpListBullet']">
                <fo:block>
                    <xsl:call-template name="ph.AVpListBullet"/>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:when>
            <xsl:when test="parent::*[contains(@class,' task/info ')]">
                <fo:block>
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:when>
            <xsl:when test="parent::*[contains(@outputclass,'AVpFAQ')]">
                <fo:block>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:when>
            <xsl:when test="@outputclass = 'AVpRefCondition'">
                <fo:block xsl:use-attribute-sets="p.AVpRefCondition">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:call-template name="insertVariable">
                        <xsl:with-param name="theVariableID" select="@outputclass"/>
                    </xsl:call-template>                                
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:when>
            <xsl:when test="@outputclass = ('AVpRefFromScreen','AVpRefToScreen','AVpRefKey')">
                <fo:block xsl:use-attribute-sets="p">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:call-template name="insertVariable">
                        <xsl:with-param name="theVariableID" select="@outputclass"/>
                    </xsl:call-template>                                
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:when>
            <xsl:otherwise>
                <fo:block xsl:use-attribute-sets="p">
                    <xsl:choose>
                        <xsl:when test="@outputclass = 'AVpNormalIndent'">
                            <xsl:call-template name="p.AVpNormalIndent"/>
                        </xsl:when>
                        <xsl:when test="@outputclass = 'AVpNormalDoubleIndent'">
                            <xsl:call-template name="p.AVpNormalDoubleIndent"/>
                        </xsl:when>
                    </xsl:choose>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- inlines -->
    <xsl:template match="*[contains(@class,' topic/ph ')][@outputclass = 'AVcKey']">
        <fo:inline>
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="ph.AVcKey"/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' topic/ph ')][@outputclass = 'AVcCode']">
        <fo:inline>
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="ph.AVcCode"/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' topic/ph ')][@outputclass = 'AVcModule']">
        <fo:inline>
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="ph.AVcModule"/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <xsl:template match="*[contains(@class,' topic/ph ')][@outputclass = 'AVpListBullet']">
        <fo:block>
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' topic/ph ')][@outputclass = 'AVcCommand']">
        <fo:inline>
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="ph.AVcCommand"/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
        
    <xsl:template match="*[contains(@class,' ui-d/uicontrol ')]" priority="2">
        <!-- insert an arrow before all but the first uicontrol in a menucascade -->
        <xsl:if test="ancestor::*[contains(@class,' ui-d/menucascade ')]">
            <xsl:variable name="uicontrolcount" select="count(preceding-sibling::*[contains(@class,' ui-d/uicontrol ')])"/>
            <xsl:if test="$uicontrolcount &gt; 0">
                <fo:inline xsl:use-attribute-sets="menucascade-separator">
                    <xsl:call-template name="insertVariable">
                        <xsl:with-param name="theVariableID" select="'#menucascade-separator'"/>
                    </xsl:call-template>
                </fo:inline>
            </xsl:if>
        </xsl:if>
        <fo:inline xsl:use-attribute-sets="uicontrol">
            <xsl:choose>
                <xsl:when test="@outputclass = 'AVcKey'">
                    <xsl:call-template name="uicontrol.AVcKey"/>
                </xsl:when>
                <xsl:when test="@outputclass = 'AVcField'">
                    <xsl:call-template name="uicontrol.AVcField"/>
                </xsl:when>
                <xsl:when test="@outputclass = 'AVcScreen'">
                    <xsl:call-template name="uicontrol.AVcScreen"/>
                </xsl:when>
            </xsl:choose>
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' topic/xref ')][@outputclass = 'AVcCommand']">
        <fo:inline>
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="xref.AVcCommand"/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    
    <!-- figures -->
    <xsl:template match="*[contains(@class,' topic/fig ')]/*[contains(@class,' topic/title ')]">
        <fo:block xsl:use-attribute-sets="fig.title">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="insertVariable">
                <xsl:with-param name="theVariableID" select="'Figure'"/>
                <xsl:with-param name="theParameters">
                    <number>
                        <xsl:number format="1." count="bookmap/concept[title[@outputclass='Heading 1']]"/>
                        <xsl:number level="any" format="1. " from="bookmap/concept"
                            count="*[contains(@class, ' topic/fig ')][child::*[contains(@class, ' topic/title ')]]" />
                    </number>
                    <title>
                        <xsl:apply-templates/>
                    </title>
                </xsl:with-param>
            </xsl:call-template>
        </fo:block>
    </xsl:template>
    
    <!-- table -->
    <xsl:template match="*[contains(@class, ' topic/table ')]/*[contains(@class, ' topic/title ')]">
        <fo:block xsl:use-attribute-sets="table.title">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="insertVariable">
                <xsl:with-param name="theVariableID" select="'Table'"/>
                <xsl:with-param name="theParameters">
                    <number>
                        <xsl:number format="1." count="bookmap/concept[title[@outputclass='Heading 1']]"/>
                        <xsl:number level="any" format="1. " from="bookmap/concept"
                            count="*[contains(@class, ' topic/table ')][child::*[contains(@class, ' topic/title ')]]"/>
                    </number>
                    <title>
                        <xsl:apply-templates/>
                    </title>
                </xsl:with-param>
            </xsl:call-template>
        </fo:block>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/thead ')]">
        <fo:table-header xsl:use-attribute-sets="tgroup.thead">
            <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:table-header>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/tbody ')]/*[contains(@class, ' topic/row ')]">
        <fo:table-row xsl:use-attribute-sets="tbody.row">
            <xsl:if test="not(following-sibling::*[contains(@class, ' topic/row ')])">
                <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
            </xsl:if>
            <xsl:if test="not(preceding-sibling::*[contains(@class, ' topic/row ')])">
                <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
            </xsl:if>
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:table-row>
    </xsl:template>
    
    
    <!-- place title below table -->
    <xsl:template match="*[contains(@class, ' topic/table ')]">
        <xsl:variable name="scale">
            <xsl:call-template name="getTableScale"/>
        </xsl:variable>
        
        <fo:block xsl:use-attribute-sets="table">
            <xsl:call-template name="commonattributes"/>
            <xsl:if test="not(@id)">
                <xsl:attribute name="id">
                    <xsl:call-template name="get-id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="not($scale = '')">
                <xsl:attribute name="font-size"><xsl:value-of select="concat($scale, '%')"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="*[not(contains(@class, ' topic/title '))]"/>
            <xsl:apply-templates select="*[contains(@class, ' topic/title ')]"/>
        </fo:block>
    </xsl:template>
    
    <!-- Task steps -->
    <xsl:template name="determine-keeps">
        <xsl:variable name="last-step" select="not(following-sibling::*[contains(@class, ' task/step ')])"/>
        <xsl:variable name="first-step" select="not(preceding-sibling::*[contains(@class,' task/step ')])"/>
        <xsl:choose>
            <xsl:when test="$first-step and not(last-step)">
                <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
            </xsl:when>
            <xsl:when test="$last-step and not($first-step)">
                <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' task/steps ')]/*[contains(@class, ' task/step ')]">
        <!-- Switch to variable for the count rather than xsl:number, so that step specializations are also counted -->
        <xsl:variable name="actual-step-count" select="number(count(preceding-sibling::*[contains(@class, ' task/step ')])+1)"/>
        <fo:list-item xsl:use-attribute-sets="steps.step">
            <xsl:call-template name="determine-keeps"/>
            <fo:list-item-label xsl:use-attribute-sets="steps.step__label">
                <fo:block xsl:use-attribute-sets="steps.step__label__content">
                    <fo:inline>
                        <xsl:call-template name="commonattributes"/>
                    </fo:inline>
                    <xsl:if test="preceding-sibling::*[contains(@class, ' task/step ')] | following-sibling::*[contains(@class, ' task/step ')]">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID" select="'Ordered List Number'"/>
                            <xsl:with-param name="theParameters">
                                <number>
                                    <xsl:value-of select="$actual-step-count"/>
                                </number>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:if>
                </fo:block>
            </fo:list-item-label>
            
            <fo:list-item-body xsl:use-attribute-sets="steps.step__body">
                <fo:block xsl:use-attribute-sets="steps.step__content">
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>
            
        </fo:list-item>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' task/steps-unordered ')]/*[contains(@class, ' task/step ')]">
        <fo:list-item xsl:use-attribute-sets="steps-unordered.step">
            <xsl:call-template name="determine-keeps"/>
            <fo:list-item-label xsl:use-attribute-sets="steps-unordered.step__label">
                <fo:block xsl:use-attribute-sets="steps-unordered.step__label__content">
                    <fo:inline>
                        <xsl:call-template name="commonattributes"/>
                    </fo:inline>
                    <xsl:call-template name="insertVariable">
                        <xsl:with-param name="theVariableID" select="'Unordered List bullet'"/>
                    </xsl:call-template>
                </fo:block>
            </fo:list-item-label>
            
            <fo:list-item-body xsl:use-attribute-sets="steps-unordered.step__body">
                <fo:block xsl:use-attribute-sets="steps-unordered.step__content">
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>
            
        </fo:list-item>
    </xsl:template>
   
    <!-- FAQ formatted in table -->
    <!-- table starts on conbody and takes all content into account, not only the sections with outputclass="AVpFAQ" -->
    <xsl:template match="*[contains(@class,' topic/body ')]/*[contains(@class,' topic/section ')][@outputclass='AVpFAQ']">
        <fo:table>
            <xsl:call-template name="faq_table"/>
            <fo:table-column xsl:use-attribute-sets="faq__image__column"/>
            <fo:table-column xsl:use-attribute-sets="faq__text__column"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell xsl:use-attribute-sets="faq__image__entry">
                        <fo:block line-height="{$default-line-height}">
                            <fo:external-graphic  
                                src="url({concat($artworkPrefix,'Customization/OpenTopic/common/artwork/',$faqIcon)})"
                                content-height="2em" content-width="2em"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell xsl:use-attribute-sets="faq__text__entry">
                        <xsl:apply-templates/>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
     
    <xsl:template match="*[contains(@class,' topic/section ')]/*[contains(@class,' topic/title ')][@outputclass='AVpFAQ']">
        <fo:block>
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="faq.section"/>
            <xsl:apply-templates select="." mode="getTitle"/>
        </fo:block>
    </xsl:template>
    
    <!-- notes -->
    <!-- apparently without overriding this template extra attributes are added to external-graphic (inline-progression-dimension) 
        that prevent the proper display of the icon -->
    <xsl:template match="*[contains(@class,' topic/note ')]">
        <xsl:variable name="noteType">
            <xsl:choose>
                <xsl:when test="@type = 'other' and @othertype">
                    <xsl:value-of select="@othertype"/>
                </xsl:when>
                <xsl:when test="@type">
                    <xsl:value-of select="@type"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'note'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="noteImagePath">
            <xsl:call-template name="insertVariable">
                <xsl:with-param name="theVariableID" select="concat($noteType, ' Note Image Path')"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="not($noteImagePath = '')">
                <fo:table xsl:use-attribute-sets="note__table">
                    <fo:table-column xsl:use-attribute-sets="note__image__column"/>
                    <fo:table-column xsl:use-attribute-sets="note__text__column"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell xsl:use-attribute-sets="note__image__entry">
                                <fo:block line-height="{$default-line-height}">
                                    <fo:external-graphic src="url({concat($artworkPrefix, $noteImagePath)})"
                                        content-height="2em" content-width="2em"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="note__text__entry">
                                <xsl:apply-templates select="." mode="placeNoteContent"/>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="placeNoteContent"/>
            </xsl:otherwise>
        </xsl:choose>
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
    
    <!-- sort glossary terms. glossary terms each in separate topic. 
        so need to customize "processTopic" or "processTopicChapter" on the container-topic-->
    
    <xsl:template match="*" mode="commonTopicProcessing">
        <xsl:variable name="topicrefShortdesc">
            <xsl:call-template name="getTopicrefShortdesc"/>
        </xsl:variable>
        <xsl:apply-templates select="*[contains(@class, ' topic/title ')]"/>
        <xsl:apply-templates select="*[contains(@class, ' topic/prolog ')]"/>
        
        <xsl:choose>
            <!-- When topic has an abstract, we cannot override shortdesc -->
            <xsl:when test="*[contains(@class, ' topic/abstract ')]">
                <xsl:apply-templates select="*[not(contains(@class, ' topic/title ')) and
                    not(contains(@class, ' topic/prolog ')) and
                    not(contains(@class, ' topic/shortdesc ')) and
                    not(contains(@class, ' topic/topic '))]"/>
            </xsl:when>
            <xsl:when test="$topicrefShortdesc/*">
                <xsl:apply-templates select="$topicrefShortdesc/*"/>
                <xsl:apply-templates select="*[not(contains(@class, ' topic/title ')) and
                    not(contains(@class, ' topic/prolog ')) and
                    not(contains(@class, ' topic/shortdesc ')) and
                    not(contains(@class, ' topic/topic '))]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="*[not(contains(@class, ' topic/title ')) and
                    not(contains(@class, ' topic/prolog ')) and
                    not(contains(@class, ' topic/topic '))]"/>
            </xsl:otherwise>
        </xsl:choose>      
        <xsl:apply-templates select="." mode="buildRelationships"/>
        
        <!-- sort glossentries: first check if ALL child topics are also glossentry -->
        <xsl:choose>
            <xsl:when
                test="count(*[contains(@class,' topic/topic ')]) = count(*[contains(@class,' glossentry/glossentry ')])">
                <xsl:apply-templates
                    select="*[contains(@class,' topic/topic ')][contains(@class,' glossentry/glossentry ')]">
                    <xsl:sort select="lower-case(*[contains(@class,' glossentry/glossterm ')])"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="*[contains(@class,' topic/topic ')]"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="." mode="topicEpilog"/>
    </xsl:template>

</xsl:stylesheet>