require 'csscutter/version'
require 'csscutter/fixer'
require 'csscutter/cleaner'
require 'csscutter/simplifier'
require 'csscutter/whitespace_keeper'

class CssCutter
  def initialize(options = {})
    @options = options
  end

  def optimize(code)
    keeper = WhitespaceKeeper.new(code, @options)
    keeper.safely_optimize do |_code|
      [:fix, :clean, :simplify]
        .inject(_code) { |result, method| self.send(method,result) }
    end
  end

  def clean(code)
    Cleaner.new(code)
      .remove_whitespace
      .remove_trailing_semicolons
      .remove_comments
      .remove_empty_selectors
  end

  def simplify(code)
    Simplifier.new(code)
      .remove_units_after_zero
      .replace_zeros
      .convert_rgb_to_hex
      .minify_hex
      .minify_floats
      .replace_none_value_with_zero
  end

  def fix(code)
    Fixer.new(code)
      .add_missing_semicolons
  end
end