import './SeasonDisplay.css';
import React from 'react';

const seasonConfig = {
    summer: {
        name: "summer",
        icon: "sun",
        text: "Let's hit the beach!"
    },
    winter: {
        name: "winter",
        icon: "snowflake",
        text: "Time for a hot chocolate!"
    }
}

const getSeason = (lat) => {

    let month = new Date().getMonth();
    let key = '';

    if ((month > 2) && (month < 9)) {
        key = (lat > 0) ? "summer" : "winter"
    } else {
        key = (lat > 0) ? "winter" : "summer";
    }
    return seasonConfig[key]
}

const SeasonDisplay = (props) => {

    const season = getSeason(props.lat);

    return (
        <div className={`season-display ${season.name}`}>
            <i className={`icon-left massive icon ${season.icon}`} />
            <h1>{season.text}</h1>
            <i className={`icon-right massive icon ${season.icon}`} />
        </div >);
}

export default SeasonDisplay;