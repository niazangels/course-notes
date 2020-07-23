import React from 'react';
import ReactDOM from 'react-dom';

// Create a component

// const App = function () {
//     return <h1>Hello there</h1>
// }

const App = () => {
    return <h1>Hello there</h1>
}

// Show it on the screen
ReactDOM.render(
    <App />,
    document.querySelector("#root")
);