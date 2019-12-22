require 'test_helper'
class TFDSL::FormatterTest < Minitest::Test
  def test_stack_composition
    expected = <<-TEXT.gsub(/^ {4}/, '')
    terraform {
        backend "local" {
            path = "relative/path/to/terraform.tfstate"
        }
    }

    variable "images"  {
        default = {
            us-east-1 = "ami-123456"
            us-east-2 = "ami-654321"
        }
        type = "map"
    }

    variable "foo"  {
    }

    data "aws_ami" "web" {
        filter  {
            name = "state"
            values = [
                "available"
            ]
        }
    }

    resource "null_resource" "foo" {
        triggers  {
            foo = "bar"
        }
        provider "local-exec" {
            command = "whoami"
        }
    }

    module "some_module"  {
        list_of_objects = [
            {
                foo = "bar"
                bar = "foo"
            },
            {
                foo1 = "bar1"
                bar1 = "foo1"
            },
            "somevalue",
            "another value"
        ]
    }

    TEXT
    stack = TFDSL::Stack.new do
      terraform do
        backend 'local' do
          path 'relative/path/to/terraform.tfstate'
        end
      end

      variable 'images' do
        type 'map'
        default(
          'us-east-1': 'ami-123456',
          'us-east-2': 'ami-654321'
        )
      end

      variable 'foo'

      datasource 'aws_ami', 'web' do
        filter do
          name 'state'
          values ['available']
        end
      end

      resource 'null_resource', 'foo' do
        triggers do
          foo 'bar'
        end
        provider 'local-exec' do
          command 'whoami'
        end
      end

      tfmodule 'some_module' do
        list = [
          { 'foo' => 'bar', 'bar' => 'foo' },
          { 'foo1' => 'bar1', 'bar1' => 'foo1' },
          'somevalue',
          'another value'
        ]
        list_of_objects list
      end
    end

    received = stack.to_s
    assert_equal expected, received
  end
end
