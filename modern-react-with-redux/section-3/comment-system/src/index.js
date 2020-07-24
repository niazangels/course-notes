import Faker from 'faker';
import Comment from './Comment';
import ApprovalCard from './ApprovalCard';

import React from 'react';
import ReactDOM from 'react-dom';


const App = () => {
    return (
        <div className="ui comments container">
            <ApprovalCard>
                <h4>Warning!</h4>
                Are you sure you want to do this?
                </ApprovalCard>
            <ApprovalCard>
                <Comment author="Sam" avatar={Faker.image.avatar()} time="3:36pm" message="Hello there!" />
            </ApprovalCard>
            <Comment author="Alex" avatar={Faker.image.avatar()} time="4:36pm" message="Woah! It worked!" />
            <Comment author="Jane" avatar={Faker.image.avatar()} time="5:36pm" message="Sure it did! :)" />
        </div>
    );
}

// Show it on the screen
ReactDOM.render(
    <App />,
    document.querySelector("#root")
);