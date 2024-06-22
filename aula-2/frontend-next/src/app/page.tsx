import Header from "../components/Header";

export default function Home() {
  return (
    <div className="min-h-screen bg-gray-100 text-gray-900">
      <Header />
      <main className="container mx-auto p-4">
        <h1 className="text-4xl font-bold mb-4">
          Bem-vindo ao Meu Site Next.js
        </h1>
        <p>
          Use o menu acima para navegar pelas diferentes páginas de exemplos.
        </p>
      </main>
    </div>
  );
}
