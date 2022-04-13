
import { authApi } from "../utils/apiHelper";
import { useEffect, useState } from 'react'
import LoadingSpinner from "../components/LoadingSpinner";
import CardProfile from '../components/CardProfile';

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
          <img className="object-cover h-[160px] w-[160px] rounded-full" src="/affan-imut.jpeg" alt="" />
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
              <CardProfile data={data} review={review} key={idx}/>
            )
          })
        }
      </div>
    </div>

  )
}