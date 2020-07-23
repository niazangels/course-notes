# Modern React with Redux
- Course link: https://www.udemy.com/course/react-redux/
- Author: Stephen Grider

# Abbreviations
- `cmp` : component 
- `R` : React
- `RD` : ReactDOM
- `fn` : function
# Section - 1 

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

## Understanding `import` statement
- import React from `react`;
- here React is the variable we want to assign this import to
- 'react' is the name of the dependency or the path path of the file
- this means the name React could be changed to anything you want
- `import` statement is to import ES2015 Modules system
- `require` statement is to CommonJS Module system

## Understanding React components
- A React component is a function or a class that produces HTML to show the user via JSX and handles feedback from the user through event handlers.
- 