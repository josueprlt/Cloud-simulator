import axios from 'axios'

const api = axios.create({
  baseURL: 'http://localhost:8000/api',
})

// Intercepteur pour ajouter le token à chaque requête
api.interceptors.request.use(config => {
    if (!config.url.includes('/auth/login_check')) {
  const token = sessionStorage.getItem('token')
  
  if (token) {
    config.headers.Authorization = `Bearer ${token}`
  }
}
  return config
}, error => {
  return Promise.reject(error)
})

export default api
