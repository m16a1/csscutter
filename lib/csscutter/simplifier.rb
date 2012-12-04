class CssCutter::Simplifier < String
  def replace_zeros
    gsub /:\s*(0\s+)+0(?=[;\s\}])/, ':0'
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
end