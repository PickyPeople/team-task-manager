<template lang="pug">
  .container.mt-5
    h2 {{ workspace.name }} - 칸반 보드
    p {{ workspace.description }}
    .row
      .col-md-4
        h4 Todo
        ul
          li(v-for="task in todoTasks" :key="task.id") {{ task.name }}
  
      .col-md-4
        h4 In Progress
        ul
          li(v-for="task in progressTasks" :key="task.id") {{ task.name }}
  
      .col-md-4
        h4 Done
        ul
          li(v-for="task in doneTasks" :key="task.id") {{ task.name }}
  </template>
  
  <script setup>
  import { ref } from 'vue'
  
  const workspace = ref({
    name: '프로젝트 A',
    description: 'A 프로젝트입니다.'
  })
  
  const todoTasks = ref([{ id: 1, name: 'DB 설계' }])
  const progressTasks = ref([{ id: 2, name: 'API 개발' }])
  const doneTasks = ref([{ id: 3, name: 'UI 디자인' }])
  </script>
  