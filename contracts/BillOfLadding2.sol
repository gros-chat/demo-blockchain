// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// we don't want no problem with SafeMath


contract BillOfLadding2{

    // address buyer;
    // address seller;
    // address shippingCompany;
    uint256 public amountForSeller;
    uint256 public amountForShipping;
    string leCode = '1234';  

   address public seller = 0x48405d7AfFB636928360F405C135250410e1feb8;
   address public buyer = 0xbEcEA6E36FB3F210fAd48e7146861d47485593B4;
   address public shippingCompany =0xb2Cc3cBDfF632228520608ef55B0c6D1f7965C15;

    
    // constructor (_buyer, _seller, _shippingCompany){
    // buyer=_buyer;
    // seller=_seller;
    // shippingCompany=_shippingCompany;    
    // }

    function fundShippingFee()public payable{
        amountForShipping = msg.value;
    }


    function fundPrice() public payable{
        amountForSeller = msg.value;
    }

    modifier onlyShippingCompany() {
        require(msg.sender == shippingCompany);
        _;
    }
    function payTheSeller(string memory unCode) public payable onlyShippingCompany{
        // if (keccak256(bytes(unCode)) == keccak256(bytes(leCode))){
        require(keccak256(bytes(unCode)) == keccak256(bytes(leCode)), "transaction not authorised"); 
        // payable(msg.sender).transfer(amountForSeller);
        (bool success, ) = seller.call{value:amountForSeller}("");
        require(success, "Transfer failed.");
        if(success){
            amountForSeller = 0;
        }
        payShippingCompany();
        }

    

    function payShippingCompany()internal {
        // payable(shippingCompany).transfer(amountForShipping);
          (bool success, ) = msg.sender.call{value:amountForShipping}("");

        require(success, "Transfer failed.");
        if (success){
            amountForShipping= amountForShipping - amountForShipping;
        }
    }

    function getBalance() public view returns (uint256) {

      return this.getBalance();

    }
    // returnMoneyToBuyer(){

    // }
}