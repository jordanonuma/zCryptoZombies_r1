pragma solidity ^0.4.25;
import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {

    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
      require(msg.sender == zombieToOwner[_zombieId]);

      //Local 'Zombie' named 'myZombie' is a storage pointer indexed '_zombieId' in the 'zombies' array.
      Zombie storage myZombie = zombies[_zombieId]; 
    } //end function feedAndMultiply()

} //end contract ZombieFeeding {}
