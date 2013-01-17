class CssCutter::Cleaner < String
  def remove_whitespace
    strip
      .remove_repeated
      .remove_around_curly_brackets
      .remove_between_property_and_value
      .remove_in_selectors
      .remove_around_other_brackets
      .remove_in_attribute_selectors
  end

  def remove_trailing_semicolons
    gsub /;+}/, '}'
  end

  def remove_empty_selectors
    gsub(/\A[^\{]+\{\s*\}/, '')
    .gsub /\}[^\}]+\{\s*\}/, '}'
  end

  def remove_comments
    gsub /\/\*.*?\*\//, ''
  end

  def remove_repeated
    gsub(/\s+/, ' ')
  end

  def remove_around_curly_brackets
    gsub(/\s*\{\s*/, '{')
      .gsub(/\s*\}\s*/, '}')
  end

  def remove_between_property_and_value
    gsub(/(?:^|\})[^\{:]+\s+:+[^\{]*\{/) { |m| m.gsub ':', '_COLON_' }
      .gsub(/\s?:\s?/, ':')
      .gsub('_COLON_', ':')
  end

  def remove_around_other_brackets
    gsub(/([\(\[]) /, '\1')
      .gsub(/ ([\)\]])/, '\1')
  end

  def remove_in_selectors
    gsub(/\s?([,;=\+\>~])\s?/, '\1')
  end

  def remove_in_attribute_selectors
    gsub(/ ([\~\$\*\|\^])=/, '\1=')
  end
end