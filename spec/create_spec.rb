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
        expect(bmp.grid.nil?).to eq(true)
      end

      it 'throws exception with invalid number of create commands' do
        expect { bmp.run('spec/test_files/invalid_number_create_command.txt') }.to raise_error(ArgumentError, "invalid initialize command count")
        expect(bmp.grid.nil?).to eq(true)
      end

      it 'throws exception with invalid types of create commands' do
        expect { bmp.run('spec/test_files/invalid_create_commands.txt') }.to raise_error(ArgumentError, "non-numeric command provided")
      end

      it 'initializes the instance with valid params' do
        bmp.run('spec/test_files/create_command.txt')
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

    describe '#color' do

      before(:each) do
        # create new instance for each test
        bmp = BitmapEditor.new
        bmp.run('spec/test_files/create_command.txt')
      end

      describe '#individual' do
        it 'throws exception with invalid number of color individual commands' do
          expect { bmp.run('spec/test_files/invalid_number_color_individual_commands.txt') }.to raise_error(ArgumentError, "invalid color individual command count")
        end

        it 'throws exception with invalid types of color individual commands' do
          expect { bmp.run('spec/test_files/invalid_color_individual_commands.txt') }.to raise_error(ArgumentError, "non-numeric command provided")
        end

        it 'colors the coordinate correctly' do
          bmp.run('spec/test_files/color_individual_command.txt')
          expect(bmp.grid[2][0]).to eq('A')
        end
      end

    end
  end
end
