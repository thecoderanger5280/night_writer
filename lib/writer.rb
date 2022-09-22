require_relative 'braille_writer'

writer = BrailleWriter.new(ARGV)

p writer.output
