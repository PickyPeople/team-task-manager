import api from "../lib/axios";

export const fetchTasks = async (workspaceId) => {
  try {
    const res = await api.get(`workspaces/${workspaceId}/tasks`);
    return res.data
  } catch (err) {
    console.error('테스크 목록을 불러오지 못했습니다.', err);
    throw err;
  }
}

export const createTask = async (workspaceId, taskData) => {
  try {
    const res = await api.post(`workspaces/${workspaceId}/tasks`, taskData);
    return res.data;
  } catch (err) {
    console.error("Task 생성에 실패했습니다.", err);
    throw err;
  }
}

export const updateTask = async (workspaceId, taskId, taskData) => {
  console.log('태스크 수정 시작!')
  try {
    const res = await api.patch(`/workspaces/${workspaceId}/tasks/${taskId}`, {
      task: taskData
    });
    return res.data;
  } catch (err) {
    console.error("Task 수정에 실패했습니다.", err);
    throw err;
  }
}

export const deleteTask = async (workspaceId, taskId) => {
  try {
    await api.delete(`workspaces/${workspaceId}/tasks/${taskId}`)
    console.log("task 삭제했습니다.");
  } catch (err) {
     console.error("Task 삭제에 실패했습니다.", err);
     throw err;
  }
}