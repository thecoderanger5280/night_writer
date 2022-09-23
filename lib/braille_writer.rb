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
      'a' => [
        ['0.'],
        ['..'],
        ['..']
      ],
      'b' => [
        ['0.'],
        ['0.'],
        ['..']
      ],
      'c' => [
        ['00'],
        ['..'],
        ['..']
      ],
      'd' => [
        ['00'],
        ['.0'],
        ['..']
      ],
      'e' => [
        ['0.'],
        ['.0'],
        ['..']
      ],
      'f' => [
        ['00'],
        ['0.'],
        ['..']
      ],
      'g' => [
        ['00'],
        ['00'],
        ['..']
      ],
      'h' => [
        ['0.'],
        ['00'],
        ['..']
      ],
      'i' => [
        ['.0'],
        ['0.'],
        ['..']
      ],
      'j' => [
        ['.0'],
        ['00'],
        ['..']
      ],
      'k' => [
        ['0.'],
        ['..'],
        ['0.']
      ],
      'l' => [
        ['0.'],
        ['0.'],
        ['0.']
      ],
      'm' => [
        ['00'],
        ['..'],
        ['0.']
      ],
      'n' => [
        ['00'],
        ['.0'],
        ['0.']
      ],
      'o' => [
        ['0.'],
        ['.0'],
        ['0.']
      ],
      'p' => [
        ['00'],
        ['0.'],
        ['0.']
      ],
      'q' => [
        ['00'],
        ['00'],
        ['0.']
      ],
      'r' => [
        ['0.'],
        ['00'],
        ['0.']
      ],
      's' => [
        ['.0'],
        ['0.'],
        ['0.']
      ],
      't' => [
        ['.0'],
        ['00'],
        ['0.']
      ],
      'u' => [
        ['0.'],
        ['..'],
        ['00']
      ],
      'v' => [
        ['0.'],
        ['0.'],
        ['00']
      ],
      'w' => [
        ['.0'],
        ['00'],
        ['.0']
      ],
      'x' => [
        ['00'],
        ['..'],
        ['00']
      ],
      'y' => [
        ['00'],
        ['.0'],
        ['00']
      ],
      'z' => [
        ['0.'],
        ['.0'],
        ['00']
      ],
      ' ' => [
        ['..'],
        ['..'],
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
      "#{top_line}\n#{middle_line}\n#{bottom_line}\n"
    end
  end
end