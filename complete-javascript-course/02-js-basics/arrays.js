/*****************
      Arrays
 *****************/

// Initialize arrays
var names = ["John", "Mark", "Niyas"];
var years = new Array(1990, 1969, 1948);

// Mutate array
names[1] = "Ben"
names[5] = "Lucy" // Creates 2xempty elements in between


console.log(names);
console.log(years.length);

// Different data types
var john = ["John", "Smith", 1990, "teacher"];
john.push("blue");
john.unshift("Mr.");
console.log(john);

john.pop("Smith");
john.shift("Mr.");
console.log(john);

console.log(john.indexOf(1990));
console.log(john.indexOf(23));

isDesigner = john.indexOf('designer') === -1 ? "John is not a designer" : "John is a designer";
isTeacher = john.indexOf('teacher') === -1 ? "John is not a teacher" : "John is a teacher";
console.log(isDesigner)
console.log(isTeacher)