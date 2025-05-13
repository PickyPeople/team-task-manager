<template lang="pug">
 nav.navbar.navbar-expand-lg.bg-body-tertiary
  div.container-fluid
    a.navbar-brand(href="#") Noteflow
    button.navbar-toggler(type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation")
      span.navbar-toggler-icon
    div.collapse.navbar-collapse#navbarSupportedContent
      ul.navbar-nav.me-auto.mb-2.mb-lg-0
        li.nav-item
          a.nav-link.active(aria-current="page" href="#") Home
      form.d-flex(role="search")
        input.form-control.me-2(type="search" placeholder="Search" aria-label="Search")
        button.btn.btn-outline-success(type="submit") Search
      div.logout(@click="handleLogout") logout  

</template>

<script setup>
import { useRouter } from 'vue-router'
import { logout } from '../api/authApi';


const router = useRouter()


const handleLogout = async () => {
  try {
    await logout()
    localStorage.removeItem('token') // 로컬 스토리지 토큰 제거
    router.push('/login') // 로그인 페이지로 이동
  } catch (err) {
    console.error('로그아웃 실패:', err)
    alert('로그아웃에 실패했습니다.')
  }
}
</script>

<style scoped>
.logout {
  border: 1px solid black;
  border-radius: 20px;
  padding: 5px 15px;
  margin: 0 20px;
  cursor: pointer;
  transition: .5s;
}

.logout:hover {
  background-color: black;
  color: white;
}
</style>
