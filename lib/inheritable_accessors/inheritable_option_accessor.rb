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
            def #{name}(new_val=nil)
              if new_val
                #{opts_location}[:#{name}] = new_val
              else
                #{opts_location}[:#{name}]
              end
            end

            def self.#{name}(new_val=nil)
              if new_val
                #{opts_location}[:#{name}] = new_val
              else
                #{opts_location}[:#{name}]
              end
            end
          METHUD
        end

      end
    end

  end
end
