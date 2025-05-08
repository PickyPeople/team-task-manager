import { createRouter, createWebHistory } from 'vue-router'
import LoginView from '../views/LoginView.vue'
import SignupView from '../views/SignupView.vue'
import WorkspaceListView from '../views/WorkspaceListView.vue'
import WorkspaceCreateView from '../views/WorkspaceCreateView.vue'
import WorkspaceDetailView from '../views/WorkspaceDetailView.vue'

const routes = [
  { path: '/', redirect: '/login' },
  { path: '/login', component: LoginView },
  { path: '/signup', component: SignupView },
  { path: '/workspaces', component: WorkspaceListView },
  { path: '/workspaces/new', component: WorkspaceCreateView},
  { path: '/workspaces/:id', component: WorkspaceDetailView}
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
