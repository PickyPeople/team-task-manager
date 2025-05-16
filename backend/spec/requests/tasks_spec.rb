require 'rails_helper'

RSpec.describe "Tasks API", type: :request do
  let(:user) { User.create(name: "Test", email: "user@example.com", password: "password") }
  let(:workspace) { Workspace.create(name: "Test WS", description: "desc", user: user, owner: user.name) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }

  let(:headers) do
    {
      "Authorization" => "Bearer #{token}",
      "Content-Type" => "application/json"
    }
  end

  describe "POST /workspaces/:workspace_id/tasks" do
    context "정상적인 요청인 경우" do
      it "Task를 생성한다" do
        post "/workspaces/#{workspace.id}/tasks", params: {
          task: {
            title: "새 태스크",
            description: "설명",
            status: "todo",
            done: false,
            assignee_id: nil
          }
        }.to_json, headers: headers

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)["title"]).to eq("새 태스크")
      end
    end

    context "로그인하지 않은 경우" do
      it "401 Unauthorized 응답을 반환한다" do
        post "/workspaces/#{workspace.id}/tasks", params: {
          task: {
            title: "비인증 태스크",
            description: "설명",
            status: "todo",
            done: false
          }
        }.to_json

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
