import React from 'react'
import Link from 'next/link'
import { AiOutlineStar } from 'react-icons/ai'
import { MdOutlineComment } from 'react-icons/md'
export default function CardTimeline({ data }) {
  let text = data.review.slice(0, 200) + " ..."
  return (
    <>
      {/* Soal COTS menambahkan shadow-md dan rounded-xl */}
      <div className="flex justify-center shadow-md rounded-xl">
      {/*  */}
        <div className="max-w-[720px] w-full">
          <div className="mt-[4px] flex items-center h-[50px] p-[12px]">
            <Link href={"/profil/"+data.user.id}>
              <a className="flex items-center">
                <img src={data.photo} alt="" className="object-cover h-[35px] w-[35px] rounded-full" />
                <p className='mx-2 font-bold uppercase'>{data.user.name}</p>
              </a>
            </Link>
          </div>
          <Link href={"/review/"+data.id}>
          <a >
          <img src={data.photo} alt="" className="object-cover h-[300px] w-full" />
          </a>
          </Link>
          <div className='mt-[4px] h-[130px] p-[12px] '>
            <div className='flex items-center h-[30px]'>
              <p className='text-[18px] text-yellow-500'><AiOutlineStar /></p>
              <p className='ml-1'>{data.rating}</p>
              <Link href={"/review/"+data.id}>
              <a className='mx-2 font-bold underline underline-offset-1'>
                {data.nama_tempat}
              </a>
              </Link>
            </div>
            <p className="overflow-hidden line-clamp-2">
              {text}
            </p>
            <div className='flex justify-end items-center mt-2 '>
              <Link href={"/review/"+data.id}>
                <a className='flex items-center'>
                  <MdOutlineComment />
                </a>
              </Link>
              <p className='ml-2'>{data.komentar_count}</p>
            </div>
          </div>
        </div>
      </div>
    </>
  )
}