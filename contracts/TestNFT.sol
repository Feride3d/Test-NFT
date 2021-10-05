// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title TestNFT contract
 * @dev ERC721 Non-Fungible Token Standard basic implementation
 */
contract TestNFT is ERC721, Ownable {
    
    string public provenance = "The first TNFT ever";
    uint256 public TokensPrice = 10000000000000000; // 0.01 ETH
    uint256 public maxAmountTokens = 1000;
    uint public constant maxTokens = 20;
    bool public saleIsActive = false;
    

    constructor() ERC721("Test NFT", "TNFT") {
    }
    
    function mintTokens (uint _numberOfTokens) public payable {
        require(saleIsActive, "TestNFT: Sale is active to mint TNFT");
        require(_numberOfTokens <= maxTokens, "TestNFT: Can mint only 20 tokens at the same time");
        require(totalSupply().add(_numberOfTokens) <= maxAmountTokens, "TestNFT: Max supply of tokens");
        uint256 _lastTokenId = totalSupply();

        for(uint i = 0; i < _numberOfTokens; i++) {
            _lastTokenId ++;
            _mint(_to, _lastTokenId);
            }
        }
    }
    
    function setProvenance(string memory _prov) public onlyOwner {
        provenance = prov;
        }
    
    function setBaseURI(string memory _baseURI) public onlyOwner {
        _setBaseURI(baseURI);
        }
    
    function changeTokensPrice(uint256 memory _newTokensPrice) public onlyOwner { 
        TokensPrice = newTokensPrice;    
        }