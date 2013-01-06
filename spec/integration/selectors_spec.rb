require 'spec_helper'

describe 'selectors', integration: true do
  let(:cutter) { CssCutter.new }
  it 'Universal selector' do
    code = <<-CSS
      a {color: red}
      * {
        padding: 0
      }
    CSS
    cutter.optimize(code).should == 'a{color:red}*{padding:0}'
  end
  context 'an element with an attribute' do
    it 'E[foo]' do
      code = <<-CSS
        a {color: red}
        p[ data-z ] {
          padding: 0
        }
      CSS
      cutter.optimize(code).should == 'a{color:red}p[data-z]{padding:0}'
    end
    it 'E[foo="bar"]' do
      code = <<-CSS
        a {color: red}
        p[ dir = "auto" ] {
          padding: 0
        }
      CSS
      cutter.optimize(code).should == 'a{color:red}p[dir="auto"]{padding:0}'
    end
    it 'E[foo~="bar"]' do
      code = <<-CSS
        a {color: red}
        p[ data-z ~= "n" ] {
          padding: 0
        }
      CSS
      cutter.optimize(code).should == 'a{color:red}p[data-z~="n"]{padding:0}'
    end
    it 'E[foo$="bar"]' do
      code = <<-CSS
        a {color: red}
        p[ data-z $= "bar" ] {
          padding: 0
        }
      CSS
      cutter.optimize(code).should == 'a{color:red}p[data-z$="bar"]{padding:0}'
    end
    it 'E[foo*="bar"]' do
      code = <<-CSS
        a {color: red}
        p[ data-z *= "bar" ] {
          padding: 0
        }
      CSS
      cutter.optimize(code).should == 'a{color:red}p[data-z*="bar"]{padding:0}'
    end
    it 'E[foo|="bar"]' do
      code = <<-CSS
        a {color: red}
        p[ data-z |= "bar" ] {
          padding: 0
        }
      CSS
      cutter.optimize(code).should == 'a{color:red}p[data-z|="bar"]{padding:0}'
    end
  end
  context 'pseudo-classes' do
    it 'E:root' do
      code = <<-CSS
        a {color: red}
        html:root {
          padding: 0
        }
      CSS
      cutter.optimize(code).should == 'a{color:red}html:root{padding:0}';
    end
    it 'E:nth-child(n)' do
      code = <<-CSS
        a {color: red}
        p:nth-child( 2 ) {
          padding: 0
        }
      CSS
      cutter.optimize(code).should == 'a{color:red}p:nth-child(2){padding:0}';
    end
    it 'E:nth-child(2n + 1)' do
      code = <<-CSS
        a {color: red}
        p:nth-child( 2n + 1 ) {
          padding: 0
        }
      CSS
      cutter.optimize(code).should == 'a{color:red}p:nth-child(2n+1){padding:0}';
    end
  end
  it 'E::first-line' do
    code = <<-CSS
        a {color: red}
        p::first-line {
          color: blue
        }
    CSS
    cutter.optimize(code).should == 'a{color:red}p::first-line{color:blue}';
  end
  it 'E.class' do
    code = <<-CSS
        a {color: red}
        p.active  .blue {
          color: blue
        }
    CSS
    cutter.optimize(code).should == 'a{color:red}p.active .blue{color:blue}';
  end
  it 'E#id' do
    code = <<-CSS
        a {color: red}
        #content  nav#left {
          color: blue
        }
    CSS
    cutter.optimize(code).should == 'a{color:red}#content nav#left{color:blue}';
  end
  it 'E > F' do
    code = <<-CSS
        a {color: red}
        div > p {
          color: blue
        }
    CSS
    cutter.optimize(code).should == 'a{color:red}div>p{color:blue}';
  end
  it 'E + F' do
    code = <<-CSS
        a {color: red}
        div + p {
          color: blue
        }
    CSS
    cutter.optimize(code).should == 'a{color:red}div+p{color:blue}';
  end
  it 'E ~ F' do
    code = <<-CSS
        a {color: red}
        div ~ p {
          color: blue
        }
    CSS
    cutter.optimize(code).should == 'a{color:red}div~p{color:blue}';
  end
end