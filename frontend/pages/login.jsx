import jsCookie from 'js-cookie'
import { useState } from 'react'
import { api } from '../utils/apiHelper'
import { useRouter } from 'next/router'
import Router from 'next/router'

export default function Home() {
  let router = useRouter()

  const [LoginForm, setLoginForm] = useState({
    email: '',
    password: ''
  })

  const onSubmitLogin = async (e) => {
    e.preventDefault()
    // Bagian ini harus ada setidaknya sekali untuk sessioning, lebih aman kalau misalkan ada di setiap post request
    let result = await api().get("/sanctum/csrf-cookie")
    console.log(result)
    if (result.status != 204) {
      console.log("Error getting CSRF token")
    }

    result = await api().post("/api/login", LoginForm)
    if (result.status == 200) {
      // jsCookie.set('main_token', result.data.token)
      jsCookie.set("auth", true)
      Router.push("/")
    }
  }

  return (
    <>
      <div className=' flex flex-col justify-center items-center h-screen'>
        <h1>Login</h1>
        <h2>Email</h2>
        <input onChange={e => setLoginForm({ ...LoginForm, email: e.target.value })} className='border' type="text" name="" id="" />
        <h2>Password</h2>
        <input onChange={e => setLoginForm({ ...LoginForm, password: e.target.value })} className='border' type="text" name="" id="" />
        <button onClick={onSubmitLogin} type="submit">Login!</button>
      </div>
    </>
  )
}
