<template lang="pug">
  div.d-flex.justify-content-center.align-items-center.min-vh-100.bg-light
    div.container.text-center.p-4.shadow.rounded.bg-white(style="max-width: 400px;")
      img(src="/N-logo-final.svg" alt="Logo" style="width: 64px; height: 64px;")
      h2.mt-2.mb-4.--bs-tertiary-bg Workflow
  
      form(@submit.prevent="handleLogin")
        .mb-3.text-start
          label.form-label(for="email") 이메일
          input#email.form-control(type="email" v-model="email" required placeholder="example@email.com")
        
        .mb-3.text-start
          label.form-label(for="password") 비밀번호
          input#password.form-control(type="password" v-model="password" required placeholder="비밀번호 입력")
        
        button.btn.btn-primary.w-100.mb-2(type="submit") 로그인
  
      button.btn.btn-outline-secondary.w-100(@click="goToSignup") 회원가입
  </template>
  
  <script setup>
  import { ref } from 'vue'
  import { useRouter } from 'vue-router'
  
  const router = useRouter()
  const email = ref('')
  const password = ref('')
  
  const handleLogin = () => {
    // 실제 로그인 처리 로직은 나중에 API 연동
    console.log('Email:', email.value)
    console.log('Password:', password.value)
    alert('로그인 버튼 클릭됨')
  }
  
  const goToSignup = () => {
    router.push('/signup')
  }
  </script>
  
  <style scoped>
  </style>
  