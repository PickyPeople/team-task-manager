<template lang="pug">
  div.d-flex.justify-content-center.align-items-center.min-vh-100.bg-light
    div.container.text-center.p-4.shadow.rounded.bg-white(style="max-width: 400px;")
      img(src="/N-logo-final.svg" alt="Logo" style="width: 64px; height: 64px;")
      h2.mt-2.mb-4.--bs-tertiary-bg Workflow
  
      form(@submit.prevent="handleLogin")
        div.mb-3.text-start
          label.form-label(for="email") 이메일
          input#email.form-control(type="email" v-model="email" required placeholder="example@email.com")
        
        div.mb-3.text-start
          label.form-label(for="password") 비밀번호
          input#password.form-control(type="password" v-model="password" required placeholder="비밀번호 입력")

        p.errMsg(v-if="successLogin") 이메일 혹은 비밀번호를 다시 한번 확인해주세요

        button.btn.btn-primary.w-100.mb-2(type="submit") 로그인
        button.btn.btn-outline-secondary.w-100(@click="goToSignup") 회원가입
  </template>

<script setup>
import { ref } from "vue";
import { useRouter } from "vue-router";
import { login } from "../api/authApi";

const router = useRouter();
const email = ref("");
const password = ref("");
const successLogin = ref(false);

const handleLogin = async () => {
  try {
    const res = await login(email.value, password.value)

    if(res) {
      router.push("/workspaces");
    }
  } catch (err) {
    console.error("로그인 실패:", err.response?.data || err.message);
    successLogin.value = true;
  }
};

const goToSignup = () => {
  router.push("/signup");
};
</script>

<style scoped>
.errMsg {
  color: #FF9A9A;
}
</style>
