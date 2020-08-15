var BudgetController = (function () {

})()

var UIController = (function () {
    var DOM = {
        inputType: document.querySelector(".add__type"),
        inputDescription: document.querySelector(".add__description"),
        inputValue: document.querySelector(".add__value"),
        inputBtn: document.querySelector(".add__btn")
    }

    return {
        DOM: DOM,
        getInput: function () {
            return {
                type: DOM.inputType.value,
                description: DOM.inputDescription.value,
                value: DOM.inputValue.value,
            }
        }
    }
})()

var AppController = (function (budgetCtrl, UICtrl) {

    function setupEventListeners() {
        var DOM = UICtrl.DOM;
        DOM.inputBtn.addEventListener('click', addBudget);
        document.addEventListener("keypress", function (event) {
            if (event.keyCode === 13 || event.which === 13) {
                addBudget();
            }
        });
    }

    function addBudget() {
        console.log("Adding budget");
        console.log(UIController.getInput());
    }

    return {
        init: function () {
            console.log("App has started");
            setupEventListeners();
        }
    }

})(BudgetController, UIController);


AppController.init();