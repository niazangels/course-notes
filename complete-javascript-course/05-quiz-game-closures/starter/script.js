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
            this.currentQuestion = this.data[idx];

            // Shuffle options
            var L = this.currentQuestion.o.length;
            var pivot = Math.random() * L;
            var options = this.currentQuestion.o;
            this.currentQuestion.o = options.slice(pivot, L).concat(options.slice(0, pivot)

            );
        },
        displayQuestion: function () {
            console.log("Q. " + this.currentQuestion.q)
            console.log("===================================================")
            for (i = 0; i < this.currentQuestion.o.length; i++) {
                console.log(i + ": " + this.currentQuestion.o[i])
            }
        }
    }

    function keepScore() {
        var sc = 0;
        return function score(correct) {
            if (correct) {
                sc += 50;
                return sc;
            } else {
                return sc;
            }
        }
    }

    function checkAnswer(userInput, callback) {
        userInput = parseInt(userInput);

        if (questions.currentQuestion.o[userInput] == questions.currentQuestion.a) {
            message = "^_^ Sahi jawab! ";
            score = callback(true);
        } else {
            message = "x_x Galat hei";
            score = callback(false);
        }

    }

    console.log("Welcome to Kaun Banega Crorepati!")
    console.log("Choose the answer or enter `exit` to quit game");

    var scoreKeeper = keepScore();
    while (true) {
        questions.new();
        questions.displayQuestion();
        var userInput = prompt("Final answer: ");
        if (userInput.toLowerCase() === "exit") {
            break;
        }
        checkAnswer(userInput, scoreKeeper)
        console.log("********* " + message + "(Score: " + score + ") **********")
    }
})()


