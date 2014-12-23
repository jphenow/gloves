require 'gloves/storage/json_store'
module Gloves
  class Storage
    attr_reader :base_path
    attr_reader :store

    def initialize(base_storage_directory)
      @base_path = base_storage_directory
      @store = JSONStore.new location
    end

    def [](key)
      store.read(key)
    end

    def []=(key, value)
      store.write(key, value)
    end

    def location
      "#{base_path}/data.json"
    end
    private :location
  end
end
