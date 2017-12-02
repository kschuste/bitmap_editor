class BitmapEditor

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    grid = nil

    File.open(file).each do |line|
      line = line.chomp
      commands = line.split
      case commands[0]
        when 'S'
          grid.each do |row|
            rowValue = ''
            row.each do |value|
              rowValue += value
            end
            puts rowValue
          end
        when 'I'
          if commands.length != 3
            puts 'invalid initialize command'
            next
          end
          rows = commands[1].to_i
          columns = commands[2].to_i
          if (isValidCoordinate(rows) && isValidCoordinate(columns))
            grid = Array.new(columns){Array.new(rows, 'O')}
          end
        when 'L'
          if commands.length != 4
            puts 'invalid color pixel command'
            next
          end
          row = commands[1].to_i
          column = commands[2].to_i
          if (isValidCoordinate(row) && isValidCoordinate(column))
            color = commands[3]
            if row <= grid.length && column <= grid[row - 1].length
              grid[column - 1][row - 1] = color
            end
          end
        when 'V'
          if commands.length != 5
            puts 'invalid vertical color pixel command'
            next
          end
          column = commands[1].to_i
          row1 = commands[2].to_i
          row2 = commands[3].to_i
          color = commands[4]
          if (isValidCoordinate(column) && isValidCoordinate(row1) && isValidCoordinate(row2))
            while row1 <= row2 && row1 <= grid.length do
              grid[row1 - 1][column - 1] = color
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
          if (isValidCoordinate(column1) && isValidCoordinate(column2) && isValidCoordinate(row))
            while column1 <= column2 && column1 <= grid[row].length do
              grid[row - 1][column1 - 1] = color
              column1 = column1 + 1
            end
          end
        when 'C'
          rows = grid.length
          columns = grid[0].length
          grid = Array.new(columns){Array.new(rows, 'O')}
        else
          puts 'unrecognised command :('
      end
    end
  end

  def isValidCoordinate(coordinate)
    if (coordinate >= 1 && coordinate <= 250)
      return true
    end
    return false
  end
end
