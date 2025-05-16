<template lang="pug">

  HeaderComp(@search="handleSearch")

  div.container.mt-5 
    div.d-flex.justify-content-between.align-items-center.mb-4
      h2 ワークスペース リスト
      button.btn.btn-primary(@click="showCreateModal = true") + ワークスペースを作る

    draggable.grid-view(
      :list="filteredWorkspaces", 
      group="workspaces", 
      @end="onDragEnd"
    )
      template(#item="{ element }")
        .grid-item
          WorkspaceCard(:workspace="element")

    CreateWorkspaceModal(
      v-if="showCreateModal"
      @close="showCreateModal=false"
      @submit="handleCreateWorkspace"
    )  
</template>

<script setup>
import { ref, onMounted, computed } from "vue";
import draggable from "vuedraggable";
import WorkspaceCard from "../components/WorkspaceCard.vue";
import CreateWorkspaceModal from "../components/CreateWorkspaceModal.vue";
import HeaderComp from "../components/HeaderComp.vue";
import { createWorkspace, fetchWorkspaces } from '../api/workspaceApi'
import { useWorkspaceStore } from "../stores/workspaceStore"

const workspaceStore = useWorkspaceStore()
const searchQuery = ref('');
const showCreateModal = ref(false);

const loadWorkspaces = async () => {
  try {
    const data = await fetchWorkspaces();
    workspaceStore.setWorkspaces(data)
  } catch (error) {
    console.error("워크스페이스를 불러오지 못했습니다.")
  }
}

const handleCreateWorkspace = async (workspaceData) => {
  try {
    const newWorkspace = await createWorkspace(workspaceData.name, workspaceData.description)
    workspaceStore.workspaces.push(newWorkspace)
    showCreateModal.value = false
  } catch (error) {
    alert('워크스페이스 생성에 실패했습니다.')
  }
}

const handleSearch = (query) => {
  searchQuery.value = query;
}

const filteredWorkspaces = computed(() => {
  if (!searchQuery.value) return workspaceStore.workspaces
  return workspaceStore.workspaces.filter(ws =>
    ws.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
    ws.owner.toLowerCase().includes(searchQuery.value.toLowerCase())
  )
})

onMounted(() => {
  loadWorkspaces()
})

</script>

<style>
.grid-view {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
  gap: 15px;
  margin-top: 20px;
}

.grid-item {
  display: flex;
  justify-content: center;
}
</style>
