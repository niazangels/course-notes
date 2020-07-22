/*************************
 *  Objects and methods
 *************************/

var john = {
    firstName: "John",
    lastName: "John",
    birthYear: 1990,
    family: ["Jane", "Mark", "Bob", "Emily"],
    job: "teacher",
    isMarried: false,
    calcAge: function (birthYear) {
        return 2020 - birthYear;
    }
}

console.log(john.calcAge(1993));