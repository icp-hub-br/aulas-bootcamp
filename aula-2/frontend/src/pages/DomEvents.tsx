import React, { useState } from "react";

const DomEvents: React.FC = () => {
  const [message, setMessage] = useState(
    "Clique no botão para mudar este texto."
  );
  const [userInput, setUserInput] = useState("");

  const handleClick = () => {
    setMessage(userInput || "Texto alterado com sucesso!");
  };

  return (
    <div className="min-h-screen bg-gray-100 text-gray-900">
      <main className="container mx-auto p-4">
        <h1 className="text-2xl font-bold mb-4">
          Exemplo de Manipulação do DOM e Eventos
        </h1>
        <p id="message" className="mb-4">
          {message}
        </p>
        <input
          type="text"
          value={userInput}
          onChange={(e) => setUserInput(e.target.value)}
          className="border border-gray-300 p-2 rounded mb-4 w-full"
          placeholder="Digite o novo texto aqui"
        />
        <button
          onClick={handleClick}
          className="bg-blue-500 text-white p-2 rounded hover:bg-blue-600"
        >
          Clique aqui
        </button>
      </main>
    </div>
  );
};

export default DomEvents;
