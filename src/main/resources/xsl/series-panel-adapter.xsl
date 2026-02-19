<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:include href="resource:xsl/render-series-panel.xsl" />

  <xsl:param name="MCRDerivateID" />
  <xsl:param name="MCRObjectID" />

  <xsl:template match="series-panel">
    <xsl:if test="$MCRObjectID and $MCRDerivateID">
      <xsl:call-template name="resolve-navigation-and-render-series-panel">
        <xsl:with-param name="root-object-id" select="$MCRObjectID" />
        <xsl:with-param name="derivate-id" select="$MCRDerivateID" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
