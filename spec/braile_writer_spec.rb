require 'rspec'
require './lib/braile_writer.rb'

RSpec.describe BraileWriter do
  describe '#initialize' do
    it 'exists' do
      writer = BraileWriter.new

      expect(writer).to be_an_instance_of(BraileWriter)
    end
  end
end