import React from 'react';

const Comment = (props) => {
    return (
        <div className="comment">
            <a className="avatar">
                <img src={props.avatar} alt="avatar" />
            </a>
            <div className="content">
                <a className="author">{props.author}</a>
                <div className="metadata">
                    <span className="date">{props.time}</span>
                </div>
                <div className="text">
                    {props.message}
                </div>
                <div className="actions">
                    <a className="reply">Reply</a>
                </div>
            </div>
        </div>

    );
}

export default Comment;