/*************************
 *  Objects and properties
 *************************/

var john = {
    firstName: "John",
    lastName: "Smith",
    birthYear: 1990,
    family: ["Dad", "Mom", "Sis"],
    job: "teacher",
    isMarried: false
};

console.log(john);
console.log(john.firstName);
console.log(john["lastName"]);

john.job = "designer";
john.isMarried = true;
console.log(john);

// new Object syntax
jane = new Object();
jane.firstName = "Jane"
jane['lastName'] = "Smith"
jane.birthYear = 1991;
console.log(jane)