<template lang="pug">
  div.mb-3.card-container
    div.card(@click="goToDetail", draggable="true")
      div.card-body
        h5.card-title {{ workspace.name }}
        p.card-text {{ workspace.description }}
        p.card-text 작성자: {{ workspace.owner }}
</template>

<script setup>
import { useRouter } from 'vue-router'

const router = useRouter()

const props = defineProps({
  workspace: {
    type: Object,
    required: true,
  },
})


const goToDetail = (event) => {
  event.preventDefault()    
  event.stopPropagation()  

  
  router.push(`/workspaces/${props.workspace.id}`)
}
</script>

<style>
  .card-container {
    width: 100%;
  }

  .card {
    cursor: pointer;
    transition: 0.2s ease;
  }

  .card:hover {
    transform: scale(1.02);
  }
</style>
