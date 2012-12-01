require 'spec_helper'

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
      data[bucket].fetch(:key)
    end

    private

    def find_key(attributes)
      [:id, :key].each do |key|
        return attributes[key] if !attributes[key].nil?
      end
      raise 'No key found in attributes'
    end

    def data
      $_simple_store_data ||= {}
    end
  end
end

describe SimpleStore::Memory do
  it 'stores hashes using given key' do
    store = SimpleStore::Memory.new(:people)
    person_attributes = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
    store.put person_attributes
    store.get(1).should == person_attributes
  end
end
