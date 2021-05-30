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
- You don't have to pass in a component as above- you can pass in any valid html including plain textGa
- After creating a class based component, you can set the default props as follows:  
```javascript
    ComponentName.defaultProps = {key: value}
``` 

# Section 4 - Structuring Apps with Class Based Components

### How react *used to be*
- **Class components**
  - Can produce JSX to show content to users
  - Can use lifecycle system to run code at specific points of time
  - Can use the `state` system to update content on the screen

- **Functional components**
  - Can produce JSX to show content to users

## But now
- **Functions components** 
  - Can use Hooks to run code at specific points of time
  - Can use Hooks to access `state` and update content on the screen

## Seasons Project
- GeoLocation results may arrive only after JSX is rendered
- So we will class based components to rerender content when we have the results

## Rules of Class Based Components
- Must be a JS class
- Must extend React.Component (by inheriting)
- Must define a render method that returns some JSX

```javascript
class App extends React.Component {
    
    constructor(props){
        super(props);
        this.state = {};
    }

    componentDidMount() {
        // The recommended place to put all data loading code
        ...
    }

    componentDidUpdate() {
        ...
    }

    componentWillUnmount() {
        ...
    }

    render() {
        return <h1> Hello </h1>
    }
}
```

```javascript
class App extends React.Component {

// Alternate state initialization
state = {}

render() {

    }
}
```
# Section 5 - State in React Components

## Rules of State
- Only usable directly by class based components
- Easy to confuse props with state
- `state` is a JS object that contains data relevant to a component
- Updating a component's `state` almost instantly causes it to rerender
- `state` must be initialized when a component is created
- `state` **can only be updated using the function** `setState`

## More on classes
- **JS classes are based on prototypal inheritance**
- Classes may have a `constructor` that receives `props` as argument

# Section 6  - Understanding Lifecycle Methods

## Component Lifecycle is as follows
  - constructor
  - render
  - *Component is shown on screen*
  - componentDidMount
  - *Sit and wait for updates*
  - componentDidUpdate
  - *Sit and wait till component is no longer shown*
  - componentWillUnmount

## Styling
-  `import './SeasonDisplay.css';`
-  You can import CSS files inside Component files
-  Webpack is going to figure this out and stick it into the index.html file (how?)
-  Tip: avoid having multiple return statements within the render method. If you have conditional rendering, offload the conditional rendering to another function. This helps you style the outer content eg. if you always need a red border around the rendered component.

```javascript
class Spinner extends React.Component {

    render() {
        return (
            <div>
                {this.renderConditionally()}
            </div>
        );
    }
}
```

# Section 7 - Handling User Input with Forms and Events

## Event Handler Example
- Event callbacks will **always** take the event as an argument
  
```javascript
class SearchBar extends React.Component {
    onInputChange(e) {
        console.log(e.target.value)
    }
    render() {
      return <input type="text" onChange={this.onInputChange} />

    }
}

```

## Controlled vs Uncontrolled

- A controlled flow
  - User types in input
  - Callbacks gets invoked
  - we call setState with new value
  - Component rerenders
  - Input is told what it's value is (from state)

## Arrow functions
- Enables `this` to be accessible inside the body


## Responsibility in Components
- `SearchBar` component does not need to make API requests- that's a job for `App` component
- `SearchBar` needs to communicate "up" to it's parent `App`
- One solution is to define `onSearchSubmit` in `App` and pass it down as a prop to the `SearchBar`. So whenever the form is submitted, the callback is invoked by `App`'s definition of `onSearchSubmit`

# Section 8 - Making API requests with React
- Axios returns a promise. 
- You can chain on a `.then()` function

```javascript
// Chaining
axios.get(URL,
      {
          headers: { .. },
          params: { .. }
      }).then(
        (reponse) => { .. }
      )
```

```javascript
// Async/Await
async onSubmit(term) {
  const resposne = await axios.get(URL);
  console.log(response);
}
```

```javascript
// Async/Await Arrow function
onSubmit = async(term) => {
  const resposne = await axios.get(URL);
  console.log(response);
}
```

```javascript
// Axios reusable object
ax = axios.create({
    baseURL: 'https://api.unspash.com',
    headers: { .. }
});
```

# Section 9 - Building Lists of Records

## Understanding .map()

```javascript
const numbers = [1, 2, 3, 4, 5, 6];
let newNumbers = [];

// Using for
for (let i = 0; i < numbers.length; i++){
  newNumbers.push(2*numbers[i])
}

// Using map
newNumbers = numbers.map(
  (i) => { return (2*i); }
)

// Using map
newNumbers = numbers.map( i => 2*i});
```


## Question: why does the following work? Isn't it violating the "I can only return one element" principle?

```javascript
class ImageList extends React.Component {

    render() {
        return (
                this.props.images.map(
                    (image) => { return <img src={image.urls.small} /> }
                )
        );
    }
}
```

## Understanding `key` prop
- Required for React to append only new items to DOM
- If an item is already rendered, React wont update it again in DOM
- `key` helps React identify and compare items. It's purely a performance consideration.
- `key` is passed in as a prop. You don't need to do anything with the key in the background, nor return it as an attribute in the rendered html.

## Using `refs` for DOM access
- Let the element render itself
- Reach into the DOM and figure out properties of the element (eg. height)
- Set the height on `state` to get the component to rerender
- When rerendering, assign new html attributes or inline styles
- React `ref`s gives access to a single DOM element
- We create `ref`s in constructor & assign them to instance variables & then pass to a particular JSX element as prop
- No need to put this into state - we only add something to state if we expect it to change over time
- React components eventually gets converted into DOM elements. There's no good way of accessing DOM elements outside of the `ref` system

## Gotchas
- Browser consoles are "extremely fancy"
- When they print out `{current: <obj>}` they don't know yet what `<obj>` is
- It only knows the height once we expand that object
- During the mounting, images are not loaded immmediately as they require the network request to be completed


```javascript

class ImageCard extends React.Component {

    constructor(props) {
        super(props);
        this.state = { spans: 0 };
        
        // This is how to create a `ref`
        this.imageRef = React.createRef();
    }


    componentDidMount() {
        // Ensure a callback is fired only after the image has loaded
        this.imageRef.current.addEventListener('load', this.setSpans);
    }

    setSpans = (e) => {
      // Since the image has loaded, we now have the actual height
      const height = this.imageRef.current.clientHeight;
      // The following will cause the object to rerender itself
      this.setState({ spans: height });
    }

    render() {
        return (
          <img 
            ref={this.imageRef} 
            style={{ property: this.state.spans }} 
          />
        );
    }
}

```
# Section 12 - Hook System

- useState: Fn that lets you use the state in a functional component
- useEffect: Fn that lets you use something like a lifecycle method in a functional component
- useRef: Fn that lets you create a ref in a functional component

- Hooks are a way to write reusable code instead of more classic techniques like inheritance

```js
// Array destructuring
const [name, setName] = useState("Niyas")
```

- reason we dont do `<a onClick={f(index)}>` is because it is triggers when the item is first rendered even without clicking. So we use `<a onClick={() => f(index)}>`

- initial state is only set when rendering the component for the first time.
- 