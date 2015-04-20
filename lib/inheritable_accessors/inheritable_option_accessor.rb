module InheritableAccessors
  module InheritableOptionAccessor
    extend ActiveSupport::Concern

    ##
    # def request_path(new_path=nil, &block)
    #   if new_path
    #     request_opts[:path] = new_path
    #   elsif block_given?
    #     request_opts[:path] = LetOption.new(block)
    #   else
    #     path = request_opts[:path]
    #     path = instance_exec(&path.block) if path.instance_of?(LetOption)
    #
    #     return path if path
    #     raise "You must configure a path"
    #   end
    # end

    module ClassMethods
      def inheritable_option_accessor(*names)
        options = names.pop if names.last.kind_of?(Hash)

        opts_location = options[:for].to_s
        raise ArgumentError, 'requires for: to be kind of InheritableHashAccessor' unless respond_to?(opts_location) && send(opts_location).kind_of?(InheritableAccessors::InheritableHash)

        names.each do |name|
          name = name.to_s

          module_eval <<-METHUD
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
      end
    end

    def self.__inheritable_option(context, options_hash, name, value, &block)
      if value
        options_hash[name] = value
      elsif block_given?
        options_hash[name] = LetOption.new(block)
      else
        options_hash[name].instance_of?(LetOption) ? context.instance_exec(&options_hash[name].block) : options_hash[name]
      end
    end

  end
end
