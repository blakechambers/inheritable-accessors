require "active_support/concern"
require "inheritable_accessors/version"
require "inheritable_accessors/inheritable_hash"
require "inheritable_accessors/inheritable_hash_accessor"
require "inheritable_accessors/inheritable_set"
require "inheritable_accessors/inheritable_set_accessor"
require "inheritable_accessors/inheritable_option_accessor"

module InheritableAccessors
  extend ActiveSupport::Concern
  # include InheritableHashAccessor
  # include InheritableSetAccessor
end
