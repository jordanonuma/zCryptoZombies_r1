pragma solidity ^0.4.25;
import "./ERC721XToken.sol";
import "./Ownable.sol";

Contract ZombieCard is ERC721XToken {
  mapping (uint => uint) internal tokenIdToIndividualSupply;

  function name() external view returns (string) {
      return "ZombieCard";
  } //end function name()

  function symbol() external view returns (string) {
      return "ZCX";
  } //end function symbol()

  function tokenIndividualSupply(uint _tokenId) public view returns (uint) {
    return tokenIdToIndividualSupply[_tokenId];
  } //end function tokenIndividualSupply()
} //end Contract ZombieCard {}
