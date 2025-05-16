import { defineStore } from 'pinia'

export const useWorkspaceStore = defineStore('workspace', {
  state: () => ({
    workspaces: []
  }),
  actions: {
    setWorkspaces(list) {
      this.workspaces = list
    },
    clearWorkspaces() {
      this.workspaces = []
    }
  }
})
