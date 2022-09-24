require_relative 'braille_reader'

reader = BrailleReader.new(ARGV)

p reader.output