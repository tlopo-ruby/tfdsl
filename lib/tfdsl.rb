require 'tfdsl/version'
require 'yaml'
require 'erb'

# Terraform DSL
module TFDSL
  module_function

  LIB_DIR = "#{__dir__}/tfdsl/".freeze

  require "#{LIB_DIR}/template"
  require "#{LIB_DIR}/formatter"
  require "#{LIB_DIR}/block"
  require "#{LIB_DIR}/resource"
  require "#{LIB_DIR}/variable"
  require "#{LIB_DIR}/output"
  require "#{LIB_DIR}/data_source"
  require "#{LIB_DIR}/provider"
  require "#{LIB_DIR}/tfmodule"
  require "#{LIB_DIR}/locals"
  require "#{LIB_DIR}/terraform"
  require "#{LIB_DIR}/stack"

  def stack(&block)
    Stack.new do
      instance_eval(&block) if block_given?
    end
  end
end
