class CssCutter::Simplifier < String
  def replace_zeros
    gsub /(?<!background-position)\s*:\s*(0\s+)+0(?=[;\s\}])/, ':0'
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

  def convert_rgb_to_hex
    gsub /rgb\s*\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)/ do |match|
      '#' + dec_to_hex($1) + dec_to_hex($2) + dec_to_hex($3)
    end
  end

  def minify_hex
    gsub /\#(\h)\1(\h)\2(\h)\3/, '#\1\2\3'
  end

  def minify_floats
    gsub /(\s|:)0.(\d)/, '\1.\2'
  end

  def replace_none_value_with_zero
    gsub /((\{|;)\s*\w+\s*):(\s*)none(\s*(;|\}))/, '\1:\30\4'
  end

  private
  def dec_to_hex(number)
    "%02x" % number.to_i
  end
end