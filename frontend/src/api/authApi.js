import api from "../lib/axios";

export const login = async (email, password) => {
  try {
    const res = await api.post('/login', {
      email, password
    })

    localStorage.setItem('token', res.data.token);

    return res.data
  } catch(error) {
    console.error('로그인 실패')
  }
}