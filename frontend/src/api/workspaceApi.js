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
    console.log("📡 워크스페이스 목록 가져오기 요청")
    const response = await api.get('/workspaces')
    console.log("✅ 워크스페이스 목록:", response.data)
    return response.data
  } catch (error) {
    console.error('워크스페이스 목록 가져오기 실패:', error.response?.data || error.message)
    throw error
  }
}