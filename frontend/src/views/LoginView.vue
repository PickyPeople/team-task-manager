<template lang="pug">
  div.d-flex.justify-content-center.align-items-center.min-vh-100.bg-light
    div.container.text-center.p-4.shadow.rounded.bg-white(style="max-width: 400px;")
      img(src="/N-logo-final.svg" alt="Logo" style="width: 64px; height: 64px;")
      h2.mt-2.mb-4.text-primary Workflow
  
      button.btn.btn-primary.w-100.mb-2(@click="handleLogin") 로그인
      button.btn.btn-outline-secondary.w-100(@click="goToSignup") 회원가입
  </template>
  
  <script setup>
  import { useRouter } from 'vue-router'
  const router = useRouter()
  
  const handleLogin = () => {
    // 실제 로그인 처리 로직은 나중에 연결
    alert('로그인 버튼 클릭됨')
  }
  
  const goToSignup = () => {
    router.push('/signup')
  }
  </script>
  
  <style scoped>
  </style>
  