require 'rails_helper'

RSpec.describe Video, :type => :model do

  describe "validation" do
    let(:video) { FactoryGirl.build(:video) }
    let(:params) {
      { video_id: video_id, title: title, duration: duration, upload_date: upload_date, file_size: file_size, thumbnail_url: thumbnail_url }
    }

    describe "when video_id is missing" do
      before { video.video_id = "" }
      it { expect(video).not_to be_valid }
    end

    describe "when title is missing" do
      before { video.title = "" }
      it { expect(video).not_to be_valid }
    end

    describe "when upload_date is zero" do
      before { video.upload_date = "20160631" }
      it { expect(video).not_to be_valid }
    end

    describe "when duration is zero" do
      before { video.duration = 0 }
      it { expect(video).not_to be_valid }
    end

    describe "when file_size is zero" do
      before { video.file_size = 0 }
      it { expect(video).not_to be_valid }
    end

  end
end
