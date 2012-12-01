require 'spec_helper'

module SimpleStore
  class RecordNotFound < StandardError; end

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

describe SimpleStore::Memory do
  it 'stores hashes using given key' do
    store = SimpleStore::Memory.new(:people)
    person_attributes = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
    store.put person_attributes
    store.get(1).should == person_attributes
  end

  it 'raise RecordNotFound for missing records' do
    store = SimpleStore::Memory.new(:people)
    expect { store.get(1) }.to raise_error SimpleStore::RecordNotFound
  end

  it 'does not persist across instances' do
    store = SimpleStore::Memory.new(:people)
    person_attributes = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
    store.put person_attributes

    new_store = SimpleStore::Memory.new(:people)
    expect { new_store.get(1) }.to raise_error SimpleStore::RecordNotFound
  end
end
