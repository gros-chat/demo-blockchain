// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// we don't want no problem with SafeMath

contract billOfLading{

    address buyer;
    address seller;
    address shippingCompany;
    uint256 public amountForSeller;
    uint256 public amountForShipping; 

    constructor (address _buyer, address _seller, address _shippingCompany){
        buyer = _buyer;
        seller = _seller;
        shippingCompany = _shippingCompany;
    }

    function fundShippingFee(uint256 _leAmount)public payable{
        amountForShipping = _leAmount;
    }


    function fundPrice(uint256 _leAmount) public payable{
        amountForSeller = _leAmount;
    }

    modifier onlySeller() {
        require(msg.sender == seller);
        _;
    }
    function payTheSeller(uint256 theCode) public payable onlySeller{
        payable(msg.sender).transfer(amountForSeller);
        payShippingCompany();
    }

    function payShippingCompany()internal {
        payable(shippingCompany).transfer(amountForShipping);
    }

    // returnMoneyToBuyer(){

    // }
}