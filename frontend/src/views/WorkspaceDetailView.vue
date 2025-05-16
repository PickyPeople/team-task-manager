<template lang="pug">
div.container.mt-5
  div.d-flex.justify-content-between.align-items-center.mb-3
    h3 {{ workspace.name }}
    div.button-group
      template(v-if="workspace.user_id === currentUserId")
        button.btn.btn-outline-success(@click="handleEdit") 修正する
        button.btn.btn-outline-danger(@click="handleDelete") 削除する
      template(v-else)  
        button.btn.btn-primary(v-if="!isParticipant" @click="handleJoin") 参加する
        button.btn.btn-primary(v-else @click="handleLeave") 脱退する

  p.mb-3 {{ workspace.description }}

  h5.mt-4 参加者 リスト
  ul.list-group
    li.list-group-item(v-for="user in participants" :key="user.id")
      span {{ user.name }} ({{ user.email }})

  WorkspaceChart(:progressData="progressData" v-if="progressData")

  TaskList(
    v-if="workspace.id", 
    :workspaceId="workspace.id", 
    :isParticipant="isParticipant", 
    :isMine="workspace.user_id === currentUserId",
    :currentUserId="currentUserId",
    :userList="participants",
    @taskChanged="fetchProgress"
    )
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { fetchWorkspaceDetail, updateWorkspace, deleteWorkspace, joinWorkspace, getParticipants, leaveWorkspace, getProgressByWorkspace } from '../api/workspaceApi'
import { me } from '../api/authApi'
import TaskList from '../components/TaskList.vue'
import WorkspaceChart from '../components/WorkspaceChart.vue'

const route = useRoute()
const router = useRouter()

const workspace = ref({})
const currentUserId = ref(null)
const isParticipant = ref(false)
const participants = ref([])
const progressData = ref([])


const fetchWorkspaceDetailData = async () => {
  try {
    const data = await fetchWorkspaceDetail(route.params.id)
    workspace.value = data
  } catch (error) {
    console.error("워크스페이스 정보를 불러오지 못했습니다.")
  }
}

const checkIfUserIsParticipant = async () => {
  const members = await getParticipants(workspace.value.id)
  participants.value = members;
  isParticipant.value = members.some(member => member.id === currentUserId.value)
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

const handleJoin = async() => {
   await joinWorkspace(workspace.value.id)
   await checkIfUserIsParticipant()
}

const handleLeave = async() => {
  await leaveWorkspace(workspace.value.id);
  await getParticipants();
  await checkIfUserIsParticipant();
}

const fetchProgress = async () => {
  progressData.value = await getProgressByWorkspace(workspace.value.id)
}

onMounted( async () => {
  try { 
    const user = await me();
    currentUserId.value = user.id;

    await fetchWorkspaceDetailData();
    await checkIfUserIsParticipant();
  } catch (err) {
    console.error('ユーザを探せません。', err);
  }
  fetchWorkspaceDetailData();
  fetchProgress();
})

</script>

<style scoped>
.button-group {
  display: flex;
  gap: 10px;
}
</style>
