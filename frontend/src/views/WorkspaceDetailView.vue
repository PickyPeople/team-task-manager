<template lang="pug">
div.container.mt-5
  div.d-flex.justify-content-between.align-items-center.mb-3
    h3 {{ workspace.name }}
    div.button-group
      template(v-if="workspace.user_id === currentUserId")
        button.btn.btn-outline-success(@click="handleEdit") 修正する
        button.btn.btn-outline-danger(@click="handleDelete") 削除する
      button.btn.btn-primary(v-else @click="handleJoin") 参加する

  p.mb-3 {{ workspace.description }}
  
  TaskList(:workspaceId="workspace.id", v-if="workspace.id", :matchUser="workspace.user_id === currentUserId")
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { fetchWorkspaceDetail, updateWorkspace, deleteWorkspace } from '../api/workspaceApi'
import { me } from '../api/authApi'
import TaskList from '../components/TaskList.vue'

const route = useRoute()
const router = useRouter()
const workspace = ref({})
const currentUserId = ref(null)

const fetchWorkspaceDetailData = async () => {
  try {
    const data = await fetchWorkspaceDetail(route.params.id)
    console.log(data);
    workspace.value = data
  } catch (error) {
    console.error("워크스페이스 정보를 불러오지 못했습니다.")
  }
}

const handleEdit = async () => {
  const newName = prompt("新しいタイトルを入力してください。", workspace.value.name)
  const newDescription = prompt("新しい説明を入力してください。", workspace.value.description)

  if (newName && newDescription) {
    try {
      const updatedData = await updateWorkspace(route.params.id, newName, newDescription)
      workspace.value.name = updatedData.name
      workspace.value.description = updatedData.description
    } catch (error) {
      alert("修正に失敗しました。")
    }
  }
}

const handleDelete = async () => {
  if (confirm("本当に削除しますか？？")) {
    try {
      await deleteWorkspace(route.params.id)
      router.push('/workspaces')
    } catch (error) {
      alert("削除に失敗しました。")
    }
  }
}

const handleJoin = () => {
  alert("참가하기 기능은 아직 구현되지 않았습니다.")
}

onMounted( async () => {
  try { 
    const user = await me();
    currentUserId.value = user.id;
  } catch (err) {
    console.error('ユーザを探せません。', err);
  }
  fetchWorkspaceDetailData();
})

</script>

<style scoped>
.button-group {
  display: flex;
  gap: 10px;
}
</style>
