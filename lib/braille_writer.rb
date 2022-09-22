class BrailleWriter
  attr_reader :read_file,
              :write_file
  def initialize(files)
    @read_file = files[0]
    @write_file = files[1]
    @message_file = File.open(@read_file, "r")
    @braille_file = File.open(@write_file, "w")
  end

  def output
    "Created '#{@write_file}' containing #{read_file_length} characters"
  end

  def read_file_length
    @message_file.read.length
  end
end