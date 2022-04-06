import { BiTrash } from 'react-icons/bi'
import { AiOutlineStar } from 'react-icons/ai'
import { useRouter } from 'next/router'
import { authApi } from "../utils/apiHelper";
import { useEffect, useState } from 'react'
import LoadingSpinner from "../components/LoadingSpinner";

export default function ProfilSendiri() {
  const [data, setData] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    authApi().get(`/api/user`)
      .then((res) => {
        setData(res.data)
        setLoading(false)
      })
      .catch(e => {
        console.log(e)
      })
  },[])

  if ((data == null)) return <LoadingSpinner />

  return (
    <div className="flex justify-center">
      <div className="border-2 max-w-[720px] w-full min-h-screen">
        <div className="hero container max-w-screen-lg justify-center pt-10">
          <img className="object-cover h-[160px] w-[160px] rounded-full" src="/kiseki-no-sedai.jpeg" alt="" />
        </div>
        <div className="hero container max-w-screen-lg justify-center pb-2 pt-2">
          <p className='text-[37.54px] font-bold'>
            {data.user.name}
          </p>
        </div>
        <div className='flex justify-center'>
          <div className='w-[350px] grid grid-cols-2'>
            <div className='text-center'>
              <p className='underline'>Total Review</p>
              <p>{data.total_review}</p>
            </div>
            <div className='text-center'>
              <p className='underline'>Rataan Rating</p>
              <p>{data.avg_ratings}</p>
            </div>
          </div>
        </div>
        {
          data.review.map((review, idx) => {
            return (
              <div key={idx} className="mt-[20px] border-b border-black">
                <div className='mt-[4px] flex items-center justify-between h-[50px] p-[12px]'>
                  <a href="/myprofile">
                    <div className="flex items-center">
                      <img className="object-cover h-[35px] w-[35px] rounded-full" src="/kiseki-no-sedai.jpeg" alt="" />
                      <p className="mx-2 text-[18px] font-bold">{data.user.name}</p>
                    </div>
                  </a>
                  <button className='text-[18px] text-red-500'>
                    <BiTrash />
                  </button>
                </div>
                <img src="/kiseki-no-sedai.jpeg" alt="" className='object-cover h-[300px] w-full' />
                <div className='mt-[4px] flex items-center h-[50px] p-[12px]'>
                  <AiOutlineStar />
                  4.4
                  <p className="mx-2 text-[18px] font-bold">{review.nama_tempat}</p>
                </div>
                <div className='mt-[2px] flex items-center h-[50px] p-[12px]'>
                  <p className='text-[14px] line-clamp-2'>{review.review}</p>
                </div>
              </div>
            )
          })
        }
      </div>
    </div>

  )
}