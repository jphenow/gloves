require 'gloves/storage/json_store'
module Gloves
  class Storage
    attr_reader :base_path

    def initialize(alfred)
      @base_path = alfred.storage_path
    end

    def [](key)
      store.read(key)
    end

    def []=(key, value)
      store.write(key, value)
    end

    def store
      @store ||= JSONStore.new location
    end
    private :store

    def location
      "#{base_path}/data.json"
    end
    private :location
  end
end
