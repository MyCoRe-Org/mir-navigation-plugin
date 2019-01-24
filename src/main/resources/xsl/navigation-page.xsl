<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================== -->
<!-- $Revision$ $Date$ -->
<!-- ============================================== -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation" xmlns:xalan="http://xml.apache.org/xalan"
  exclude-result-prefixes="xalan i18n">

  <xsl:include href="duepublico-series-panel.xsl" />
  <xsl:include href="copynodes.xsl" />

  <xsl:param name="WebApplicationBaseURL" />
  <xsl:param name="MCRObjectID" />
  <xsl:param name="MCRDerivateID" />

  <xsl:template match="/MyCoReWebPage">
    <xsl:copy>
      <xsl:copy-of select="@*" />

      <xsl:apply-templates select="*|text()" />

      <xsl:message>
        -------------------------------
        <xsl:value-of select="$MCRObjectID" />
        //
        <xsl:value-of select="$MCRDerivateID" />
      </xsl:message>

    
      <section xml:lang="all">
        <xsl:apply-templates select="document(concat('notnull:mcrfile:',$MCRDerivateID,'/navigation.xml'))/item"
          mode="seriesLayout">
          <xsl:with-param name="rootID" select="$MCRObjectID" />
        </xsl:apply-templates>
      </section>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>