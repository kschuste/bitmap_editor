require 'spec_helper'
require './lib/bitmap_editor'

describe BitmapEditor do
  describe '#run' do
    bmp = BitmapEditor.new

    describe '#color individual' do
      before(:each) do
        # create new instance for each test
        bmp = BitmapEditor.new
        bmp.run('spec/test_files/create/create_command.txt')
      end

      it 'throws exception with invalid number of color individual commands' do
        expect { bmp.run('spec/test_files/color_individual/color_individual_invalid_command_count.txt') }.to raise_error(ArgumentError, "invalid command count")
      end

      it 'throws exception with an alpha row param' do
        expect { bmp.run('spec/test_files/color_individual/color_individual_alpha_row.txt') }.to raise_error(ArgumentError, "non-numeric command provided")
      end

      it 'throws exception with an alpha column param' do
        expect { bmp.run('spec/test_files/color_individual/color_individual_alpha_column.txt') }.to raise_error(ArgumentError, "non-numeric command provided")
      end

      it 'throws exception with row too small' do
        expect { bmp.run('spec/test_files/color_individual/color_individual_row_small_bounds.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exception with column too small' do
        expect { bmp.run('spec/test_files/color_individual/color_individual_column_small_bounds.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exception with invalid color param' do
        expect { bmp.run('spec/test_files/color_individual/color_individual_invalid_color.txt') }.to raise_error(ArgumentError, "non-alpha command provided")
      end

      it 'throws exception with row outside bitmap' do
        expect { bmp.run('spec/test_files/color_individual/color_individual_row_outside_bitmap.txt') }.to raise_error(ArgumentError, "coordinates outside bitmap")
      end

      it 'throws exception with column outside bitmap' do
        expect { bmp.run('spec/test_files/color_individual/color_individual_column_outside_bitmap.txt') }.to raise_error(ArgumentError, "coordinates outside bitmap")
      end

      it 'colors the coordinate correctly' do
        bmp.run('spec/test_files/color_individual/color_individual_command.txt')
        expect(bmp.grid[2][0]).to eq('A')
      end
    end
  end
end
