<template lang="pug">
  div.d-flex.justify-content-center.align-items-center.min-vh-100.bg-light
    div.container.text-center.p-4.shadow.rounded.bg-white(style="max-width: 400px;")
      img(src="/N-logo-final.svg" alt="Logo" style="width: 64px; height: 64px;")
      h2.mt-2.mb-4.--bs-tertiary-bg Workflow
  
      form(@submit.prevent="handleSignup")
        .mb-3.text-start
          label.form-label(for="name") 이름
          input#name.form-control(type="text" v-model="name" required placeholder="홍길동")
  
        .mb-3.text-start
          label.form-label(for="email") 이메일
          input#email.form-control(type="email" v-model="email" required placeholder="example@email.com")
  
        .mb-3.text-start
          label.form-label(for="password") 비밀번호
          input#password.form-control(type="password" v-model="password" required placeholder="비밀번호 입력")
  
        .mb-3.text-start
          label.form-label(for="confirmPassword") 비밀번호 확인
          input#confirmPassword.form-control(type="password" v-model="confirmPassword" required placeholder="비밀번호 재입력")
  
        button.btn.btn-outline-secondary.w-100.mb-2(type="submit") 회원가입
  
      button.btn.btn-outline-primary.w-100(@click="goToLogin") 로그인으로 돌아가기
  </template>
  
  <script setup>
  import { ref } from 'vue'
  import { useRouter } from 'vue-router'
  
  const router = useRouter()
  const name = ref('')
  const email = ref('')
  const password = ref('')
  const confirmPassword = ref('')
  
  const handleSignup = () => {
    if (password.value !== confirmPassword.value) {
      alert('비밀번호가 일치하지 않습니다.')
      return
    }
  
    // 회원가입 데이터 확인용 (나중에 API 연동)
    console.log('회원가입 정보:', name.value, email.value, password.value)
    alert('회원가입 요청됨!')
  }
  
  const goToLogin = () => {
    router.push('/login')
  }
  </script>
  
  <style scoped>
  </style>
  