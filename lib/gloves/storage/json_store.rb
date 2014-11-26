require 'json'
module Gloves
  class Storage
    class JSONStore
      def initialize(location)
        @location = location
      end

      def read(key)
        parsed[key.to_s]
      end

      def write(key, value)
        original = parsed
        if value.nil?
          original.delete(key.to_s)
        else
          original[key.to_s] = value
        end
        file_write(original)
        value
      end

      def file_write(data)
        File.open(location, 'w') { |f| f.write(parse(data)) }
      end
      private :file_write

      def parse(data)
        JSON.generate(data)
      end
      private :parse

      def parsed
        JSON.parse(raw)
      end
      private :parsed

      def raw
        File.read(location)
      end
      private :raw
    end
  end
end
