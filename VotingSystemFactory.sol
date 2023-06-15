// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import './VotingSystem.sol';

contract VotingSystemFactory {
    VotingSystem[] public votingSystems;

    function createVotingSystem() public{
        VotingSystem votingSystem = new VotingSystem();
        votingSystems.push(votingSystem);
    }

    function getVotingSystems() public view returns (VotingSystem[] memory) {
        return votingSystems;
    }
     function getOwner(uint256 _index) public view returns(address){
        VotingSystem votingSystem = VotingSystem(address(votingSystems[_index]));
        return votingSystem.owner();
    }
}