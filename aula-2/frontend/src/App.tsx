import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Header from "./components/Header";
import Home from "./pages/Home";
import DomEvents from "./pages/DomEvents";
import ReactHooks from "./pages/ReactHooks";
import FetchForm from "./pages/FetchForm";

const App: React.FC = () => {
  return (
    <Router>
      <Header />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/dom-events" element={<DomEvents />} />
        <Route path="/react-hooks" element={<ReactHooks />} />
        <Route path="/fetch-form" element={<FetchForm />} />
      </Routes>
    </Router>
  );
};

export default App;
