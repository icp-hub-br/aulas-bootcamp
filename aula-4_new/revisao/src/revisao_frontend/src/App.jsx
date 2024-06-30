import { useEffect, useState } from "react";
import { revisao_backend } from "declarations/revisao_backend";

function App() {
  const [result, setResult] = useState("");
  const [inputValue, setInputValue] = useState("");

  async function handleOperation(operation) {
    const value = parseInt(inputValue, 10);
    if (isNaN(value) && operation !== "clearall") {
      alert("Please enter a valid number");
      return;
    }

    let response;
    try {
      switch (operation) {
        case "add":
          response = await revisao_backend.add(value);
          break;
        case "sub":
          response = await revisao_backend.sub(value);
          break;
        case "mul":
          response = await revisao_backend.mul(value);
          break;
        case "div":
          response = await revisao_backend.div(value);
          response = response !== null ? response : "Error";
          break;
        case "clearall":
          await revisao_backend.clearall();
          response = 0;
          break;
        default:
          return;
      }
      setResult(response.toString());
    } catch (error) {
      console.error("Error performing operation:", error);
      setResult("Error");
    }
  }

  useEffect(() => {
    console.log("Result updated: ", result);
  }, [result]);

  return (
    <main className="flex flex-col items-center justify-center min-h-screen bg-gray-100">
      <header className="bg-gray-800 text-white w-full py-4 mb-6">
        <h1 className="text-2xl text-center font-bold">Calculadora</h1>
      </header>
      <form className="bg-white p-6 rounded-lg shadow-md w-full max-w-md">
        <div className="mb-4">
          <label htmlFor="value" className="block text-gray-700 font-bold mb-2">
            Enter a value:
          </label>
          <input
            id="value"
            type="text"
            value={inputValue}
            onChange={(e) => setInputValue(e.target.value)}
            className="border border-gray-300 p-2 rounded w-full"
            placeholder="Digite o novo texto aqui"
          />
        </div>
        <div className="grid grid-cols-2 gap-4">
          <button
            type="button"
            onClick={() => handleOperation("add")}
            className="bg-teal-500 text-white p-2 rounded hover:bg-teal-600"
          >
            Add
          </button>
          <button
            type="button"
            onClick={() => handleOperation("sub")}
            className="bg-teal-500 text-white p-2 rounded hover:bg-teal-600"
          >
            Subtract
          </button>
          <button
            type="button"
            onClick={() => handleOperation("mul")}
            className="bg-teal-500 text-white p-2 rounded hover:bg-teal-600"
          >
            Multiply
          </button>
          <button
            type="button"
            onClick={() => handleOperation("div")}
            className="bg-teal-500 text-white p-2 rounded hover:bg-teal-600"
          >
            Divide
          </button>
          <button
            type="button"
            onClick={() => handleOperation("clearall")}
            className="col-span-2 bg-red-500 text-white p-2 rounded hover:bg-red-600"
          >
            Clear
          </button>
        </div>
      </form>
      <section
        id="result"
        className="mt-6 bg-white p-4 rounded-lg shadow-md w-full max-w-md text-center"
      >
        <h2 className="text-xl font-bold text-black">Result:</h2>
        <p className="text-2xl text-gray-800">{result}</p>
      </section>
    </main>
  );
}

export default App;
