// SPDX-License-Identifier: MIT
// 
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
// pragma solidity ^0.8.0;
pragma solidity >=0.4.0 <0.9.0;

contract MiNFT is ERC721, ERC721Enumerable, ERC721URIStorage {
    using SafeMath for uint256;
    uint public constant mintPrice = 0;
    function _beforeTokenTransfer(address _from, address _to, uint _tokenId) internal override (ERC721, ERC721Enumerable) {
//        require(_to != address(0));
//        require(_from != address(0));
//        require(_to != _from);
        super._beforeTokenTransfer(_from, _to, _tokenId);
    }

    function _burn(uint _tokenId) internal override (ERC721,ERC721URIStorage ,ERC721Enumerable) {
        super._burn(_tokenId);
    }
    function tokenURI(uint _tokenId) public view override (ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(_tokenId);
    }
    function supportsInterface(bytes4 _interfaceID) public view override (ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(_interfaceID);
    }
    constructor () ERC721("VNft", "VN") { }
    function mint(string memory _URI) public payable {
        uint256 mintIndex = totalSupply();
        _safeMint(msg.sender, mintIndex);
        _setTokenURI(mintIndex, _URI);
    }
}
