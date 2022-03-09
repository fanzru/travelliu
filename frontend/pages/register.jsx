import React from 'react'
import api from '../utils/api'
import axios from 'axios'
import { useState, useEffect } from 'react'

function Register() {

  const [registerForm, setRegisterForm] = useState({
    email: '',
    password: '',
    name: ''
  })

  const onSubmitLogin = (e) => {
    e.preventDefault()
    api.get("/sanctum/csrf-cookie").then(() => {
      api.post("/api/register", registerForm).then(res => {
        console.log(res)
      })
    })
  }

  return (
    <div className='flex flex-col justify-center items-center h-screen'>
      <h1>Register</h1>
      <h2>Nama</h2>
      <input onChange={e => setRegisterForm({ ...registerForm, name: e.target.value })} className='border' type="text" name="" id="" />
      <h2>Email</h2>
      <input onChange={e => setRegisterForm({ ...registerForm, email: e.target.value })} className='border' type="email" name="" id="" />
      <h2>Password</h2>
      <input onChange={e => setRegisterForm({ ...registerForm, password: e.target.value })} className='border' type="password" name="" id="" />
      <button onClick={onSubmitLogin} type="submit">Register!</button>
    </div>
  )
}

export default Register