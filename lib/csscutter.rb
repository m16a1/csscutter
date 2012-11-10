class CssCutter
  VERSION = '0.0.1'

  attr_reader :output

  def initialize(input)
    @output = input
    remove_comments
    @output
  end

  private
  def remove_comments
    @output.gsub! /\/\*.*?\*\//, ''
  end
end