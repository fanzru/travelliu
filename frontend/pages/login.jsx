import jsCookie from 'js-cookie'
import { useState } from 'react'
import { api } from '../utils/apiHelper'
import { useRouter } from 'next/router'
import Router from 'next/router'
import MainButton from "../components/button/MainButton"
import SecondButton from "../components/button/SecondButton"

export default function login({ must_login }) {
  let router = useRouter()
  const [LoginForm, setLoginForm] = useState({
    email: '',
    password: ''
  })

  must_login = router.query["must_login"] == ""

  const [ErrorMessage, setErrorMessage] = useState({
    error : must_login ? "Kamu Harus Login Dulu" : "",
    message : must_login ? "Untuk melanjutkan laman yang dituju lakukan login terlebih dahulu" : "" 
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

  const onDaftarButton = async () => {
    router.push("/register")
  }

  return (
    <>
      <div className=' flex flex-col justify-center items-center h-screen'>
        <div className='w-[510px] flex flex-col gap-4'>
          <h1 className='font-bold text-[72px] text-center'>Bagikan Momentmu</h1>

          <p className='text-[18px] text-left'>Email</p>
          <input onChange={e => setLoginForm({ ...LoginForm, email: e.target.value })} className='border h-[62px] rounded-[15px] p-2' type="text" name="" id="" />

          <p className='text-[18px] text-left'>Password</p>
          <input onChange={e => setLoginForm({ ...LoginForm, password: e.target.value })} className='border h-[62px] rounded-[15px] p-2' type="password" name="" id="" />

          {
            ErrorMessage.error != "" ? 
          <div className='p-2 border-2 border-red-500 rounded-[15px] h-[120px] flex flex-col items-center justify-center'>
            {/* Login Error */}
            <h2 className='text-center text-[18px] font-bold text-red-500'>
              {ErrorMessage.error}
            </h2>
            <p className='text-ellipsis line-clamp-2 text-center'>{ErrorMessage.message}</p>
          </div>
          : <></>
          }

          <div className='flex justify-around'>
            <SecondButton className='w-[167px]' onClick={onDaftarButton}>
              Daftar
            </SecondButton>
            <MainButton className="w-[167px]" onClick={onSubmitLogin}>
              Masuk
            </MainButton>
          </div>

        </div>
      </div>
    </>
  )
}

export async function getServerSideProps(context) {
  if (context.query["must_login"] != undefined) {
    return {
      props: {
        must_login: true
      }
    }
  }

  return {
    props: {}
  }
}
