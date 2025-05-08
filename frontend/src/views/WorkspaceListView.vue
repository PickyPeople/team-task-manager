<template lang="pug">
  div.container.mt-5 
    div.d-flex.justify-content-between.align-items-center.mb-4
      h2 워크 스페이스 목록
      router-link.btn.btn-primary(to="/workspaces/new") + 새 워크 스페이스 생성
    div.row
      WorkspaceCard(v-for="workspace in workspaces" 
        :key="workspace.id" 
        :workspace="workspace"
      )
</template>

<script setup>
import { ref } from "vue";
import WorkspaceCard from "../components/WorkspaceCard.vue";

const workspaces = ref([
  { id: 1, name: "프로젝트A", description: "A프로젝트입니다" },
  { id: 2, name: "프로젝트B", description: "B프로젝트입니다" },
]);
</script>

<style></style>
