class CssCutter::WhitespaceKeeper
  DEFAULT_OPTIONS = {
    keep_important_comments: true
  }

  def initialize(code, options = {})
    @code = code
    @options = DEFAULT_OPTIONS.merge options
    @blocks = []
  end

  def safely_optimize(&block)
    _code = [
      :save_contents,
      @options[:keep_important_comments] ? :save_important_comments : nil
    ].inject(@code) { |result, method| method ? send(method,result) : result }
    restore(yield _code)
  end

  private
  def save_contents(code)
    code.gsub(/(?<=\Wcontents)(\s*:\s*)([\"\'])(.*?)\2/) do |match|
      @blocks << $2 + $3 + $2
      "#{$1}@@#{@blocks.size}@@"
    end
  end

  def save_important_comments(code)
    code.gsub(/\/\*\!.*?\*\//) do |match|
      @blocks << match
      "@@#{@blocks.size}@@"
    end
  end

  def restore(code)
    result = code.gsub(/@@(\d+)@@/) { |match| @blocks[$1.to_i - 1] }
    result = restore(result) if /@@(\d+)@@/ =~ result
    result
  end
end