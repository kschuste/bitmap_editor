require 'spec_helper'
require './lib/bitmap_editor'

describe BitmapEditor do
  describe '#run' do
    bmp = BitmapEditor.new

    describe '#show' do

      before(:each) do
        # create new instance for each test
        bmp = BitmapEditor.new
        bmp.run('spec/test_files/create/create_command.txt')
      end

      it 'throws exception when bitmap has not been initialized' do
        bmp.bitmap = nil
        expect { bmp.run('spec/test_files/show/show_command.txt') }.to raise_error(ArgumentError, "uninitialized bitmap")
      end

      it 'outputs the empty bitmap' do
        expect(STDOUT).to receive(:puts).with('OOOOO').exactly(10).times
        bmp.run('spec/test_files/show/show_command.txt')
      end

      it 'outputs the colored bitmap' do
        expect(STDOUT).to receive(:puts).with('AOOOW').exactly(1).times
        expect(STDOUT).to receive(:puts).with('ZZZZZ').exactly(1).times
        expect(STDOUT).to receive(:puts).with('OOOOW').exactly(8).times
        bmp.run('spec/test_files/show/test_inputs.txt')
        bmp.run('spec/test_files/show/show_command.txt')
      end
    end
  end
end
