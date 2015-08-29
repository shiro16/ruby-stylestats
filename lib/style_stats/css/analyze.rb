class StyleStats
  class Css
    def analyze
      selector = sort_selector_by_declarations_count.first
      most_indentifier_selector = selectors.first || StyleStats::Css::Selector.new
      {
        "Published"                       => Time.now,
        "Paths"                           => paths,
        "Style Sheets"                    => stylesheets.count,
        "Style Elements"                  => elements.count,
        "Size"                            => size,
        "Data URI Size"                   => data_uri_size,
        "Ratio of Data URI Size"          => "#{data_uri_size.fdiv(size).round(1) * 100}%",
        "Gzipped Size"                    => gzipped_size,
        "Rules"                           => rules.count,
        "Selectors"                       => selectors.count,
        "Declarations"                    => declarations.count,
        "Simplicity"                      => "#{rules.count.fdiv(selectors.count).round(1) * 100}%",
        "Average of Identifier"           => selectors.map(&:identifier_count).inject(0, :+).fdiv(selectors.count).round(3),
        "Most Identifier"                 => most_indentifier_selector.identifier_count,
        "Most Identifier Selector"        => most_indentifier_selector.name,
        "Average of Cohesion"             => declarations.count.fdiv(rules.count).round(3),
        "Lowest Cohesion"                 => selector.declarations.count,
        "Lowest Cohesion Selector"        => selector.name,
        "Total Unique Font Sizes"         => self["font-size"][:count],
        "Unique Font Sizes"               => self["font-size"][:values],
        "Total Unique Font Families"      => self["font-family"][:count],
        "Unique Font Families"            => self["font-family"][:values],
        "Total Unique Colors"             => self["color"][:count],
        "Unique Colors"                   => self["color"][:values],
        "ID Selectors"                    => selectors_count(:id),
        "Universal Selectors"             => selectors_count(:universal),
        "Unqualified Attribute Selectors" => selectors_count(:unqualified),
        "JavaScript Specific Selectors"   => selectors_count(:js),
        "Important Keywords"              => declarations_count(:important),
        "Float Properties"                => declarations_count(:float),
        "Properties Count"                => aggregate_declaration.declarations.sort { |(_, v1), (_, v2)| v2[:count] <=> v1[:count] }.take(10).map{ |property, declaration| "#{property}: #{declaration[:count]}" },
        "Media Queries"                   => media_types.count
      }
    end
  end
end
