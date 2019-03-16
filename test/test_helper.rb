$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'pry'
require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
])

SimpleCov.minimum_coverage 95
SimpleCov.start { add_filter %r{^/test/} }

require 'tfdsl'
require 'tfdsl/formatter'
require 'minitest/autorun'
