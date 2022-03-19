import {BiTrash} from 'react-icons/bi'
import { AiOutlineStar } from 'react-icons/ai'
import CardTimeline from '../../components/CardTimeline'
import {HiOutlineLocationMarker} from 'react-icons/hi'
export default function ReviewById(){
  return (
    <>
      <div className="flex justify-center">
        <div className=" max-w-[720px] w-full min-h-screen">
          <img src="/kiseki-no-sedai.jpeg" alt="" className="object-cover h-[300px] w-full"/>

          <div className="mt-[4px] flex items-center justify-between h-[50px] p-[12px]">
            
            <div className="flex items-center">
              <img src="/kiseki-no-sedai.jpeg" alt="" className="object-cover h-[35px] w-[35px] rounded-full"/>
              <p className="ml-4 text-[18px] font-bold">Ananda Affan Fattahila</p>
            </div>

            {/* <button className="text-[18px] text-red-500">
              <BiTrash/>
            </button> */}

          </div>
          <div className="flex px-[12px] items-center">
            <div className="flex  items-center  ">
              <AiOutlineStar/>
              <p className="ml-1">
                {"4.4"}
              </p>
            </div>
            <div className="font-bold ml-4">
              {"Negeri Isekai"}
            </div>
          </div>
          <div className="px-[12px] text-[14px]">
            {"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nibh turpis, scelerisque ac felis non, gravida tempor velit. Quisque eget venenatis neque. Aliquam varius, leo et rhoncus feugiat, lorem risus vehicula ex, at pellentesque ipsum turpis non nibh. Sed at sagittis justo. Sed enim quam, rutrum ac mauris vel, condimentum volutpat metus. Praesent vulputate tincidunt nisl nec luctus. Quisque sollicitudin imperdiet nisl, eu facilisis diam scelerisque ac."}
          </div>
          <div className="flex px-[12px] mt-4">
            <div className="btn btn-outline ">
              <HiOutlineLocationMarker/>
            </div>
            <div className=" ml-[10px] w-full text-[14px]">
              {"Alamat: Jl Kekcocakan yang sangat panjang sekali sehingga ini seharusnya bisa tiidak muat jadi  yang dilakukan adalah menambahkan text ini ke bawah dibatasi 200 karakter"}
            </div>
          </div>
        </div>
      </div>
      
    </>
  )
}
