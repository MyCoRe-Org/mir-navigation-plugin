<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:include href="resource:xsl/render-series-panel.xsl" />
  <xsl:include href="copynodes.xsl" />

  <xsl:param name="WebApplicationBaseURL" />
  <xsl:param name="MCRObjectID" />
  <xsl:param name="MCRDerivateID" />

  <xsl:template match="/MyCoReWebPage">
    <xsl:copy>
      <section xml:lang="all">
        <div class="row detail_row">
          <div class="col-xs-12 col-sm-8" id="main_col">
            <xsl:copy-of select="@*" />
            <xsl:apply-templates select="*|text()" />
          </div>
          <div class="col-xs-12 col-sm-4" id="aux_col">
            <xsl:call-template name="resolve-navigation-and-render-series-panel">
              <xsl:with-param name="root-object-id" select="$MCRObjectID" />
              <xsl:with-param name="derivate-id" select="$MCRDerivateID" />
            </xsl:call-template>
          </div>
        </div>
      </section>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
