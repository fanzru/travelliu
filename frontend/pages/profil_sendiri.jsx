import { BiTrash } from 'react-icons/bi'
import { AiOutlineStar } from 'react-icons/ai'

export default function ProfilSendiri() {
  return (
    <div className="flex justify-center">
      <div className="border-2 max-w-[720px] w-full min-h-screen">
        <div className="hero container max-w-screen-lg justify-center pt-10">
          <img className="object-cover h-[160px] w-[160px] rounded-full" src="/kiseki-no-sedai.jpeg" alt="" />

        </div>
        <div className="hero container max-w-screen-lg justify-center pb-2 pt-2">
          <p className='text-[37.54px] font-bold'>
            Ananda Fatahilla
          </p>
        </div>

        <div className='flex justify-center'>
          <div className='w-[350px] grid grid-cols-2'>
            <div className='text-center'>
              <p className='underline'>Total Review</p>
              <p>0</p>
            </div>
            <div className='text-center'>
              <p className='underline'>Rataan Rating</p>
              <p>0</p>
            </div>
          </div>
        </div>




        <div className='mt-[4px] flex items-center justify-between h-[50px] p-[12px]'>
          <div className="flex items-center">
            <img className="object-cover h-[35px] w-[35px] rounded-full" src="/kiseki-no-sedai.jpeg" alt="" />
            <p className="mx-2 text-[18px] font-bold">Ananda Affan Fatahilla</p>
          </div>

          <button className='text-[18px] text-red-500'>
            <BiTrash />
          </button>
        </div>
        <img src="/kiseki-no-sedai.jpeg" alt="" className='object-cover h-[300px] w-full'/>
        <div className='mt-[4px] flex items-center h-[50px] p-[12px]'>
          <AiOutlineStar />
          4.4
          <p className="mx-2 text-[18px] font-bold">Negeri Isekai</p>
        </div>
        <div className='mt-[2px] flex items-center h-[50px] p-[12px]'>
          <p className='text-[14px]'>Negeri ini sangat indah dimana hati, otak dan pikiran akan selalu tenang karena tempat yang dapat membuat semua beban terlepas serta mendapatkan ketenangan jiwa hhe :).</p>
        </div>



      </div>
    </div>

  )
}



// import {BiTrash} from 'react-icons/bi'
// export default function RevievById(){
//   return (
//       <div className="flex justify-center">
//         <div className="border-2 max-w-[720px] w-full min-h-screen">
//           <ing src"/kiseki-no-sedai.jpeg" alt="" className="object-cover h-[300px] w-full"/
//           <div className="mt-[4px] flex items-center justify-between h-[50px] p-[12px]">
//             <div className="flex items-center">
//               <ing src="/kiseki-no-sedai.jpeg" alt="" className="object-cover h-[35px] w-[35
//               <p className="nx-2 text-[18px] font-bold">Ananda Affan Fattahila</p>
//             </div>
//             <button className="text-[18px] text-red-580">
//               BiTrash/>
//             </button>
//           </div>
//       </div> CATP/>

// export default function ReviewById (){
//     return (
//         <div className="flex justify-center">
//           <div className="border-2 max-w-[720px] w-full min-h-screen">
//             <img src="/kiseki-no-sedai.jpeg" alt="" className="object-cover h-[300px] w-full"/>
//               <img src="/kiseki-no-sedai.jpeg" alt="" className="object-cover h-[35px] w-[35px] " />
//               <p></p>
//               <button></button>
//             </div>
//           </div>
//         </div>
//       </>