require 'rails_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  describe 'GET /show' do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }

    it '特定の記事が取得できること' do
      get api_v1_post_path(post.id)
      json = JSON.parse(response.body)
      # responseの可否判定
      expect(response).to have_http_status(:success)
      expect(json['title']).to eq(post.title)
      expect(json['content']).to eq(post.content)
    end
  end
end