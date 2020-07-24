# Modern React with Redux
- Course link: https://www.udemy.com/course/react-redux/
- Author: Stephen Grider

# Abbreviations
- `cmp` : component 
- `R` : React
- `RD` : ReactDOM
- `fn` : function

# Section 1 

## Translate App

#### What was that App function?
- The App component is a React component
- App components produces JSX and handles user events
- JSX is a set of instructions to tell React what content to show on screen
- App component returns JSX
- Each element has a closing tag or is self closing eg. `<Translate />`
- JSX tells React to either
  - create an HTML element
  - show another React component

##### How did the content get displayed on the screen?
- `index.html` will request for `bundle.js`
- `bundle.js` is a bundle of all js files including all cmp inside our project
- `index.js` renders `<App />` using `ReactDOM` and puts it into the DOM inside the element with `id="root"`

#### What's the difference between `React` and `ReactDOM`?
- React
  - Knows how to work with cmps by getting them to work together, how to call a cmp fn, get back JSX, iterate over cmp
  - Called a `reconciler`

- ReactDOM
  - Knows how to take JSX and turn it into HTML
  - Called a `renderer`

#### What was all that useState stuff?
- useState
  - fn for working with R's state system
  - state is used to track data over time
  - used to make R update elements on screen

## Understanding `Babel` package
- ES5 is the version of JS you probably know
- ES2015-2019 are newer version with more features
- Babel transpiles to ES5
- Babel also converts JSX to normal looking javascript code


## Understanding `import` statement
- import React from `react`;
- here React is the variable we want to assign this import to
- 'react' is the name of the dependency or the path path of the file
- this means the name React could be changed to anything you want
- `import` statement is to import ES2015 Modules system
- `require` statement is to CommonJS Module system

# Section 2 

## Understanding JSX and React components
- A React component is a function or a class that produces HTML to show the user via JSX and handles feedback from the user through event handlers.
- Babel converts JSX to JS
  - https://babeljs.io/repl
  - Ensure `React` is checked
  - See how the following code is transpiled
  - ```javascript
    const App = () => {
	return  <ul> 
                <li> One </li>
                <li> Two </li>
                <li> Three </li>
            </ul>
    }
    ```
- JSX is a special dialect of JS (not HTML!)
- Browsers don't understand JSX- we need to transpile it to native JS
- JSX is very similar to HTML in form and function


## JSX vs HTML
- Custom styling uses a different syntax
    - HTML: `<div id="invoice" style="backgroundColor: red"></div>`
    - JSX: `<div id="invoice" style={{backgroundColor: 'red'}}></div>`
    - Outer curly brace indicates we're going to reference a JS variable inside JSX
    - Inner curly brace is a regular JS object
    - Convert hyphenated keys to camelCase
    - JSX requires you to use double quotes for strings
    - By convention, most developers use single quotes for JS objects (see "id" and "style" of JSX)
- Adding a class to element uses a different syntax
  - use `className` instead of `class`
- JSX can reference JS variables
- There are some exceptions in names:
  - Warning: Invalid DOM property `for`. Did you mean `htmlFor`?
  - Same thing applies for "class"

## Values JSX can't show
- Objects: they give a weird error "Objects are not valid as a React child"
- You can however reference JS objects as long as you're not trying to print them on screen eg. see `style` JSX example


## Three tenents of components
- Nesting
  - One cmp can be shown inside another
- Reusability
  - One cmp can be reused multiple times
- Configurable
  - One cmp can be configured when created


# Section 3

## Props system
- Send data from parent to child to customize the child
- `<Comment author="Niyas" message="Sup bro?" />` will give `Comment` two props: `author` and `message`
- `<ApprovalCard> <Comment /> </ApprovalCard>` gives `ApprovalCard`'s props a `children` property 
- So inside `ApprovalCard` you can say `<div> {props.children} </div>` and render the children
- You don't have to pass in a component as above- you can pass in any valid html including plain text