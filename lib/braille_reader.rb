class BrailleReader
  attr_reader :read_file,
              :write_file
  def initialize(files)
    @read_file = files[0]
    @write_file = files[1]
    @braille_file = File.open(@read_file, "r").readlines
    @original_message_file = File.open(@write_file, "w")
  end

  def output
    "Created #{@write_file} containing #{original_message_length} characters."
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
end