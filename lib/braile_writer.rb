class BraileWriter
  attr_reader :read_file
  def initialize
    read_file = ARGV[0]
  end
end