import React from 'react';

const VideoDetail = ({video}) => {
    
    if (!video){
        return <div>Choose a video</div>
    }

    const videoSrc = `https://www.youtube.com/embed/${video.id.videoId}`;

    return (
        <div>
            <div className="ui embed">
            <iframe 
                width="560" height="315" 
                src={videoSrc} 
                title="YouTube video player" 
                frameBorder="0" 
                allowFullScreen>

            </iframe>
            </div>
            <div className="ui segment">
                <h4 className="ui header"> {video.snippet.title} </h4>
                <p>{video.snippet.description}</p>
            </div>
        </div>
    )
}
export default VideoDetail