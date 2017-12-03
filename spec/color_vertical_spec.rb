require 'spec_helper'
require './lib/bitmap_editor'

describe BitmapEditor do
  describe '#run' do
    bmp = BitmapEditor.new

    describe '#color vertical' do
      before(:each) do
        # create new instance for each test
        bmp = BitmapEditor.new
        bmp.run('spec/test_files/create/create_command.txt')
      end

      it 'throws exception when bitmap has not been initialized' do
        bmp.bitmap = nil
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_command.txt') }.to raise_error(ArgumentError, "uninitialized bitmap")
      end

      it 'throws exception with invalid number of color vertical commands' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_invalid_command_count.txt') }.to raise_error(ArgumentError, "invalid command count")
      end

      it 'throws exception with an alpha column param' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_alpha_column.txt') }.to raise_error(ArgumentError, "non-numeric command provided")
      end

      it 'throws exception with an alpha begin row index param' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_alpha_begin_row.txt') }.to raise_error(ArgumentError, "non-numeric command provided")
      end

      it 'throws exception with an alpha end row index param param' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_alpha_end_row.txt') }.to raise_error(ArgumentError, "non-numeric command provided")
      end

      it 'throws exception with column too small' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_column_small_bounds.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exception with begin row index too small' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_begin_row_small_bounds.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exception with end row index too small' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_end_row_small_bounds.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exception with column too large' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_column_large_bounds.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exception with begin row index too large' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_begin_row_large_bounds.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exception with end row index too large' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_end_row_large_bounds.txt') }.to raise_error(ArgumentError, "invalid coordinates")
      end

      it 'throws exception with invalid color param' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_invalid_color.txt') }.to raise_error(ArgumentError, "non-alpha command provided")
      end

      it 'throws exception with begin row index larger than end row index' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_begin_row_greater_than_end_row.txt') }.to raise_error(ArgumentError, "beginning row index larger than ending row index")
      end

      it 'throws exception with column outside bitmap' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_column_outside_bitmap.txt') }.to raise_error(ArgumentError, "coordinates outside bitmap")
      end

      it 'throws exception with begin row outside bitmap' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_begin_row_outside_bitmap.txt') }.to raise_error(ArgumentError, "coordinates outside bitmap")
      end

      it 'throws exception with end row outside bitmap' do
        expect { bmp.run('spec/test_files/color_vertical/color_vertical_end_row_outside_bitmap.txt') }.to raise_error(ArgumentError, "coordinates outside bitmap")
      end

      it 'colors the coordinates correctly' do
        bmp.run('spec/test_files/color_vertical/color_vertical_command.txt')
        expect(bmp.bitmap[2][1]).to eq('W')
        expect(bmp.bitmap[3][1]).to eq('W')
        expect(bmp.bitmap[4][1]).to eq('W')
        expect(bmp.bitmap[5][1]).to eq('W')
        expect(bmp.bitmap[1][1]).to eq('O')
        expect(bmp.bitmap[6][1]).to eq('O')
      end
    end
  end
end
