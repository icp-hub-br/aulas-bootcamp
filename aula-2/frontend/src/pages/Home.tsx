import React from "react";

const Home: React.FC = () => {
  return (
    <div className="min-h-screen bg-gray-100 text-gray-900">
      <main className="container mx-auto p-4">
        <h1 className="text-4xl font-bold mb-4">
          Bem-vindo ao Meu Site React com TypeScript
        </h1>
        <p className="mb-4">
          Este site possui exemplos de manipulação do DOM, uso de React Hooks e
          Fetch API com implementação de formulários.
        </p>
        <p>
          Use o menu acima para navegar pelas diferentes páginas de exemplos.
        </p>
      </main>
    </div>
  );
};

export default Home;
