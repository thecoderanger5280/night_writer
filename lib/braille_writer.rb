require_relative 'braille_dictionary'

class BrailleWriter < BrailleDictionary
  attr_reader :read_file,
              :write_file
  def initialize(files)
    @read_file = files[0]
    @write_file = files[1]
    @message_file = File.open(@read_file, "r")
    @braille_file = File.open(@write_file, "w")
    @read_file_length = @message_file.read.length
  end

  def output
    "Created '#{@write_file}' containing #{@read_file_length} characters"
  end

  def braille_converter(message)
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
    if(top_line.length > 80)
      top_lines = top_line.scan(/.{80}/)
      middle_lines = middle_line.scan(/.{80}/)
      bottom_lines = bottom_line.scan(/.{80}/)
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
    str
  end
end