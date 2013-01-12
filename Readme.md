# csscutter# [![Build Status](https://travis-ci.org/m16a1/csscutter.png)](https://travis-ci.org/m16a1/csscutter)
Ruby CSS minifier inspired by cssmin.

## Examples of usage
```ruby
cutter = CssCutter.new
cutter.optimize('a {color: red;}')
# >> "a{color:red}"
```