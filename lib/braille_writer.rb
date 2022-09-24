require_relative 'braille_dictionary'

class BrailleWriter < BrailleDictionary
  attr_reader :read_file,
              :write_file
  def initialize(files)
    @read_file = files[0]
    @write_file = files[1]
    @message_file = File.open(@read_file, "r").read
    @braille_file = File.open(@write_file, "w")
  end

  def output
    "Created '#{@write_file}' containing #{@message_file.length} characters"
  end

  def braille_converter(message = @message_file)
    letters = message.split("")
    braille = letters.map do |letter|
      braille_dictionary[letter].flatten
    end
    top_line = ""
    middle_line = ""
    bottom_line = ""
    braille.each do |letter|
      top_line << letter[0]
      middle_line << letter[1]
      bottom_line << letter[2]
    end
    str = ""
    if(top_line.length >= 80)
      top_lines = top_line.chars.each_slice(80).map(&:join)
      middle_lines = middle_line.chars.each_slice(80).map(&:join)
      bottom_lines = bottom_line.chars.each_slice(80).map(&:join)
      top_lines.each_with_index do |_, i|
        str << top_lines[i]
        str << "\n"
        str << middle_lines[i]
        str << "\n"
        str << bottom_lines[i]
        str << "\n"
      end
    else
      str = "#{top_line}\n#{middle_line}\n#{bottom_line}\n"
    end
    @braille_file.write(str)
    str
  end
end