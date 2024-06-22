import React from "react";
import { Link } from "react-router-dom";

const Header: React.FC = () => {
  return (
    <header className="bg-gray-800 text-white py-4">
      <nav className="container mx-auto flex justify-between">
        <h1 className="text-xl font-bold">Meu Site React com TypeScript</h1>
        <ul className="flex space-x-4">
          <li>
            <Link to="/dom-events" className="hover:underline">
              Manipulação do DOM e Eventos
            </Link>
          </li>
          <li>
            <Link to="/react-hooks" className="hover:underline">
              React Hooks: useState e useEffect
            </Link>
          </li>
          <li>
            <Link to="/fetch-form" className="hover:underline">
              Fetch API e Implementação de Formulários
            </Link>
          </li>
        </ul>
      </nav>
    </header>
  );
};

export default Header;
