import api from '../lib/axios.js'

export const createWorkspace = async (name, description) => {
  try {
    const res = await api.post('/workspaces', {
      workspace: {
        name,
        description
      }
    })
    console.log(res);
    return res.data
  } catch (error) {
    console.error('워크스페이스 생성 실패:', error.response?.data || error.message)
    throw error
  }
}

export const fetchWorkspaces = async () => {
  try {
    const response = await api.get('/workspaces')
    // console.log("워크스페이스 목록:", response.data)
    return response.data
  } catch (error) {
    console.error('워크스페이스 목록 가져오기 실패:', error.response?.data || error.message)
    throw error
  }
}

export const deleteWorkspace = async (id) => {
  try {
    console.log(`📡 워크스페이스 삭제 요청: ${id}`)
    const response = await api.delete(`/workspaces/${id}`)
    console.log("워크스페이스 삭제 성공:", response.data)
    return response.data
  } catch (error) {
    console.error('워크스페이스 삭제 실패:', error.response?.data || error.message)
    throw error
  }
}

export const fetchWorkspaceDetail = async (id) => {
  try {
    const response = await api.get(`/workspaces/${id}`)
    // console.log("워크스페이스 상세 정보:", response.data)
    return response.data
  } catch (error) {
    console.error('워크스페이스 상세 정보 가져오기 실패:', error.response?.data || error.message)
    throw error
  }
}

export const updateWorkspace = async (id, name, description) => {
  try {
    const response = await api.put(`/workspaces/${id}`, {
      workspace: {
        name,
        description
      }
    })
    console.log("워크스페이스 수정 성공:", response.data)
    return response.data
  } catch (error) {
    console.error('워크스페이스 수정 실패:', error.response?.data || error.message)
    throw error
  }
}

export const joinWorkspace = async (workspaceId) => {
  try {
    const res = await api.post(`/workspaces/${workspaceId}/join`)
    console.log(res);
    return res.data
  } catch (err) {

  }
}

export const getParticipants = async (workspaceId) => {
  try {
    const res = await api.get(`/workspaces/${workspaceId}/participants`)
    return res.data;
  } catch (err) {
    console.error('参加者目録読み込み失敗', err);
  }
}

export const leaveWorkspace = async (workspaceId) => {
  try {
    const res = await api.delete(`/workspaces/${workspaceId}/leave`);
    return res.data
  } catch (err) {
    console.error('ワークスペース脱退');
  }
}