import Head from 'next/head'
import Image from 'next/image'
// import styles from '../styles/Home.module.css'
import api from '../utils/api'

import { useState, useEffect } from 'react'

export default function Home() {
  const [LoginForm, setLoginForm] = useState({
    email: '',
    password: ''
  })

  const onSubmitLogin = async (e) => {
    e.preventDefault()
    // Bagian ini harus ada setidaknya sekali untuk sessioning, lebih aman kalau misalkan ada di setiap post request
    let result = await api.get("/sanctum/csrf-cookie")
    console.log(result)
    if ( result.status != 204 ) {
      console.log("Error getting CSRF token")
    }

    result = await api.post("/api/login", LoginForm)
  }

  return (
    <div className='flex flex-col justify-center items-center h-screen'>
      <h1>Login</h1>
      <h2>Email</h2>
      <input onChange={e => setLoginForm({ ...LoginForm, email: e.target.value })} className='border' type="text" name="" id="" />
      <h2>Password</h2>
      <input onChange={e => setLoginForm({ ...LoginForm, password: e.target.value })} className='border' type="text" name="" id="" />
      <button onClick={onSubmitLogin} type="submit">Login!</button>
    </div>
  )
}
