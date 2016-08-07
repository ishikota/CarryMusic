require 'rails_helper'

describe 'Videos' do
  describe 'GET /videos/:id' do
    let!(:video) { FactoryGirl.create(:video) }
    context "when passed correct video id" do
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

    context "when passed invalid video id" do
      it "should fail" do
        get "/videos/hoge"
        json = JSON.parse(response.body)
        expect(response.status).to eq 404
        expect(json["status"]).to eq 404
      end
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

  describe "POST /videos" do
    let(:params) { { video_id: video_id } }
    let(:succ_response) { { :success => true, :model => video } }

    context "when download success" do
      let(:video) { FactoryGirl.create(:video) }
      before do
        allow_any_instance_of(VideosHelper).to receive(:download_video).and_return succ_response
      end

      let(:video_id) { FactoryGirl.attributes_for(:video)["video_id"] }
      it "should drop video to tmp directory" do
        post videos_path, params: params
        expect(response).to be_success
        expect(response.body).to eq video.to_json
      end
    end

    context "when download failed" do
      let(:video_id) { "invalid_id" }
      let(:error_response) { { :success => false, :reason => "hoge" } }
      before do
        allow_any_instance_of(VideosHelper).to receive(:download_video).and_return error_response
      end

      it "should fail" do
        post videos_path, params: params
        json = JSON.parse(response.body)
        expect(response).not_to be_success
        expect(response.status).to eq 404
        expect(json["status"]).to eq 404
        expect(json["message"]).to eq error_response[:reason]
      end
    end
  end
end
