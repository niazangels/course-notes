var BudgetController = (function () {

    var Expense = function (id, desc, val) {
        this.id = id;
        this.desc = desc;
        this.val = val;
    };

    var Income = function (id, desc, val) {
        this.id = id;
        this.desc = desc;
        this.val = val;
    };

    var data = {
        items: {
            exp: [],
            inc: []
        },
        totals: {
            income: 0,
            expense: 0,
        }

    }

    function addItem(type, desc, val) {
        var id, item;

        if (data.items[type].length == 0) {
            id = 0;
        } else {
            id = data.items[type][data.items[type].length - 1].id + 1
        }

        if (type == "exp") {
            item = new Expense(id, desc, val);
        } else if (type == "inc") {
            item = new Income(id, desc, val);
        }

        data.items[type].push(item);
        console.log(data)
        return item

    }

    return {
        addItem: addItem
    }

})()

var UIController = (function () {
    var DOM = {
        inputType: document.querySelector(".add__type"),
        inputDescription: document.querySelector(".add__description"),
        inputValue: document.querySelector(".add__value"),
        inputBtn: document.querySelector(".add__btn")
    };

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
        DOM.inputBtn.addEventListener('click', ctrlAddItem);
        document.addEventListener("keypress", function (event) {
            if (event.keyCode === 13 || event.which === 13) {
                ctrlAddItem();
            }
        });
    }

    function ctrlAddItem() {
        var input, newItem;
        // 1. Get input data from UI
        input = UIController.getInput();

        // 2. Add item to budget controller
        newItem = budgetCtrl.addItem(input.type, input.description, input.value);

        // 3. Update the UI

        // 4. Calculate the budget

        // 5. Display budget on UI
    }

    return {
        init: function () {
            console.log("App has started");
            setupEventListeners();
        }
    }

})(BudgetController, UIController);


AppController.init();