import { createRouter, createWebHistory } from 'vue-router'
import LoginView from '../views/LoginView.vue'
import SignupView from '../views/SignupView.vue'
import WorkspaceDashboardView from '../views/WorkspaceDashboardView.vue'
import WorkspaceDetailView from '../views/WorkspaceDetailView.vue'
import WorkspaceKanbanView from '../views/WorkspaceKanbanView.vue'

const routes = [
  { path: '/', redirect: '/login' },
  { path: '/login', component: LoginView },
  { path: '/signup', component: SignupView },
  { path: '/workspaces', component: WorkspaceDashboardView },
  { path: '/workspaces/:id', component: WorkspaceDetailView },
  { path: '/workspaces/:id/kanban', component: WorkspaceKanbanView }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
