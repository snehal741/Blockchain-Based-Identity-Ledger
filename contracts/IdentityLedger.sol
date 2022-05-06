// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <8.10.0;

contract IdentityLedger {
  // uint storedData;

  // function set(uint x) public {
  //   storedData = x;
  // }

  // function get() public view returns (uint) {
  //   return storedData;
  // }
  mapping(address => string) identityLedger;
    //mapping(address => mapping(address => string)) identityLedger;
    event ipfsStored(string _ipfsHash, address _address);
    event receivedIPFS(string response);
    modifier notFull(string memory _string) {
        bytes memory stringTest = bytes(_string);
        require(stringTest.length == 0);
        _;
    }
    constructor() public {}
    function sendIPFS(address _address, string memory _ipfsHash)
        public
        notFull(identityLedger[_address])
    {
        identityLedger[_address] = _ipfsHash;
        emit ipfsStored(_ipfsHash, _address);
    }
    function checkInbox() public {
        string memory ipfs_hash = identityLedger[msg.sender];
        if (bytes(ipfs_hash).length == 0) {
            emit receivedIPFS("Empty Inbox");
        } else {
            identityLedger[msg.sender] = "";
            emit receivedIPFS(ipfs_hash);
        }
    }
}
