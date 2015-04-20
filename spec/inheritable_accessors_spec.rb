require 'spec_helper'

describe InheritableAccessors do
  it 'has a version number' do
    expect(InheritableAccessors::VERSION).not_to be nil
  end

  context "InheritableHash" do
    it 'should not mutate original object' do
      hash = InheritableAccessors::InheritableHash.new
      hash[:foo] = "test"

      copy = hash.inherit_copy

      expect(copy[:foo]).to eq("test")

      copy[:foo] = "bar"
      expect(copy[:foo]).to eq("bar")
      expect(hash[:foo]).to eq("test")

    end

    it "should allow hash#delete" do
      hash = InheritableAccessors::InheritableHash.new
      hash[:foo] = "test"

      copy = hash.inherit_copy
      copy[:bar] = "test"
      copy.delete(:foo)
      copy.delete(:bar)

      expect(copy.to_hash).to_not have_key(:foo)
      expect(copy.to_hash).to_not have_key(:bar)
    end
  end

  context "InheritableSet" do
    it 'should not mutate original object' do
      set = InheritableAccessors::InheritableSet.new
      set << "test"

      copy = set.inherit_copy

      expect(copy).to include("test")

      copy.merge(["this"])
      expect(set).to_not include("this")
      expect(copy).to include("this")

    end
  end

  context "InheritableAccessors::InheritableHashAccessor" do

    it "should inherit from class, then to instance" do

      parent = Class.new do
        include InheritableAccessors::InheritableHashAccessor

        inheritable_hash_accessor :options

        options[:a] = 1
      end

      child  = Class.new(parent) do
        options[:b] = 2
      end

      grandchild  = Class.new(child) do
        options[:c] = 3
      end

      item = grandchild.new
      item.options[:d] = 4

      expect(item.options.to_hash).to eq({a: 1, b: 2, c: 3, d: 4})
    end
  end

  context "InheritableAccessors::InheritableOptionAccessor" do

    it "should accept multiple names, and create multiple accessors" do
      parent = Class.new do
        include InheritableAccessors::InheritableHashAccessor
        include InheritableAccessors::InheritableOptionAccessor

        inheritable_hash_accessor   :request_opts
        inheritable_option_accessor :path, :action, for: :request_opts

        path   "/"
        action "GET"
      end

      expect(parent.path).to eq("/")
      expect(parent.new.path).to eq("/")
      expect(parent.action).to eq("GET")
      expect(parent.new.action).to eq("GET")
    end

    it "should require an inheritable_hash_accessor name as :for in configuration" do
      parent = Class.new do
        include InheritableAccessors::InheritableHashAccessor
        include InheritableAccessors::InheritableOptionAccessor
      end

      expect{
        parent.inheritable_option_accessor :path, for: :invalid_name
      }.to raise_error(ArgumentError)

    end

    context "accessors" do
      it "should save a block and call it in context of the child later" do
        parent = Class.new do
          include InheritableAccessors::InheritableHashAccessor
          include InheritableAccessors::InheritableOptionAccessor

          inheritable_hash_accessor   :request_opts
          inheritable_option_accessor :path, for: :request_opts

          path   { the_path }

        protected

          def the_path
            "/secret_path"
          end

        end

        expect(parent.new.path).to eq("/secret_path")
      end

      it "should memoize block values" do
        parent = Class.new do
          include InheritableAccessors::InheritableHashAccessor
          include InheritableAccessors::InheritableOptionAccessor

          inheritable_hash_accessor   :request_opts
          inheritable_option_accessor :path, for: :request_opts

          path   { secret_path }
        end

        path_expectation = double("path")
        expect_any_instance_of(parent).to receive(:secret_path).once.and_return(path_expectation)

        i = parent.new
        2.times { i.path }
      end

      # it "should raise an error when accessing block values from the class level"
    end

  end
end
