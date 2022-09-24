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
      allow(reader).to receive(:original_message_length).and_return(11)

      expect(reader.output).to eq("Created '#{reader.write_file}' containing #{reader.original_message_length} characters.")
    end
  end

  describe '#english converter' do
    it 'can convert a braille letter to english' do
      reader = BrailleReader.new(['braille.txt', 'original_message.txt'])
      allow(reader).to receive(:braille_file).and_return(double("braille_file"))
      allow(reader.braille_file).to receive(:readlines).and_return(["0.\n","00\n","..\n"])

      expect(reader.english_converter(reader.braille_file.readlines)).to eq("h")
    end
  end
end