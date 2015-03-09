require 'forwardable'

module InheritableAccessors
  class InheritableHash < Hash
    attr_accessor :__local_values__
    attr_reader   :__parent__
    extend Forwardable

    WRITE_METHODS = [
      :[]=,
      :merge!,
      :initialize
    ]

    READ_METHODS = [
      :inspect,
      :each,
      :each_pair,
      :merge,
      :[]
    ]

    def_delegators :@__local_values__, *WRITE_METHODS
    delegate READ_METHODS => :to_hash

    def initialize(prototype=nil)
      @__local_values__ = Hash.new
      @__parent__ = prototype
    end

    def inherited?
      !!__parent__
    end

    def to_hash
      if inherited?
        __parent__.to_hash.merge(__local_values__)
      else
        __local_values__.clone
      end
    end

    def inherit_copy
      InheritableHash.new(self)
    end
  end
end

IHash = InheritableAccessors::InheritableHash