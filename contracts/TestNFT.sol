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
    uint256 public constant tnftPrice = 10000000000000000; // 0.01 ETH
    uint256 public maxAmountTnft = 1000;
    uint public constant maxTnft = 20;
    bool public saleIsActive = false;
    

    constructor() ERC721("Test NFT", "TNFT") {
    }
    
    function mintTnft (uint _numberOfTokens) public payable {
        require(saleIsActive, "TestNFT: Sale is active to mint TNFT");
        require(_numberOfTokens <= maxTnft, "TestNFT: Can mint only 20 tokens at the same time");
        require(totalSupply().add(_numberOfTokens) <= maxAmountTnft, "TestNFT: Max supply of tokens");
        require(tnftPrice.mul(_numberOfTokens) <= msg.value, "TestNFT: Not enough ether");
        
        for(uint i = 0; i < _numberOfTokens; i++) {
            uint _mintIndex = totalSupply(); // Из-за конструкции ID токена = totalSupply у первого токена будет индекс 0, что не очень хорошая практика — А какая практика хорошая? Можно записать как mintIndex + 1? 
                _safeMint(msg.sender, _mintIndex);
            }
        }
    }
    
    function setProvenance(string memory _prov) public onlyOwner {
        provenance = prov;
    }
    
    function setBaseURI(string memory _baseURI) public onlyOwner {
        _setBaseURI(baseURI);
    }
    
    function changeTnftPrice(uint256 memory _newTnftPrice) public onlyOwner { 
        tnftPrice = newTnftPrice;    
    }
}
