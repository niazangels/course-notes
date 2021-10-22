import React from 'react';
import Accordion from './components/Accordion'

const items = [
    {title: "What is react", content: "JS library that is awesome"},
    {title: "Why React", content: "It's the cool kid on the block"},
    {title: "How to React", content: "Start creating components"},
]

export default () => {
    return (
    <div>
    <h1>Widgets App</h1>
    <Accordion items={items}/>
    </div>
    )
}
