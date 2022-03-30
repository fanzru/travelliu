import React from 'react'
import { api } from '../utils/apiHelper'
import { useState, useEffect } from 'react'
import MainButton from '../components/button/MainButton'
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

function Register() {
  const [registerForm, setRegisterForm] = useState({
    email: '',
    password: '',
    name: ''
  })
  const onSubmitRegister = (e) => {
    e.preventDefault()
    api().get("/sanctum/csrf-cookie").then(
      api().post("/api/register", registerForm)
        .then(() => {
          router.push("/login")
        })
        .catch((e) => {
          if (e.response && e.response.status != 500) {
            toast.error(e.response.data);
            return
          }
          toast.error("Server Error, Coba lagi nanti");
        })
    ).catch(e => {
      toast.error("Server Error, Coba lagi nanti");
    })
  }

  return (
    <>
      <ToastContainer
        position="bottom-right"
        autoClose={5000}
        hideProgressBar={false}
        newestOnTop={false}
        closeOnClick
        rtl={false}
        pauseOnFocusLoss
        draggable
        pauseOnHover
      />
      <div className='flex flex-col justify-center items-center h-screen'>
        <div className="max-w-[510px] w-full px-2">
          <h1 className=" font-bold text-[72px] text-center">Register</h1>
          <h2 className="text-left">Nama</h2>
          <input onChange={e => setRegisterForm({ ...registerForm, name: e.target.value })} className='w-full border h-[62px] rounded-[15px] p-2' type="text" name="" />
          <h2>Email</h2>
          <input onChange={e => setRegisterForm({ ...registerForm, email: e.target.value })} className='w-full border h-[62px] rounded-[15px] p-2' type="email" name="" />
          <h2>Password</h2>
          <input onChange={e => setRegisterForm({ ...registerForm, password: e.target.value })} className='w-full border h-[62px] rounded-[15px] p-2' type="password" name="" />

        </div>

        <MainButton onClick={onSubmitRegister} className="mt-10" type="submit">Register!</MainButton>

      </div>
    </>
  )
}

export default Register