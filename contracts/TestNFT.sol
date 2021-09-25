// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title TestNFT contract
 * @dev ERC721 Non-Fungible Token Standard basic implementation
 */
contract TestNFT is ERC721, Ownable {
    using SafeMath for uint256;
    
    string public provenance = "The first TNFT ever";
    uint256 public constant tnftPrice = 10000000000000000; // 0.01 ETH
    uint256 public MaxAmountTnft = 1000;
    uint public constant maxTnft = 20;
    bool public saleIsActive = false;
    

    constructor() public ERC721("Test NFT", "TNFT") {
    }
    
    function mintTNFT (uint numberOfTokens) public payable {
        require(saleIsActive, "Sale is active to mint TNFT");
        require(numberOfTokens <= maxTnft, "Can mint only 20 tokens at the same time");
        require(totalSupply().add(numberOfTokens) <= MaxAmountTnft, "Max supply of tokens");
        require(tnftPrice.mul(numberOfTokens) <= msg.value, "Not enough ether");
        
        for(uint i = 0; i < numberOfTokens; i++) {
            uint mintIndex = totalSupply();
            if (totalSupply() < MaxAmountTnft) {
                _safeMint(msg.sender, mintIndex);
            }
        }
    }
    
    function setProvenance(string memory prov) public onlyOwner {
        provenance = prov;
    }
    
    function setBaseURI(string memory baseURI) public onlyOwner {
        _setBaseURI(baseURI);
    }
    
    function changeTnftPrice(uint256 memory newTnftPrice) public onlyOwner {  //посмотреть допустимо ли константу (первоначальная цена) менять в таких случаях
        tnftPrice = newTnftPrice;
        
    }
}