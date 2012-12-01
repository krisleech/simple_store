# SimpleStore

Store buckets of keyed hashes in memory or to disk, useful for testing without a real database.

## Installation

Add this line to your application's Gemfile:

    gem 'simple_store'

## Usage

### Memory Store

    person = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
    store = SimpleStore::Memory.new(:people)
    store.put(person)

    # some moments later...

    store.get(1) # => { ... }

### Disk Store

    person = { :id => 1, :first_name => 'Kris', :last_name => 'Leech' }
    store = SimpleStore::Disk.new(:people)
    store.put(person)

    # some days later...

    store = SimpleStore::Disk.new(:people)
    store.get(1) # => { ... }

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
