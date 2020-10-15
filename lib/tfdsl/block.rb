module TFDSL
  # This class is the representation of terraform configuration block
  # https://www.terraform.io/docs/configuration/
  class Block
    attr_reader :__type__, :__labels__
    @@formatter = Formatter.new
    def initialize(&block)
      @__blocks__ = []
      instance_eval(&block) if block_given?
    end

    def method_missing(method_name, *args, &block)
      super if [:respond_to_missing?].include? method_name
      return method_missing_handler(method_name, *args, &block)
    end

    def method_missing_handler(method_name, *args, &block)
      method = method_name.to_s.gsub(/=$/, '')

      if block_given?
        r = Block.new
        r.__type__ = method
        r.__labels__ = args
        @__blocks__ << r
        return r.instance_eval(&block)
      end

      return instance_variable_set "@#{method}", *args unless args.empty?
      return instance_variable_get "@#{method}" if args.empty?
    end

    def timeout(*args, &block)
      method_missing_handler :timeout, *args,  &block
    end

    def respond_to_missing?(_method_name, _include_private = true)
      true
    end

    def to_tf
      @@formatter.format self
    end

    def to_str
      to_tf
    end

    def to_s
      to_tf
    end

    def to_json_repr(depth = 0)
      block = { 'tmp' => {} }

      ref = block['tmp']

      labels = __labels__.dup
      labels = [__type__] + labels if !__type__.empty? && depth.zero?

      labels.each do |l|
        ref[l] = {} if ref[l].nil?
        ref = ref[l]
      end

      instance_variables.each do |var|
        var_name = var.to_s.gsub(/^@/, '')
        next if var_name =~ /^__/

        ref[var_name] = send var_name
      end

      __blocks__.each do |b|
        json = b.to_json_repr depth + 1
        if b.__labels__.empty?
          if ref[b.__type__].nil?
            ref[b.__type__] = json
          else
            ref[b.__type__] = [ref[b.__type__], json].flatten
          end
        else
          ref[b.__type__] = [] if ref[b.__type__].nil?
          ref[b.__type__] << json
        end
      end
      block['tmp']
    end
  end
end
