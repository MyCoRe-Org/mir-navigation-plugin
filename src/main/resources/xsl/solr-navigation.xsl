<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xalan="http://xml.apache.org/xalan"
  xmlns:mods="http://www.loc.gov/mods/v3" 
  exclude-result-prefixes="xalan xlink mods">
  <xsl:import href="xslImport:solr-document:solr-navigation.xsl" />

  <xsl:template match="mycoreobject">
    <xsl:apply-imports />
    <xsl:apply-templates select="metadata/def.modsContainer/modsContainer/mods:mods/mods:relatedItem[@type='host'][@xlink:href]" mode="rootID" />
  </xsl:template>
  
  <!-- go up all the ancestors to find ID of root object that has no parent (root of series/journal) -->
  <xsl:template match="mods:relatedItem[@type='host'][@xlink:href]" mode="rootID">
    <xsl:choose>
      <xsl:when test="mods:relatedItem[@type='host'][@xlink:href]">
        <xsl:apply-templates select="mods:relatedItem[@type='host'][@xlink:href]" mode="rootID" />
      </xsl:when>
      <xsl:otherwise>
        <field name="root">
          <xsl:value-of select="@xlink:href" />
        </field>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>