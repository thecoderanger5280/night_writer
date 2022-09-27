require 'rspec'
require './lib/braille_reader.rb'

RSpec.describe BrailleReader do
  before(:each) do
    @reader = BrailleReader.new(['d2braille.txt', 'doriginal_message.txt'])
    allow(@reader).to receive(:braille_file).and_return(double("braille_file"))
    allow(@reader.braille_file).to receive(:readlines).and_return(["0.0.0.0.0....00.0.0.00\n","00.00.0..0..00.0000..0\n","....0.0.0....00.0.0...\n"])
  end
  
  describe '#initialize' do
    it 'exists' do
      expect(@reader).to be_an_instance_of(BrailleReader)
    end

    it 'has a file path to read from' do
      expect(@reader.read_file).to eq('d2braille.txt')
    end

    it 'has a file path to write to' do
      expect(@reader.write_file).to eq('doriginal_message.txt')
    end
  end

  describe '#output' do
    it 'can output information based on what file paths you gave it' do
      expect(@reader.output).to eq("Created '#{@reader.write_file}' containing #{@reader.original_message_length} characters.")
    end

    it 'can convert multiple braille letters to english' do
      expect(@reader.english_converter(@reader.braille_file.readlines)).to eq("hello world")
    end
  end

  describe '#original_message_length' do
    it 'gets the length of the original message' do
      expect(@reader.original_message_length).to eq(11)
    end
  end
end