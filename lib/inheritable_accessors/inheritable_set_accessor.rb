module InheritableAccessors
  module InheritableSetAccessor
    extend ActiveSupport::Concern

    module ClassMethods
      def inheritable_set_accessor(name)
        name = name.to_s

        module_eval <<-METHODS
          def self.inheritable_set?
            true
          end

          def self.#{name}
            @__#{name}__ ||= begin
              if superclass.respond_to?(:inheritable_set?)
                superclass.#{name}.inherit_copy
              else
                ::InheritableAccessors::InheritableSet.new
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