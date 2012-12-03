class CssCutter::Cleaner < String
  def remove_whitespace
    strip
      .gsub(/\s+/, ' ')
      .gsub(/\s*\{\s*/, '{')
      .gsub(/\s*\}\s*/, '}')
      .gsub(/(\{[^\}]*)(\S)\s?:\s?(\S)/, '\1\2:\3')
  end

  def remove_trailing_semicolons
    gsub /;+}/, '}'
  end

  def remove_empty_selectors
    gsub /[^\}]+\{\s*\}/, ''
  end

  def remove_comments
    gsub /\/\*.*?\*\//, ''
  end

  def remove_units_after_zero
    regex = %r{
      (?<=[:\s])
      0
      (px|em|%|in|cm|mm|ex|pt|pc|ch|rem|vw|vh|vmin|vmax|deg|rad|grad|turn|s|ms)
      (?=[;\s\}])
    }x
    gsub regex, '0'
  end
end