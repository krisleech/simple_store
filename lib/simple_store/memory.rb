module SimpleStore
  class Memory
    attr_reader :bucket

    def initialize(bucket)
      @bucket = bucket
      data[bucket] ||= {}
    end

    def put(attributes)
      key = find_key(attributes)
      data[bucket][key] = attributes
    end

    def get(key)
      data[bucket].fetch(key) { raise SimpleStore::RecordNotFound, "Record not found with key #{key}"}
    end

    def destroy_all
      data[bucket] = {}
    end

    def to_s
      data.inspect
    end

    private

    def find_key(attributes)
      [:id, :key].each do |key|
        return attributes[key] if !attributes[key].nil?
      end
      raise 'No key found in attributes'
    end

    def data
      @data ||= {}
    end
  end
end

