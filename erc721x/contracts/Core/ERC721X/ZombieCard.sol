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

  function mintToken(uint _tokenId, uint _supply) public onlyOwner {
    require(!exists(_tokenId), "Error: Tried to mint duplicate token id"); //restricts token to being minted only once
    _mint(_tokenId, msg.sender, _supply);
    tokenIdToIndividualSupply[_tokenId] = _supply; //updates mapping to store the supply of the token
  } //end function mintToken()
} //end Contract ZombieCard {}
