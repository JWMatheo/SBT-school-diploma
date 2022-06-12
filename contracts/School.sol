// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

import "./Factory.sol";
import "./Promotion.sol";

contract School {
    address owner;
    address[] Operators;
    string[] Formations;

    struct Operator{
        bool authorized;
    }

    struct Formation{
        bool exist;
    }
    
    mapping (string=>Formation) setFormation;
    mapping (address=>Operator) setOperator;
    mapping (string=>mapping(string=>address[])) listStudentByFormationAndYear;

     constructor () {

        owner = msg.sender;
        setOperator[owner].authorized = true;
        Operators.push(owner);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You're not the owner !");
        _;
    }

    modifier onlyOperator() {
        require(setOperator[msg.sender].authorized == true, "You're not an operator. Owner have to set your address as operator.");
        _;
    }

    modifier existingFormation(string calldata _formation) {
        require(setFormation[_formation].exist == true, "The formation doesn't exist.");
        _;
    }

    function getOwner() external view returns(address){
        return owner;
    }

    function getOperators() external view returns(address[] memory){
        return Operators;
    }

    function getFormations() external view returns(string[] memory){
        return Formations;
    }

    function getStudents(string calldata _formation, string calldata _year_XXXX_to_XXXX_Format) external view onlyOperator existingFormation(_formation) returns(address[] memory) {
        return listStudentByFormationAndYear[_formation][_year_XXXX_to_XXXX_Format];
    }

    function isOperator(address _address) external view returns(bool){
        return setOperator[_address].authorized;
    }

    function isFormationExist(string calldata _formation) external view returns(bool){
        return setFormation[_formation].exist;
    }
    function setNewOwner(address _newOwnerAddress) external onlyOwner{
        owner = _newOwnerAddress;
    }

    function addOperator(address _operatorAddress) external onlyOwner {
        setOperator[_operatorAddress].authorized = true;
        Operators.push(_operatorAddress);
    }

    function addFormation(string calldata _newFormation) external onlyOperator{
        if (setFormation[_newFormation].exist == false) {
            setFormation[_newFormation].exist = true;
            Formations.push(_newFormation);
        } else {
            revert("This formation name is already taken !");
        }
        
    }

    function addStudent(string calldata _formation, string calldata _year_XXXX_to_XXXX_Format, address _studentAddress) external onlyOperator existingFormation(_formation){
        bool temp;
        for (uint256 i = 0; i < listStudentByFormationAndYear[_formation][_year_XXXX_to_XXXX_Format].length; i++) {
            if (listStudentByFormationAndYear[_formation][_year_XXXX_to_XXXX_Format][i] == _studentAddress) {
                temp = true;
            } 
        }
        if (temp == true) {
            revert("Student is already listed");
        } else {
            listStudentByFormationAndYear[_formation][_year_XXXX_to_XXXX_Format].push(_studentAddress);
        }
        
    }

    // function with _salt, _baseURI and _extension linked to Factory.sol
}
