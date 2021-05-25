import axios from 'axios';
const KEY = "AIzaSyCnwwLoeii_zgKUZn4O34GcdjqMZtHCMcQ";

export default axios.create({
    baseURL: 'https://www.googleapis.com/youtube/v3',
    params:{
        part: 'snippet',
        maxResults: 5,
        type:'video',
        key: KEY
    }
})