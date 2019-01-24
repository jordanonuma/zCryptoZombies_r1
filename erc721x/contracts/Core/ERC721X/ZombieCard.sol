pragma solidity ^0.4.25;
import "./ERC721XToken.sol";
import "./Ownable.sol";

Contract ZombieCard is ERC721XToken {
  mapping (uint => uint) internal tokenIdToIndividualSupply;
  event TokenAwarded(uint indexed tokenId, address claimer, uint amount);

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

  function awardToken(uint _tokenId, address _to, uint _amount) public onlyOwner {
    require(exists(_tokenId), "TokenID has not been minted");

    if (individualSupply[_tokenId] > 0) { //fixed supply and token is an NFT
      require(_amount <= balanceOf(msg.sender, _tokenId), "Quantity greater than remaining cards");
      _updateTokenBalance(msg.sender, _tokenId, _amount, ObjectLib.Operations.SUB); //reduces msg.sender's (game server) balance of _tokenId by _amount
    } //end if (token is NFT)
    _updateTokenBalance(_to, _tokenId, _amount, ObjectLib.Operations.ADD);
    emit TokenAwarded(_tokenId, _to, _amount);
  } //end function awardToken()
} //end Contract ZombieCard {}
