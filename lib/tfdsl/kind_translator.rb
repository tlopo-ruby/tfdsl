module TFDSL
  # Translates Class names into terraform block types
  module KindTranslator
    module_function

    def kind(cls)
      kinds = {
        Provider => 'provider',
        TFModule => 'module',
        Locals => 'locals',
        Resource => 'resource',
        Variable => 'variable',
        DataSource => 'data',
        Output => 'output',
        Terraform => 'terraform'
      }
      kinds[cls]
    end
  end
end
