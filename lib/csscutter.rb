class CssCutter
  VERSION = '0.0.1'

  attr_reader :output

  def initialize(input)
    @output = input
    remove_whitespace
    remove_comments
    remove_trailing_semicolons
    remove_empty_selectors
    remove_units_after_zero
    replace_zeros
    @output
  end

  private
  def remove_whitespace
    @output.gsub! /\s+/, ' '
    @output.gsub! /\s*\{\s*/, '{'
    @output.gsub! /\s*\}\s*/, '}'
    @output.gsub! /(\S)\s?:\s?(\S)/, '\1:\2'
  end

  def remove_trailing_semicolons
    @output.gsub! ';}', '}'
  end

  def remove_empty_selectors
    @output.gsub! /[^\}]+\{\}/, ''
  end

  def remove_comments
    @output.gsub! /\/\*.*?\*\//, ''
  end

  def remove_units_after_zero
    regex = %r{
      (?<=[:\s])
      0
      (px|em|%|in|cm|mm|ex|pt|pc|ch|rem|vw|vh|vmin|vmax|deg|rad|grad|turn|s|ms)
      (?=[;\s\}])
    }x
    @output.gsub! regex, '0'
  end

  def replace_zeros
    @output.gsub! /:(0 )+0(?=[;\s\}])/, ':0'
  end
end