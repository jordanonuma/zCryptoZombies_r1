pragma solidity ^0.4.25;
import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {

    function feedAndMultiply(uint _zombieId, uint _targetDna) public {
      require(msg.sender == zombieToOwner[_zombieId]);

      //Local 'Zombie' named 'myZombie' is a storage pointer indexed '_zombieId' in the 'zombies' array.
      Zombie storage myZombie = zombies[_zombieId];

      _targetDna = _targetDna % dnaModulus; //takes last 16 digits of _targetDna
      uint newDna = (myZombie.dna + _targetDna) / 2; //access 'myZombie' properties using 'myZombie.dna' or 'myZombie.name'
      _createZombie("NoName", newDna); //with require() will user be able to call function if they already have a zombie(s)
    } //end function feedAndMultiply()

} //end contract ZombieFeeding {}
