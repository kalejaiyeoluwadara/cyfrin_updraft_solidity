// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleStorage {    
    uint256 public myfavoriteNumber;

     struct Person {
        uint256 favoriteNumber;
        string name;
    }
    
    //dynamic array
    Person[] public listOfPeople;

    mapping(string => uint256) public nameToFavoriteNumber;

   

    function store(uint256 _myfavoriteNumber) public virtual {
        myfavoriteNumber = _myfavoriteNumber;
    }

    function retrieve() public view returns(uint256){
        return myfavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push(Person(_favoriteNumber,_name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

}
contract SimpleStorage2{}
contract SimpleStorage3{}
contract SimpleStorage4{}