module TFDSL
  # This will format hash maps, lists and elements in HCL format
  class DataFormatter
    def initialize
      @sio = StringIO.new
      @indent = ' ' * 4
    end

    def format(input, level = 0, last = false, parent_is_list = false)
      if input.class == Hash
        handle_hash input, level, last, parent_is_list
      elsif input.class == Array
        handle_list input, level, last, parent_is_list
      else
        handle_element input, level, last, parent_is_list
      end

      return @sio.string if level.zero?
    end

    def handle_element(input, _level, last, parent_is_list)
      if last
        @sio << %("#{input}"\n)
      elsif parent_is_list
        @sio << %("#{input}",\n)
      else
        @sio << %("#{input}"\n)
      end
    end

    def handle_list(input, level, _last, _parent_is_list)
      @sio << "[\n#{@indent * (level + 1)}"
      input.each_with_index do |e, i|
        if i == input.size - 1
          format e, level + 1, true, true
        else
          format e, level + 1, false, true
        end

        @sio << @indent * (level + 1) unless i == input.size - 1
      end
      @sio << "#{@indent * level}]\n"
    end

    def handle_hash(input, level, last, _parent_is_list)
      @sio << "{\n"
      input.each_with_index do |e, i|
        k, v = e
        @sio << "#{@indent * (level + 1)}#{k} = "
        if i == input.size - 1
          format v, level + 1, true
        else
          format v, level + 1
        end
      end
      if last || level.zero?
        @sio << @indent * level + "}\n"
      else
        @sio << @indent * level + "},\n"
      end
    end
  end
end
