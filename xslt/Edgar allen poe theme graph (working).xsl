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
    <xsl:key name="Theme" match="story" use="@theme"/>
    
    <xsl:template match="/">
        <svg width="200%" height="500%">
            <g transform="translate(60, 1000)">
                <!-- Title -->
                <text x="375" y="-800" text-anchor="middle">Theme usage in Edgar Allan Poe Short Stories</text>
                <line x1="20" x2="20" y1="0" y2="-650" stroke="black" stroke-width="1"/>
                <line x1="20" x2="1000" y1="0" y2="0" stroke="black" stroke-width="1"/>
                
                <!-- Y-axis labels -->
                <text x="5" y="0" text-anchor="middle">0</text>
                <text x="5" y="-60" text-anchor="middle">1</text>
                <text x="5" y="-120" text-anchor="middle">2</text>
                <text x="5" y="-180" text-anchor="middle">3</text>
                <text x="5" y="-240" text-anchor="middle">4</text>
                <text x="5" y="-300" text-anchor="middle">5</text>
                <text x="5" y="-360" text-anchor="middle">6</text>
                <text x="5" y="-420" text-anchor="middle">7</text>
                <text x="5" y="-480" text-anchor="middle">8</text>
                <text x="5" y="-540" text-anchor="middle">9</text>
                <text x="5" y="-600" text-anchor="middle">10</text>
                
                <!-- Process each unique theme -->
                <xsl:variable name="totalThemes" select="count(distinct-values($edgar_allen_poe//story/@theme))"/>
                
                <xsl:for-each select="distinct-values($edgar_allen_poe//story/@theme)">
                    <xsl:variable name="theme" select="."/>
                    
                    <!-- Count how many times this theme appears across all stories -->
                    <xsl:variable name="count" select="count($edgar_allen_poe//story[@theme=$theme])"/>
                    
                    <!-- Calculate X position (evenly spaced) -->
                    <xsl:variable name="xPos" select="(position() - .5) * (900 div $totalThemes) + 40"/>
                    
                    <!-- Calculate bar height based on the theme count -->
                    <xsl:variable name="barHeight" select="$count * 60"/>
                    
                    <!-- Create the bar for the theme -->
                    <rect x="{$xPos}" y="{- $barHeight}" width="40" height="{$barHeight}" fill="red"/>
                    
                    <!-- Create text for theme name above the bar -->
                    <text x="{$xPos}" y="30" text-anchor="middle">
                        <xsl:value-of select="$theme"/>
                    </text>
                </xsl:for-each>
                
            </g>
        </svg>
    </xsl:template>
    
</xsl:stylesheet>
