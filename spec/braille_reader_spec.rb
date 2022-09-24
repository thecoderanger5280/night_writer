require 'rspec'
require './lib/braille_reader.rb'

RSpec.describe BrailleReader do
  describe '#initialize' do
    it 'exists' do
      reader = BrailleReader.new('braille.txt', 'original_message.txt')

      expect(reader).to be_an_instance_of(BrailleReader)
    end

    it 'has a file path to read from' do
      reader = BrailleReader.new('braille.txt', 'original_message.txt')
      
      expect(reader.read_file).to eq('braille.txt')
    end

    it 'has a file path to write to' do
      reader = BrailleReader.new('braille.txt', 'original_message.txt')
      
      expect(reader.write_file).to eq('original_message.txt')
    end
  end
end