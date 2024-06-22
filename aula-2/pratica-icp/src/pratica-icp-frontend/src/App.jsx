import { pratica_icp_backend } from "declarations/pratica-icp-backend";

function App() {
  // Complete as linhas abaixo
  //
  // Declare os valores a serem usados
  //

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
          response = await pratica_icp_backend.add(value);
          break;
        case "sub":
          response = await pratica_icp_backend.sub(value);
          break;
        case "mul":
          response = await pratica_icp_backend.mul(value);
          break;
        case "div":
          response = await pratica_icp_backend.div(value);
          response = response !== null ? response : "Error";
          break;
        case "clearall":
          await pratica_icp_backend.clearall();
          response = 0;
          break;
        default:
          return;
      }
      // Complete essa linha
      //
      // setar o resultado aqui
      //
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
      <header className="">
        <h1 className="text-2xl text-center font-bold">
          Precisamos fazer algo aqui
        </h1>
      </header>
      {/* Faça o frontend se comunicar com as funções em js aqui */}
    </main>
  );
}

export default App;
