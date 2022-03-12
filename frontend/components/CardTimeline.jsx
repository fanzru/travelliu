import React from 'react'
import {BiTrash} from 'react-icons/bi'
import {AiOutlineStar} from 'react-icons/ai'
import {MdOutlineComment} from 'react-icons/md'
export default function CardTimeline({props}) {
  return (
    <>
      <div className="flex justify-center">
        <div className="border-2 max-w-[720px] w-full">
          <div className="mt-[4px] flex items-center h-[50px] p-[12px]">
            <div className="flex items-center">
              <img src="/kiseki-no-sedai.jpeg" alt="" className="object-cover h-[35px] w-[35px] rounded-full" />
              <p className='mx-2 font-bold'>Shabrina Retno Ningsih</p>
            </div>
          </div>
          <img src="/kiseki-no-sedai.jpeg" alt="" className="object-cover h-[300px] w-full" />
          <div className='mt-[4px] h-[130px] p-[12px] '>
            <div className='flex items-center h-[30px]'>
              <p className='text-[18px] text-yellow-500'><AiOutlineStar /></p>
              <p className='ml-1'>4.5</p>
              <button className='mx-2 font-bold underline underline-offset-1'>
                Negeri Isakai
              </button>
            </div>
            <p className="overflow-hidden line-clamp-2">
              Negeri ini sangat indah dimana hati, otak dan pikiran akan selalu tenang karena tempat yang dapat membuat semua beban terlepas serta mendapatkan ketenangan jiwa hhe :) ....
            </p>
            <div className='flex justify-end items-center mt-2 '>
              <button className='flex items-center '>
                <MdOutlineComment />
                <p className='ml-2'>2</p>
              </button>
            </div>
          </div>
        </div>
      </div>
    </>
  )
}