import React from 'react'
import Nav from './Nav'


function Layout({ children }) {
  return (
    <>
      <Nav />
      {/* <main className='max-w-[720px] border-2 border-black relative z-0 left-1/4 min-h-full pt-2'> */}
      <main>
        {children}
      </main>
    </>
  )
}

export default Layout