class BrailleReader
  attr_reader :read_file,
              :write_file
  def initialize(files)
    @read_file = files[0]
    @write_file = files[1]
    @message_file = File.open(@read_file, "r").read
    @braille_file = File.open(@write_file, "w")
  end
end