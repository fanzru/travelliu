import { AiOutlineStar } from 'react-icons/ai'
import {HiOutlineLocationMarker} from 'react-icons/hi'
import { useRouter } from 'next/router'
import { api } from "../../utils/apiHelper";
import {useEffect,useState} from 'react'
import LoadingSpinner from "../../components/LoadingSpinner";
export default function ReviewById(props){
  const router = useRouter()
  const [data,setData] = useState([])
  const [loading,setLoading] = useState(true)
  useEffect( () => {
    let {id} = router.query
    api().get(`/api/review/${id}`)
    .then((res) => {
      setData(res.data)
      setLoading(false)
    })
    .catch(e => {
      // console.log(e)
    }) 
    
  
  }, [])

  if ((data.length == 0 )) return <LoadingSpinner/>


  return (
    <>
      <div className="flex justify-center">
        <div className=" max-w-[720px] w-full min-h-screen">
          <img src={data.photo} alt="" className="object-cover h-[300px] w-full"/>
          <div className="mt-[4px] flex items-center justify-between h-[50px] p-[12px]">
            <div className="flex items-center">
              <img src="/kiseki-no-sedai.jpeg" alt="" className="object-cover h-[35px] w-[35px] rounded-full"/>
              <p className="ml-4 text-[18px] font-bold">{data.user?.name}</p>
            </div>

          </div>
          <div className="flex px-[12px] items-center">
            <div className="flex  items-center  ">
              <AiOutlineStar/>
              <p className="ml-1">
                {data.rating}
              </p>
            </div>
            <div className="font-bold ml-4">
              {data.nama_tempat}
            </div>
          </div>
          <div className="px-[12px] text-[14px]">
            {data.review}
          </div>
          <div className="flex px-[12px] mt-4">
            <div className="btn  ">
              <HiOutlineLocationMarker/>
            </div>
            <div className=" ml-[10px] w-full text-[14px]">
              {data.alamat}
            </div>
          </div>
          <form className="p-[12px] flex items-center">
            <input type="text" placeholder="Maksimal 300 Karakter" className="input input-bordered w-full mr-4"/>
            <button className="btn " >Balas</button>
          </form>
            {
              data.komentar?.map((komen,idx)=>{
                return (
                  <div key={idx} className="border border-black mx-[12px] p-4 rounded-md">
                    <div className="font-bold">{komen.user?.name}</div>
                      <p className="line-clamp-1">{komen.komentar}</p>
                    
                  </div>
                )
              })
            }
        </div>
      </div>
    </>
  )
}