<template lang="pug">
.container.mt-5
  .d-flex.justify-content-between.align-items-center.mb-3
    h3 {{ workspace.name }}
    .button-group
      button.btn.btn-outline-success(@click="handleEdit") 수정하기
      button.btn.btn-outline-danger(@click="handleDelete") 삭제하기

  p.mb-3 {{ workspace.description }}
  
  h4.mt-4 Task 목록
  ul.list-group
    li.list-group-item(
      v-for="task in tasks" 
      :key="task.id"
    )
      span {{ task.title }}
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import api from '../lib/axios'

const route = useRoute()
const router = useRouter()
const workspace = ref({})
const tasks = ref([])

const loadWorkspace = async () => {
  try {
    const response = await api.get(`/workspaces/${route.params.id}`)
    workspace.value = response.data
  } catch (error) {
    console.error("워크스페이스 정보를 불러오지 못했습니다.")
  }
}

const loadTasks = async () => {
  try {
    const response = await api.get(`/workspaces/${route.params.id}/tasks`)
    tasks.value = response.data
  } catch (error) {
    console.error("Task 정보를 불러오지 못했습니다.")
  }
}

const handleDelete = async () => {
  if (confirm("정말 삭제하시겠습니까?")) {
    try {
      await api.delete(`/workspaces/${route.params.id}`)
      alert("워크스페이스가 삭제되었습니다.")
      router.push('/')
    } catch (error) {
      alert("삭제에 실패했습니다.")
    }
  }
}

const handleEdit = () => {
  const newName = prompt("새로운 제목을 입력하세요:", workspace.value.name)
  const newDescription = prompt("새로운 설명을 입력하세요:", workspace.value.description)
  
  if (newName && newDescription) {
    workspace.value.name = newName
    workspace.value.description = newDescription

    api.put(`/workspaces/${route.params.id}`, {
      name: newName,
      description: newDescription
    }).then(() => {
      alert("워크스페이스가 수정되었습니다.")
    }).catch(() => {
      alert("수정에 실패했습니다.")
    })
  }
}

onMounted(() => {
  loadWorkspace()
  loadTasks()
})
</script>

<style scoped>
.button-group {
  display: flex;
  gap: 10px;
}
</style>
