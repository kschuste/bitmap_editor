require 'spec_helper'
require './lib/bitmap_editor'

describe BitmapEditor do
  describe '#run' do
    bmp = BitmapEditor.new

    describe '#color horizontal' do
      before(:each) do
        # create new instance for each test
        bmp = BitmapEditor.new
        bmp.run('spec/test_files/create/create_command.txt')
      end

      it 'throws exception when bitmap has not been initialized' do
        bmp.bitmap = nil
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_command.txt') }.to raise_error(ArgumentError, "uninitialized bitmap")
      end

      it 'throws exception with invalid number of color horizontal commands' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_invalid_command_count.txt') }.to raise_error(ArgumentError, "invalid command count")
      end

      it 'throws exception with an alpha row param' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_alpha_row.txt') }.to raise_error(ArgumentError, "non-numeric command provided")
      end

      it 'throws exception with an alpha begin column index param' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_alpha_begin_column.txt') }.to raise_error(ArgumentError, "non-numeric command provided")
      end

      it 'throws exception with an alpha end column index param param' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_alpha_end_column.txt') }.to raise_error(ArgumentError, "non-numeric command provided")
      end

      it 'throws exception with row too small' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_row_small_bounds.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exception with begin column index too small' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_begin_column_small_bounds.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exception with end column index too small' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_end_column_small_bounds.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exception with row too large' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_row_large_bounds.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exception with begin column index too large' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_begin_column_large_bounds.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exception with end column index too large' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_end_column_large_bounds.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exception with invalid color param' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_invalid_color.txt') }.to raise_error(ArgumentError, "non-alpha command provided")
      end

      it 'throws exception with begin column index larger than end column index' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_begin_column_greater_than_end_column.txt') }.to raise_error(ArgumentError, "beginning column index larger than ending column index")
      end

      it 'throws exception with row outside bitmap' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_row_outside_bitmap.txt') }.to raise_error(ArgumentError, "coordinates outside bitmap")
      end

      it 'throws exception with begin column outside bitmap' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_begin_column_outside_bitmap.txt') }.to raise_error(ArgumentError, "coordinates outside bitmap")
      end

      it 'throws exception with end column outside bitmap' do
        expect { bmp.run('spec/test_files/color_horizontal/color_horizontal_end_column_outside_bitmap.txt') }.to raise_error(ArgumentError, "coordinates outside bitmap")
      end

      it 'colors the coordinates correctly' do
        bmp.run('spec/test_files/color_horizontal/color_horizontal_command.txt')
        expect(bmp.bitmap[1][2]).to eq('Z')
        expect(bmp.bitmap[1][3]).to eq('Z')
        expect(bmp.bitmap[1][4]).to eq('Z')
        expect(bmp.bitmap[1][1]).to eq('O')
      end
    end
  end
end
