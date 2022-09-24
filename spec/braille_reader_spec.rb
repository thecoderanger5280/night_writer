require 'rspec'
require './lib/braille_reader.rb'

RSpec.describe BrailleReader do
  describe '#initialize' do
    it 'exists' do
      reader = BrailleReader.new(['braille.txt', 'original_message.txt'])

      expect(reader).to be_an_instance_of(BrailleReader)
    end

    it 'has a file path to read from' do
      reader = BrailleReader.new(['braille.txt', 'original_message.txt'])
      
      expect(reader.read_file).to eq('braille.txt')
    end

    it 'has a file path to write to' do
      reader = BrailleReader.new(['braille.txt', 'original_message.txt'])
      
      expect(reader.write_file).to eq('original_message.txt')
    end
  end

  describe '#output' do
    it 'can output information based on what file paths you gave it' do
      reader = BrailleReader.new(['braille.txt', 'original_message.txt'])
      allow(reader)to receive(:original_message_length).and_return(11)

      expect(reader.output).to eq("Created '#{reader.write_file}' containing #{reader.original_message_length} characters")
    end
  end
end