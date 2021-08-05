require 'rails_helper'

RSpec.describe "Api::V1::Posts", type: :request do
  describe "GET /api/v1/posts/:id" do
    subject(:call_api){ get "/api/v1/posts/#{post.id}" }

    let(:user) { create(:confirmed_user) }
    let(:post) { create :post, user_id: user.id }

    it "レスポンスボディーに期待された値が返ること" do
      call_api
      res = JSON.parse(response.body)
      expect(res["data"]["attributes"]["name"]).to eq "test"
      expect(res["data"]["attributes"]["content"]).to eq "example"
      expect(res["data"]["attributes"]["public"]).to eq false
      expect(res["data"]["attributes"]["user-id"]).to eq user.id
    end
  end

  describe "POST /api/v1/posts" do
    subject(:call_api){ post "/api/v1/posts", headers: headers, params: params }

    let(:user) { create(:confirmed_user) }
    let(:headers) { user.create_new_auth_token }
    let(:params) {{ }}

    context "postが作成されたとき" do
      let(:params) do
        {
          post: {
            name: "test",
            content: "example",
            public: false,
          }
        }
      end

      it "200ステータスが返ること" do
        call_api
        expect(response.status).to eq 200
      end

      it "postが作成される" do
        expect { call_api }.to change { Post.count }.from(0).to(1)
      end

      it "レスポンスボディーに期待された値が返ること" do
        call_api
        res = JSON.parse(response.body)
        expect(res["data"]["attributes"]["name"]).to eq "test"
        expect(res["data"]["attributes"]["content"]).to eq "example"
        expect(res["data"]["attributes"]["public"]).to eq false
        expect(res["data"]["attributes"]["user-id"]).to eq user.id
      end
    end

    context "postの作成に失敗した場合" do
      let(:params) do
        {
          post: {
            name: "",
            content: "",
            public: false,
          }
        }
      end

      it "エラーになる" do
        call_api
        res = JSON.parse(response.body)
        expect(res["status"]).to eq "error"
        expect(res["errors"]["name"]).to eq ["を入力してください"]
        expect(res["errors"]["content"]).to eq ["を入力してください"]
      end
    end
  end

  describe "PUT /api/v1/posts/:id" do
    subject(:call_api){ put "/api/v1/posts/#{post.id}", headers: headers, params: params }

    let(:user) { create :confirmed_user }
    let(:user2) { create :confirmed_user, username: "test_name" }
    let(:headers) { user.create_new_auth_token }
    let(:post) { create :post, user_id: user.id }
    let(:params) {{}}

    context "ログインユーザーと投稿ユーザーが一致している場合" do
      context "postの更新に失敗した場合" do
        let(:params) do
          {
            post: {
              name: "test",
              content: "example",
              public: false,
            }
          }
        end

        it "200ステータスが返ること" do
          call_api
          expect(response.status).to eq 200
        end

        it "レスポンスボディーに期待された値が返ること" do
          call_api
          res = JSON.parse(response.body)
          expect(res["data"]["attributes"]["name"]).to eq "test"
          expect(res["data"]["attributes"]["content"]).to eq "example"
          expect(res["data"]["attributes"]["public"]).to eq false
          expect(res["data"]["attributes"]["user-id"]).to eq user.id
        end
      end

      context "postの更新に失敗した場合" do
        let(:params) do
          {
            post: {
              name: "",
              content: "",
              public: false,
            }
          }
        end

        it "エラーになる" do
          call_api
          res = JSON.parse(response.body)
          expect(res["status"]).to eq "error"
          expect(res["errors"]["name"]).to eq ["を入力してください"]
          expect(res["errors"]["content"]).to eq ["を入力してください"]
        end
      end
    end

    context "ログインユーザーと投稿ユーザーが一致していない場合" do
      before { post.update(user_id: user2.id) }

      it "アクセス権限がないと返ること" do
        call_api
        res = JSON.parse(response.body)
        expect(res["success"]).to eq false
        expect(res["errors"]).to eq "アクセスする権限がありません"
      end
    end
  end

  describe "DELETE /api/v1/posts/:id" do
    subject(:call_api){ delete "/api/v1/posts/#{post.id}", headers: headers }

    let(:user) { create :confirmed_user }
    let(:user2) { create :confirmed_user, username: "test_name" }
    let(:headers) { user.create_new_auth_token }
    let(:post) { create :post, user_id: user.id }

    context "ログインユーザーと投稿ユーザーが一致している場合" do
      context "postの削除に成功した場合" do
        it "200ステータスが返ること" do
          call_api
          expect(response.status).to eq 200
        end

        it "postが削除されること" do
          expect { call_api }.to change { Post.count }.by(0)
        end

        it "レスポンスボディーに期待された値が返ること" do
          call_api
          res = JSON.parse(response.body)
          expect(res["data"]["attributes"]["name"]).to eq "test"
          expect(res["data"]["attributes"]["content"]).to eq "example"
          expect(res["data"]["attributes"]["public"]).to eq false
          expect(res["data"]["attributes"]["user-id"]).to eq user.id
        end
      end
    end

    context "ログインユーザーと投稿ユーザーが一致していない場合" do
      before { post.update(user_id: user2.id) }

      it "アクセス権限がないと返ること" do
        call_api
        res = JSON.parse(response.body)
        expect(res["success"]).to eq false
        expect(res["errors"]).to eq "アクセスする権限がありません"
      end
    end
  end
end