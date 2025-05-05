import axios from 'axios'

const api = axios.create({
  baseURL: 'http://localhost:3000', // Rails API 주소
  withCredentials: true // 세션 방식일 경우 필요
})

export default api