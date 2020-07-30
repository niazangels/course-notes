import React from 'react';

import ImageCard from './ImageCard';
import './ImageList.css'

class ImageList extends React.Component {

    render() {
        return (
            <div className="image-list"> {
                this.props.images.map(
                    (image) => {
                        return <ImageCard key={image.id} image={image} />
                    }
                )}
            </div>
        );
    }
}

export default ImageList;