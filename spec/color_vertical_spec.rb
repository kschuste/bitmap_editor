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

      it 'throws exception with invalid number of color verical commands' do
        expect { bmp.run('spec/test_files/invalid_number_color_vertical_commands.txt') }.to raise_error(ArgumentError, "invalid command count")
      end
    end
  end
end
