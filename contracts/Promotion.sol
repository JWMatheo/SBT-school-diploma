// SPDX-License-Identifier: MIT
// USE ERC1155 to create different collection e.g for university purpose (new promotion each year and different class too)
pragma solidity 0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Promotion is ERC721URIStorage{
   using Strings for uint256;
   using Counters for Counters.Counter;
   Counters.Counter private _tokenId;
   address owner;
   string _baseCollectionURI;
   string extension;

   constructor (string memory _baseURI, string memory _extension) ERC721("Soulbound Token","SBT") {
    owner = msg.sender;
    setBaseURI(_baseURI);
    setURIExtension(_extension);
   }

   modifier onlyOwner() {
    require(msg.sender == owner);
    _;
   }

   function mint(address _to) external onlyOwner{
    _tokenId.increment();
    uint tokenId = _tokenId.current();
    _mint(_to, tokenId);
   }
   
   function setBaseURI(string memory _yourBaseURI) internal onlyOwner{
    _baseCollectionURI = _yourBaseURI;
   }

   function setURIExtension(string memory _yourExtension) internal onlyOwner{
    extension = _yourExtension;
   }

   function tokenURI(uint256 tokenId) public view override returns (string memory) {

    require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

    return (bytes(_baseCollectionURI).length > 0 ? string(abi.encodePacked(_baseCollectionURI, tokenId.toString(), extension)) : "No base URI set");
    }

// disable all transfearable features of ERC721 to make our NFT Non transferable


  function safeTransferFrom(address _from, address _to, uint256 _tokenId) public pure override {
    revert("SBT's cannot be transfered");
  }
  

  function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory _data) public pure override {
    revert("SBT's cannot be transfered");
  }


  function transferFrom(address _from, address _to, uint256 _tokenId) public pure override {
    revert("SBT's cannot be transfered");
  }


  function approve(address _to, uint256 _tokenId) public pure override {
    revert("SBT's cannot be transfered");
  }


  function setApprovalForAll(address _operator, bool _approved) public pure override {
    revert("SBT's cannot be transfered");
  }


  function getApproved(uint256 _tokenId) public pure override returns (address) {
    return address(0x0);
  }


  function isApprovedForAll(address _owner, address _operator) public pure override returns (bool){
    return false;
  }
    
}