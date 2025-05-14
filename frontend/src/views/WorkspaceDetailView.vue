<template lang="pug">
div.container.mt-5
  div.d-flex.justify-content-between.align-items-center.mb-3
    h3 {{ workspace.name }}
    div.button-group
      button.btn.btn-outline-success(@click="handleEdit") 수정하기
      button.btn.btn-outline-danger(@click="handleDelete") 삭제하기

  p.mb-3 {{ workspace.description }}
  
  TaskList(:workspaceId="workspace.id", v-if="workspace.id")
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { fetchWorkspaceDetail, updateWorkspace, deleteWorkspace } from '../api/workspaceApi'
import TaskList from '../components/TaskList.vue'

const route = useRoute()
const router = useRouter()
const workspace = ref({})

const fetchWorkspaceDetailData = async () => {
  try {
    const data = await fetchWorkspaceDetail(route.params.id)
    workspace.value = data
  } catch (error) {
    console.error("워크스페이스 정보를 불러오지 못했습니다.")
  }
}

const handleEdit = async () => {
  const newName = prompt("새로운 제목을 입력하세요:", workspace.value.name)
  const newDescription = prompt("새로운 설명을 입력하세요:", workspace.value.description)

  if (newName && newDescription) {
    try {
      const updatedData = await updateWorkspace(route.params.id, newName, newDescription)
      workspace.value.name = updatedData.name
      workspace.value.description = updatedData.description
      alert("워크스페이스가 수정되었습니다.")
    } catch (error) {
      alert("수정에 실패했습니다.")
    }
  }
}

const handleDelete = async () => {
  if (confirm("정말 삭제하시겠습니까?")) {
    try {
      await deleteWorkspace(route.params.id)
      alert("워크스페이스가 삭제되었습니다.")
      router.push('/workspaces')
    } catch (error) {
      alert("삭제에 실패했습니다.")
    }
  }
}

onMounted(() => {
  fetchWorkspaceDetailData();
})
</script>

<style scoped>
.button-group {
  display: flex;
  gap: 10px;
}
</style>
