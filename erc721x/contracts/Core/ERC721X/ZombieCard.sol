pragma solidity ^0.4.25;
import "./ERC721XToken.sol";

Contract ZombieCard is ERC721XToken {
  function name() external view returns (string) {
      return "ZombieCard";
  } //end function name()

  function symbol() external view returns (string) {
      return "ZCX";
  } //end function symbol()
} //end Contract ZombieCard {}
