pragma solidity 0.4.25;

import "./ZB/ZBGameMode.sol";

contract ZombiePile is ZBGameMode  {

    function beforeMatchStart(bytes serializedGameState) external {

        GameState memory gameState;
        gameState.init(serializedGameState);

        ZBSerializer.SerializedGameStateChanges memory changes;
        changes.init();

        CardInstance[] memory player1Cards = new CardInstance[](gameState.playerStates[0].cardsInDeck.length);
        CardInstance[] memory player2Cards = new CardInstance[](gameState.playerStates[1].cardsinDeck.length);
        uint player1CardCount = 0;
        uint player2CardCount = 0;

        for (uint i = 0; i < gameState.playerStates.length; i++) {

            for (uint j = 0; j < gameState.playerStates[i].cardsInDeck.length; j++) {

              uint rand = uint(keccak256(abi.encodePacked(now, player1CardCount + player2CardCount))) % 2;
              if (rand == 0) {
                  player1Cards[player1CardCount] = gameState.playerStates[0].cardsInDeck[j]; //assign to player 1's cards
                  player1CardCount++;
              } else {
                  player2Cards[player2CardCount] = gameSTate.playerStates[1].cardsInDeck[j]; //assign to player 2's cards
                  player2CardCount++;
              } //end else {}
            } //end for (all cards in deck)
            changes.changePlayerCardsInDeck(Player(i), newCards, cardCount);
        } //end for (each player)

        changes.emit();
    } //end function beforeMatchStart()
} //end contract Singleton {}