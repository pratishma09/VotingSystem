// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract VotingSystem{

    //address of owner
    address public owner;
    uint public noOfCandidates=0;
    uint256[] public CandidateIds;

    //structure
    struct Voter{
        string name;
        uint age;
        bool VotesGiven;
    }

    struct Candidate{
        string name;
        string party;
        uint256 candidateId;
        uint256 count;
    }

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner{
        require(owner==msg.sender,"You don't have rights to access this");
        _;
    }

    //mapping
    mapping(uint256=>Candidate) public candidate;
    mapping(address=>Voter) public voter;

    function addCandidate(string memory _name, string memory _party, uint _candidateId) public{
        //for unique candidate id
        require(candidate[_candidateId].candidateId==0,"Candidate already exists.");

        candidate[_candidateId]= Candidate(_name,_party,_candidateId, 0);
        ++noOfCandidates;
        CandidateIds.push(_candidateId);
    }

    function voteCandidate(uint256 _candidateId, uint256 _age, string memory _votername) public{
        //function to vote for candidate
        require(_age>=18,"You are not eligible to vote.");

        require(voter[msg.sender].VotesGiven==false,"You have already voted");
        require(SearchId(_candidateId),"No such candidate exists.");
        candidate[_candidateId].count++;
        voter[msg.sender]=Voter(_votername, _age, true);
    }

    function viewVote(uint256 _candidateId) public view returns(uint256){
        //function to view no of votes received by candidate
        return candidate[_candidateId].count;
    }

    function viewNoOfCandidates() public view returns(uint256){
        //function to view no of candidates
        return noOfCandidates;
    }

    function SearchId(uint256 _id) public view returns(bool){
        //function to search elements within array
        for (uint256 i = 0; i < CandidateIds.length; i++) {
            if (CandidateIds[i] == _id) {
                return true; // Element found
            }
        }
        return false;
    }

    function receiveFunds() external payable{
        //function to receive funds
    }

    function viewCandidateIds() public view returns(uint256[] memory){
        //function to view candidate ids
        return CandidateIds;
    }

    function viewWinner() public view returns(string memory){
        //function to view results
        uint MAX_VOTES=0;
        string memory WINNER_NAME;
        for (uint256 i = 0; i < CandidateIds.length; i++) {
            if(candidate[i].count>MAX_VOTES){
                MAX_VOTES=candidate[i].count;
                WINNER_NAME=candidate[CandidateIds[i]].name;
            }
        }
        return WINNER_NAME;
    }
    function withdraw() public payable{
        //function to withdraw funds
        require(owner==msg.sender,"Only the owner can withdraw funds.");
        require(address(this).balance>0,"You don't have enough fund");
        payable(msg.sender).transfer(address(this).balance);
    }
}