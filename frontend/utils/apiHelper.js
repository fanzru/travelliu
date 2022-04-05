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
  ax.interceptors.response.use(res => { return res }, e => {
    // Redirect to login page
    if (e.response && e.response.status == 403) {
      window.location.replace("/login?must_login")
      jsCookie.remove('auth')
    }
    console.log(e)
    return Promise.reject(e)
  })

  return ax
}

export { authApi, api };
