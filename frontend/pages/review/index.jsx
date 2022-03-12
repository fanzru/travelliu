import {BiTrash} from 'react-icons/bi'

export default function ReviewById(){
  return (
    <>
      <div className="flex justify-center">
        <div className="border-2 max-w-[720px] w-full min-h-screen">
          
          <img src="/kiseki-no-sedai.jpeg" alt="" className="object-cover h-[300px] w-full"/>

          <div className="mt-[4px] flex items-center justify-between h-[50px] p-[12px]">
            
            <div className="flex items-center">
              <img src="/kiseki-no-sedai.jpeg" alt="" className="object-cover h-[35px] w-[35px] rounded-full"/>
              <p className="mx-2 text-[18px] font-bold">Ananda Affan Fattahila</p>
            </div>

            <button className="text-[18px] text-red-500">
              <BiTrash/>
            </button>

          </div>

        </div>
      </div>
    </>
  )
}
