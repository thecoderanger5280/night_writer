require 'rspec'
require './lib/braille_writer.rb'

RSpec.describe BrailleWriter do
  describe '#initialize' do
    it 'exists' do
      writer = BrailleWriter.new(['message.txt', 'braille.txt'])

      expect(writer).to be_an_instance_of(BrailleWriter)
    end

    it 'has a file path to read from' do
      writer = BrailleWriter.new(['message.txt', 'braille.txt'])

      expect(writer.read_file).to eq('message.txt')
    end

    it 'has a file path to write to' do
      writer = BrailleWriter.new(['message.txt', 'braille.txt'])

      expect(writer.write_file).to eq('braille.txt')
    end
  end
end