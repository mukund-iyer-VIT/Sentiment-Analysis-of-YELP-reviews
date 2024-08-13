// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

contract Yelp {
    struct Business {
        mapping(uint => bytes[5]) reviews;
    }
    
    mapping(bytes => Business) businesses;
    
    function setReview(string memory businessName, uint star, string memory review) public {
        require(star >= 1 && star <= 5, "Star rating must be between 1 and 5");
        
        bytes memory businessNameBytes = stringToBytes(businessName);
        bytes memory reviewBytes = stringToBytes(review);
        
        uint reviewIndex = 0;
        while (reviewIndex < 5 && businesses[businessNameBytes].reviews[star][reviewIndex].length > 0) {
            reviewIndex++;
        }
        require(reviewIndex < 5, "All review slots for this star rating are filled");
        
        businesses[businessNameBytes].reviews[star][reviewIndex] = reviewBytes;
    }

    function getAllReviews(string memory businessName) public view returns (string[][] memory) {
        bytes memory businessNameBytes = stringToBytes(businessName);
        string[][] memory allReviews = new string[][](5);
        
        for (uint star = 1; star <= 5; star++) {
            uint count = 0;
            for (uint i = 0; i < 5; i++) {
                if (businesses[businessNameBytes].reviews[star][i].length > 0) {
                    count++;
                }
            }
            if(count==0) continue;
            allReviews[star-1] = new string[](count);
            uint index = 0;
            for (uint i = 0; i < 5; i++) {
                bytes memory review = businesses[businessNameBytes].reviews[star][i];
                if (review.length > 0) {
                    allReviews[star-1][index] = bytesToString(review);
                    index++;
                }
            }
        }
        
        return allReviews;
    }

    function getReview(string memory businessName, uint star, uint reviewIndex) public view returns (string memory) {
        require(star >= 1 && star <= 5, "Star rating must be between 1 and 5");
        require(reviewIndex < 5, "Review index must be between 0 and 4");
        
        bytes memory businessNameBytes = stringToBytes(businessName);
        bytes memory review = businesses[businessNameBytes].reviews[star][reviewIndex];
        require(review.length > 0, "Review does not exist");
        
        return bytesToString(review);
    }

    function getReviewsForStar(string memory businessName, uint star) public view returns (string[] memory) {
        require(star >= 1 && star <= 5, "Star rating must be between 1 and 5");
        
        bytes memory businessNameBytes = stringToBytes(businessName);
        uint count = 0;
        for (uint i = 0; i < 5; i++) {
            if (businesses[businessNameBytes].reviews[star][i].length > 0) {
                count++;
            }
        }
        
        string[] memory starReviews = new string[](count);
        uint index = 0;
        for (uint i = 0; i < 5; i++) {
            bytes memory review = businesses[businessNameBytes].reviews[star][i];
            if (review.length > 0) {
                starReviews[index] = bytesToString(review);
                index++;
            }
        }
        
        return starReviews;
    }

    function stringToBytes(string memory s) internal pure returns (bytes memory) {
        return bytes(s);
    }

    function bytesToString(bytes memory b) internal pure returns (string memory) {
        return string(b);
    }
}
