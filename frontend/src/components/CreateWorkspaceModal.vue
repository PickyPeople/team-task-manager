<template lang="pug">
  div.modal(@click.self="handleClose")
    div.modal-content
      div.modal-header
        h5.modal-title ワークスペースを作る
        button.btn-close(@click="handleClose")
      div.modal-body
        form(@submit.prevent="handleSubmit")
          div.mb-3
            label.form-label(for="name") タイトル
            input#name.form-control(v-model="name" required)
  
          div.mb-3
            label.form-label(for="description") 説明
            textarea#description.form-control(v-model="description")
  
          button.btn.btn-success(type="submit") 生成する
</template>

<script setup>
import { ref } from "vue";

const emit = defineEmits(['close', 'submit'])
const name = ref("");
const description = ref("");

const handleClose = () => {
  emit("close");
  name.value = "";
  description.value = "";
};

const handleSubmit = () => {
  emit("submit", {
    name: name.value,
    description: description.value,
  });

  handleClose();
};
</script>

<style scoped>
.modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  width: 50vh;
  z-index: 1010;
}
</style>
