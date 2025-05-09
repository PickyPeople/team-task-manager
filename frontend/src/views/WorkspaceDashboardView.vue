<template lang="pug">

  HeaderComp

  div.container.mt-5 
    div.d-flex.justify-content-between.align-items-center.mb-4
      h2 워크 스페이스 목록
      button.btn.btn-primary(@click="showCreateModal = true") + 워크스페이스 생성

    draggable.grid-view(
      :list="workspaces", 
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
import { ref, onMounted } from "vue";
import draggable from "vuedraggable";
import WorkspaceCard from "../components/WorkspaceCard.vue";
import CreateWorkspaceModal from "../components/CreateWorkspaceModal.vue";
import HeaderComp from "../components/HeaderComp.vue";
import { createWorkspace, fetchWorkspaces } from '../api/workspaceApi'

const workspaces = ref([]);

const showCreateModal = ref(false);

const loadWorkspaces = async () => {
  try {
    const data = await fetchWorkspaces()
    workspaces.value = data
  } catch (error) {
    console.error("워크스페이스를 불러오지 못했습니다.")
  }
}

onMounted(() => {
  loadWorkspaces()
})

const handleCreateWorkspace = async (workspaceData) => {
  try {
    const newWorkspace = await createWorkspace(workspaceData.name, workspaceData.description)
    workspaces.value.push(newWorkspace)
    showCreateModal.value = false
  } catch (error) {
    alert('워크스페이스 생성에 실패했습니다.')
  }
}



const onDragEnd = (evt) => {
  // console.log("드래그 완료!", evt.oldIndex, "→", evt.newIndex);
};
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
