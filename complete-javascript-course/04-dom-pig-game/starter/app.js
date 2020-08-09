/*
GAME RULES:

- The game has 2 players, playing in rounds
- In each turn, a player rolls a dice as many times as he whishes. Each result get added to his ROUND score
- BUT, if the player rolls a 1, all his ROUND score gets lost. After that, it's the next player's turn
- The player can choose to 'Hold', which means that his ROUND score gets added to his GLBAL score. After that, it's the next player's turn
- The first player to reach 100 points on GLOBAL score wins the game

*/

var playerScores, currentScore, playerTurn, gameOver;
var $ = document.querySelector.bind(document);;
var domDice = $('.dice');
newGame();

$('.btn-roll').addEventListener('click', function () {

    if (gameOver) { return; };

    // Roll dice
    var dice = Math.floor(Math.random() * 6) + 1;

    // Show die
    domDice.style.display = 'block';
    domDice.src = 'dice-' + dice + '.png';

    // Update currentScore
    if (dice !== 1) {
        currentScore += dice;
        $('#current-' + playerTurn).textContent = currentScore;
    } else {
        switchPlayer();
    }
});

$('.btn-hold').addEventListener('click', function () {

    if (gameOver) { return; };

    // Update Scores & Switch player
    playerScores[playerTurn] += currentScore;
    $('#score-' + playerTurn).textContent = playerScores[playerTurn];

    // Check winner
    if (playerScores[playerTurn] >= 10) {
        gameOver = true;
        domDice.style.display = 'none';
        $('#name-' + playerTurn).textContent = "Winner!";
        $('.player-' + playerTurn + '-panel').classList.add('winner');
    } else {
        switchPlayer();
    }

});

$('.btn-new').addEventListener('click', newGame);

function newGame() {

    playerScores = [0, 0];
    currentScore = 0;
    playerTurn = 0;
    gameOver = false;

    domDice.style.display = 'none';

    $('#score-0').textContent = 0;
    $('#score-1').textContent = 0;
    $('#current-0').textContent = 0;
    $('#current-1').textContent = 0;

    $('#name-0').textContent = "Player 1";
    $('#name-1').textContent = "Player 2";

    $('.player-0-panel').classList.add('active');
    $('.player-1-panel').classList.remove('active');

    $('.player-0-panel').classList.remove('winner');
    $('.player-1-panel').classList.remove('winner');

}

function switchPlayer() {
    // Reset currentScore
    currentScore = 0;
    $('#current-' + playerTurn).textContent = 0;

    // Switch player
    $('.player-' + playerTurn + '-panel').classList.remove('active');
    playerTurn === 0 ? playerTurn = 1 : playerTurn = 0;
    $('.player-' + playerTurn + '-panel').classList.add('active');
}
