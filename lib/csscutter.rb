class CssCutter
  VERSION = '0.0.1'

  attr_reader :output

  def initialize(input)
    @output = input
    remove_whitespace
    remove_comments
    @output
  end

  private
  def remove_whitespace
    @output.gsub! /\s+/, ' '
    @output.gsub! /\s*\{\s*/, '{'
    @output.gsub! /\s*\}\s*/, '}'
    @output.gsub! /(\S):\s(\S)/, '\1:\2'
  end

  def remove_comments
    @output.gsub! /\/\*.*?\*\//, ''
  end
end