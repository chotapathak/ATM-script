pragma solidity >=0.4.0 <0.6.0;;
// Making A Contract OF name = SimpleStorage
contract SimpleStorage {
	uint storedData;
	function set(uint x) public {
		storedData = x;		
	}
	// Function Get Public view MEans ( it visible for public ) it's a public Ledger
	function get() public view returns (uint) {
		return storedData; 		
	}
}