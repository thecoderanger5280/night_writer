class BrailleWriter
  attr_reader :read_file,
              :write_file
  def initialize(files)
    @read_file = files[0]
    @write_file = files[1]
  end
end