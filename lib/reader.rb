require_relative 'braille_reader'

reader = BrailleReader.new(ARGV)

reader.english_converter
p reader.output