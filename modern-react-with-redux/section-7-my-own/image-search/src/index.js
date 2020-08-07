import React from 'react';
import ReactDOM from 'react-dom';

import SearchBar from './components/SearchBar'

class App extends React.Component {

    onSubmit = (searchTerm) => {
        alert("The value is" + searchTerm);
    }

    render() {
        return (
            <div>
                <h1>Search</h1>
                <SearchBar onSubmit={this.onSubmit} />
            </div>
        );
    }
}

ReactDOM.render(<App />, document.querySelector('#root'));