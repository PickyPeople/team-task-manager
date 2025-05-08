<template lang="pug">
  div.col-md-4.mb-3
    div.card
      div.card-body
        h5.card-title {{ workspace.name }}
        p.card-text {{workspace.description }}
        router-link.btn.btn-outline-primary(:to="`/workspaces/${workspace.id}`") 자세히 보기
</template>

<script setup>
  defineProps({
  workspace: {
    type: Object,
    required: true
  }
})

</script>