import React from 'react';
import Accordion from './components/Accordion';

const items = [
    {
        title: "What is react?",
        content: "Lorem ipsum dolor siet ladeu"
    },
    {
        title: "Why use react?",
        content: "Lorem ipsum dolor siet ladeu"
    },
    {
        title: "How to use react?",
        content: "Lorem ipsum dolor siet ladeu"
    },
]

export default () => {
    return (
        <div>
            <Accordion items={items}/>
        </div>
    );
};