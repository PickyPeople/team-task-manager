import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:3000',
  headers: {
    'Content-Type': 'application/json',
  },
  withCredentials: true,  // ✅ 이 설정이 있어야 쿠키가 전달됨
})


// 요청 인터셉터 설정
api.interceptors.request.use(
  (config) => {
    console.log("🔎 인터셉터 실행됨")  // ✅ 여기가 찍혀야 함

    const token = localStorage.getItem('token')
    console.log("📡 Authorization 토큰: ", token)  // ✅ 토큰이 있는지 확인

    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`
    } else {
      console.error("🚫 토큰이 존재하지 않습니다.")
    }
    return config
  },
  (error) => Promise.reject(error)
)

export default api;
