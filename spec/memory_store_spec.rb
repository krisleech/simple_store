require 'spec_helper'

describe SimpleStore::Memory do
  it '#put stores keyed hashes' do
    store = SimpleStore::Memory.new(:people)
    person_attributes = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
    store.put person_attributes
    store.get(1).should == person_attributes
  end

  it '#get raise RecordNotFound for missing keys' do
    store = SimpleStore::Memory.new(:people)
    expect { store.get(1) }.to raise_error SimpleStore::RecordNotFound
  end

  it '#put does not persist across instances' do
    store = SimpleStore::Memory.new(:people)
    person_attributes = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
    store.put person_attributes

    new_store = SimpleStore::Memory.new(:people)
    expect { new_store.get(1) }.to raise_error SimpleStore::RecordNotFound
  end

  it '#destroy_all removes all records' do
    store = SimpleStore::Memory.new(:people)
    first_person_attributes = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
    second_person_attributes = { :id => 2, :first_name => 'Kris', :last_name => 'Leech' }
    store.put first_person_attributes
    store.put second_person_attributes
    store.destroy_all
    expect { store.get(1) }.to raise_error SimpleStore::RecordNotFound
    expect { store.get(2) }.to raise_error SimpleStore::RecordNotFound
  end
end
