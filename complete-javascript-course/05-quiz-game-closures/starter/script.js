(function () {
    var questions, score;

    questions = {
        data: [
            {
                "q": "What is the capital of India?",
                "o": ["Argentina", "Bolivia", "Atlantis", "New Delhi"],
                "a": "New Delhi"
            },
            {
                "q": "Who created this?",
                "o": ["Niyas", "John Wick", "John Khejriwal", "Lelu Allu"],
                "a": "Niyas"
            },
            {
                "q": "What day is it?",
                "o": ["Yesterday", "Tomorow", "Today", "Doomsday"],
                "a": "Today"
            },
        ],
        new: function () {
            var idx = Math.floor(Math.random() * this.data.length);
            return this.data[idx];
        },
        displayQuestion: function (question) {
            console.log("Q. " + question.q)
            console.log("===================================================")
            for (i = 0; i < question.o.length; i++) {
                console.log(i + ": " + question.o[i])
            }
        }
    }

    score = 0;
    console.log("Welcome to Kaun Banega Crorepati!")
    console.log("Choose the answer or enter `exit` to quit game");

    while (true) {
        currentQuestion = questions.new();
        questions.displayQuestion(currentQuestion);
        var userInput = prompt("Final answer: ");

        if (userInput.toLowerCase() === "exit") {
            break;
        } else {
            userInput = parseInt(userInput);
        }

        if (userInput === currentQuestion.o.indexOf(currentQuestion.a)) {
            message = "^_^ Sahi jawab! "
            score += 50;
        } else {
            message = "x_x Galat hei"
        }
        console.log("********* " + message + "(Score: " + score + ") **********")
    }
})()


