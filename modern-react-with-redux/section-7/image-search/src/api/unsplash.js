import axios from 'axios';

const ax = axios.create({
    baseURL: 'https://api.unspash.com',
    headers: {
        Authorization: 'Client-ID 62e2948b1a20f1cc68df2633be8503e15f83bcf6b00035dabba3c8eeac03eb4c'

    }
});

export default ax;