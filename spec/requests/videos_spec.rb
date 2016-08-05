require 'rails_helper'

describe 'Videos' do
  describe 'GET /videos/:id' do
    let(:video) { FactoryGirl.create(:video) }

    it 'should success' do
      get video_path(video)
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it "should return model in json format" do
      get video_path(video)
      expect(response.body).to eq video.to_json
    end
  end

  describe "GET /videos/download" do
    let(:video) { FactoryGirl.create(:video) }

    context "when file exists" do
      it 'should send mp3 data' do
        get "/videos/download/#{video.video_id}"
        expect(response.body).to eq IO.binread(File.join(Rails.root, 'tmp', 'cache', 'downloads', video.video_id, "#{video.video_id}.mp3"))
      end
    end

    context "when file not exists" do
      it "should fail" do
        get "/videos/download/hoge"
        expect(response).not_to be_success
        expect(response.status).to eq 404
      end
    end
  end
end
