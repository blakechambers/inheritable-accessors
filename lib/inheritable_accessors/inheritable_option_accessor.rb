module InheritableAccessors
  module InheritableOptionAccessor
    extend ActiveSupport::Concern

    module ClassMethods
      def inheritable_option_accessor(*names)
        options = names.pop if names.last.kind_of?(Hash)

        opts_location = options[:for].to_s
        unless respond_to?(opts_location) && send(opts_location).kind_of?(InheritableAccessors::InheritableHash)
          raise ArgumentError, 'requires for: to be kind of InheritableHashAccessor'
        end

        names.each do |name|
          name = name.to_s

          module_eval <<-METHUD, __FILE__, __LINE__
            def #{name}(new_val=nil, &block)
              InheritableAccessors::InheritableOptionAccessor.__inheritable_option(self, #{opts_location}, :#{name}, new_val, &block)
            end

            def self.#{name}(new_val=nil, &block)
              InheritableAccessors::InheritableOptionAccessor.__inheritable_option(self, #{opts_location}, :#{name}, new_val, &block)
            end
          METHUD
        end

      end

    end

    class LetOption
      attr_reader :block

      def initialize(block)
        @block = block
        @memoized = {}
      end

      def with_context(context)
        @memoized[context] ||= begin
          context.instance_exec(&block)
        end
      end
    end

    def self.__inheritable_option(context, options_hash, name, value, &block)
      if value
        options_hash[name] = value
      elsif block_given?
        options_hash[name] = InheritableOptionAccessor::LetOption.new(block)
      else
        options_hash[name].instance_of?(InheritableOptionAccessor::LetOption) ? options_hash[name].with_context(context) : options_hash[name]
      end
    end

  end
end
