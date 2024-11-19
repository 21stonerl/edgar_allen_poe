<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:svg="http://www.w3.org/2000/svg">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <!-- Define a key to group fos elements by their type -->
    <xsl:key name="fosByType" match="fos" use="@type"/>
    
    <xsl:template match="/">
        <svg width="800" height="600">
            <g transform="translate(50, 550)">
                <text x="300" y="-450" text-anchor="middle" font-size="16" font-weight="bold">Figures of Speech Used in Stories</text>
                <line x1="0" x2="0" y1="0" y2="-450" stroke="black" stroke-width="1"/>
                <line x1="0" x2="700" y1="0" y2="0" stroke="black" stroke-width="1"/>
                
                <!-- Y-axis Labels -->
                <text x="-20" y="0" text-anchor="middle">0</text>
                <text x="-20" y="-60" text-anchor="middle">10</text>
                <text x="-20" y="-120" text-anchor="middle">20</text>
                <text x="-20" y="-180" text-anchor="middle">30</text>
                <text x="-20" y="-240" text-anchor="middle">40</text>
                <text x="-20" y="-300" text-anchor="middle">50</text>
                <text x="-20" y="-360" text-anchor="middle">60</text>
                <text x="-20" y="-420" text-anchor="middle">70</text>
                
                <!-- Apply templates for each unique type -->
                <xsl:for-each select="//fos[generate-id() = generate-id(key('fosByType', @type)[1])]">
                    <xsl:variable name="typeValue" select="@type"/>
                    <xsl:variable name="count" select="count(//fos[@type=$typeValue])"/>
                    
                    <xsl:if test="$count > 0">
                        <xsl:variable name="barIndex" select="position()"/>
                        <xsl:variable name="xPos" select="($barIndex - 1) * 80"/>
                        
                        <!-- Draw the bar -->
                        <rect x="{$xPos}" y="{-(($count * 6))}" width="50" height="{$count * 6}" fill="green" stroke="black"/>
                        
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
