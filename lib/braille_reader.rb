require_relative 'braille_dictionary'

class BrailleReader < BrailleDictionary
  attr_reader :read_file,
              :write_file
  def initialize(files)
    @read_file = files[0]
    @write_file = files[1]
    @braille_file = File.open(@read_file, "r").readlines
    @original_message_file = File.open(@write_file, "w")
  end

  def output
    "Created '#{@write_file}' containing #{original_message_length} characters."
  end

  def original_message_length
    top_line = ""
    middle_line = ""
    bottom_line = ""
    @braille_file.each_with_index do |line, i|
      if((i + 1) % 3 == 0)
        bottom_line << line
      elsif((i + 2) % 3 == 0)
        middle_line << line
      else
        top_line << line
      end
    end
    top_line = top_line.split("\n").join("")
    # require 'pry'; binding.pry
    top_line.length / 2
  end

  def english_converter(braille = @braille_file)
    top_line = ""
    middle_line = ""
    bottom_line = ""
    top_lines = []
    middle_lines = []
    bottom_lines = []
    message = []
    braille.each_with_index do |line, i|
      if((i + 1) % 3 == 0)
        bottom_line << line
      elsif((i + 2) % 3 == 0)
        middle_line << line
      else
        top_line << line
      end
    end
    top_line = top_line.split("\n").join("")
    middle_line = middle_line.split("\n").join("")
    bottom_line = bottom_line.split("\n").join("")
    top_lines = top_line.chars.each_slice(2).map(&:join)
    middle_lines = middle_line.chars.each_slice(2).map(&:join)
    bottom_lines = bottom_line.chars.each_slice(2).map(&:join)
    # require 'pry'; binding.pry
    top_lines.each_with_index do |_, i|
      char = []
      char << top_lines[i]
      char << middle_lines[i]
      char << bottom_lines[i]
      message << char
    end
    english_dictionary = {}
    braille_dictionary.each do |letter, braille|
      english_dictionary[braille.flatten] = letter
    end
    # require 'pry'; binding.pry
    # english_dictionary = english_dictionary.invert
    str = ""
    message = message.map do |letter|
      english_dictionary[letter]
    end
    # require 'pry'; binding.pry
    # message.flatten
    message.each do |letter|
      # require 'pry'; binding.pry
      str << letter
    end
    str
    @original_message_file.write(str)
    # require 'pry'; binding.pry
  end
end