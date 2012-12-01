require 'spec_helper'

describe SimpleStore::Memory do
  let(:store) { SimpleStore::Memory.new(:people) }

  it '#put stores keyed hashes' do
    person_attributes = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
    store.put person_attributes
    store.get(1).should == person_attributes
  end

  it '#get raise RecordNotFound for missing keys' do
    expect { store.get(1) }.to raise_error SimpleStore::RecordNotFound
  end

  it '#put does not persist across instances' do
    person_attributes = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
    store.put person_attributes

    new_store = SimpleStore::Memory.new(:people)
    expect { new_store.get(1) }.to raise_error SimpleStore::RecordNotFound
  end

  it '#destroy_all removes all records' do
    first_person_attributes = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
    second_person_attributes = { :id => 2, :first_name => 'Kris', :last_name => 'Leech' }
    store.put first_person_attributes
    store.put second_person_attributes
    store.destroy_all
    expect { store.get(1) }.to raise_error SimpleStore::RecordNotFound
    expect { store.get(2) }.to raise_error SimpleStore::RecordNotFound
  end

  it '#put stores nested hashes' do
    record = { :id => 1, :name => 'Foobar', :chapters => [ 1,2,3 ], :sections => [{ :name => '1', :color => :red }, { :name => '2', :color => :green } ] }
    store.put record
    store.get(1).should == record
  end
end
