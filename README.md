# Team Task Manager

Vue.js + Ruby on Rails による簡易タスク管理SaaSツール。

## ✅ 主な機能

- JWT認証（ログイン・サインアップ）
- ワークスペースの作成・参加・脱退
- タスクの作成・編集・削除・フィルタリング
- タスク進捗率をチャートで可視化

---

## 💻 使用技術

| 項目 | 内容 |
|------|------|
| フロントエンド | Vue.js 3 + Vite + Bootstrap + Pug |
| バックエンド | Ruby on Rails 8.0 (APIモード) |
| 状態管理 | Pinia |
| 認証 | JWT + HttpOnly Cookie |
| テスト | RSpec（5テスト成功） |
| DB | SQLite3 |
| バッチ処理 | Rake Task（進捗率）

---

## 📂 ディレクトリ構成
- /backend    - Rails API (RSpec, JWT, Devise)
- /frontend   - Vue 3 SPA (Vite + Pug)
- /docs       - 設計書・提出用資料

---

## 🚀 セットアップ

```bash
# バックエンド
cd backend
bundle install
rails db:create db:migrate
rails server

# フロントエンド
cd frontend
npm install
npm run dev

🧪 テスト実行
cd backend
bundle exec rspec
.....

Finished in 0.03787 seconds (files took 0.61113 seconds to load)
5 examples, 0 failures
```

# 使い方
---
## ログイン＆サインアップ
▶️ [動画を見る](https://youtu.be/nR9HnVMNYyE)

---
## ワークスペースを創成、修正、削除
▶️ [動画を見る](https://youtu.be/XdNU_5gt_BM)

---
## タスクの創成、修正、削除
