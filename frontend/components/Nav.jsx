import React, { useEffect, useState } from 'react'
import MainButton from './button/MainButton'
import jsCookie from 'js-cookie'
import { authApi } from '../utils/apiHelper'
import Link from 'next/link'
import {BiMenu} from 'react-icons/bi'
export default function Nav() {
  let auth = jsCookie.get('auth')

  const handleLogout = async () => {
    let result = await authApi().post("/api/logout")
    if (result.status == 200) {
      jsCookie.remove('auth')
      jsCookie.remove('main_token')
      jsCookie.remove('personal_token')
      jsCookie.remove('laravel_session')
      jsCookie.remove('token')
      window.location.replace("login")
    }
  }

  useEffect(() => {
  }, [auth])

  return (
    <>
      <nav className='fixed w-full bg-white h-[70px] px-[30px] flex items-center justify-between border-b-2 border-dashed border-black z-50'>
        <Link href="/">
          <a >
            <h1 className='font-bold text-[25px]'>
              Travelliu
            </h1>
          </a>
        </Link>
        <div className='hidden gap-[30px] items-center md:flex'>
          <Link href="/">
            <a className='text-[17px]'>Timeline</a>
          </Link>
          {
            auth == "true" ?
              <>
                <Link href="/myprofile">
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
        <div className='md:hidden'>
          <div className="dropdown dropdown-end ">
            <label tabIndex="0" className="btn btn-ghost rounded-btn"><BiMenu/></label>
            <ul tabIndex="0" className="menu dropdown-content p-2 shadow bg-base-100 rounded-box w-52 mt-4">
              <Link href="/">
                <a className='text-[17px]  w-full h-[50px] flex items-center justify-center'>Timeline</a>
              </Link>
              {
                auth == "true" ?
                  <>
                    <Link href="/myprofile">
                      <a className='text-[17px]  w-full h-[50px] flex items-center justify-center '>My Profile</a>
                    </Link>
                    {/* Need to make div because of  MainButton bug */}
                    <div>
                      <button onClick={handleLogout} className='text-[17px]  w-full h-[50px] flex items-center justify-center' href="/">Logout</button>
                    </div>
                  </>
                  :
                  <Link href="/login">
                    <a className='text-[17px]  w-full h-[50px] flex items-center justify-center'>Login</a>
                  </Link>
                  
              }
              <Link href="/tikum">
                <a className='text-[17px]  w-full h-[50px] flex items-center justify-center'>Tikum</a>
              </Link>
              <MainButton href="/">Download</MainButton>
            </ul>
          </div>
        </div>
      </nav>
      <div className='w-full h-[65px]'>
      </div>
    </>
  )
}
