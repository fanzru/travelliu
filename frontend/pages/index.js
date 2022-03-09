import { useEffect, useState } from "react";
import api from "../utils/api";

import React from 'react'

function index() {
  const [NameEmail, setNameEmail] = useState({
    name: "",
    email: "",
  })


  useEffect(async () => {
    let result = await api.get("/api/user")
    if (result.status !== 200) {
      alert("Gagal")
    }

    setNameEmail({...NameEmail, 
    name: result.data.name,
    email: result.data.email })
  }, [])

  return (
    <div>
      {NameEmail.name == "" ? "Not Logged in" : "Logged in"} 
      {NameEmail.name}
      {NameEmail.email}
    </div>
  )
}

export default index