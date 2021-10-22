import React, { useState } from "react";
import Accordion from "./components/Accordion";
import Search from "./components/Search";
import Dropdown from "./components/Dropdown";
import Translate from "./components/Translate";

import Header from "./components/Header";
import Route from "./components/Route";

const items = [
  {
    title: "What is React?",
    content: "React is a front end javascript framework",
  },
  {
    title: "Why use React?",
    content: "React is a favorite JS library among engineers",
  },
  {
    title: "How do you use React?",
    content: "You use React by creating components",
  },
];

const options = [
  {
    label: "The Color Red",
    value: "red",
  },
  {
    label: "The Color Green",
    value: "green",
  },
  {
    label: "A Shade of Blue",
    value: "blue",
  },
];


const App = () => {

  const [selected, setSelected] = useState(options[0]);

  return (
    <div>
      <Header/>
      <Route path="/">
        {/* Inner element is received as a special prop called `children`  */}
        <Accordion items={items}/>
      </Route>

      <Route path="/list">
        <Search/>
      </Route>

      <Route path="/translate">
        <Translate/>
      </Route>

      <Route path="/dropdown">
        <Dropdown
          label="Select a color"
          options={options}
          selected={selected}
          onSelectedChange={setSelected}
        />
      </Route>
    </div>
  );
};
export default App;
