require 'spec_helper'
require 'ruby-prof'

describe CssCutter do
  it 'performance', performance: true do
    css_code = open('./spec/performance/heavy.css').read
    RubyProf.start
    cutter = CssCutter.new
    cutter.optimize css_code
    result = RubyProf.stop
    printer = ::RubyProf::GraphPrinter.new result
    printer.print STDOUT, {}
  end
end