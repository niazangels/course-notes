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