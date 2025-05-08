<template lang="pug">
  div.mb-3.card-container
    div.card(draggable="true")
      div.card-body
        h5.card-title {{ workspace.name }}
        p.card-text {{ workspace.description }}
        router-link.btn.btn-outline-primary(:to="`/workspaces/${workspace.id}/kanban`") 칸반 보기
</template>

<script setup>
defineProps({
  workspace: {
    type: Object,
    required: true,
  },
});
</script>

<style>
  .card-container {
    width: 100%;
  }
</style>
