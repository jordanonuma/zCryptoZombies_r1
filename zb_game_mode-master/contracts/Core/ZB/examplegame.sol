pragma solidity 0.4.24;

import "./ZB/ZBGameMode.sol";

contract ExampleGame is ZBGameMode  {

  function beforeMatchStart(bytes serializedGameState) external {

    GameState memory gameState; //Declares a new GameState in memory
    gameState.init(serializedGameState); //Function init() will read in all the data from serializedGameState and use it to populate 'gameState' with data

    //Declares custom data type 'changes'. 'Changes' will track edits made in the game state.
    ZBSerializer.SerializedGameStateChanges memory changes;
    changes.init(); //Initializes 'changes'

    changes.changePlayerDefense(Player.Player1, 15);
    changes.changePlayerDefense(Player.Player2, 15);
    changes.changePlayerCurrentGooVials(Player.Player1, 3); //the number of vials the player currently has available for this round. The default starts at 1 when the match starts, and increases by 1 with every turn.
    changes.changePlayerCurrentGooVials(Player.Player2, 3);
    changes.changePlayerCurrentGoo(Player.Player1, 3); //the number of vials that are filled with goo in the current round. Defaults to be the same as the number of goo vials at the start of each turn.
    changes.changePlayerCurrentGoo(Player.Player2, 3);
    changes.changePlayerMaxGooVials(Player.Player1, 8); //default is 10
    changes.changePlayerMaxGooVials(Player.Player2, 8); //default is 10
  } //end function beforeMatchStart()
} //end contract ExampleGame {}
