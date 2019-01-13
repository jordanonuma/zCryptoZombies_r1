pragma solidity 0.4.25;

import "./ZB/ZBGameMode.sol";

// 1. Change the name of this contract
contract Singleton is ZBGameMode  {

    function beforeMatchStart(bytes serializedGameState) external {

        GameState memory gameState;
        gameState.init(serializedGameState);

        ZBSerializer.SerializedGameStateChanges memory changes;
        changes.init();

        for (uint i = 0; i < gameState.playerStates.length; i++) {
            CardInstance[] memory newCards = new CardInstance[](gameState.playerStates[i].cardsInDeck.length);
            uint cardCount = 0;

            for (uint j = 0; j < gameState.playerStates[i].cardsInDeck.length; j++) {
                bool cardAlreadyInDeck = false;

                if (!cardAlreadyInDeck) {
                    newCards[cardCount] = gameState.playerStates[i].cardsInDeck[j];
                    cardCount++;
                } //end if (for each card)
            } //end for (all cards in deck)
            changes.changePlayerCardsInDeck(Player(i), newCards, cardCount);
        } //end for (each player)

        changes.emit();
    } //end function beforeMatchStart()


} //end contract Singleton {}