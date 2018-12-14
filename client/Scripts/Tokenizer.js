var tokenizer =  {

    problems: [
        { answer: "9", question: "n - 7 = 2" },
        { answer: "12", question: "n - 6 = 6" },
        { answer: "6", question: "n - 4 = 2" },
        { answer: "5", question: "n - 3 = 2" },
        { answer: "26", question: "x - 9 = 17" },
        { answer: "27", question: "n - 14 = 13" },
        { answer: "31", question: "n - 12 = 19" },
        { answer: "33", question: "b - 11 = 22" },
        { answer: "60", question: "a - 20 = 40" },
        { answer: "145", question: "n - 100 = 45" },
        { answer: "34", question: "x - 15 = 19" },
        { answer: "11", question: "n - 3 = 8" }
    ],


    Tokenizer: function (problem) {
        this.problem = problem;
        this.operators = ["/", "*", "+", "-", "=", "(", ")", "[", "]"];
    }
}

tokenizer.Tokenizer.prototype.tokenize = function () {
    //var operators = ['-', '+', '=', '*', '/'];

    var operatorPositions = [];

    // parse problem to return operators and their indicies
    for (var i = 0; i < this.problem.question.length; i++) {
        var character = this.problem.question[i];
        if (this.operators.indexOf(character) > -1) {
            operatorPositions.push({ "operator": character, "index": i });
        }
    }

    var tokens = [];

    var startIndex = 0;
    var endIndex = 0;
    for (var i = 0; i < operatorPositions.length; i++) {
        var operator = operatorPositions[i];
        var endIndex = operator.index; 

        tokens.push(this.problem.question.substring(startIndex, endIndex).split(" ").join(""));
        tokens.push(operator.operator);

        startIndex = endIndex + 1;
        endIndex = 999;
    }

    tokens.push(this.problem.question.substring(startIndex, endIndex).split(" ").join(""));
    //window.alert(tokens);
    return tokens;
}
