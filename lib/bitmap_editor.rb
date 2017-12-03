class BitmapEditor

  attr_accessor :grid

  def initialize()
    @grid = nil
  end

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)
    
    File.open(file).each do |line|
      line = line.chomp
      commands = line.split
      case commands[0]
        when 'S'
          print()
        when 'I'
          create(commands)
        when 'L'
          color_individual(commands)
        when 'V'
          if commands.length != 5
            puts 'invalid vertical color pixel command'
            next
          end
          column = commands[1].to_i
          row1 = commands[2].to_i
          row2 = commands[3].to_i
          color = commands[4]
          if (isValidCoordinate?(column) && isValidCoordinate?(row1) && isValidCoordinate?(row2))
            while row1 <= row2 && row1 <= @grid.length do
              @grid[row1 - 1][column - 1] = color
              row1 = row1 + 1
            end
          end
        when 'H'
          if commands.length != 5
            puts 'invalid vertical color pixel command'
            next
          end
          column1 = commands[1].to_i
          column2 = commands[2].to_i
          row = commands[3].to_i
          color = commands[4]
          if (isValidCoordinate?(column1) && isValidCoordinate?(column2) && isValidCoordinate?(row))
            while column1 <= column2 && column1 <= @grid[row].length do
              @grid[row - 1][column1 - 1] = color
              column1 = column1 + 1
            end
          end
        when 'C'
          rows = @grid.length
          columns = @grid[0].length
          @grid = Array.new(columns){Array.new(rows, 'O')}
        else
          raise ArgumentError, "unrecognised command"
      end
    end
  end

  def create(commands)
    if commands.length != 3
      raise ArgumentError, "invalid initialize command count"
    end

    unless (isNumericString?(commands[1]) && isNumericString?(commands[2]))
      raise ArgumentError, "non-numeric command provided"
    end

    rows = commands[1].to_i
    columns = commands[2].to_i

    unless (isValidCoordinate?(rows) && isValidCoordinate?(columns))
      raise ArgumentError, "invalid initialize coordinates"
    end

    @grid = Array.new(columns){Array.new(rows, 'O')}
  end

  def color_individual(commands)
    if commands.length != 4
      raise ArgumentError, "invalid color individual command count"
    end

    unless (isNumericString?(commands[1]) && isNumericString?(commands[2]))
      raise ArgumentError, "non-numeric command provided"
    end

    row = commands[1].to_i
    column = commands[2].to_i

    unless (isValidCoordinate?(row) && isValidCoordinate?(column))
      raise ArgumentError, "invalid initialize coordinates"
    end

    color = commands[3]
    if row <= @grid.length && column <= @grid[row - 1].length
      @grid[column - 1][row - 1] = color
    end
  end

  def print()
    @grid.each do |row|
      rowValue = ''
      row.each do |value|
        rowValue += value
      end
      puts rowValue
    end
  end

  private

  def isNumericString?(value)
    true if Integer(value) rescue false
  end

  def isValidCoordinate?(coordinate)
    if (coordinate >= 1 && coordinate <= 250)
      return true
    end
    return false
  end
end
