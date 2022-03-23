import React from 'react'
import { api } from '../utils/apiHelper'
import { useState, useEffect } from 'react'

function Register() {
  const [errorHandler,setErrorHandler] = useState(false)
  const [registerForm, setRegisterForm] = useState({
    email: '',
    password: '',
    name: ''
  })
  const onSubmitRegister = async (e) => {
    e.preventDefault()
    // Bagian ini harus ada setidaknya sekali untuk sessioning, lebih aman kalau misalkan ada di setiap post request
    try {
      let result = await api.get("/sanctum/csrf-cookie")
    console.log(result)
    if (result.status != 204) {
      console.log("Error getting CSRF token")
    }

    result = await api.post("/api/register", registerForm)
    console.log(result)
    } catch {
      setErrorHandler(true)
    }
    
  }

  return (
    <>

      <div className='flex flex-col justify-center items-center h-screen'>
        <div className="max-w-[510px] w-full px-2">
        <h1 className=" font-bold text-[72px] text-center">Register</h1>
        <h2 className="text-left">Nama</h2>
          <input onChange={e => setRegisterForm({ ...registerForm, name: e.target.value })} className='w-full border h-[62px] rounded-[15px] p-2' type="text" name="" id="" />
          <h2>Email</h2>
          <input onChange={e => setRegisterForm({ ...registerForm, email: e.target.value })} className='w-full border h-[62px] rounded-[15px] p-2' type="email" name="" id="" />
          <h2>Password</h2>
          <input onChange={e => setRegisterForm({ ...registerForm, password: e.target.value })} className='w-full border h-[62px] rounded-[15px] p-2' type="password" name="" id="" />
          {
            errorHandler ? 
            <div className='p-2 border-2 border-red-500 rounded-[15px] h-[120px] flex flex-col items-center justify-center mt-10'>
            {/* Login Error */}
            <h2 className='text-center text-[18px] font-bold text-red-500'>
              {"Ada Kesalahan"}
            </h2>
            <p className='text-ellipsis line-clamp-2 text-center'>{"Jangan lupa di cek lagi ya formnya"}</p>
          </div>: <></>
          }
          
        </div>

        <button onClick={onSubmitRegister} className="mt-10 btn" type="submit">Register!</button>
        
      </div>
    </>
  )
}

export default Register