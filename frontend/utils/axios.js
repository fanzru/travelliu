import axios from 'axios'

const api = axios.create({
  baseUrl: process.env.NEXT_PUBLIC_BACKEND,
  withCredentials: true
})

api.interceptors.response.use(response => response, error => {
  if (error.response.status === 401) {
      // Do if api is not authorized
      return Promise.reject()
  }

  return Promise.reject(error)
})

export default api;