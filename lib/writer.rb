require_relative 'braille_writer'

writer = BrailleWriter.new(ARGV)

writer.braille_converter
p writer.output

