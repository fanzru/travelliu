import jsCookie from 'js-cookie'
import { useState } from 'react'
import { api } from '../utils/apiHelper'
import { useRouter } from 'next/router'
import MainButton from "../components/button/MainButton"
import SecondButton from "../components/button/SecondButton"
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

export default function login({ must_login }) {
  let router = useRouter()
  const [LoginForm, setLoginForm] = useState({
    email: '',
    password: ''
  })

  must_login = router.query["must_login"] == ""

  const [ErrorMessage, setErrorMessage] = useState({
    error: must_login ? "Kamu Harus Login Dulu" : "",
    message: must_login ? "Untuk melanjutkan laman yang dituju lakukan login terlebih dahulu" : ""
  })

  const onSubmitLogin = (e) => {
    e.preventDefault()
    // Bagian ini harus ada setidaknya sekali untuk sessioning, lebih aman kalau misalkan ada di setiap post request
    api().get("/sanctum/csrf-cookie").then(
      api().post("/api/login", LoginForm)
        .then(() => {
          setErrorMessage({
            error: "Login Berhasil", 
            message: "Mengarahkan ke laman utama"
          })
          jsCookie.set("auth", true)
          setTimeout(() => {
            router.push("/")
          }, 2000);
        })
        .catch((e) => {
          if (e.response && e.response.status != 500) {
            toast.error(e.response.data);
            return
          }
          toast.error("Server Error, Coba lagi nanti");
        })
    )
  }

  const onDaftarButton = async () => {
    router.push("/register")
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
      <div className=' flex flex-col justify-center items-center h-screen'>
        <div className='max-w-[510px] flex flex-col gap-4 mx-2'>
          <h1 className='font-bold text-[72px] text-center'>Bagikan Momentmu</h1>

          <p className='text-[18px] text-left'>Email</p>
          <input onChange={e => setLoginForm({ ...LoginForm, email: e.target.value })} className='border h-[62px] rounded-[15px] p-2' type="text" name="" />

          <p className='text-[18px] text-left'>Password</p>
          <input onChange={e => setLoginForm({ ...LoginForm, password: e.target.value })} className='border h-[62px] rounded-[15px] p-2' type="password" name="" />

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
