import React from 'react';

const Spinner = (props) => {
    return (
        <div class="ui active inverted dimmer">
            <div class="ui big text loader">{props.children}</div>
        </div>
    );
}

Spinner.defaultProps = {
    children: "Loading.. Please wait."
}

export default Spinner;