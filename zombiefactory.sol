pragma solidity ^0.4.25;

contract ZombieFactory {
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

  function _createZombie(string _name, uint _dna) private {
    //Creates a new Zombie struct.
    //Adds the Zombie struct to array 'zombies'.
    zombies.push.Zombie(_name, _dna);  //Replaces Zombie zombies = Zombie(_name, _dna); zombies.push(zombies);
  } //end function createZombie()

  function _generateRandomDna(string _str) private view returns (uint) {
    //Creates pseudorandom number from '_str' and with type uint.
    uint rand = uint(keccak256(_str));
    //Returns last 16 characters of 'rand' since dnaModulus = 10^16.
    return rand % dnaModulus;
  } //end function _generateRandomDna()
} //end contract ZombieFactory{}
