<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/2000/svg">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="Interval" select="60"/>
    
    <!-- Variable for all stories collection -->
    <xsl:variable name="edgar_allen_poe" select="collection('../xml/?select=*.xml')"/>
    
    <!-- Key to group stories by theme -->
    <xsl:key name="Type" match="story" use="@type"/>
    
    <xsl:template match="/">
        <svg width="800" height="1000" viewbox=" 0 0 1700 1000">
            <g transform="translate(50, 750)">
                <!-- Title -->
                <text x="375" y="-800" text-anchor="middle">FOS used in edgar allen poe stories</text>
                <line x1="20" x2="20" y1="0" y2="-650" stroke="black" stroke-width="1"/>
                <line x1="20" x2="1200" y1="0" y2="0" stroke="black" stroke-width="1"/>
                
                <!-- Y-axis labels -->
                <text x="5" y="0" text-anchor="middle">0</text>
                <text x="5" y="-60" text-anchor="middle">50</text>
                <text x="5" y="-120" text-anchor="middle">100</text>
                <text x="5" y="-180" text-anchor="middle">150</text>
                <text x="5" y="-240" text-anchor="middle">200</text>
                <text x="5" y="-300" text-anchor="middle">250</text>
                <text x="5" y="-360" text-anchor="middle">300</text>
                <text x="5" y="-420" text-anchor="middle">350</text>
                <text x="5" y="-480" text-anchor="middle">400</text>
                <text x="5" y="-540" text-anchor="middle">450</text>
                <text x="5" y="-600" text-anchor="middle">500</text>
                
                <!-- Process each unique fos -->
                <xsl:variable name="totalFos" select="count(distinct-values($edgar_allen_poe//fos/@type))"/>
                
                <xsl:for-each select="distinct-values($edgar_allen_poe//fos/@type)">
                    <xsl:variable name="type" select="."/>
                    
                    <!-- Count how many times this fos appears across all stories -->
                    <xsl:variable name="count" select="count($edgar_allen_poe//fos[@type=$type])"/>
                    
                    <!-- Calculate X position (evenly spaced) -->
                    <xsl:variable name="xPos" select="(position() - .5) * (1100 div $totalFos) + 40"/>
                    
                    <!-- Calculate bar height based on the fos count -->
                    <xsl:variable name="barHeight" select="$count * 60"/>
                    
                    <!-- Create the bar for the fos -->
                    <rect x="{$xPos}" y="{- $barHeight}" width="40" height="{$barHeight}" fill="red"/>
                    
                    <!-- Create text for fos name above the bar -->
                    <text x="{$xPos}" y="30" text-anchor="middle">
                        <xsl:value-of select="$type"/>
                    </text>
                    <text x="{$xPos + 25}" y="{-(($count * 6))-10}" text-anchor="middle">
                        <xsl:value-of select="$count"/>
                    </text>
                </xsl:for-each>
                
            </g>
        </svg>
    </xsl:template>
    
</xsl:stylesheet>
