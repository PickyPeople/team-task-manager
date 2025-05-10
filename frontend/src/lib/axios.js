import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:3000',
  headers: {
    'Content-Type': 'application/json',
  },
  withCredentials: true,  //이 설정이 있어야 쿠키가 전달됨
})


// 요청 인터셉터 설정
api.interceptors.request.use(
  (config) => {

    const token = localStorage.getItem('token')

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
