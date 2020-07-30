import React from 'react';

class SearchBar extends React.Component {

    state = { searchTerm: '' }

    onFormSubmit = (event) => {
        event.preventDefault();
        this.props.onSubmit(this.state.searchTerm);
    }

    render() {
        return (
            <div className="ui inverted segment">
                <h4>Image search</h4>
                <form onSubmit={this.onFormSubmit}>
                    <div className="ui inverted fluid left icon input">

                        <input
                            type="text"
                            placeholder="Search..."
                            value={this.state.searchTerm}
                            onChange={
                                (e) => {
                                    this.setState({ searchTerm: e.target.value });
                                    // console.log(this.state.searchTerm, e.target.value)
                                }
                            }
                        />
                        <i className="search icon"></i>
                    </div>
                </form>
            </div >
        );
    }
}

export default SearchBar;