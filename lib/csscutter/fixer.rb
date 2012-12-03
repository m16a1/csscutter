class CssCutter::Fixer < String
  def add_missing_semicolons
    gsub /(\{[^\}]+)(\s+)(\S+)\s*:/, '\1;\2\3:'
  end
end