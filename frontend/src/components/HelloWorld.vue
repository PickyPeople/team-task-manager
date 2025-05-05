<template lang="pug">
  div.container.mt-5
    h1.mb-4.text-primary 로그인 화면
  
    form
      .mb-3
        label.form-label(for="email") 이메일
        input#email.form-control(type="email" placeholder="이메일 입력")
      
      .mb-3
        label.form-label(for="password") 비밀번호
        input#password.form-control(type="password" placeholder="비밀번호 입력")
      
      button.btn.btn-primary(type="submit") 로그인
  </template>
  