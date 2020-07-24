import SeasonDisplay from './SeasonDisplay'
import React from 'react';
import ReactDOM from 'react-dom';

class App extends React.Component {

    constructor(props) {
        super(props);
        this.state = { lat: null, errorMessage: null };

        window.navigator.geolocation.getCurrentPosition(
            (pos) => {
                this.setState({ lat: pos.coords.latitude });
                console.log(this.state.lat);
            },
            (err) => {
                this.setState({ errorMessage: err.message });
                console.log(err.message);
            }
        );
    }

    render() {
        if (this.state.errorMessage) {
            return <h1>Error: {this.state.errorMessage}</h1>
        }
        if (this.state.lat) {
            return <h1> Latitude: {this.state.lat} </h1>
        }
        return <h1>Loading</h1>
    }
}


ReactDOM.render(
    <App />,
    document.querySelector('#root')
);