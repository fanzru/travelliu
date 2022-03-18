import React from 'react'
import { useRouter } from 'next/router'

function MainButton({className="", onClick = null, href = null, children }) {
  let router = useRouter()

  if (href == null && onClick == null) {
    href = "/"
  }

  const doOnclick = () => {
    if (onClick == null) {
      router.push(href)
      return
    }
    onClick()
  }

  return (
    <button className={'px-[19px] py-[12px] bg-black text-white font-bold rounded-[12px]' + " " + className} onClick={doOnclick}>
      {children}
    </button>
  )
}

export default MainButton