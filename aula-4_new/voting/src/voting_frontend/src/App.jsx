import React, { useEffect, useState } from "react";
import { voting_backend } from "declarations/voting_backend";

function App() {
  const [question, setQuestion] = useState("");
  const [votingResults, setVotingResults] = useState({
    Rust: 0,
    Motoko: 0,
    TypeScript: 0,
    Python: 0,
  });
  const [selectedOption, setSelectedOption] = useState("");

  useEffect(() => {
    const fetchData = async () => {
      const question = await voting_backend.getQuestion();
      setQuestion(question);

      const voteCounts = await voting_backend.getVotes();
      updateLocalVoteCounts(voteCounts);
    };

    fetchData();
  }, []);

  const updateLocalVoteCounts = (voteCounts) => {
    const results = { ...votingResults };
    voteCounts.forEach(([key, value]) => {
      results[key] = Number(value); // Certifique-se de que o valor é um número
    });
    setVotingResults(results);
  };

  const handleVote = async (e) => {
    e.preventDefault();
    if (selectedOption) {
      const updatedVoteCounts = await voting_backend.vote(selectedOption);
      updateLocalVoteCounts(updatedVoteCounts);
    }
  };

  const handleReset = async (e) => {
    e.preventDefault();
    await voting_backend.resetVotes();
    const voteCounts = await voting_backend.getVotes();
    updateLocalVoteCounts(voteCounts);
  };

  return (
    <div className="container mx-auto p-5 relative">
      <div className="border-2 border-blue-500 bg-gray-100 p-5 rounded">
        <h1 className="text-3xl mb-5 text-center">Simple Voting App</h1>
      </div>
      <h2 className="text-2xl my-5 text-center">{question}</h2>

      <form
        onSubmit={handleVote}
        className="mb-5 border-2 border-green-500 p-5 rounded"
      >
        {["Rust", "Motoko", "TypeScript", "Python"].map((option) => (
          <label key={option} className="block mb-3 text-lg">
            <input
              type="radio"
              name="option"
              value={option}
              checked={selectedOption === option}
              onChange={(e) => setSelectedOption(e.target.value)}
              className="mr-2"
            />
            {option}
          </label>
        ))}
        <button
          type="submit"
          className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-700"
        >
          Vote
        </button>
      </form>

      <h2 className="text-2xl mb-5 text-center">Results</h2>
      <div
        id="results"
        className="border-2 border-green-500 p-5 rounded flex flex-col items-center justify-center"
      >
        <ul>
          {Object.entries(votingResults).map(([key, value]) => (
            <li key={key} className="text-lg">
              <strong>{key}</strong>: {value}
            </li>
          ))}
        </ul>
        <button
          onClick={handleReset}
          id="reset"
          className="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-700 mt-12"
        >
          Reset Votes
        </button>
      </div>
    </div>
  );
}

export default App;
