require 'rspec'
require './lib/braile_writer.rb'

RSpec.describe BraileWriter do
  describe '#initialize' do
    it 'exists' do
      writer = BraileWriter.new

      expect(writer).to be_an_instance_of(BraileWriter)
    end

    xit 'has a read file name' do
      writer = BraileWriter.new

      expect(writer.read_file).to be_an_instance_of(String)
    end
  end
end