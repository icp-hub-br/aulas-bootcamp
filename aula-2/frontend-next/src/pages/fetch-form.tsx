import Header from "../components/Header";
import { useState } from "react";
import "../app/globals.css";

const FetchForm = () => {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [responseMessage, setResponseMessage] = useState("");

  const handleSubmit = async (e: any) => {
    e.preventDefault();
    const response = await fetch("/api/form", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ name, email }),
    });
    const data = await response.json();
    setResponseMessage(data.message);
  };

  return (
    <div className="min-h-screen bg-gray-100 text-gray-900">
      <Header />
      <main className="container mx-auto p-4">
        <h1 className="text-2xl font-bold mb-4">
          Exemplo de Fetch API e Implementação de Formulários
        </h1>
        <form
          onSubmit={handleSubmit}
          className="bg-white p-4 shadow-md rounded-md"
        >
          <div className="mb-4">
            <label htmlFor="name" className="block text-gray-700">
              Nome:
            </label>
            <input
              type="text"
              id="name"
              value={name}
              onChange={(e) => setName(e.target.value)}
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500"
            />
          </div>
          <div className="mb-4">
            <label htmlFor="email" className="block text-gray-700">
              Email:
            </label>
            <input
              type="email"
              id="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-blue-500"
            />
          </div>
          <button
            type="submit"
            className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600"
          >
            Enviar
          </button>
        </form>
        {responseMessage && (
          <div className="mt-4 p-4 bg-green-100 text-green-700 rounded">
            {responseMessage}
          </div>
        )}
      </main>
    </div>
  );
};

export default FetchForm;
