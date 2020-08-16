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
            inc: 0,
            exp: 0,
        },
        budget: 0,
        exp_percentage: -1

    }

    function calculateTotal(type) {
        var sum = 0;
        data.items[type].forEach(function (current, index, array) {
            sum += current.val;
        })
        data.totals[type] = sum;
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
        addItem: addItem,
        getBudget: function () {
            calculateTotal("inc");
            calculateTotal("exp");

            if (data.totals["inc"] > 0) {
                data.exp_percentage = Math.round(100 * (data.totals["exp"] / data.totals["inc"]));
            } else {
                data.exp_percentage = -1;
            }

            data.budget = data.totals["inc"] - data.totals["exp"];
            return {
                totals: {
                    inc: data.totals["inc"],
                    exp: data.totals["exp"],
                },
                budget: data.budget,
                exp_percentage: data.exp_percentage
            }
        },
    }

})()

var UIController = (function () {
    var DOM = {
        inputType: document.querySelector(".add__type"),
        inputDescription: document.querySelector(".add__description"),
        inputValue: document.querySelector(".add__value"),
        inputBtn: document.querySelector(".add__btn"),
        incomeList: document.querySelector(".income__list"),
        expenseList: document.querySelector(".expenses__list"),
        inc: document.querySelector(".budget__income--value"),
        exp: document.querySelector(".budget__expenses--value"),
        exp_percentage: document.querySelector(".budget__expenses--percentage"),
        budget: document.querySelector(".budget__value"),
    }
    return {
        DOM: DOM,
        getInput: function () {
            return {
                type: DOM.inputType.value,
                description: DOM.inputDescription.value,
                value: parseFloat(DOM.inputValue.value),
            }
        },
        addItem: function (object, type) {
            var html;
            if (type === "inc") {
                element = DOM.incomeList;
                html = `<div class="item clearfix" id="income-%id%">
                <div class="item__description">%desc%</div>
                <div class="right clearfix">
                    <div class="item__value">+ %val%</div>
                    <div class="item__delete">
                        <button class="item__delete--btn"><i class="ion-ios-close-outline"></i></button>
                    </div>
                </div>
            </div>`;
            } else if (type === "exp") {
                element = DOM.expenseList;
                html = `<div class="item clearfix" id="expense-%id%">
                <div class="item__description">%desc%</div>
                <div class="right clearfix">
                    <div class="item__value">- %val%</div>
                    <div class="item__percentage">21%</div>
                    <div class="item__delete">
                        <button class="item__delete--btn"><i class="ion-ios-close-outline"></i></button>
                    </div>
                </div>
            </div>`;
            }

            // Change values in template
            html = html.replace('%id%', object.id);
            html = html.replace('%desc%', object.desc);
            html = html.replace('%val%', object.val);

            // Add to DOM
            element.insertAdjacentHTML('beforeend', html);
        },
        clearInputs: function () {
            var inputs = [DOM.inputValue, DOM.inputDescription];
            inputs.forEach(function (current, index, array) {
                current.value = "";
            })
        },
        updateBudget: function (data) {
            DOM.inc.textContent = data.totals.inc;
            DOM.exp.textContent = data.totals.exp;
            DOM.budget.textContent = data.budget;
            if (data.exp_percentage >= 0) {
                DOM.exp_percentage.textContent = data.exp_percentage + "%";
            } else {
                DOM.exp_percentage.textContent = "--";

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
        var input, newItem, currentBudget;
        // 1. Get input data from UI
        input = UICtrl.getInput();

        if (input.description !== "" && !isNaN(input.value) && input.value > 0) {

            // 2. Add item to budget controller
            newItem = budgetCtrl.addItem(input.type, input.description, input.value);

            // 3. Update the UI
            UICtrl.addItem(newItem, input.type);
            UICtrl.clearInputs();

            // 4. Update the budget
            currentBudget = budgetCtrl.getBudget();
            UICtrl.updateBudget(currentBudget);

        }
    }

    return {
        init: function () {
            console.log("App has started");
            currentBudget = budgetCtrl.getBudget();
            UICtrl.updateBudget(currentBudget);
            setupEventListeners();
        }
    }

})(BudgetController, UIController);


AppController.init();