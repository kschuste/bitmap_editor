require 'spec_helper'
require './lib/bitmap_editor'

describe BitmapEditor do
  describe '#run' do
    bmp = BitmapEditor.new

    describe '#create' do

      before(:each) do
        # create new instance for each test
        bmp = BitmapEditor.new
      end

      it 'throws exception with unrecognized command' do
        expect { bmp.run('spec/test_files/unrecognized_command.txt') }.to raise_error(ArgumentError, "unrecognised command")
      end

      it 'throws exception with invalid number of create commands' do
        expect { bmp.run('spec/test_files/create/create_invalid_command_count.txt') }.to raise_error(ArgumentError, "invalid command count")
      end

      it 'throws exception with invalid type of row command' do
        expect { bmp.run('spec/test_files/create/create_invalid_row_command.txt') }.to raise_error(ArgumentError, "non-numeric command provided")
      end

      it 'throws exception with invalid type of column command' do
        expect { bmp.run('spec/test_files/create/create_invalid_row_command.txt') }.to raise_error(ArgumentError, "non-numeric command provided")
      end

      it 'throws exceptions with coordinates too large' do
        expect { bmp.run('spec/test_files/create/create_invalid_large_coordinates.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exceptions with coordinates too small' do
        expect { bmp.run('spec/test_files/create/create_invalid_small_coordinates.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'initializes the instance with valid params' do
        bmp.run('spec/test_files/create/create_command.txt')
        expect(bmp.grid.nil?).to eq(false)
        expect(bmp.grid.length).to eq(10)
        expect(bmp.grid[0].length).to eq(5)

        bmp.grid.each do |column|
          column.each do |row|
            expect(row).to eq('O')
          end
        end
      end
    end
  end
end
