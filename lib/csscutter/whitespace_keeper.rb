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
      @options[:keep_important_comments] ? :save_important_comments: nil
    ].inject(@code) { |result, method| self.send(method,result) if method }
    restore(yield _code)
  end

  private
  def save_contents(code)
    code.gsub(/(?:contents\s*:\s*)(?<quot>[\"\']).*?\k<quot>/) do |match|
      @blocks << match
      "contents:@@#{@blocks.size}@@"
    end
  end

  def save_important_comments(code)
    code.gsub(/\/\*\!.*?\*\//) do |match|
      @blocks << match
      "@@#{@blocks.size}@@"
    end
  end

  def restore(code)
    code.gsub(/@@(\d+)@@/) { |match| @blocks[$1.to_i - 1] }
  end
end