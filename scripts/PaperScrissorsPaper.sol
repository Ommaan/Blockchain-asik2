// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RockScissorsPaperContract {

    uint constant public BET_AMOUNT = 0.0001 ether;
    uint constant public REWARD_MULTIPLIER = 2;

    event LogMoves(PlayerChoose playerMove, PlayerChoose opponentMove);

enum PlayerChoose {
    Rock,Scissors,Paper, None
}

enum Result {
    Win, Lose, Draw, None
}



 struct Game {
        address player;
        PlayerChoose playerMove;
        PlayerChoose opponentMove;
        Result result;
    }

 mapping(address => Game[]) public gameHistory;

address payable Player1;
address payable Player2;

bytes32 private encrChoosePlayer1;
bytes32 private encrChoosePlayer2;

PlayerChoose private movePlayer1;
PlayerChoose private movePlayer2;


function play(PlayerChoose _playerMove) external payable {

    
        require(msg.value == BET_AMOUNT, "Incorrect bet amount.");
        require(_playerMove >= PlayerChoose.Rock && _playerMove <= PlayerChoose.Paper, "Invalid move.");

        

        PlayerChoose opponentMove = PlayerChoose(uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 3 + 1);
        Result result;

        emit LogMoves(_playerMove, opponentMove);

        if (_playerMove == opponentMove) {
            result = Result.Draw;
        } else if (
            (_playerMove == PlayerChoose.Rock && opponentMove == PlayerChoose.Scissors) ||
            (_playerMove == PlayerChoose.Scissors && opponentMove == PlayerChoose.Paper) ||
            (_playerMove == PlayerChoose.Paper && opponentMove == PlayerChoose.Rock)
        ) {
            result = Result.Win;
            payable(msg.sender).transfer(BET_AMOUNT * REWARD_MULTIPLIER);
        } else {
            result = Result.Lose;
        }

        gameHistory[msg.sender].push(Game(msg.sender, _playerMove, opponentMove, result));
    }

    function getGameHistory() external view returns (Game[] memory) {
        return gameHistory[msg.sender];
    }


}
