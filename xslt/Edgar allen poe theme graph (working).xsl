<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/2000/svg">
    
    <xsl:output method="xml" indent="yes"/>
    <xsl:variable name="Interval" select="60"/>
    <xsl:key name="Theme" match="story" use="@theme"/>
    
    <!-- Template to process multiple documents -->
    <xsl:variable name="edgar_allen_poe" select="collection('../xml/?select=*.xml')"/>
    <xsl:template match="/">
    <!--    <xsl:variable name="documents" select="collection('Berenice.xml', 'Eleonora.xml', 'The_Angel_of_the_Odd.xml', 'The_Masque_of_the_Red_Death.xml', 
            'The_Narratives_of_Arthur_Gordon.xml', 'Thefacts_inthe_caseof_Mvaldemar.xml', 
            'adescent_intothe_maelstrom.xml', 'hopfrog.xml', 'ligeia.xml', 
            'manuscript_foundina_bottle.xml', 'mesmeric_revelation.xml', 
            'neverbet_thedevil_yourhead.xml', 'silenceafable.xml', 
            'somewordswithamummy.xml', 'the_caskof_amontillado.xml', 'the_oblong_box.xml', 
            'the_purloined_letter.xml', 'the_spectacles.xml', 'the_telltale_heart.xml', 
            'theballoonhoax.xml', 'theblackcat.xml', 'theffall_ofthe_houseofusher.xml' 
            , 'the_imp_of_perverse.xml', 'the_island_of_the_fay.xml', 
            'the_man_of_the_crowd.xml', 'themurders_inthe_ruemorgue.xml', 'theovalportrait.xml', 
            'thepit_andthe_pendulum.xml', 'thepremature_burial.xml', 'thesystemsof_drtarrandproffether.xml', 
            'theymysteryof_marieroget.xml', 'williamwilson.xml') 
            "/>   -->
        
        <!-- Start the SVGy -->
        <svg width="100%" height="100%">
            <g transform="translate(60, 575)">
                <!-- Title -->
                <text x="375" y="-550" text-anchor="middle">Theme usage in Edgar Allan Poe Short Stories</text>
                <line x1="20" x2="20" y1="0" y2="-450" stroke="black" stroke-width="1"/>
                <line x1="20" x2="750" y1="0" y2="0" stroke="black" stroke-width="1"/>
                
                <!-- Y-axis labels -->
                <text x="5" y="0" text-anchor="middle">0</text>
                <text x="5" y="-60" text-anchor="middle">1</text>
                <text x="5" y="-120" text-anchor="middle">2</text>
                <text x="5" y="-180" text-anchor="middle">3</text>
                <text x="5" y="-240" text-anchor="middle">4</text>
                <text x="5" y="-300" text-anchor="middle">5</text>
                <text x="5" y="-360" text-anchor="middle">6</text>
                <text x="5" y="-420" text-anchor="middle">7</text>
                
                <!-- Process each document -->
                <xsl:for-each select="$edgar_allen_poe/story">
                    <!-- Template to match each story and count its themes -->
                    
                    
                    
                        <xsl:variable name="theme" select=".//@theme"/>
                        
                        <xsl:if test="not(preceding::story[@theme = $theme])"> <!-- did this to try to stop the repeating but is not working -->
                            <!-- Count how many times this theme appears across all stories -->
                            <xsl:variable name="count" select="count(//story[.//@theme=$theme])"/>
                            
                            <!-- Calculate X position (intervals between bars) -->
                            <xsl:variable name="xPos" select="position() * $Interval"/>
                            
                            <!-- Calculate bar height based on the theme count -->
                            <xsl:variable name="barHeight" select="$count * 60"/>
                            
                            <!-- Create the bar for the theme -->
                            <rect x="{$xPos}" y="{-$barHeight}" width="40" height="{$barHeight}" fill="blue"/>
                            
                            <!-- Create text for theme name above the bar -->
                            <text x="{$xPos}" y="30" text-anchor="middle">
                                <xsl:value-of select=".//@theme"/>
                            </text>
                            
                        </xsl:if>
                   <!--whc: move the template rule material from below up to here-->
                    <!-- MN linked the filed together -->
                    <!-- Apply templates for stories in each document -->
                    
                </xsl:for-each>
                
            </g>
        </svg>
    </xsl:template>
    
 

    
</xsl:stylesheet>