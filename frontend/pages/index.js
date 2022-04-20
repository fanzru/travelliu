import { useEffect, useState } from "react";
import React from 'react'
import { api, authApi } from "../utils/apiHelper";
import CardTimeline from "../components/CardTimeline";
import jsCookie from "js-cookie";
import LoadingSpinner from "../components/LoadingSpinner";

function Index() {  
  const [TimelineData, SetTimelineData] = useState([])

  useEffect(() => {
    api().get("/api/review")
    .then((res) => {
      SetTimelineData(res.data)
    })
    .catch(e => {

    })
    
  }, [])

  if (TimelineData.length == 0 ) return <LoadingSpinner/>

  return (
    <>
      <div>
        {
          TimelineData.map((val, idx) => {
            return <CardTimeline key={idx} data={val} />
          })
        }
      </div>
    </>
  )
}

// export async function getServerSideProps(context) {
//   if (context.req.cookies.auth == "true") {
//     return {
//       props: {}
//     }
//   }

//   return {
//     redirect : {
//       destination: "/login?must_login",
//       permanent: false
//     }
//   }

// }

export default Index