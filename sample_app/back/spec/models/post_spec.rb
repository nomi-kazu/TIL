require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  context 'レビュー記事作成' do
    it '各項目が入力済みで成功' do
      expect(post).to be_valid
    end

    it '各項目が未入力で失敗' do
      post.content = ''
      expect(post).to_not be_valid
    end
  end
end
