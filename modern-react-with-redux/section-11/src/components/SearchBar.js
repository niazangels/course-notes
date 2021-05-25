import React from 'react';

class SearchBar extends React.Component{
    state ={term: ''};

    onInputChange = (event) => {
        this.setState({term: event.target.value})
    };

    onTermSubmit = (event) => {
        event.preventDefault();
        this.props.onTermSubmit(this.state.term);
        // Execute callback from parent component
    }

    render(){
        return (
        <div className="search-bar ui segment">
            <form 
                className="ui form"
                onSubmit={this.onTermSubmit}    
            >
                <div className="field">
                    <label>Video search</label>
                    <input 
                        type="text" 
                        value={this.state.term}
                        onChange={this.onInputChange}
                    />
                </div>
            </form>
        </div>
        );
    }
}

export default SearchBar;