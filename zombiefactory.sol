pragma solidity ^0.4.25;

contract ZombieFactory {

  //State variable will be permamently stored on-chain
  uint dnaDigits = 16;
  //To make sure our Zombie's DNA is only 16 characters, set 'dnaModulus' equal to 10^16.
  //Modulus operator (%) will be used to shorten the integer to 16 digits.
  uint dnaModulus = 10 ** dnaDigits;

  struct Zombies {
    string name;
    uint dna;
  } //end struct zombies {}

}
