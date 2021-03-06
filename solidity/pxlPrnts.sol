pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Context.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721Metadata.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721Enumerable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/IERC721Receiver.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/introspection/ERC165.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/EnumerableSet.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/EnumerableMap.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Strings.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";


contract pixelPrints is ERC721 {
   
    address owner = msg.sender;
    string public termsURI = "";
    string private  name_ = "pxlPrnts";
    string private  symbol_ = "PXLP";
   
    modifier onlyOwner {
      require(msg.sender == owner);
      _;
    } 

    constructor () ERC721 ("", "") {}
    
    function mintToken (address _owner, uint _tokenID, string memory _tokenURI) public onlyOwner {
        _mint(_owner, _tokenID);
        _setTokenURI(_tokenID, _tokenURI);
        
        emit eMintToken(_owner, _tokenID, _tokenURI);
    }
 
    function updateTokenURI (uint _tokenID, string memory _tokenURI) public onlyOwner {
        _setTokenURI(_tokenID, _tokenURI);
        emit eUpdateTokenURI(_tokenID, _tokenURI);
    }
    
    function burnToken (uint _tokenID) public onlyOwner {
        _burn(_tokenID);
        emit eBurnToken(_tokenID);
    }
    
    function transferOwnership (address _owner) public onlyOwner {
        owner = _owner;
        emit eTransferOwnership(msg.sender, _owner);
    }
    
    function updateTermsURI (string memory _termsURI) public onlyOwner{
        termsURI = _termsURI;
        emit eUpdateTokenURI(_termsURI);
    }
    
    function setBaseURI (string memory _baseURI) public onlyOwner{
        _setBaseURI(_baseURI);
        emit eSetBaseURI(_baseURI);
    }
    
    function name() public view virtual override returns (string memory) {
        return name_;
    }
    
    function symbol() public view virtual override returns (string memory) {
        return symbol_;
    }
    
    function SetNameAndSymbol(string memory _name, string memory _symbol) public onlyOwner  {
        name_ = _name;
        symbol_ = _symbol;
        emit eSetNameAndSymbol(_name, _symbol);
    }
    

    event eMintToken(address _owner, uint _tokenID, string _tokenURI);
    event eUpdateTokenURI(uint _tokenID, string _tokenURI);
    event eBurnToken(uint _tokenID);
    event eTransferOwnership(address _owner, address _newOwner);
    event eUpdateTokenURI(string _termsURI);
    event eSetBaseURI(string _baseURI);
    event eSetNameAndSymbol(string _name, string _symbol);

}
