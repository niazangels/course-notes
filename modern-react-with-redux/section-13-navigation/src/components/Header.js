import React from 'react';
import Link from './Link';

const Header = () => {
    return (
        <div className="ui secondary pointing menu">
            

            <Link href="/" className="item">
                Accordion
            </Link>
            <Link href="/list" className="item">
                List
            </Link>
            <Link href="/translate" className="item">
                Translate
            </Link>
            <Link href="/dropdown" className="item">
                Dropdown
            </Link>
        </div>
    )
}

export default Header;