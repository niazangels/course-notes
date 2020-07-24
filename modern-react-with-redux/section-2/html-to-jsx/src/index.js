import React from 'react';
import ReactDOM from 'react-dom';

const App = () => {

    const buttonText = "click me!";

    return (
        <div>
            <label htmlFor="name" className="label"> Enter name </label>
            <input name="name" type="text" />
            <button style={{ backgroundColor: "orangered", color: "white" }} type="submit"> {buttonText} </button>
        </div>);
}

// Show it on the screen
ReactDOM.render(
    <App />,
    document.querySelector("#root")
);