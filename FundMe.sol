// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {AggregatorV3Interface} from "@chainlink/contracts@1.5.0/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    
    uint256 public minimumUSD = 5e18;
    AggregatorV3Interface public priceFeed;
    address[] public funders;
    mapping( address funder => uint256 amountFunded) public addressToAmountFunded;

    // 0x694AA1769357215DE4FAC081bf1f309aDC325306

    constructor(address priceFeedAddress) {
        priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate(priceFeed) >= minimumUSD,
            "Send at least $5 worth of ETH!"
        );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] +=  msg.value;
    }

  
}
