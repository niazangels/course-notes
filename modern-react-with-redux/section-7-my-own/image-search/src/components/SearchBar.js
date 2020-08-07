import React from 'react';

class SearchBar extends React.Component {

    state = { search_term: 'hello' }

    onFormSubmit = (e) => {
        e.preventDefault();
        console.log(this.state.search_term);
        this.props.onSubmit(this.state.search_term);
    }

    render() {
        return (
            <form onSubmit={this.onFormSubmit}>
                <input
                    type="text"
                    name="search_term"
                    autoFocus
                    onChange={e => {
                        this.setState({ search_term: e.target.value })
                    }
                    }
                    value={this.state.search_term} />
            </form>
        );
    }
}

export default SearchBar;