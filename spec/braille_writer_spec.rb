require 'rspec'
require './lib/braille_writer.rb'

RSpec.describe BraileWriter do
  describe '#initialize' do
    it 'exists' do
      writer = BraileWriter.new('message.txt', 'braille.txt')

      expect(writer).to be_an_instance_of(BraileWriter)
    end
  end
end