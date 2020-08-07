import React from 'react';
import ReactDOM from 'react-dom';

class SearchBar extends React.Component {

    state = {}

    render() {
        return (
            <div class="ui container">
                <div class="ui large fluid action input">
                    <input type="text" placeholder="Search..." />
                    <div class="ui button">Search</div>
                </div>
            </div>
        );
    }

}

export default SearchBar;