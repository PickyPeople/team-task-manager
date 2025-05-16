<template lang="pug">
  div.d-flex.justify-content-center.align-items-center.min-vh-100.bg-light
    div.container.text-center.p-4.shadow.rounded.bg-white(style="max-width: 400px;")
      img(src="/N-logo-final.svg" alt="Logo" style="width: 64px; height: 64px;")
      h2.mt-2.mb-4.--bs-tertiary-bg Workflow
  
      form(@submit.prevent="handleSignup")
        .mb-3.text-start
          label.form-label(for="name") 名前
          input#name.form-control(type="text" v-model="name" required placeholder="홍길동")
  
        .mb-3.text-start
          label.form-label(for="email") メール
          input#email.form-control(type="email" v-model="email" required placeholder="example@email.com")
  
        .mb-3.text-start
          label.form-label(for="password") パスワード
          input#password.form-control(type="password" v-model="password" required placeholder="비밀번호 입력")
  
        .mb-3.text-start
          label.form-label(for="confirmPassword") パスワード 確認
          input#confirmPassword.form-control(type="password" v-model="confirmPassword" required placeholder="비밀번호 재입력")
  
        button.btn.btn-outline-secondary.w-100.mb-2(type="submit") サインアップ
  
      button.btn.btn-outline-primary.w-100(@click="goToLogin") ログイン画面に戻る
  </template>
  
  <script setup>
  import { ref } from 'vue'
  import { useRouter } from 'vue-router'
  import { signup } from '../api/authApi.js'
  
  const router = useRouter()
  const name = ref('')
  const email = ref('')
  const password = ref('')
  const confirmPassword = ref('')
  
  const handleSignup = async () => {
    if (password.value !== confirmPassword.value) {
      alert('パスワードが一致しません。')
      return 
    }
  
    try {
      await signup(name.value, email.value, password.value)
      router.push('/login');
    } catch(err) {
      console.error('회원가입 실패: ', err.response?.data || err.message);
    }
  }
  
  const goToLogin = () => {
    router.push('/login')
  }
  </script>
  
  <style scoped>
  </style>
  