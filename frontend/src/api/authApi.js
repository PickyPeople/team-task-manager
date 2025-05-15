import api from "../lib/axios";

export const login = async (email, password) => {
  try {
    const res = await api.post('/login', {
      email, password
    })

    localStorage.setItem('token', res.data.token);
    console.log(res.data)

    return res.data
  } catch(error) {
    console.error('로그인 실패')
  }
}

export const signup = async (name, email, password) => {
  try {
    const res = await api.post('/signup', {
      name,
      email,
      password
    })

    console.log(res.data);

    return res.data;
  } catch(err) {
    console.error('회원가입 실패:', err.res?.data || err.message)
    throw err
  }
}

export const logout = async() => {
  try {
    const res = await api.post('/logout')
    return res.data;
  } catch (err) {
    console.error(err);
  }
}