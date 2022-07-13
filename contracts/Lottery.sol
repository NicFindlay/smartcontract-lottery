// SPDX-License-Identifier: MIT

pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract Lottery {
    address payable[] public players;
    uint256 public usdEntryFee;
    AggregatorV3Interface internal ethUsdPriceFeed;

    constructor(address _priceFeedAddress) public {
        usdEntryFee = 50 * (10**18);
        ethUsdPriceFeed = AggregatorV3Interface(_priceFeedAddress);
    }

    function enter() public payable {
        //$50 Min
        players.push(msg.sender);
    }

    function getEntranceFee() public view returns (unit256) {
        (, int256 price, , , , ) = ethUsdPriceFeed.latestRoundData;
        unit256 adjustedPrice = unit256(price) * 10**10; //18 decimals
        // $50, $2000 / Eth.   50/2000     50 * 100000 / 2000

        unit256 costToEnter = (usdEntryFee * 10**18) / price;
        return costToEnter;
    }

    function startLottery() public {}

    function endLottery() public {}
}
