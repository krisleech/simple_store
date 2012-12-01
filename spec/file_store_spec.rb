require 'spec_helper'

describe SimpleStore::Disk do
  let(:store) { SimpleStore::Disk.new(:people) }

  before(:each) do
    store.destroy_all
  end

  it 'stores hashes using given key' do
    person_attributes = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
    store.put person_attributes
    store.get(1).should == person_attributes
  end

  it 'raise RecordNotFound for missing records' do
    expect { store.get(1) }.to raise_error SimpleStore::RecordNotFound
  end

  it 'does persist across instances' do
    person_attributes = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
    store.put person_attributes

    new_store = SimpleStore::Disk.new(:people)
    expect { new_store.get(1) }.not_to raise_error SimpleStore::RecordNotFound
  end

  it '#destroy_all removes all records' do
    store = SimpleStore::Disk.new(:people)
    first_person_attributes = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
    second_person_attributes = { :id => 2, :first_name => 'Kris', :last_name => 'Leech' }
    store.put first_person_attributes
    store.put second_person_attributes
    store.destroy_all
    expect { store.get(1) }.to raise_error SimpleStore::RecordNotFound
    expect { store.get(2) }.to raise_error SimpleStore::RecordNotFound
  end
end
