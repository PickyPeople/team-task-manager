require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { User.create(name: "Test User", email: "test@example.com", password: "password") }
  let(:workspace) { Workspace.create(name: "Test Workspace", description: "Desc", user: user, owner: user.name) }

  it "필수 속성(title, status)이 있을 때 유효하다" do
    task = Task.new(title: "테스트 태스크", status: "todo", user: user, workspace: workspace)
    expect(task).to be_valid
  end

  it "제목이 없으면 유효하지 않다" do
    task = Task.new(status: "todo", user: user, workspace: workspace)
    expect(task).not_to be_valid
  end

  it "상태가 없으면 유효하지 않다" do
    task = Task.new(title: "태스크", user: user, workspace: workspace)
    expect(task).not_to be_valid
  end
end
