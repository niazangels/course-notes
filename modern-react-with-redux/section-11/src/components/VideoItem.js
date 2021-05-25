import React from 'react';
import './VideoItem.css'

const VideoItem = ({video, onVideoSelect}) => {
    return (
        <div className="video-item item" onClick={()=>onVideoSelect(video)}>
            <img 
            src={video.snippet.thumbnails.medium.url} 
            alt={video.snippet.title} 
            className="ui image"
            />
            <div className="content">
                <div className="header">
                    {video.snippet.title}
                </div>
            </div>
        </div>
    )
}

export default VideoItem;