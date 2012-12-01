require "simple_store/version"
require "simple_store/memory"
require "simple_store/disk"

module SimpleStore
  class RecordNotFound < StandardError; end
end
