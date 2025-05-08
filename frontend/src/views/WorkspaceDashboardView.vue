<template lang="pug">
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
      @submit="addWorkspace"
    )  
</template>

<script setup>
import { ref } from "vue";
import draggable from "vuedraggable";
import WorkspaceCard from "../components/WorkspaceCard.vue";
import CreateWorkspaceModal from "../components/CreateWorkspaceModal.vue";

const showCreateModal = ref(false);

const addWorkspace = (workspace) => {
  workspaces.value.push({
    id: workspaces.value.length + 1,
    name: workspace.name,
    description: workspace.description,
  });
  showCreateModal.value = false;
};

const workspaces = ref([
  { id: 1, name: "프로젝트 A", description: "A 프로젝트입니다." },
  { id: 2, name: "프로젝트 B", description: "B 프로젝트입니다." },
  { id: 3, name: "프로젝트 C", description: "C 프로젝트입니다." },
]);

const onDragEnd = (evt) => {
  console.log("드래그 완료!", evt.oldIndex, "→", evt.newIndex);
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
