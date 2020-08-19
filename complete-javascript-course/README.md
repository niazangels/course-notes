# The Complete Javascript Course
*Course Link*: https://www.udemy.com/course/the-complete-javascript-course/
*Instructor*: Jonas Schmedtmann

- Operator precedence: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence
- Switch case can be used to check conditions
  ```javascript
  switch(car){
        case 'honda': 
            console.log("Honda goes hoooondaaaa");
            break;
        case 'audi':
        case 'volvo':
            console.log("Audi and volvo don't go")
  }

  // Now we're looking where the case's condition turns true
  switch(true){
        case (age < maxage): 
            console.log("Still eligible");
            break;
        case (age > maxage):
            console.log("Not eligible");
            break;
  }
  ```

### Statement vs Expresssion
- Statement need not run immediately eg. `if` statement
- Expression is evaluated on the spot eg. `x+=4`

### Truthy and Falsy values
- Falsy values are
  - `undefined`
  - `null`
  - `0`, `-0`, `0n`
  - `false`
  - `""`
  - `NaN`
- Everything else is truthy
  - **Warning**: negative numbers are truthy

### Operators
- `==` will coerce types 
  - `23 == "23"` is `true`
- `===` will not coerce types
  - `23 === "23"` is `false`

### Arrays
- Unlike in most languages, you can index beyond the length of the array
```javascript
var names = ["John", "Mark", "Niyas"];
names[5] = "Charlie"
// ["John", "Mark", "Niyas", 2xempty, "Charlie"]
// empty means undefined
```

## Section 3: How Javascript works behind the scenes
- JS code is usually hosted in a browser/nodejs/other apps
- Host contains a JS engine that executes it
- V8, SpiderMonkey, Javascript core etc. are all engines

- JS engine does the following
  - Parser --correctly parsed code--> AST
  - AST ---> Conversion to Machine Code
  - Machine code --> CPU execution

### Execution context
  - A contianer which stores variables and in which a piece of our code is executed or evaluated
  - Default execution context is always executed in the global context and associated with the global object
  - Global context is where all the code that that isn't inside a function is executed. In the browser, that's the `window` object.
  - ```javascript 
    lastName === window.lastName //true
    ```
  - execution contexts are stacked on the global context  
 
    ![picture 2](images/4585c8074cc36436e5a7907ce0db95f82289ab72c880dd48b0bd238c52c86d6e.png)  

- Execution context can be treated as an object with 3 properties
  - Variable object: contains fn args. any other var declarations,fn declarations
  - Scope chain: contains current var obj (pointer??) as well as var obj of all its parents
  - `this` variable

- When a function is called a new exec context is put on top of the execution stack. This happens in 2 phases
  1. Creation phase
     - Creation of the variable object
     - Creation of the scope chain
     - Determine value of the `this` variable

  2. Execution phase
     - code of the fn that created the execution context is run line by line

### Variable object creation
1. `argument` object is created containing all the arguments that were passed to the function
1. Code is scanned for fn declarations and for each fn, a property is created in the VO, pointing to the fn
1. Code is scanned for var declarations and for each var value is set to undefined
1. Last 2 points together is called "hoisting"
1. All the fn are already defined before the execution phase starts, while vars are set to `undefined` and will only be defined in the exec phase

```javascript

// `sayHello` fn runs even though the fn def is below the fn call due to hoisting
sayHello("@niazangels");

function sayHello(name){
  console.log("👋 " + name);
}

// `shout` isn't declared as a function- it's a variable,s so the following code raises an error
shout("@yolo")

var shout = function(text){
  return text.toUpperCase();
}

// Arrow fns behave just like variables, the following will raise an error
sayByeBye("@nsync");

sayByeBye = (name) => {
  console.log(name + " 👋");
}
```


```javascript

console.log(age); // undefined
var age =10;
console.log(age); // 10


console.log(address); // Error: `address` is not defined
```

### Scoping
- Scoping answers the question: where can I find this var
- Each new fn creates a scope. Not `for`/`if`/`while` blocks as with some other languages
- Lexical scoping: nested fn gets access to vars in outer fn

![picture 1](images/92b18dc33078a969d756caf0d54de69418851ade9cf82697ea1058123a9314f3.png)  

![picture 2](images/786e3f835befd48b040120d9f993acdf5c9d0f67ddeb57b6306e983be12ffdca.png)  

### `this` keyword
  - In a regular fn call, `this` points to the global object. i.e. the `window` object in a browser
  - In a method call, `this` points to the object that is calling the method
  - `this` **is not assigned a value until a fn where it is actualy called** 😲


```javascript
var john = {
  name: "John",
  yob: 1990,
  calcAge: function(){ 
    console.log(this); // will show `john` object if we invoked this via john.calcAge()
    console.log(2020 - this.yob); 
    }
}

john.calcAge() // logs `john` and  30

var mike = {
  name: "Mike",
  yob: 2000
}

//  Method borrowing
mike.calcAge = john.calcAge
mike.calcAge() // logs `mike` and 20
```

## Section 4: DOM Manipulation
- Document Object Model
  - Structured representation of HTML page
  - Used to connect webpages to scripts like JS
  - For each HTML box, there's an object in the DOM we can access and interact with

- JS is not DOM. JS interacts with DOM

### Basics

- `document.querySelector` selects DOM objects just like CSS but only the first element.
- `document.querySelector(obj).style` can be used to get/set all css properties such as `style.display = None`


### Events

- Events are notifications sent to the code that something has happened on the page
- Event listener is a fn that performs an action based on a certain event
- **An event can only be handled when the execution stack is empty** 🤯 
- So all exec stacks should have returned
- Besides the Execution stack, we also have a message queue in the JS engine
- The events sit waiting to be processed until we return to global context
- When it does, the next ev gets processed
- So the ev handler picks it up and it gets its own execution context
- `DOMobject.addEventListener('click', fn)`
- Anonymous fn does not have a name and hence cannot be reused 
- `getElementById` is faster than `querySelector`


## Section 5: Objects and Functions
- "Everything is an object. Except the primitives"
- Numbers, Strings, Booleans, Undefined, Null are all primitives
- Everything else including Arrays, fn, Dates are all objects

### Prototypal inheritance
- In other programming languages, its called a class. In js its called a constructor or prototype
- Each and every js obj has a prototype property
- Prototype property is where we put methods and properties that we want other objects to inherit 
- Constructor's prototype property is not the prototype of the constructor itself, it's the prototype of all instances created through it.
- When a prop or method is called, the search starts in the instance and follows the prototype chain
![picture 1](images/c983e23b8db28412a8a831068e465d94b2d7ed4966a610f622d266982c9cef49.png)  

- **@niazangels: This is the Prototype design pattern 😲**
- All prototypes inherit from the `Object` prototype which inherits from the `null` primitive. 
- So if the parameter is not found it is `undefined`. Wut? 😕

### The `new` keyword
- `new` creates an empty `Object`
- Attaches it to the `this` keyword in the context for running the fn
- If we dont attach to `this`, `this` would point to the global excon
- value is usually stored as a var

```javascript
var Person = function(name, yearOfBirth, job){
  this.name = name;
  this.yearOfBirth = yearOfBirth;
  this.job = job;
}

// Only the prototype needs this, not each object
Person.prototype.calculateAge = function(){
  console.log(2020 - this.yearOfBirth);
}

// You can use the same for properties but its less common
Person.prototype.lastname = "Smith";

var john = new Person("John", 1990, "developer");
var jane = new Person("Jane", 1980, "designer");
var steve = new Person("Steve", 1970, "sales");


john instanceof Person; //true

john.__proto__ === Person.prototype; //true
john.__proto__ === jane.__proto__; //true

john.hasOwnProperty('job'); //true
john.hasOwnProperty('lastname'); //false

```

How to inspect objects
```javascript
console.info([1,2,3])
```


### `Object.create` to create new objects
- First define the object that act as the prototype
- Then create an object based on that very prototype


```javascript
// Note that this is no longer a fn constructor
var personProto = {
  calculaeAge: function(){
    console.log(2020 - this.yearOfBirth);
  }
}

var john = Object.create(personProto);
john.name = "John";
john.yearOfBirth = 1990;
john.job = "dev";

var jane = Object.create(personProto, {
  name: { value: "Jane"},
  yearOfBirth: { value: 2000},
  job: { value: "designer"},
});

```

### Object.create vs Fn prototype 
- Obj.create builds an object that directly inherits from the one that we've passed into the first argument
- In Fn constructor, the newly created obj inherits from the fn constructor's prototype property


### Primitives and Objects
- Variables containing primitives contain their value inside the variable itself.
- Vars associated with objects do not contain that object, but instead contain a reference to a place in memory where the obj is stored

```javascript
var a = 23;
var b = a;
a = 46;

console.log(a); // 46
console.log(b); // 23
```

```javascript
var a = { name: "John" };
var b = a;

a.name = "Jane";

console.log(a); // Jane
console.log(b); // Jane
```

```javascript
var a = 23;
var b = {name: "John"}

function change(x, y){
  x = 46;
  y.name = "Jane";
}

change(a, b);

console.log(a);
console.log(b);

```

### Function
- Fn are instances of obj type
- Fn behaves like any other obj
- We can store fn in a var
- We can pass fn as args to another fn
- We can return a fn from a fn
- So we say in JS fn are first class objects


### Immediately invoked fn expressions

- Not for reusability, but for data privacy
- IIFE hides vars from the current context
- With IIFE you dont need to define a new fn and keep it in memory
- It involves creating a fn expression and invoking it immediately
```javascript
  (function(){
    // Code
  })() // Call this at the end!
```
- An anonymous fn is defined and wrapped in paranthesis
- The paranthesis around the fn def tricks the parser into believing this is an expression and not a declaration
- Without this wrapping paranthesis, the parser would break because there is no name
- Also immediately invoke the fn with a succeeding paranthesis open and close

```javascript
(function(goodLuck) {
    if ( ((Math.random() * 10) + goodLuck) >= 5 ) {
      console.log("Winner!")
    }
})(3)
```

### Closures

- An inner fn always has access to the vars and params defined in it's outer fn, **even after the outer fn has returned**!

```javascript
function retirement(ageLimit) {
  var template = " years left":
  return function(age){
    console.log( (ageLimit - age) + template)
  } 
}

retirementIndia = retirement(68);
retirementIndia(20);
```
- Scope stays intact and variables stay on execution stack (?) even after outer fn excon is popped.
- This can be accessed by inner fn
- In the following 
![picture 1](images/919cc01eb6131a16c8eb2ca4c7a5d8c82a336308865d3b12475661f5b66a1331.png)  

### `call`,`apply` and `bind`

- `call` is used for method borrowing
- `apply` is the same but uses an array instead of accepting multiple args
- `bind` creates a copy of the fn with the passed in arguments as default args

```javascript
var john = {
  name: "John",
  greeting: function(style, timeOfDay){
    if (style == "formal") {
      console.log("Good " + timeOfDay + " everyone. My name is " + this.name );
    } else if (style == "friendly") {
      console.log("What's up? I'm " + this.name + ". What're  you upto this " + timeOfDay + "?");
    } 
  }
}

john.greeting("friendly", "morning");

jane = { name:"Jane" }

// The first arg is what `this` should be mapped to. All other args are fn args.
john.greeting.call(jane, "formal", "evening")

// Same for `apply`, but all args are passed in as an array
john.greeting.apply(jane, ["formal", "night"])

// Bind creates a copy of the fn with the default args as passed in
var johnFormal = john.greeting.bind(john, "formal")
johnFormal("day");
```

### Budgety App
- Separate modules based on responsibility
- BudgetController does not depend on UI Controller
- So even with an updated UI need not change anything in BudgetController
- All classes are created as IIFE for data privacy
- The overall layout is as follows

```javascript

var BudgetController = (function(){
  //code
})();

var UIController = (function(){
  //code
})();

var AppController = (function(UICtrl, BudgetCrtrl){
  // Notice that the args have different names so that if we ever change
  // the name of the `UIController` class, we don't need to update it in here 

  return {
    init: function(){
      // Main 
    }
  }
})(UIController, BudgetController);

AppController.init()

```

- To convert list to Array:
```javascript
var arr = Array.prototype.slice.call(list)
```

### Event delegation

- An event is triggered on some DOM element, but its also fired for all its parent elements one at a time upto and including the root element
- Event bubbles up in the dom tree
- The target element is stored as a property in the event, so all parent elements will also know the target element
- We can attach an event handler to the parent element and wait for the event to bubble up
- This is called Event delegation
- Why do we need event delegation?
  - Lots of child elements
  - Ev handler for an element that's not yet in the DOM


### More array methods
- Difference between `.map` and `.forEach` is that `map` returns a new item for each current
- `arr.splice(startinIndex, noOfElementsToRemove)`

### Adding and removing nodes to UI
- You can only remove a child. So if you want to delete an element, you need to `element.parentNode.removeChild(element)` 