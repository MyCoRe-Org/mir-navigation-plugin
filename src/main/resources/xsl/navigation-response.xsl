<!-- ============================================== -->
<!-- $Revision$ $Date$ -->
<!-- ============================================== -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation" xmlns:xalan="http://xml.apache.org/xalan"
  exclude-result-prefixes="xalan i18n">

  <xsl:include href="duepublico-series-panel.xsl" />
  <xsl:include href="copynodes.xsl" />

  <xsl:param name="WebApplicationBaseURL" />

  <xsl:template match="/">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:apply-templates select="*|text()" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>