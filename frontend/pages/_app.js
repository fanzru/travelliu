import '../styles/globals.css'
import api from '../utils/axios' // Untuk menggunakan axios
import { useEffect } from 'react'

function MyApp({ Component, pageProps }) {
  return <Component {...pageProps} />
}

export default MyApp