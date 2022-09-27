require_relative 'braille_dictionary'

class BrailleReader < BrailleDictionary
  attr_reader :read_file,
              :write_file
  def initialize(files)
    @read_file = files[0]
    @write_file = files[1]
    @braille_file = File.open(@read_file, "r").readlines
    @original_message_file = File.open(@write_file, "w")
    @top_line = ""
    @middle_line = ""
    @bottom_line = ""
    @top_lines = []
    @middle_lines = []
    @bottom_lines = []
    @str = ""
    @message = []
  end

  def output
    "Created '#{@write_file}' containing #{original_message_length} characters."
  end

  def original_message_length
    bottom_line = ""
    @braille_file.each_with_index do |line, i|
      if((i + 1) % 3 == 0)
        bottom_line << line
      end
    end
    bottom_line = bottom_line.split("\n").join("")
    bottom_line.length / 2
  end

  def split_braille
    english_dictionary = invert_dictionary
    @top_line = @top_line.split("\n").join
    @middle_line = @middle_line.split("\n").join
    @bottom_line = @bottom_line.split("\n").join
    @top_lines = @top_line.chars.each_slice(2).map(&:join)
    @middle_lines = @middle_line.chars.each_slice(2).map(&:join)
    @bottom_lines = @bottom_line.chars.each_slice(2).map(&:join)
  end

  def invert_dictionary
    english_dictionary = {}
    braille_dictionary.each do |letter, braille|
      english_dictionary[braille.flatten] = letter
    end
    english_dictionary
  end

  def write_to_file
    english_dictionary = invert_dictionary
    @top_lines.each_with_index do |_, i|
      char = []
      char << @top_lines[i]
      char << @middle_lines[i]
      char << @bottom_lines[i]
      @message << char
    end
    capital = false
    @message = @message.map do |letter|
      english_letter = []
      if(english_dictionary[letter] != 'shift')
        if(capital == true && english_dictionary[letter] != 'shift')
          english_letter << english_dictionary[letter].upcase
          capital = false
        else
          english_letter << english_dictionary[letter]
        end
      elsif(english_dictionary[letter] == 'shift')
        capital = true
      end
      english_letter
    end
    @message.each do |letter|
      if(letter != nil)
        letter.each { |line| @str << line}
      end
    end
    @original_message_file.write(@str)
  end

  def english_converter(braille = @braille_file)
    braille.each_with_index do |line, i|
      if((i + 1) % 3 == 0)
        @bottom_line << line
      elsif((i + 2) % 3 == 0)
        @middle_line << line
      else
        @top_line << line
      end
    end
    split_braille
    write_to_file
    @str
  end
end