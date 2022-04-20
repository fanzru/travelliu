import React from 'react'
import Nav from './Nav'


function Layout({ children }) {
  return (
    <>
      <Nav />
      <div className='flex justify-center'>
        <main className='w-[720px] border-2 border-black relative z-0 min-h-full pt-2'>
          {children}
        </main>
      </div>
    </>
  )
}

export default Layout