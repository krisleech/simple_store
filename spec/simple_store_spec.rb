require 'spec_helper'

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
