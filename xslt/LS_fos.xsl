<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:svg="http://www.w3.org/2000/svg">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <!-- Define a key to group fos elements by their type -->
    <xsl:key name="fosByType" match="fos" use="@type"/>
    
    <!-- Template to generate Y-axis labels -->
    <xsl:template name="generateLabels">
        <xsl:param name="start" select="0"/>
        <xsl:param name="end" select="200"/>
        <xsl:param name="step" select="10"/>
        
        <xsl:if test="$start &lt;= $end">
            <!-- Calculate the y position for the label -->
            <xsl:variable name="labelSpacing" select="1200 div 200"/>
            <text x="-20" y="{-(($start * $labelSpacing))}" text-anchor="middle">
                <xsl:value-of select="$start"/>
            </text>
            <!-- call this template to generate the next label. found this on https://www.w3schools.com/xml/ref_xsl_el_call-template.asp-->
            <xsl:call-template name="generateLabels">
                <xsl:with-param name="start" select="$start + $step"/>
                <xsl:with-param name="end" select="$end"/>
                <xsl:with-param name="step" select="$step"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="/">
        <svg width="800" height="1000" viewBox="0 0 1700 1000">
            <g transform="translate(50, 750)"> <!-- Moved the graph further down to fit the title -->
                <text x="700" y="-1250" text-anchor="middle" font-size="26" font-weight="bold">Figures of Speech Used in Stories</text>              
                <!-- X and Y axes -->
                <line x1="0" x2="1500" y1="0" y2="0" stroke="black" stroke-width="1"/> 
                <line x1="0" x2="0" y1="0" y2="-1200" stroke="black" stroke-width="1"/> 
                
                <!-- Y-axis Labels (spaced evenly from 0 to 200) -->
                <xsl:call-template name="generateLabels">
                    <xsl:with-param name="start" select="0"/>
                    <xsl:with-param name="end" select="200"/>
                    <xsl:with-param name="step" select="10"/>
                </xsl:call-template>
                
                <!-- Apply templates for each unique type -->
                <xsl:for-each select="//fos[generate-id() = generate-id(key('fosByType', @type)[1])]">
                    <xsl:variable name="typeValue" select="@type"/>
                    <xsl:variable name="count" select="count(//fos[@type=$typeValue])"/>
                    
                    <xsl:if test="$count > 0">
                        <xsl:variable name="barIndex" select="position()"/>
                        
                        <!-- Calculate the x-position for spacing between the bars -->
                        <xsl:variable name="xPos" select="($barIndex - 1) * 150"/> <!-- Increased space to 150px between bars -->
                        
                        <!-- Draw the bar -->
                        <rect x="{$xPos}" y="{-(($count * 6))}" width="50" height="{$count * 6}" fill="#820000" stroke="black"/>
                        
                        <!-- Label the type on the X-axis -->
                        <text x="{$xPos + 25}" y="20" text-anchor="middle">
                            <xsl:value-of select="$typeValue"/>
                        </text>
                        
                        <!-- Count label on the bar -->
                        <text x="{$xPos + 25}" y="{-(($count * 6)) - 10}" text-anchor="middle">
                            <xsl:value-of select="$count"/>
                        </text>
                    </xsl:if>
                </xsl:for-each>
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>
