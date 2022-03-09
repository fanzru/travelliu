import axios from 'axios'

const api = axios.create({
  baseURL: process.env.NEXT_PUBLIC_BACKEND,
  withCredentials: true,
  headers: {
    'X-Requested-With': 'XMLHttpRequest'
  }
})

api.interceptors.response.use(response => response, error => {
  console.log(error.response)
  if (error.response.status === 401) {
      // Do if api is not authorized
      return Promise.reject()
  }

  return Promise.reject(error)
})

export default api;