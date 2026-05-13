<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exslt="http://exslt.org/common"
  extension-element-prefixes="exslt">

  <xsl:template match="/MyCoReWebPage[@render-series-panel='true']/section" priority="10">
    <xsl:variable name="enriched-section">
      <div class="row detail_row">
        <div class="col-xs-12 col-sm-8" id="main_col">
          <xsl:apply-templates select="node()[not(self::head)]"/>
        </div>
        <div class="col-xs-12 col-sm-4" id="aux_col">
          <series-panel />
        </div>
      </div>
    </xsl:variable>

    <section>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="head/node()"/>
      <xsl:apply-templates select="exslt:node-set($enriched-section)/node()"/>
    </section>
  </xsl:template>

</xsl:stylesheet>
