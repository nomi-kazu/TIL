require "rails_helper"

RSpec.describe User, type: :model do
  describe "validates presence" do
    context "全カラムの値を指定しているとき" do
      let!(:user) { create(:user) }
      it "userレコードが作成される" do
        expect(user).to be_valid
      end
    end

    context "emailを指定していないとき" do
      let!(:user) { build(:user, email: nil) }
      it "エラーになる" do
        user.valid?
        expect(user.errors.messages[:email]).to include "can't be blank"
      end
    end

    context "passwordを指定していないとき" do
      let!(:user) { build(:user, password: nil) }
      it "エラーになる" do
        user.valid?
        expect(user.errors.messages[:password]).to include "can't be blank"
      end
    end
  end

  describe "validates uniqueness" do
    context "保存されているメールアドレスが再度指定されたとき" do
      let!(:user1) { create(:user) }
      let!(:user2) { build(:user, email: user1.email) }
      it "エラーになる" do
        user2.valid?
        expect(user2.errors.messages[:email]).to include "has already been taken"
      end
    end

    context "保存されているusernameが再度指定されたとき" do
      let!(:user1) { create(:user) }
      let!(:user2) { build(:user, username: user1.username) }

      it "エラーになる" do
        user2.valid?
        expect(user2.errors.messages[:username]).to include "has already been taken"
      end
    end
  end

  describe "validates length" do
    context "パスワードが８文字未満の場合" do
      let!(:user) { build(:user, password: "12345") }
      it "エラーになる" do
        user.valid?
        expect(user.errors.messages[:password]).to include "is too short (minimum is 8 characters)"
      end
    end

    context "nameが51文字以上のとき" do
      let!(:user) { build(:user, name: "a" * 51) }
      it "エラーになる" do
        user.valid?
        expect(user.errors.messages[:name]).to include "is too long (maximum is 50 characters)"
      end
    end

    context "addressが31文字以上のとき" do
      let!(:user) { build(:user, address: "a" * 31) }

      it "エラーになる" do
        user.valid?
        expect(user.errors.messages[:address]).to include "is too long (maximum is 30 characters)"
      end
    end

    context "usernameが31文字以上のとき" do
      let!(:user) { build(:user, username: "a" * 31) }
      it "エラーになる" do
        user.valid?
        expect(user.errors.messages[:username]).to include "is too long (maximum is 30 characters)"
      end
    end
  end

  describe "validates regular expression" do
    context "passwordが半角英数字とアンダーバーのみのとき" do
      let!(:user) { build(:user, password: 'pass_word') }
      it "正常に保存できる" do
        expect(user).to be_valid
      end
    end

    context "passwordが半角英数字とアンダーバー以外を含むとき" do
      let!(:user) { build(:user, password: 'a' * 7 + 'あ') }
      it "エラーになる" do
        user.valid?
        expect(user.errors.messages[:password]).to include "is invalid"
      end
    end

    context "usernameが半角英数字とアンダーバーのみのとき" do
      let!(:user) { create(:user) }
      it "正常に更新できる" do
        user.update(username: 'user_name')
        expect(user).to be_valid
      end
    end

    context "usernameが半角英数字とアンダーバー以外を含むとき" do
      let!(:user) { create(:user) }
      it "エラーになる" do
        user.update(username: 'a' * 7 + 'あ')
        expect(user.errors.messages[:username]).to include "is invalid"
      end
    end
  end
end