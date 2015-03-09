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
  end

  # it '#' do
  #   expect(false).to eq(true)
  # end
end
