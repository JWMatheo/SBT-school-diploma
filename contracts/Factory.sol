// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "./Promotion.sol";

contract NFTFactory {
    event Deploy(address _address);

    function DeployYourNFT(uint _salt,
        string calldata _baseURI,
        string calldata _extension)
        external returns(address){
        Promotion _contract = new Promotion{
            salt: bytes32(_salt)
        }(_baseURI, _extension);
        emit Deploy(address(_contract));
        return address(_contract);      
    }
}