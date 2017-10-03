require 'spec_helper'

describe KitchenToolkit do

  describe '.profile_files' do
    context 'when config dir dont exist' do
      it 'should return an empty list' do
        expect(KitchenToolkit.profile_files).to eq []
      end
    end

    context 'when config dir exist' do
      it 'should return a list of Kitchen config files' do
        expect(KitchenToolkit).to receive(:profiles_dir).twice.and_return(fixtures('kitchen'))
        expect(KitchenToolkit.profile_files).to be_a(Array)
        expect(KitchenToolkit.profile_files.first).to eq fixtures('kitchen', 'debian.jessie.yml').to_s
      end
    end
  end

  describe '.kitchen_profiles' do
    context 'when config dir dont exist' do
      it 'should return an empty list' do
        expect(KitchenToolkit.kitchen_profiles).to eq []
      end
    end

    context 'when config dir exist' do
      it 'should return a list of Kitchen::Profile objects' do
        expect(KitchenToolkit).to receive(:profiles_dir).twice.and_return(fixtures('kitchen'))
        expect(KitchenToolkit.kitchen_profiles).to be_a(Array)
        expect(KitchenToolkit.kitchen_profiles.first).to be_a(KitchenToolkit::Profile)
      end
    end
  end

end
