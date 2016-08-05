require 'rails_helper'

RSpec.describe Video, :type => :model do

  describe "validation" do
    let(:video) { Video.new(params) }
    let(:video_id) { "DeGkiItB9d8" }
    let(:title) { "欅坂46 『サイレントマジョリティー』" }
    let(:duration) { 266 }
    let(:upload_date) { "20160315" }
    let(:file_size) { 4392011 }
    let(:thumbnail_url) { "https://i.ytimg.com/vi/DeGkiItB9d8/hqdefault.jpg" }
    let(:params) {
      { video_id: video_id, title: title, duration: duration, upload_date: upload_date, file_size: file_size, thumbnail_url: thumbnail_url }
    }

    describe "when video_id is missing" do
      let(:video_id) { "" }
      it { expect(video).not_to be_valid }
    end

    describe "when title is missing" do
      let(:title) { "" }
      it { expect(video).not_to be_valid }
    end

    describe "when upload_date is zero" do
      let(:upload_date) { "20160631" }
      it { expect(video).not_to be_valid }
    end

    describe "when duration is zero" do
      let(:duration) { 0 }
      it { expect(video).not_to be_valid }
    end

    describe "when file_size is zero" do
      let(:file_size) { 0 }
      it { expect(video).not_to be_valid }
    end

  end
end
