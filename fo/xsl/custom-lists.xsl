<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">

    <!--Lists-->
    <xsl:template name="determine-keeps">
        <xsl:param name="type" select="' topic/li '"/>
        <xsl:variable name="last-step" select="not(following-sibling::*[contains(@class, $type)])"/>
        <xsl:variable name="first-step" select="not(preceding-sibling::*[contains(@class,$type)])"/>
        <xsl:choose>
            <xsl:when test="$first-step and not(last-step)">
                <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
            </xsl:when>
            <xsl:when test="$last-step and not($first-step)">
                <xsl:attribute name="keep-with-previous.within-page">always</xsl:attribute>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/ul ')]/*[contains(@class, ' topic/li ')]">
        <fo:list-item xsl:use-attribute-sets="ul.li">
            <xsl:call-template name="determine-keeps">
                <xsl:with-param name="type" select="' topic/li '"/>
            </xsl:call-template>
            <fo:list-item-label xsl:use-attribute-sets="ul.li__label">
                <fo:block xsl:use-attribute-sets="ul.li__label__content">
                    <fo:inline>
                        <xsl:call-template name="commonattributes"/>
                    </fo:inline>
                    <xsl:call-template name="insertVariable">
                        <xsl:with-param name="theVariableID" select="'Unordered List bullet'"/>
                    </xsl:call-template>
                </fo:block>
            </fo:list-item-label>
            
            <fo:list-item-body xsl:use-attribute-sets="ul.li__body">
                <fo:block xsl:use-attribute-sets="ul.li__content">
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>
            
        </fo:list-item>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/ol ')]/*[contains(@class, ' topic/li ')]">
        <fo:list-item xsl:use-attribute-sets="ol.li">
            <xsl:call-template name="determine-keeps">
                <xsl:with-param name="type" select="' topic/li '"/>
            </xsl:call-template>
            <fo:list-item-label xsl:use-attribute-sets="ol.li__label">
                <fo:block xsl:use-attribute-sets="ol.li__label__content">
                    <fo:inline>
                        <xsl:call-template name="commonattributes"/>
                    </fo:inline>
                    <xsl:call-template name="insertVariable">
                        <xsl:with-param name="theVariableID" select="'Ordered List Number'"/>
                        <xsl:with-param name="theParameters">
                            <number>
                                <xsl:choose>
                                    <xsl:when test="parent::*[contains(@class, ' topic/ol ')]/parent::*[contains(@class, ' topic/li ')]/parent::*[contains(@class, ' topic/ol ')]">
                                        <xsl:number format="a"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:number/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </number>
                        </xsl:with-param>
                    </xsl:call-template>
                </fo:block>
            </fo:list-item-label>
            
            <fo:list-item-body xsl:use-attribute-sets="ol.li__body">
                <fo:block xsl:use-attribute-sets="ol.li__content">
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>
            
        </fo:list-item>
    </xsl:template>

    <!-- Task steps -->
    <xsl:template name="determine-step-keeps">
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
            <xsl:call-template name="determine-keeps">
                <xsl:with-param name="type" select="' task/step '"/>
            </xsl:call-template>
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
            <xsl:call-template name="determine-keeps">
                <xsl:with-param name="type" select="' task/step '"/>
            </xsl:call-template>
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
    
</xsl:stylesheet>