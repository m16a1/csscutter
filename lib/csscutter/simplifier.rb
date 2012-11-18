class CssCutter::Simplifier < String
  def replace_zeros
    gsub /:\s*(0\s+)+0(?=[;\s\}])/, ':0'
  end
end