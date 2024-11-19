<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/2000/svg">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="Interval" select="60"/>
    <xsl:template match="/">
        <svg width="100%" height="100%">
            <g transform="translate(60, 575)">
                <text x="375" y="-550" text-anchor="middle">Theme usage in Edgar Allen Poe Short Stories</text>
                <line x1="20" x2="20" y1="0" y2="-450" stroke="black" stroke-width="1"/>
                <line x1="20" x2="750" y1="0" y2="0" stroke="black" stroke-width="1"/>
                <text x="5" y="0" text-anchor="middle">0</text>
                <text x="5" y="-60" text-anchor="middle">1</text>
                <text x="5" y="-120" text-anchor="middle">2</text>
                <text x="5" y="-180" text-anchor="middle">3</text>
                <text x="5" y="-240" text-anchor="middle">4</text>
                <text x="5" y="-300" text-anchor="middle">5</text>
                <text x="5" y="-360" text-anchor="middle">6</text>
                <text x="5" y="-420" text-anchor="middle">7</text>
                <xsl:apply-templates select="//chapter"/>
            </g>
        </svg>
    </xsl:template>
    
    <xsl:template match="chapter">
        <xsl:variable name="xPos" select="position()*$Interval"/>
        <xsl:variable name="yPos" select="count(.//q[@sp='alice']) * 6"/>
        
        <text x="{$xPos}" y="30" text-anchor="middle"> Ch.
            <xsl:value-of select="@which"/></text>
        
        <line x1="{$xPos}" y1="-{$yPos}" x2="{$xPos}" y2="0" stroke="red" stroke-width="15"/> <!-- points -->
        <text x="{$xPos - 3}" y="{-$yPos - 30}"><xsl:value-of select="count(.//q[@sp='alice'])"/></text> <!-- numbers above dots -->
        
    </xsl:template>
    
</xsl:stylesheet>