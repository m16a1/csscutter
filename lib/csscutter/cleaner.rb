class CssCutter::Cleaner < String
  DEFAULT_OPTIONS = {
    keep_important_comments: true
  }

  def initialize(str, options = {})
    @options = DEFAULT_OPTIONS.merge options
    super str
  end

  def method_missing(name, *args)
    allowed_methods = [:remove_whitespace, :remove_trailing_semicolons,
      :remove_empty_selectors, :remove_comments]
    if allowed_methods.include? name
      result = send(name, *args)
      result.instance_variable_set('@options', @options)
      result
    else
      super
    end
  end

  private
  def remove_whitespace
    strip
      .gsub(/\s+/, ' ')
      .gsub(/\s*\{\s*/, '{')
      .gsub(/\s*\}\s*/, '}')
      .gsub(/(\{[^\}]*)(\S)\s*:\s*/, '\1\2:')
  end

  def remove_trailing_semicolons
    gsub /;+}/, '}'
  end

  def remove_empty_selectors
    gsub(/\A[^\{]+\{\s*\}/, '')
    .gsub /\}[^\}]+\{\s*\}/, '}'
  end

  def remove_comments
    if @options[:keep_important_comments]
      gsub /\/\*[^!].*?\*\//, ''
    else
      gsub /\/\*.*?\*\//, ''
    end
  end
end