<template lang="pug">

  HeaderComp(@search="handleSearch")

  div.container.mt-5 
    div.d-flex.justify-content-between.align-items-center.mb-4
      h2 워크 스페이스 목록
      button.btn.btn-primary(@click="showCreateModal = true") + 워크스페이스 생성

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

const workspaces = ref([]);
const searchQuery = ref('');
const showCreateModal = ref(false);

const loadWorkspaces = async () => {
  try {
    const data = await fetchWorkspaces();
    console.log(data);
    workspaces.value = data
  } catch (error) {
    console.error("워크스페이스를 불러오지 못했습니다.")
  }
}

const handleCreateWorkspace = async (workspaceData) => {
  try {
    const newWorkspace = await createWorkspace(workspaceData.name, workspaceData.description)
    workspaces.value.push(newWorkspace)
    showCreateModal.value = false
  } catch (error) {
    alert('워크스페이스 생성에 실패했습니다.')
  }
}

onMounted(() => {
  loadWorkspaces()
})

const handleSearch = (query) => {
  searchQuery.value = query;
}

const filteredWorkspaces = computed(() => {
  if (!searchQuery.value) return workspaces.value
  return workspaces.value.filter(ws =>
    ws.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
    ws.owner.toLowerCase().includes(searchQuery.value.toLowerCase())
  )
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
