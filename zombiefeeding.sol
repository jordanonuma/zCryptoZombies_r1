pragma solidity ^0.4.25;
import "./zombiefactory.sol";

contract KittyInterface {
    function getKitty(uint256 _id) external view returns(
        bool isGestating,
        bool isReady,
        uint256 cooldownIndex,
        uint256 nextActionAt,
        uint256 siringWithId,
        uint256 birthTime,
        uint256 matronId,
        uint256 sireId,
        uint256 generation,
        uint256 genes
    );
}

contract ZombieFeeding is ZombieFactory {

  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d; //Address of the cryptokitties contract

  //Type of KittyInterface named 'kittyContract' is initialized with ckAddress--address of the cryptokitties contract.
  KittyInterface kittyContract = KittyInterface(ckAddress);

  function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) public {
    require(msg.sender == zombieToOwner[_zombieId]);

    //Local 'Zombie' named 'myZombie' is a storage pointer indexed '_zombieId' in the 'zombies' array.
    Zombie storage myZombie = zombies[_zombieId];

    _targetDna = _targetDna % dnaModulus; //takes last 16 digits of _targetDna
    uint newDna = (myZombie.dna + _targetDna) / 2; //access 'myZombie' properties using 'myZombie.dna' or 'myZombie.name'
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {    //compares _species to the string 'kitty'
        newDna = newDna - newDna % 100 + 99; //replaces the last 2 digits of newDna with '99' to signify that new zombie came from a kitty
    }
    _createZombie("NoName", newDna); //with require() will user be able to call function if they already have a zombie(s)
  } //end function feedAndMultiply()

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId); //calls the getKitty() function in kittyContract in type of KittyInterface named 'kittyContract'
    feedAndMultiply(_zombieId, kittyDna, "kitty");
  } //end function feedOnKitty()

} //end contract ZombieFeeding {}
