class BitmapEditor

  attr_accessor :bitmap

  def initialize()
    @bitmap = nil
  end

  def run(file)
    return raise ArgumentError, "please provide correct file" if file.nil? || !File.exists?(file)
    
    File.open(file).each do |line|
      line = line.chomp
      commands = line.split
      case commands[0]
        when 'S'
          show()
        when 'I'
          create(commands)
        when 'L'
          color_individual(commands)
        when 'V'
          color_vertical(commands)
        when 'H'
          color_horizontal(commands)
        when 'C'
          clear()
        else
          raise ArgumentError, "unrecognised command"
      end
    end
  end

  def create(commands)
    isCommandCountValid?(commands, 3)

    isNumericString?(commands[1])
    isNumericString?(commands[2])

    rows = commands[1].to_i
    columns = commands[2].to_i

    isValidCoordinate?(rows)
    isValidCoordinate?(columns)

    @bitmap = Array.new(columns){Array.new(rows, 'O')}
  end

  def color_individual(commands)
    isBitmapValid?()
    isCommandCountValid?(commands, 4)

    isNumericString?(commands[1])
    isNumericString?(commands[2])

    row = commands[1].to_i
    column = commands[2].to_i

    isValidCoordinate?(row)
    isValidCoordinate?(column)

    color = commands[3]
    isAlphaString?(color)

    if (row > @bitmap.length || column > @bitmap[0].length)
      raise ArgumentError, 'coordinates outside bitmap'
    end

    @bitmap[column - 1][row - 1] = color
  end

  def color_vertical(commands)
    isBitmapValid?()
    isCommandCountValid?(commands, 5)

    isNumericString?(commands[1])
    isNumericString?(commands[2])
    isNumericString?(commands[3])

    column = commands[1].to_i
    row1 = commands[2].to_i
    row2 = commands[3].to_i

    isValidCoordinate?(column)
    isValidCoordinate?(row1)
    isValidCoordinate?(row2)

    color = commands[4]
    isAlphaString?(color)

    if (row1 > row2)
      raise ArgumentError, 'beginning row index larger than ending row index'
    end

    if (row1 > @bitmap.length || row2 > @bitmap.length || column > @bitmap[0].length)
      raise ArgumentError, 'coordinates outside bitmap'
    end

    while row1 <= row2 && row1 <= @bitmap.length do
      @bitmap[row1 - 1][column - 1] = color
      row1 = row1 + 1
    end
  end

  def color_horizontal(commands)
    isBitmapValid?()
    isCommandCountValid?(commands, 5)

    isNumericString?(commands[1])
    isNumericString?(commands[2])
    isNumericString?(commands[3])

    column1 = commands[1].to_i
    column2 = commands[2].to_i
    row = commands[3].to_i

    isValidCoordinate?(column1)
    isValidCoordinate?(column2)
    isValidCoordinate?(row)

    color = commands[4]
    isAlphaString?(color)

    if (column1 > column2)
      raise ArgumentError, 'beginning column index larger than ending column index'
    end

    if (row > @bitmap.length || column1 > @bitmap[0].length || column2 > @bitmap[0].length)
      raise ArgumentError, 'coordinates outside bitmap'
    end

    while column1 <= column2 && column1 <= @bitmap[0].length do
      @bitmap[row - 1][column1 - 1] = color
      column1 = column1 + 1
    end
  end

  def show()
    isBitmapValid?()

    @bitmap.each do |row|
      rowValue = ''
      row.each do |value|
        rowValue += value
      end
      puts rowValue
    end
  end

  def clear()
    isBitmapValid?()
    rows = @bitmap.length
    columns = @bitmap[0].length
    @bitmap = Array.new(columns){Array.new(rows, 'O')}
  end

  private

  def isBitmapValid?
    unless @bitmap
      raise ArgumentError, "uninitialized bitmap"
    end
    return true
  end

  def isCommandCountValid?(commands, expectedCount)
    if commands.length != expectedCount
      raise ArgumentError, "invalid command count"
    end
    return true
  end

  def isAlphaString?(value)
    if value.match(/^[[:alpha:]]+$/)
      return true
    end
    raise ArgumentError, "non-alpha command provided"
  end

  def isNumericString?(value)
    true if Integer(value) rescue raise ArgumentError, "non-numeric command provided"
  end

  def isValidCoordinate?(coordinate)
    if (coordinate >= 1 && coordinate <= 250)
      return true
    end
    raise ArgumentError, "invalid coordinates"
  end
end
