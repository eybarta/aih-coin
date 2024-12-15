// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract AIHCoin is ERC20, Ownable, Pausable, ERC20Permit {
    // Token parameters
    uint256 public constant INITIAL_SUPPLY = 100_000_000 * (10 ** 18); // 100 million tokens
    uint256 public constant MAX_SUPPLY = 1_000_000_000 * (10 ** 18); // 1 billion max supply

    // Donation parameters
    uint256 public tzedakaFeePercent = 100; // 1% (basis points)
    uint256 public idfSupportFeePercent = 100; // 1% (basis points)
    address public tzedakaWallet;
    address public idfSupportWallet;

    // Anti-whale mechanism
    uint256 public maxTransactionAmount;
    mapping(address => bool) public isExcludedFromLimit;

    // Business support features
    mapping(address => bool) public isVerifiedBusiness;
    mapping(address => uint256) public businessSupportPoints;

    // Events
    event TzedakaDonation(address indexed from, uint256 amount);
    event IDFSupportDonation(address indexed from, uint256 amount);
    event BusinessVerified(address indexed business);
    event SupportPointsEarned(address indexed business, uint256 points);

    constructor() 
        ERC20("Am Israel Hai Coin", "AIH") 
        ERC20Permit("Am Israel Hai Coin")
    {
        _mint(msg.sender, INITIAL_SUPPLY);
        maxTransactionAmount = INITIAL_SUPPLY / 100; // 1% of initial supply
        isExcludedFromLimit[msg.sender] = true;
    }

    // Donation management
    function setDonationWallets(
        address _tzedakaWallet,
        address _idfSupportWallet
    ) external onlyOwner {
        require(_tzedakaWallet != address(0) && _idfSupportWallet != address(0), "Invalid addresses");
        tzedakaWallet = _tzedakaWallet;
        idfSupportWallet = _idfSupportWallet;
    }

    function setDonationFees(
        uint256 _tzedakaFee,
        uint256 _idfSupportFee
    ) external onlyOwner {
        require(_tzedakaFee <= 500 && _idfSupportFee <= 500, "Fees too high"); // Max 5% each
        tzedakaFeePercent = _tzedakaFee;
        idfSupportFeePercent = _idfSupportFee;
    }

    // Business support features
    function verifyBusiness(address business) external onlyOwner {
        isVerifiedBusiness[business] = true;
        emit BusinessVerified(business);
    }

    function removeBusiness(address business) external onlyOwner {
        isVerifiedBusiness[business] = false;
    }

    function awardSupportPoints(address business, uint256 points) external onlyOwner {
        require(isVerifiedBusiness[business], "Not a verified business");
        businessSupportPoints[business] += points;
        emit SupportPointsEarned(business, points);
    }

    // Transfer override with donation logic
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual override {
        require(sender != address(0), "Transfer from zero address");
        require(recipient != address(0), "Transfer to zero address");
        require(amount > 0, "Transfer amount must be greater than zero");

        if (!isExcludedFromLimit[sender] && !isExcludedFromLimit[recipient]) {
            require(amount <= maxTransactionAmount, "Transfer amount exceeds limit");
        }

        // Calculate donation amounts
        uint256 tzedakaAmount = (amount * tzedakaFeePercent) / 10000;
        uint256 idfSupportAmount = (amount * idfSupportFeePercent) / 10000;
        uint256 transferAmount = amount - tzedakaAmount - idfSupportAmount;

        // Process donations if wallets are set
        if (tzedakaWallet != address(0)) {
            super._transfer(sender, tzedakaWallet, tzedakaAmount);
            emit TzedakaDonation(sender, tzedakaAmount);
        }
        if (idfSupportWallet != address(0)) {
            super._transfer(sender, idfSupportWallet, idfSupportAmount);
            emit IDFSupportDonation(sender, idfSupportAmount);
        }

        // Transfer remaining amount
        super._transfer(sender, recipient, transferAmount);

        // Award points for verified businesses
        if (isVerifiedBusiness[recipient]) {
            awardSupportPoints(recipient, transferAmount / (10 ** 18));
        }
    }

    // Emergency functions
    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    // Mint function with max supply check
    function mint(address to, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= MAX_SUPPLY, "Would exceed max supply");
        _mint(to, amount);
    }

    // Required overrides
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override whenNotPaused {
        super._beforeTokenTransfer(from, to, amount);
    }
}