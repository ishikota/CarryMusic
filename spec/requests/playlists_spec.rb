require 'rails_helper'

describe 'Playlists' do

  describe "GET /playlists/:playlist_id" do
    let(:playlist_id) { "playlist_id" }

    context "when valid playlist_id is passed" do
      let(:playlist_info) { JSON.parse(File.read(File.join(Rails.root, 'spec', 'requests', 'playlist_info_sample.json'))) }
      let(:succ_response) do
        { :success => true, :info => playlist_info }
      end
      before do
        allow_any_instance_of(PlaylistsHelper).to receive(:fetch_playlist_info).and_return succ_response
      end

      it "should return playlist info in json format" do
        get playlist_path(playlist_id)
        json = JSON.parse(response.body)
        expect(response).to be_success
        expect(response.status).to eq 200
        expect(json["info"].size).to eq 2
        expect(json["info"].first["id"]).to eq "OPWPa-HMpj8"
        expect(json["info"].first["title"]).to eq "[Official Video] Rather Be - Pentatonix (Clean Bandit Cover)"
      end
    end

    context "when download playlist info failed" do
      let(:fail_response) do
        { :success => false, :reason => "hoge" }
      end
      before do
        allow_any_instance_of(PlaylistsHelper).to receive(:fetch_playlist_info).and_return fail_response
      end

      it "should return 500 error" do
        get playlist_path(playlist_id)
        json = JSON.parse(response.body)
        expect(response).not_to be_success
        expect(response.status).to eq 500
        binding.pry
        expect(json["message"]).to eq fail_response[:reason]
      end
    end
  end
end

