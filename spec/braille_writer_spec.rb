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

  describe '#output' do
    it 'outputs information based on what file paths you gave it' do
      writer = BrailleWriter.new(['message.txt', 'braille.txt'])
      allow(writer).to receive(:read_file_length).and_return(60)

      expect(writer.output).to eq("Created '#{writer.write_file}' containing #{writer.read_file_length} characters.")
    end
  end

  describe '#braille_converter' do
    it 'can convert a letter to braille' do
      writer = BrailleWriter.new(['message.txt', 'braille.txt'])
      allow(writer).to receive(:message_file).and_return(double("message_file"))
      allow(writer.message_file).to receive(:read).and_return('h')

      expect(writer.braille_converter(writer.message_file.read)).to eq("0.\n00\n..\n")
      # require 'pry'; binding.pry
    end

    it 'can convert a whole string to braille' do
      writer = BrailleWriter.new(['message.txt', 'braille.txt'])
      allow(writer).to receive(:message_file).and_return(double("message_file"))
      allow(writer.message_file).to receive(:read).and_return('hello world')

      expect(writer.braille_converter(writer.message_file.read)).to eq("0.0.0.0.0....00.0.0.00\n00.00.0..0..00.0000..0\n....0.0.0....00.0.0...\n")
    end
    
    it 'can add a line break at 80 characters' do
      writer = BrailleWriter.new(['message.txt', 'braille.txt'])
      allow(writer).to receive(:message_file).and_return(double("message_file"))
      allow(writer.message_file).to receive(:read).and_return('                                                                                ')

      expect(writer.braille_converter(writer.message_file.read)).to eq("................................................................................\n................................................................................\n................................................................................\n................................................................................\n................................................................................\n................................................................................\n")
    end
  end
end