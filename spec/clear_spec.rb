require 'spec_helper'
require './lib/bitmap_editor'

describe BitmapEditor do
  describe '#run' do
    bmp = BitmapEditor.new

    describe '#clear' do

      before(:each) do
        # create new instance for each test
        bmp = BitmapEditor.new
        bmp.run('spec/test_files/create/create_command.txt')
      end

      it 'throws exception when bitmap has not been initialized' do
        bmp.bitmap = nil
        expect { bmp.run('spec/test_files/clear/clear_command.txt') }.to raise_error(ArgumentError, "uninitialized bitmap")
      end

      it 'clears the colored bitmap' do
        bmp.run('spec/test_files/show/test_inputs.txt')
        bmp.run('spec/test_files/clear/clear_command.txt')

        bmp.bitmap.each do |row|
          rowValue = ''
          row.each do |value|
            expect(value).to eq('O')
          end
        end
      end
    end
  end
end
