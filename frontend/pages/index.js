import { useEffect, useState } from "react";
import React from 'react'
import { authApi } from "../utils/apiHelper";

function index() {
  const [NameEmail, setNameEmail] = useState({
    name: "",
    email: "",
  })

  useEffect(async () => {
    let result = await authApi().get("/api/user")
    if (result.status == 200) {
      setNameEmail({
        ...NameEmail,
        name: result.data.name,
        email: result.data.email
      })
      return
    }
  }, [])

  return (
    <>
      <div>
        {NameEmail.name == "" ? "Not Logged in" : "Logged in"}
        {NameEmail.name}
        {NameEmail.email}
      </div>
    </>
  )
}

export async function getServerSideProps(context) {
  if (context.req.cookies.auth == "true") {
    return {
      props: {}
    }
  }

  return {
    redirect : {
      destination: "/login?must_login",
      permanent: false
    }
  }

}

export default index