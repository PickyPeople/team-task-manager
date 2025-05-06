import axios from 'axios';

const api = axios.create({
  baseURL: 'http://localhost:3000',
  // withCredentials: true // 세션 기반 인증 시 사용
});

// 요청 인터셉터 설정
api.interceptors.request.use(
  config => {
    const token = localStorage.getItem('token'); // 또는 적절한 저장소에서 토큰을 가져옵니다.
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`;
    }
    return config;
  },
  error => Promise.reject(error)
);

export default api;
