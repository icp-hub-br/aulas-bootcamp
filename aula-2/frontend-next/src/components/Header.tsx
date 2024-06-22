import Link from "next/link";

const Header = () => {
  return (
    <header className="bg-gray-800 text-white py-4">
      <nav className="container mx-auto flex justify-between">
        <Link href="/">
          <h1 className="text-xl font-bold cursor-pointer">Meu Site Next.js</h1>
        </Link>
        <ul className="flex space-x-4">
          <li>
            <Link href="/dom-events">
              <p className="hover:underline cursor-pointer">
                Manipulação do DOM e Eventos
              </p>
            </Link>
          </li>
          <li>
            <Link href="/react-hooks">
              <p className="hover:underline cursor-pointer">
                React Hooks: useState e useEffect
              </p>
            </Link>
          </li>
          <li>
            <Link href="/fetch-form">
              <p className="hover:underline cursor-pointer">
                Fetch API e Implementação de Formulários
              </p>
            </Link>
          </li>
        </ul>
      </nav>
    </header>
  );
};

export default Header;
