require 'spec_helper'
require 'virtus'
require 'guid'
require 'rubygems'

class Person
  include Virtus

  attribute :id, String, :default => Guid.new.to_s
  attribute :first_name
  attribute :last_name

  def full_name
    [first_name, last_name].join(' ')
  end

  def ==(person)
    id == person.id
  end
end

class PeopleTable < SimpleStore::Disk
  def initialize
    super(:people)
  end

  def put(person)
    super(person.attributes)
  end

  def get(id)
    Person.new(super(id))
  end
end

describe 'using as super class for a table' do
  it 'works' do
    person = Person.new
    person.first_name = 'Kris'
    person.last_name = 'Leech'
    table = PeopleTable.new
    table.put person
    table.get(person.id).should == person
  end

end



