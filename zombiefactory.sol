pragma solidity ^0.4.25;
import "./ownable.sol";
import "./safemath.sol";

contract ZombieFactory is Ownable {
  using SafeMath for uint256; //libraries allow for functions to attach to native data types

  event NewZombie(uint zombieId, string name, uint dna);
  //State variable will be permamently stored on-chain
  uint dnaDigits = 16;
  //To make sure our Zombie's DNA is only 16 characters, set 'dnaModulus' equal to 10^16.
  //Modulus operator (%) will be used to shorten the integer to 16 digits.
  uint dnaModulus = 10 ** dnaDigits;
  uint cooldownnTime = 1 days; //Unix time requres the poor '1 days' grammar.

  struct Zombie {
    string name;
    uint dna;
    uint32 level; //specifying less than normal 256-bits and clustering two uint32 variables in the struct is more gas efficient than not).
    uint32 readyTime;
    uint16 winCount;
    uint16 lossCount; //uint16 provides 2^16 = 65,536 slots. 2^8 only provides 256 slots.
  } //end struct zombies {}

  //Creates a struct Zombie[] named 'zombies'.
  //By having 'zombies' array public, a getter is automatically created.
  Zombie[] public zombies;

  mapping (uint => address) public zombieToOwner;
  mapping (address => uint) ownerZombieCount;

  function _createZombie(string _name, uint _dna) internal {
    require(ownerZombieCount[msg.sender] == 0); //restricts users to creating one zombie each

    //Creates a new Zombie struct.
    //Adds the Zombie struct to array 'zombies'.
    //array.push() returns a uint of the new length of the array. Since the first item in an array has index 0, array.push() - 1 will be the index of the zombie we just added.
    uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1; //Replaces Zombie zombies = Zombie(_name, _dna) and zombies.push(zombies);
                                                                                    //'level' starts at '1'. uint32(now + cooldownTime) gives the unix time of 1 day from when the function is called.

    zombieToOwner[id] = msg.sender; //Assigns user based on global zombie id that is simply a global tally whenever a zombie is created.
    ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].add(1); //Increases user's zombie tally

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
