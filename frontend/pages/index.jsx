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
    let res = api.get("/api/login")
    console.log(res)
  }

  useEffect(() => {
    console.log(LoginForm)
  }, [LoginForm])

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
