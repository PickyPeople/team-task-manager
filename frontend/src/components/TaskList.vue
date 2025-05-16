<template lang="pug">
div.container.mt-5.pb-3
  div.d-flex.justify-content-between.align-items-center.mb-3
    h4 📋 タスク一覧
      div.d-flex.align-items-center.mt-4.gap-2
        select.form-select.form-select-sm.w-auto.mr-2(v-model="selectedUserId")
          option(:value="null") 全員
          option(v-for="user in userList" :key="user.id" :value="user.id") {{ user.name }}
        template(v-if="isParticipant || isMine")
         button.btn.btn-primary(@click="handleCreate") ➕ Taskを追加

  ul.list-group
    li.list-group-item.d-flex.justify-content-between.align-items-center(v-for="task in filteredTasks" :key="task.id")
      div.d-flex.align-items-center.gap-2
        div.circle(:class="getStatusClass(task.status)")
        div.ml-2 {{ task.title }} - {{ task.description }} 
        div.creator.text-muted.small 作成者: {{ task.creator_name || '不明' }}
      div.d-flex.align-items-center
        template(v-if="(task.assignee_id === currentUserId) && (isParticipant || isMine)")
          select.form-select.form-select-sm.w-auto(v-model="task.status" @change="handleStatusChange(task)")
            option(value="pending") 対応待ち
            option(value="in-progress") 対応中
            option(value="completed") 対応済み
          button.btn.btn-outline-warning.btn-sm.ml-2(@click="handleEdit(task)") ✏️
          button.btn.btn-outline-danger.btn-sm.ml-1(@click="handleDelete(task.id)") 🗑️
</template>

<script setup>
import { ref, onMounted,computed } from 'vue';
import { fetchTasks, deleteTask, createTask, updateTask } from '../api/taskApi';
import { useTaskStore } from '../stores/taskStore';

const props = defineProps({
  workspaceId: { type: Number, required: true },
  isParticipant: { type: Boolean },
  isMine: { type: Boolean },
  currentUserId: Number,
  userList: {
    type: Array,
    default: () => []
  }
})

console.log(props.userList)

const emit = defineEmits(['taskChanged'])
const taskStore = useTaskStore()
const selectedUserId = ref(null)

const filteredTasks = computed(() => {
  if (!selectedUserId.value) return taskStore.tasks
  return taskStore.tasks.filter(task => task.assignee_id === Number(selectedUserId.value))
})

const handleCreate = async () => {
  const title = prompt("Taskのタイトルを入力してください");
  const description = prompt("Taskの説明を入力してください");

  if(title && description) {
    try {
      const newTask = await createTask(props.workspaceId, {
        title,
        description,
        status: "pending",
        done: false,
        assignee_id: props.currentUserId
      });
      taskStore.addTask(newTask);
      emit('taskChanged')
    } catch (err) {
        console.log('태스크 생성에 실패하였습니다.', err);
    }
  }
}

const handleEdit = async (task) => {
  const newTitle = prompt("Taskのタイトル修正:", task.title);
  const newDescription = prompt("Taskの説明を修正:", task.description);

  if(newTitle && newDescription) {
    try {
      const updatedTask = await updateTask(props.workspaceId, task.id, {
        title: newTitle,
        description: newDescription,
        status: task.status,
        done: task.done,
      });
      taskStore.updateTask(updatedTask);
    } catch (err) {
      console.log("Task 수정에 실패했습니다.");
    }
  }
}

const handleDelete = async (taskId) => {
  if(confirm("本当に削除しますか？？")) {
    try {
      await deleteTask(props.workspaceId, taskId);
      taskStore.deleteTask(taskId);
      emit('taskChanged')
    } catch (err) {
      console.error('삭제에 실패했습니다.', err);
    }
  }
}

const handleStatusChange = async (task) => {
  try {
    const updatedTask = await updateTask(props.workspaceId, task.id, {
      title: task.title,
      description: task.description,
      status: task.status,
      done: task.done,
      assignee_id: props.currentUserId
    })
    taskStore.updateTask(updatedTask);
    emit('taskChanged')
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
.creator {
  margin-left: 14px;
}
</style>