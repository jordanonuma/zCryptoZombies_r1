pragma solidity ^0.4.25;
import "./zombieattack.sol";
import "./erc721.sol";

/// @title ERC721 Ownership - Balance and Ownership Lookups to Transfer
/// @author Loom.io and myself
/// @notice Returns balances of and approves transfers between ERC721 tokens
contract ZombieOwnership is ZombieAttack, ERC721 {

    mapping (uint => address) zombieApprovals;

    function balanceOf(address _owner) external view returns (uint256) {
      return ownerZombieCount[_owner];
    } //end function balanceOf()

    function ownerOf(uint256 _tokenId) external view returns (address) {
      return zombieToOwner[_tokenId];
    } //end fucntion ownerOf()

    function _transfer(address _from, address _to, uint256 _tokenId) private {
      ownerZombieCount[_to] = ownerZombieCount[_to].add(1);
      ownerZombieCount[_from] = ownerZombieCount[_from].sub(1);
      zombieToOwner[_tokenId] = _to;
      emit Transfer(_from, _to, _tokenId); //dApp will send out this signal via the JSON-RPC API for the front end
    } //end function _transfer()

    function _transferFrom(address _from, address _to, uint256 _tokenId) external payable {
      require (zombieToOwner[_tokenId] == msg.sender || zombieApprovals[_tokenId] == msg.sender);
      _transfer(_from, _to, _tokenId);
    } //end function _transferFrom()

    function approved(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
      zombieApprovals[_tokenId] = _approved;
      emit Approval(msg.sender, _approved, _tokenId);
    } //end function approved()
} //end contract ZombieOwnership {}
