require 'forwardable'
require 'set'

module InheritableAccessors
  class InheritableHash
    attr_accessor :__local_values__
    attr_reader   :__parent__
    attr_reader   :__deleted_keys__
    extend Forwardable

    WRITE_METHODS = %w{
      []= initialize merge! store
    }

    DELETE_METHODS = %w{
      delete
    }

    READ_METHODS = %w{
      == [] each each_pair each_value empty? eql? fetch flatten
      has_key? has_value? hash include? index inspect invert key key? keys
      length member? merge pretty_print rehash select size to_a to_h to_s
      value? values }

    def_delegators :@__local_values__, *WRITE_METHODS
    delegate READ_METHODS => :to_hash

    def initialize(prototype=nil)
      @__local_values__ = Hash.new
      @__parent__ = prototype
      @__deleted_keys__ = prototype ? prototype.__deleted_keys__.dup : Set.new
    end

    def delete(key)
      @__deleted_keys__.merge [key]
      __local_values__.delete(key)
    end

    def to_hash
      if !!__parent__
        hash = __parent__.to_hash
        hash.delete_if do |key, _|
          __deleted_keys__.include?(key)
        end
        hash.merge(__local_values__)
      else
        __local_values__.clone
      end
    end

    def inherit_copy
      InheritableHash.new(self)
    end

    alias :initialize_copy :inherit_copy
  end
end
