import React, { useEffect, useState } from 'react'
import MainButton from './button/MainButton'
import jsCookie from 'js-cookie'
import { authApi } from '../utils/apiHelper'
import Link from 'next/link'

export default function Nav() {
  let auth = jsCookie.get('auth')

  const handleLogout = async () => {
    let result = await authApi().post("/api/logout")
    console.log(result)
    if (result.status == 200) {
      jsCookie.remove('auth')
      jsCookie.remove('main_token')
      jsCookie.remove('personal_token')
      jsCookie.remove('laravel_session')
      window.location = "/login"
    }
  }

  useEffect(() => {
    console.log(auth)
  }, [auth])

  return (
    <>
      <nav className='fixed w-full bg-white h-[70px] px-[57px] flex items-center justify-between border-b border-black z-50'>
        <Link href="/">
          <a >
            <h1 className='font-bold text-[25px]'>
              Travelliu
            </h1>
          </a>
        </Link>
        <div className='flex gap-[30px] items-center'>
          <Link href="/">
            <a className='text-[17px]'>Timeline</a>
          </Link>
          {
            auth == "true" ?
              <>
                <Link href="/">
                  <a className='text-[17px]'>My Profile</a>
                </Link>
                {/* Need to make div because of  MainButton bug */}
                <div>
                  <button onClick={handleLogout} className='text-[17px]' href="/">Logout</button>
                </div>
              </>
              :
              <Link href="/login">
                <a className='text-[17px]'>Login</a>
              </Link>
          }
          <MainButton href="/">Download</MainButton>
        </div>
      </nav>
      <div className='w-full h-[65px]'>
      </div>
    </>
  )
}