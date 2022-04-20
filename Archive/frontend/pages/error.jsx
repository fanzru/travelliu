import React from 'react'
import MainButton from "../components/button/MainButton"
import { useRouter } from 'next/router'

function ErrorPage() {
  const router = useRouter()
  return (
    <div className='h-screen flex justify-center pt-5'>
      <div className='w-[500px] flex items-center flex-col gap-2'>
        <img src="/construct.svg" alt="" />
        <h1 className='font-bold text-[40px] text-center'>Opps Sepertinya Ada Masalah</h1>
        <p className='text-center'>Mohon coba lagi nanti yaa</p>
        <MainButton onClick={() => {router.push("/")}} className='w-[167px]'>
          TIMELINE
        </MainButton>
      </div>
    </div>
  )
}

export default ErrorPage