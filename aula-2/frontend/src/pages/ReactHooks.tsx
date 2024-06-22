import React, { useState, useEffect } from "react";

const ReactHooks: React.FC = () => {
  const [count, setCount] = useState(0);
  const [time, setTime] = useState(new Date().toLocaleTimeString());

  useEffect(() => {
    const timer = setInterval(() => {
      setTime(new Date().toLocaleTimeString());
    }, 1000);
    return () => clearInterval(timer);
  }, []);

  const incrementCount = () => {
    setCount(count + 1);
  };

  return (
    <div className="min-h-screen bg-gray-100 text-gray-900">
      <main className="container mx-auto p-4">
        <h1 className="text-2xl font-bold mb-4">
          Exemplo com React Hooks: useState e useEffect
        </h1>
        <p className="mb-4">Contador: {count}</p>
        <button
          onClick={incrementCount}
          className="bg-blue-500 text-white p-2 rounded hover:bg-blue-600 mb-4"
        >
          Incrementar
        </button>
        <p className="mb-4">Hora atual: {time}</p>
      </main>
    </div>
  );
};

export default ReactHooks;
