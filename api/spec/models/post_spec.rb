require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "correct_post" do
    let(:user) { build(:user) }
    let(:post) { build(:post, name: name, content: content, public: false, user: user) }
    let(:name) { "example" }
    let(:content) { "test_post" }
    
    it "投稿が正しく作成されていること" do
      expect(post).to be_valid
    end
  end

  describe "validates length" do
    context "nameの長さが101文字以上の場合" do
      let(:post) { build(:post, name: 'a' * 101) }
      it "エラーになる" do
        post.valid?
        expect(post.errors.messages[:name]).to include "は100文字以内で入力してください"
      end
    end
  end

  describe "validate presence" do
    context "nameがNULLのとき" do
      let(:post) { build(:post, name: nil) }
      it "エラーになる" do
        post.valid?
        expect(post.errors.messages[:name]).to include "を入力してください"
      end
    end

    context "contentがNULLのとき" do
      let(:post) { build(:post, content: nil) }
      it "エラーになる" do
        post.valid?
        expect(post.errors.messages[:content]).to include "を入力してください"
      end
    end

    context "publicがNULLの時" do
      let(:post) { build(:post, public: nil) }
      it "エラーになる" do
        post.valid?
        expect(post.errors.messages[:public]).to include("は一覧にありません")
      end
    end
  end

  describe "validate inclution" do
    context "publicがtrueとfalse以外のとき" do
      let(:post) { build(:post, public: "example") }
      it "defaultでtrueが入る" do
        post.valid?
        expect(post.public).to eq true
      end
    end
  end


  describe "Association" do
    it "Userテーブルに正しく紐付いていること" do
      rel = described_class.reflect_on_association(:user)
      expect(rel.macro).to eq :belongs_to
    end
  end
end
