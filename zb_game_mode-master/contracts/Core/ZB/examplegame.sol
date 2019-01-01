pragma solidity 0.4.24;

import "./ZB/ZBGameMode.sol";

contract ExampleGame is ZBGameMode  {

  function beforeMatchStart(bytes serializedGameState) external {

    GameState memory gameState; //Declares a new GameState in memory
    gameState.init(serializedGameState); //Function init() will read in all the data from serializedGameState and use it to populate 'gameState' with data
  } //end function beforeMatchStart()
} //end contract ExampleGame {}
