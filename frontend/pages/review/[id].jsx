import { AiOutlineStar } from 'react-icons/ai'
import {HiOutlineLocationMarker} from 'react-icons/hi'
import { useRouter } from 'next/router'
import { api,authApi } from "../../utils/apiHelper";
import {useEffect,useState} from 'react'
import LoadingSpinner from "../../components/LoadingSpinner";
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

export default function ReviewById(props){
  const router = useRouter()
  const [data,setData] = useState([])
  const [loading,setLoading] = useState(true)
  const [komen, setKomen] = useState();
  let {id} = router.query
  useEffect( () => {
    if (id == undefined) return
    api().get(`/api/review/${id}`)
    .then((res) => {
      setData(res.data)
      setLoading(false)
    })
    .catch(e => {
      // console.log(e)
    }) 
  },[id])
  const onSubmitKomentar = (e) => {
    e.preventDefault()
    
    api().get("/sanctum/csrf-cookie").then(
      authApi().post(`/api/komentar/${id}`,{
        "komentar":komen
      })
      .then(() => {
          router.reload(window.location.pathname)
        })
        .catch(e => {
          if (e.response && e.response.status != 500) {
            toast.error(e.response.data);
            return
          }
          toast.error("Server Error, Coba lagi nanti");
       }),
       
        
    ).catch(e => {
      if (e.response && e.response.status != 500) {
        toast.error(e.response.data);
        return
      }
      toast.error("Server Error, Coba lagi nanti");
    })
    
  }

  if ((data.length == 0 )) return <LoadingSpinner/>


  return (
    <>
      <ToastContainer
        position="bottom-right"
        autoClose={5000}
        hideProgressBar={false}
        newestOnTop={false}
        closeOnClick
        rtl={false}
        pauseOnFocusLoss
        draggable
        pauseOnHover
      />
      <div className="flex justify-center">
        <div className=" max-w-[720px] w-full min-h-screen">
          <img src={data.photo} alt="" className="object-cover h-[300px] w-full"/>
          <div className="mt-[4px] flex items-center justify-between h-[50px] p-[12px]">
            <div className="flex items-center">
              <img src="/affan-imut.jpeg" alt="" className="object-cover h-[35px] w-[35px] rounded-full"/>
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
            <a href={`https://www.google.com/maps/search/?api=1&query=${data.longitude}%2C${data.latitude}`}>
              <div className="btn  ">
                <HiOutlineLocationMarker/>
              </div>
            </a>
            <div className=" ml-[10px] w-full text-[14px]">
              {data.alamat}
            </div>
          </div>
          <form className="p-[12px] flex items-center">
            <input type="text" placeholder="Maksimal 300 Karakter" className="input input-bordered w-full mr-4" onChange={e => setKomen(e.target.value)} />
            <button className="btn" onClick={onSubmitKomentar}>Balas</button>
          </form>
            {
              data.komentar?.map((komen,idx)=>{
                return (
                  <div key={idx} className="border border-black mx-[12px] mt-2 p-4 rounded-md">
                    <div className="font-bold"><a href={`/profil/${komen.user?.id}`}>{komen.user?.name}</a></div>
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