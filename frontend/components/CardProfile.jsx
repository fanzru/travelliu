import React from 'react'
import { BiTrash } from 'react-icons/bi'
import { AiOutlineStar } from 'react-icons/ai'
import {authApi} from "../utils/apiHelper"
import {useRouter} from "next/router"
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import Link from 'next/link'

function CardProfile({data,review}) {
    const router = useRouter()
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
        <div className="mt-[20px] border-b-2">
            <div className='mt-[4px] flex items-center justify-between h-[50px] p-[12px]'>
                <button onClick={()=> {router.push("/myprofile")}}>
                    <div className="flex items-center">
                        <img className="object-cover h-[35px] w-[35px] rounded-full" src="/affan-imut.jpeg" alt="" />
                        <p className="mx-2 text-[18px] font-bold">{data.user.name}</p>
                    </div>
                </button>
                <button 
                    className='text-[18px] text-red-500' 
                    onClick={()=>{
                        authApi().delete(`/api/review/${review.id}`)
                        .then((res)=>{
                            router.reload(window.location.pathname)
                        })
                        .catch((e)=>{
                            if (e.response && e.response.status != 500) {
                                toast.error(e.response.data);
                                return
                              }
                              toast.error("Server Error, Coba lagi nanti");
                        })
                    }}>
                    <BiTrash />
                </button>
            </div>
	    <Link href={"/review/" + review.id}>
            <img src={review.photo} alt="" className='cursor-pointer object-cover h-[300px] w-full' />
            </Link>
	    <div className='mt-[4px] flex items-center h-[50px] p-[12px]'>
                <AiOutlineStar />
                {review.rating}
		<Link href={"/review/" + review.id}>
                <p className="mx-2 text-[18px] font-bold cursor-pointer">{review.nama_tempat}</p>
                </Link>
	    </div>
            <div className='mt-[2px] flex items-center h-[50px] p-[12px]'>
                <p className='text-[14px] line-clamp-2'>{review.review}</p>
            </div>
        </div>
        </>
    )
}

export default CardProfile
