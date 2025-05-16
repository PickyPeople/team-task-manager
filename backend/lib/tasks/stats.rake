namespace :stats do
  desc "워크스페이스별 참가자 진척률 집계"
  task workspace_progress: :environment do
    Workspace.includes(:users, :tasks).find_each do |workspace|
      puts "📁 ワークスペース: #{workspace.name}"

      participants = workspace.users
      participants << workspace.user unless participants.include?(workspace.user) # 작성자 포함

      participants.uniq.each do |user|
        user_tasks = workspace.tasks.where(assignee_id: user.id)
        total = user_tasks.count
        completed = user_tasks.where(status: "completed").count
        progress = total > 0 ? (completed.to_f / total * 100).round(1) : 0.0

        puts "  👤 #{user.name} - 完了: #{completed} / 全体: #{total} (#{progress}%)"
      end

      puts "-" * 40
    end
  end
end
