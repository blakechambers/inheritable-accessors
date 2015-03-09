module InheritableAccessors
  module InheritableHashAccessor
    extend ActiveSupport::Concern

    module ClassMethods
      def inheritable_hash_accessor(name)
        name = name.to_s

        module_eval <<-METHODS
          def self.inheritable_hash?
            true
          end

          def self.#{name}
            @__#{name}__ ||= begin
              if superclass.respond_to?(:inheritable_hash?)
                superclass.#{name}.inherit_copy
              else
                ::InheritableAccessors::InheritableHash.new
              end
            end
          end

          def #{name}
            @__#{name}__ ||= self.class.#{name}.inherit_copy
          end
        METHODS
      end
    end

  end
end