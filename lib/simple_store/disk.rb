module SimpleStore
  class Disk < Memory
    def put(attributes)
      super(attributes)
      write_data
    end

    def get(key)
      load_data
      super(key)
    end

    def destroy_all
      super
      write_data
    end

    private

    def write_data
      serialized_data = YAML.dump(data[bucket])
      File.open(filename, 'w') do |file|
        file.write(serialized_data)
      end
    end

    def load_data
      deserialized_data = YAML.load(File.read(filename))
      data[bucket] = deserialized_data
    end

    def filename
      '/tmp/simple_store.yml'
    end
  end
end
