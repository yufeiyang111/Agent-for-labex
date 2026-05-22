import { useState } from 'react'

export default function App() {
  const [count, setCount] = useState(0)
  return (
    <div style={{ textAlign: 'center', marginTop: 60 }}>
      <h1>Hello React!</h1>
      <button onClick={() => setCount(count + 1)}>
        Count: {count}
      </button>
    </div>
  )
}
