require 'spec_helper'
require 'ruby-prof'

describe CssCutter do
  let(:css_code) { open('./spec/performance/heavy.css').read }
  around(:each) do |example|
    RubyProf.start
    example.run    
    result = RubyProf.stop
    printer = ::RubyProf::GraphPrinter.new result
    printer.print STDOUT, {}
  end
  it 'performance with important comments', performance: true do
    cutter = CssCutter.new
    cutter.optimize css_code
  end

  it 'performance without important comments', performance: true do
    cutter = CssCutter.new keep_important_comments: false
    cutter.optimize css_code
  end
end