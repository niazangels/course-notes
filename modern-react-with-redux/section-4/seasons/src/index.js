import React from 'react';
import ReactDOM from 'react-dom';

import SeasonDisplay from './SeasonDisplay'
import Spinner from './Spinner'


class App extends React.Component {

    constructor(props) {
        super(props);
        this.state = { lat: null, errorMessage: null };
    }

    componentDidMount() {
        window.navigator.geolocation.getCurrentPosition(
            (pos) => {
                this.setState({ lat: pos.coords.latitude });
            },
            (err) => {
                this.setState({ errorMessage: err.message });
            }
        );
    }

    renderConditionally() {
        if (this.state.errorMessage) {
            return <h1>Error: {this.state.errorMessage}</h1>
        }
        if (this.state.lat) {
            return <SeasonDisplay lat={this.state.lat} />
        }
        return <Spinner></Spinner>
    }

    render() {
        return (
            <div> {this.renderConditionally()} </div>
        );
    }
}


ReactDOM.render(
    <App />,
    document.querySelector('#root')
);