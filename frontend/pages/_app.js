import '../styles/globals.css'
import Layout from '../components/Layout'
import { useRouter } from 'next/router'
import { useState, useEffect } from 'react'
import LoadingSpinner from '../components/LoadingSpinner'

function MyApp({ Component, pageProps }) {
  const router = useRouter()
  const [Loading, setLoading] = useState(true)


  useEffect(() => {
    const handleStart = (url) => {
      setLoading(true)
    }
    const handleStop = () => {
      setLoading(false)
    }

    router.events.on('routeChangeStart', handleStart)
    router.events.on('routeChangeComplete', handleStop)
    router.events.on('routeChangeError', handleStop)

    return () => {
      router.events.off('routeChangeStart', handleStart)
      router.events.off('routeChangeComplete', handleStop)
      router.events.off('routeChangeError', handleStop)
    }
  }, [router])

  return (
    <>
      <Layout>
        <Component {...pageProps} />
      </Layout>
    </>
  )
}

export default MyApp