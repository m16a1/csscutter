# csscutter
Ruby CSS minifier inspired by cssmin

## Examples of usage
```ruby
cutter = CssCutter.new
cutter.optimize('a {color: red;}')
# >> "a{color:red}"
```