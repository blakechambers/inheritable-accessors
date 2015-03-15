require 'set'

module InheritableAccessors
  class InheritableSet
    attr_accessor :__local_values__
    attr_reader   :__parent__
    extend Forwardable

    WRITE_METHODS = %w{
      << add add? merge
    }

    REMOVE_METHODS = %w{
      clear delete delete? delete_if keep_if reject! replace select!
    }

    READ_METHODS = %w{
      & - < <= == > >= [] ^ classify difference disjoint? each empty? flatten
      include? inspect intersect? intersection length new proper_subset?
      proper_superset? size subset? subtract superset? to_a |
    }

    def_delegators :@__local_values__, *WRITE_METHODS
    delegate READ_METHODS => :to_set

    def initialize(prototype=nil)
      @__local_values__ = Set.new
      @__parent__ = prototype
    end

    def to_set
      if !!__parent__
        __parent__.to_set | __local_values__
      else
        __local_values__.clone
      end
    end

    def inherit_copy
      InheritableSet.new(self)
    end

    alias :initialize_clone :inherit_copy
    alias :initialize_dup   :inherit_copy
  end
end