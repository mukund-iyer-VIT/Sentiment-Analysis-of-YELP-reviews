// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

contract Yelp{
    struct Business {
        mapping(uint => bytes[]) reviews; 
    }
    
   mapping(bytes=>Business) businesses; 

   //getReview function for a business

   //setReview function for a business

    function stringToBytes(string memory s) internal pure returns (bytes memory) {
        return bytes(s);
    }

    function bytesToString(bytes memory b) internal pure returns (string memory) {
        return string(b);
    }
}
