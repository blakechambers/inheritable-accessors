require 'forwardable'

module InheritableAccessors
  class InheritableHash < Hash
    attr_accessor :__local_values__
    attr_reader   :__parent__
    extend Forwardable

    WRITE_METHODS = [
      :[]=,
      :initialize,
      :merge!,
      :store
    ]

    READ_METHODS = [
      :==,
      :[],
      :[],
      :each,
      :each,
      :each_pair,
      :each_pair,
      :each_value,
      :empty?,
      :eql?,
      :fetch,
      :flatten,
      :has_key?,
      :has_value?,
      :hash,
      :include?,
      :index,
      :inspect,
      :inspect,
      :invert,
      :key,
      :key?,
      :keys,
      :length,
      :member?,
      :merge,
      :pretty_print,
      :rehash,
      :select,
      :size,
      :to_a,
      :to_h,
      :to_s,
      :value?,
      :values
    ]

    def_delegators :@__local_values__, *WRITE_METHODS
    delegate READ_METHODS => :to_hash

    def initialize(prototype=nil)
      @__local_values__ = Hash.new
      @__parent__ = prototype
    end

    def to_hash
      if !!__parent__
        __parent__.to_hash.merge(__local_values__)
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