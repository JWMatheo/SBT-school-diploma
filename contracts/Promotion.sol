// SPDX-License-Identifier: MIT
// USE ERC1155 to create different collection e.g for university purpose (new promotion each year and different class too)
pragma solidity 0.8.13;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./School.sol";

contract Promotion is ERC721URIStorage{
   using Strings for uint256;
   using Counters for Counters.Counter;
   Counters.Counter private _tokenId;
   address schoolAddress;
   string _baseCollectionURI;
   string extension;

   constructor (string memory _schoolName, string memory _formation, string memory _year_XXXX_to_XXXX_Format, string memory _baseURI, string memory _extension, address _schoolAddress) ERC721(string(abi.encodePacked(_formation, " ",_year_XXXX_to_XXXX_Format, " ", _schoolName)), _schoolName) {
    schoolAddress = _schoolAddress;
    _baseCollectionURI = _baseURI;
    extension = _extension;
   }

   modifier onlySchoolAddress() {
    require(msg.sender == schoolAddress, "Can only be call by the School contract");
    _;
   }

   function mint(address _to) external onlySchoolAddress {
    _tokenId.increment();
    uint id = _tokenId.current();
    _mint(_to, id);
   }
   
   function setBaseURI(string memory _yourBaseURI) internal onlySchoolAddress {
    _baseCollectionURI = _yourBaseURI;
   }

   function setURIExtension(string memory _yourExtension) internal onlySchoolAddress {
    extension = _yourExtension;
   }

   function tokenURI(uint256 tokenId) public view override returns (string memory)  {

    require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

    return (bytes(_baseCollectionURI).length > 0 ? string(abi.encodePacked(_baseCollectionURI, "/", tokenId.toString(), ".", extension)) : "No base URI set");
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