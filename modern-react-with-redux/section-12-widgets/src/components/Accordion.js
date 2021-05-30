import React, {useState} from 'react';

const Accordion = ({ items }) => {
    // Array destructuring. LHS is not creating an array.
    const [activeIndex, setActiveIndex] = useState(null);


    const onTitleClick = (index) => {
        setActiveIndex(index);
    }
    
    const renderedItems = items.map( (item, index) => {
        return (
        <React.Fragment key={item.title}>
            <div 
                className="title active"
                onClick={() => onTitleClick(index)}
            >
                <i className="dropdown icon"></i>
                {item.title}
            </div>
            <div className="content active">
                <p> {item.content} </p>
            </div>
        </React.Fragment>)
    })
    return (
       <div className="ui styled accordion">
           {renderedItems}
           <h1>{activeIndex}</h1>
       </div>
    )
}

export default Accordion;