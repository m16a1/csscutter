class CssCutter::Cleaner < String
  def remove_whitespace
    strip
      .gsub(/\s+/, ' ')
      .gsub(/\s*\{\s*/, '{')
      .gsub(/\s*\}\s*/, '}')
      .gsub(/(\S+)\s*:\s*([^\{\};]+?)(?=[\};])/, '\1:\2')
      .gsub(/(\([^\)]*)(\S)\s*:\s*/, '\1\2:')
      .gsub(/\s*([,;])\s*/, '\1')
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
end