# SimpleStore

Store buckets of keyed hashes in memory or to disk, useful for testing without a real database.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_store'
```

## Usage

### Memory Store

```ruby
person = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
store = SimpleStore::Memory.new(:people)
store.put(person)

# some seconds later...

store.get(1) # => { ... }
```

### Disk Store

```ruby
person = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
store = SimpleStore::Disk.new(:people)
store.put(person)

# some days later...

store = SimpleStore::Disk.new(:people)
store.get(1) # => { ... }
```

### Example

```ruby
require 'virtus'
require 'guid'

class Person
  include Virtus

  attribute :id, String, :default => Guid.new.to_s
  attribute :first_name
  attribute :last_name

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

describe 'storing a domain object to disk' do
  it 'domain objects can be stored and retrieved from the store' do
    person = Person.new
    person.first_name = 'Kris'
    person.last_name = 'Leech'

    table = PeopleTable.new
    table.put person
    table.get(person.id).should == person
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
