class BrailleWriter
  attr_reader :read_file,
              :write_file
  def initialize(files)
    @read_file = files[0]
    @write_file = files[1]
    @message_file = File.open(@read_file, "r")
    @braille_file = File.open(@write_file, "w")
    @read_file_length = @message_file.read.length
    @braille_dictionary = {
      'h' => [
        ['0.'],
        ['00'],
        ['..']
      ]
    }
  end

  def output
    "Created '#{@write_file}' containing #{@read_file_length} characters"
  end

  def braille_converter(message)
    letters = message.split("")
    braille = letters.map do |letter|
      # require 'pry'; binding.pry
      @braille_dictionary[letter].flatten
    end
    top_line = ""
    middle_line = ""
    bottom_line = ""
    braille.each do |letter|
      top_line << letter[0]
      middle_line << letter[1]
      bottom_line << letter[2]
    end
    require 'pry'; binding.pry
    # "0.\n00\n.."
  end
end