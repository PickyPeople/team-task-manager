import { defineStore } from 'pinia'

export const useTaskStore = defineStore('task', {
  state: () => ({
    tasks: []
  }),
  actions: {
    setTasks(taskList) {
      this.tasks = taskList
    },
    clearTasks() {
      this.tasks = []
    },
    addTask(task) {
      this.tasks.push(task)
    },
    updateTask(updatedTask) {
      const index = this.tasks.findIndex(task => task.id === updatedTask.id)
      if (index !== -1) this.tasks[index] = updatedTask
    },
    deleteTask(taskId) {
      this.tasks = this.tasks.filter(task => task.id !== taskId)
    }
  }
})
