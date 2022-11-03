// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract NFT {

    uint public startTime;

    uint public constant START_PRICE =  1 ether;
    uint public constant END_PRICE =  0.15 ether;
    uint public constant DURATION =  340 minutes;
    uint public constant INTERVAL =  20 minutes;
    uint public constant DROP_PER_STEP = (START_PRICE - END_PRICE) / (DURATION / INTERVAL);

    constructor(uint _startTime) {
        startTime = _startTime; //timestamp --> https://www.timestamp.fr/
    }

    function getPrice() public view returns(uint){
        //didn't start yet
        if(block.timestamp < startTime){
            return START_PRICE;
        }
        //it finish already
        if(block.timestamp - startTime >= DURATION){
            return END_PRICE;
        }
        else{
            uint step = (block.timestamp - startTime)/INTERVAL;
            return START_PRICE - (step * DROP_PER_STEP);
        }
    }

    function mint(uint quantity) external payable {
        uint price = getPrice();
        require(msg.value >= price*quantity, "Not enough fund");
        //_safeMint()...
    }

    /*function setStartTime(uint _startTime) external onlyOwner {
        startTime = _startTime;
    }*/

}
