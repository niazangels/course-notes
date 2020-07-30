import React from 'react';

import SearchBar from './SearchBar';
import Unsplash from '../api/unsplash';
import ImageList from './ImageList';

class App extends React.Component {

    state = { images: [] };

    onSearchSubmit = async (searchTerm) => {
        console.log(searchTerm);
        const response = await Unsplash.get("https://api.unsplash.com/search/photos",
            {
                params: { query: searchTerm }
            });
        this.setState({ images: response.data.results });

    }

    render() {
        return (
            <div className="ui container" style={{ marginTop: "10px" }}>
                <SearchBar onSubmit={this.onSearchSubmit} />
                Found {this.state.images.length} images
                <ImageList images={this.state.images} />
            </div>
        );
    }
}

export default App;