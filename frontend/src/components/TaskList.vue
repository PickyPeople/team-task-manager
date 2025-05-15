<template lang="pug">
div.container
  div.d-flex.justify-content-between.align-items-center.mb-3
    h4 Task 目録
    template(v-if="isParticipant")
      button.btn.btn-primary(@click="handleCreate") ➕ Task 추가하기

  ul.list-group
    li.list-group-item.d-flex.justify-content-between.align-items-center(v-for="task in tasks" :key="task.id")
      div.d-flex.align-items-center
        div.circle(:class="getStatusClass(task.status)")
        span.ml-2 {{ task.title }} - {{ task.description }}
      div.d-flex.align-items-center
        template(v-if="isParticipant")
          select.form-select.form-select-sm.w-auto(v-model="task.status" @change="handleStatusChange(task)")
            option(value="pending") 대기중
            option(value="in-progress") 진행중
            option(value="completed") 완료
          button.btn.btn-outline-warning.btn-sm.ml-2(@click="handleEdit(task)") ✏️
          button.btn.btn-outline-danger.btn-sm.ml-1(@click="handleDelete(task.id)") 🗑️
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { fetchTasks, deleteTask, createTask, updateTask } from '../api/taskApi';

const props = defineProps({
  workspaceId: {
    type: Number,
    required: true,
  },
  isParticipant: {
    type: Boolean
  }
});

const tasks = ref([]);

const loadTasks = async () => {
  try {
    tasks.value = await fetchTasks(props.workspaceId);
  } catch (err) {
    console.error(err);
  }
};

const handleCreate = async () => {
  const title = prompt("새로운 Task의 제목을 입력하세요.");
  const description = prompt("task에 대한 설명을 입력해주세요");

  if(title && description) {
    try {
      const newTask = await createTask(props.workspaceId, {
        title,
        description,
        status: "pending",
        done: false
      });
      tasks.value.push(newTask);
    } catch (err) {
        console.log('태스크 생성에 실패하였습니다.', err);
    }
  }
}

const handleEdit = async (task) => {
  const newTitle = prompt("Task 제목 수정:", task.title);
  const newDescription = prompt("Task 설명 수정:", task.description);

  if(newTitle && newDescription) {
    try {
      const updatedTask = await updateTask(props.workspaceId, task.id, {
        title: newTitle,
        description: newDescription,
        status: task.status,
        done: task.done,
      });
      const index = tasks.value.findIndex(t => t.id === task.id);
      tasks.value[index] = updatedTask;
    } catch (err) {
      console.log("Task 수정에 실패했습니다.");
    }
  }
}

const handleDelete = async (taskId) => {
  if(confirm("정말 삭제하시겠습니까?")) {
    try {
      await deleteTask(props.workspaceId, taskId);
      tasks.value = tasks.value.filter(task => task.id !== taskId);
    } catch (err) {
      console.error('삭제에 실패했습니다.', err);
    }
  }
}

const handleStatusChange = async (task) => {
  console.log('태스크 상태 변경 시작!')
  try {
    const updatedTask = await updateTask(props.workspaceId, task.id, {
      title: task.title,
      description: task.description,
      status: task.status,
      done: task.done
    })
    const index = tasks.value.findIndex(t => t.id === task.id);
    tasks.value[index] = updatedTask;
  } catch(err) {
    return
  }
}

const getStatusClass = (status) => {
  switch (status) {
    case "completed":
      return "circle-completed";
    case "in-progress":
      return "circle-in-progress";
    case "pending":
      return "circle-pending";
    default:
      return "circle-default";
  }
}

onMounted(() => {
  loadTasks();
});
</script>

<style scoped>
.list-group {
  margin-top: 10px;
}

button {
  margin-left: 5px;
}

.circle {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  margin-right: 8px;
}

.circle-completed {
  background-color: green;
}

.circle-in-progress {
  background-color: orange;
}

.circle-pending {
  background-color: gray;
}

.circle-default {
  background-color: lightgray;
}

select {
  font-size: 0.85rem;
}
</style>