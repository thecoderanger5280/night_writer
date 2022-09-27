require_relative 'braille_dictionary'

class BrailleWriter < BrailleDictionary
  attr_reader :read_file,
              :write_file,
              :message_file
  def initialize(files)
    @read_file = files[0]
    @write_file = files[1]
    @message_file = File.open(@read_file, "r").read
    @braille_file = File.open(@write_file, "w")
    @top_lines = ""
    @middle_lines = ""
    @bottom_lines = ""
  end

  def output
    "Created '#{@write_file}' containing #{@message_file.length} characters."
  end

  def braille_converter(message = @message_file)
    letters = message.gsub(/\n/, " ").split('')
    braille = captial_checker(letters)
    braille.each do |letter|
      if(letter.length == 1)
        @top_lines << letter[0][0].join
        @middle_lines << letter[0][1].join
        @bottom_lines << letter[0][2].join
      elsif(letter.length == 2)
        @top_lines << letter[0][0].join
        @top_lines << letter[1][0].join
        @middle_lines << letter[0][1].join
        @middle_lines << letter[1][1].join
        @bottom_lines << letter[0][2].join
        @bottom_lines << letter[1][2].join
      end
    end
    break_line
    write_to_file
  end

  def convert_to_string

  end

  def break_line
    @top_lines = @top_lines.chars.each.each_slice(80).map(&:join)
    @middle_lines = @middle_lines.chars.each.each_slice(80).map(&:join)
    @bottom_lines = @bottom_lines.chars.each_slice(80).map(&:join)
  end

  def write_to_file
    braille_message = ""
    @top_lines.each_with_index do |_, i|
      braille_message << @top_lines[i]
      braille_message << "\n"
      braille_message << @middle_lines[i]
      braille_message << "\n"
      braille_message << @bottom_lines[i]
      braille_message << "\n"
    end
    @braille_file.write(braille_message)
    braille_message
  end

  def captial_checker(letters)
    letters.map do |letter|
      braille_letter = []
      if(letter == " ")
        braille_letter << braille_dictionary[letter]
      elsif(letter == letter.upcase)
        braille_letter << braille_dictionary['shift']
        braille_letter << braille_dictionary[letter.downcase]
      else
        braille_letter << braille_dictionary[letter]
      end
      braille_letter
    end
  end
end