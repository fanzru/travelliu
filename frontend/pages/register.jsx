import React from 'react'
import { api } from '../utils/apiHelper'
import { useState, useEffect } from 'react'

function Register() {

  const [registerForm, setRegisterForm] = useState({
    email: '',
    password: '',
    name: ''
  })

  const onSubmitRegister = async (e) => {
    e.preventDefault()
    // Bagian ini harus ada setidaknya sekali untuk sessioning, lebih aman kalau misalkan ada di setiap post request
    let result = await api.get("/sanctum/csrf-cookie")
    console.log(result)
    if (result.status != 204) {
      console.log("Error getting CSRF token")
    }

    result = await api.post("/api/register", registerForm)
    console.log(result)
  }

  return (
    <>

      <div className='flex flex-col justify-center items-center h-screen'>
        <h1>Register</h1>
        <h2>Nama</h2>
        <input onChange={e => setRegisterForm({ ...registerForm, name: e.target.value })} className='border' type="text" name="" id="" />
        <h2>Email</h2>
        <input onChange={e => setRegisterForm({ ...registerForm, email: e.target.value })} className='border' type="email" name="" id="" />
        <h2>Password</h2>
        <input onChange={e => setRegisterForm({ ...registerForm, password: e.target.value })} className='border' type="password" name="" id="" />
        <button onClick={onSubmitRegister} type="submit">Register!</button>
      </div>
    </>
  )
}

export default Register