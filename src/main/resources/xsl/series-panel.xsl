<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  exclude-result-prefixes="xlink">

  <xsl:include href="resource:xsl/render-series-panel.xsl" />

  <xsl:template match="mycoreobject" mode="seriesLayout">
    <xsl:apply-templates
      select="structure/derobjects/derobject[classification[@classid='derivate_types'][@categid='navigation']]/@xlink:href"
      mode="seriesLayout">
      <xsl:with-param name="rootID" select="@ID" />
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="derobject/@xlink:href" mode="seriesLayout">
    <xsl:param name="rootID" />
    <xsl:call-template name="resolve-navigation-and-render-series-panel">
      <xsl:with-param name="root-object-id" select="$rootID" />
      <xsl:with-param name="derivate-id" select="." />
    </xsl:call-template>
  </xsl:template>

</xsl:stylesheet>
