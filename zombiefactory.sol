pragma solidity ^0.4.25;

contract ZombieFactory {

  event NewZombie(uint zombieId, string name, uint dna);
  //State variable will be permamently stored on-chain
  uint dnaDigits = 16;
  //To make sure our Zombie's DNA is only 16 characters, set 'dnaModulus' equal to 10^16.
  //Modulus operator (%) will be used to shorten the integer to 16 digits.
  uint dnaModulus = 10 ** dnaDigits;

  struct Zombie {
    string name;
    uint dna;
  } //end struct zombies {}

  //Creates a struct Zombie[] named 'zombies'.
  //By having 'zombies' array public, a getter is automatically created.
  Zombie[] public zombies;

  mapping (uint => address) public zombieToOwner;
  mapping (address => uint) ownerZombieCount;

  function _createZombie(string _name, uint _dna) private {
    //Creates a new Zombie struct.
    //Adds the Zombie struct to array 'zombies'.
    //array.push() returns a uint of the new length of the array. Since the first item in an array has index 0, array.push() - 1 will be the index of the zombie we just added.
    uint id = zombies.push(Zombie(_name, _dna)) - 1; //Replaces Zombie zombies = Zombie(_name, _dna) and zombies.push(zombies);

    zombieToOwner[id] = msg.sender; //Assigns user based on global zombie id that is simply a global tally whenever a zombie is created.
    ownerZombieCount++; //Increases user's zombie tally

    //Fires event NewZombie
    NewZombie(id, _name, _dna);

  } //end function createZombie()

  function _generateRandomDna(string _str) private view returns (uint) {
    //Creates pseudorandom number from '_str' and with type uint.
    uint rand = uint(keccak256(_str));
    //Returns last 16 characters of 'rand' since dnaModulus = 10^16.
    return rand % dnaModulus;
  } //end function _generateRandomDna()

  function createRandomDna(string _name) public returns {
    uint randomDna = _generateRandomDna(_name);
    _createZombie(_name, randomDna);
  } //end function createRandomDna()
} //end contract ZombieFactory{}
