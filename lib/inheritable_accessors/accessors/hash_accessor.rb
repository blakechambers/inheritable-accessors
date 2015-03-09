module InheritableAccessors
  module HashAccessor
    extend ActiveSupport::Concern

    module ClassMethods
      def inheritable_hash_accessor(name)
        name = name.to_s

        class_eval <<-METHODS
          def self.__local_#{name}__
            @__local_#{name}__ ||= Hash.new
          end

          def self.__#{name}__
            @__#{name}__ ||= begin
              if superclass.respond_to?(:__local_#{name}__)
                superclass.__#{name}__.merge(__local_#{name}__)
              else
                __local_#{name}__
              end
            end
          end
        METHODS
      end
    end

  end
end