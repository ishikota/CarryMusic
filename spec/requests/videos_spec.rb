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
end
