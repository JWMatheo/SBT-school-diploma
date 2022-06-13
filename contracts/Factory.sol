// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "./Promotion.sol";

contract NFTFactory {
    event Deploy(address _address);
    uint _salt = 8;
    function DeployYourNFT(
        string calldata _schoolName,
        string calldata _formation,
        string calldata _year_XXXX_to_XXXX_Format,
        // uint _salt,
        string calldata _baseURI,
        string calldata _extension, address _schoolAddress)
        external returns(address){
        Promotion _contract = new Promotion{
            salt: bytes32(_salt)
        }(_schoolName, _formation, _year_XXXX_to_XXXX_Format, _baseURI, _extension, _schoolAddress);
        emit Deploy(address(_contract));
        return address(_contract);      
    }
}