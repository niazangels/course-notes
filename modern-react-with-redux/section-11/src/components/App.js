import React from 'react';
import ReactDOM from 'react-dom';

import SearchBar from './SearchBar'

class App extends React.Component {

    state = {
        search_term: '',
        results: []
    }

    onSearchSubmit = (search_term) => {
        alert("You searched for: " + search_term);
    }

    render() {
        return (
            <SearchBar />
        );
    }
}

export default App;