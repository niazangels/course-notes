import { useEffect, useState } from "react";

// Any time we set up an eventListener inside a component, it's usually a sign that we need to useState


const Route = ({path, children}) => {
    const [currentPath, setCurrentPath] = useState(window.location.pathname)

    useEffect(()=>{

        const onLocationChange = () => {
            // console.log('Location changed!');
            setCurrentPath(window.location.pathname)
        }

        window.addEventListener('popstate', onLocationChange)

        return () => {
            window.removeEventListener('popstate', onLocationChange)
        }
    }, []);

    return currentPath === path ? children : null;
}

export default Route;