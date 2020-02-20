require 'test_helper'
class TFDSL::FormatterTest < Minitest::Test
  def test_stack_composition
    stack_hcl = File.read("#{DATA_DIR}/stack.hcl").strip
    stack_json = File.read("#{DATA_DIR}/stack.json").strip

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
        provisioner 'local-exec' do
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

      resource 'local_file', 'foo' do
        content <<-EOJSON.gsub(/^ {8}/, '')
        {
            "key1" : "value",
            "ke2": 1
        }
        EOJSON
        filename '/tmp/foo'
      end
    end
    File.write '/tmp/1.hcl', stack.to_s.strip
    File.write '/tmp/1.json', stack.to_json.strip
    assert_equal stack_hcl, stack.to_s.strip
    assert_equal stack_json, stack.to_json.strip
  end
end
