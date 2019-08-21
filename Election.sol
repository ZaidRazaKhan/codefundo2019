pragma solidity ^0.4.11;
// We have to specify what version of compiler this code will compile with

contract Election {
  /* mapping field below is equivalent to an associative array or hash.
  The key of the mapping is candidate name stored as type bytes32 and value is
  an unsigned integer to store the vote count
  */
//   uint auction_start;
  uint auction_end;
//   address owner;
  
  mapping (bytes32 => uint8) public votesReceived;
  
  /* Solidity doesn't let you pass in an array of strings in the constructor (yet).
  We will use an array of bytes32 instead to store the list of candidates
  */
  mapping(address=>uint8) public voted;
  bytes32[] public candidateList;

  /* This is the constructor which will be called once when you
  deploy the contract to the blockchain. When we deploy the contract,
  we will pass an array of candidates who will be contesting in the election
  */
  function Election(bytes32[] candidateNames, uint duration) {
    // auction_start=start;
    auction_end=now + duration;
    // owner=msg.sender;s
    candidateList = candidateNames;
  }

//   function add_candidates(bytes32 candidate){
//     //   require(msg.sender==owner);
//     //   require(now<auction_start);
//       candidateList.push(candidate);
//   }
  
  // This function returns the total votes a candidate has received so far
  function totalVotesFor(bytes32 candidate) returns (uint8) {
    if (validCandidate(candidate) == false) throw;
    return votesReceived[candidate];
  }

  // This function increments the vote count for the specified candidate. This
  // is equivalent to casting a vote
  function voteForCandidate(bytes32 candidate) {
    // require(now>=auction_start);
    require(now<auction_end);
    require(voted[msg.sender] == 0);
    if (validCandidate(candidate) == false) throw;
    votesReceived[candidate] += 1;
    voted[msg.sender]=1;
  }

  function validCandidate(bytes32 candidate) returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (candidateList[i] == candidate) {
        return true;
      }
    }
    return false;
  }
}