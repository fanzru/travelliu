// Only use this on client side
import axios from 'axios'
import jsCookie from 'js-cookie';

const api = () => {
  const api = axios.create({
    baseURL: process.env.NEXT_PUBLIC_BACKEND,
    withCredentials: true,
  })
  return api
}

const authApi = () => {
  const ax = axios.create({
    baseURL: process.env.NEXT_PUBLIC_BACKEND,
    withCredentials: true,
  })
  let token = jsCookie.get('token')
  ax.defaults.headers.common['Authorization'] = `Bearer ${token}`;
  ax.interceptors.response.use(res => { return res }, e => {
    // Redirect to login page
    if (e.response && e.response.status == 401) {
      window.location.replace("/login?must_login")
      jsCookie.remove('auth')
    }
    console.log(e)
    return Promise.reject(e)
  })

  return ax
}

export { authApi, api };
