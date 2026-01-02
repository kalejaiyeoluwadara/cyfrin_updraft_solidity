// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {AggregatorV3Interface} from "@chainlink/contracts@1.5.0/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();
contract FundMe {
    using PriceConverter for uint256;
    
    uint256 public constant MINIMUM_USD = 5e18;
    AggregatorV3Interface public priceFeed;
    address[] public funders;
    address public immutable i_owner;
    mapping( address funder => uint256 amountFunded) public addressToAmountFunded;

    // 0x694AA1769357215DE4FAC081bf1f309aDC325306

    constructor(address priceFeedAddress) {
        priceFeed = AggregatorV3Interface(priceFeedAddress);
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate(priceFeed) >= MINIMUM_USD,
            "Send at least $5 worth of ETH!"
        );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] +=  msg.value;
    }

    function withfraw()  public onlyOwner {
         for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
        address funder = funders[funderIndex];
        addressToAmountFunded[funder] = 0;
    }
    funders = new address[](0);
    //call
    (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
    require(callSuccess, "Call failed");
    }
  
  modifier onlyOwner() {
    if(msg.sender != i_owner) revert NotOwner();
    _;
  }
}
