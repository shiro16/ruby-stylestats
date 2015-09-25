class StyleStats
  class Configuration
    def options
      @options ||= {
        stylesheets:                   true,
        paths:                         true,
        stylesheets:                   true,
        styleElements:                 true,
        size:                          true,
        dataUriSize:                   true,
        ratioOfDataUriSize:            true,
        gzippedSize:                   true,
        simplicity:                    true,
        rules:                         true,
        selectors:                     true,
        declarations:                  true,
        averageOfIdentifier:           true,
        mostIdentifier:                true,
        mostIdentifierSelector:        true,
        averageOfCohesion:             true,
        lowestCohesion:                true,
        lowestCohesionSelector:        true,
        totalUniqueFontSizes:          true,
        uniqueFontSizes:               true,
        totalUniqueFontFamilies:       true,
        uniqueFontFamilies:            true,
        totalUniqueColors:             true,
        uniqueColors:                  true,
        idSelectors:                   true,
        universalSelectors:            true,
        unqualifiedAttributeSelectors: true,
        javascriptSpecificSelectors:   "[#\\.]js\\-",
        userSpecifiedSelectors:        false,
        importantKeywords:             true,
        floatProperties:               true,
        mediaQueries:                  true,
        propertiesCount:               10,
        requestOptions:                {}
      }
    end
  end
end
