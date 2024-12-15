const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('AIHCoin', function () {
  let AIHCoin, aihCoin, owner, addr1, addr2, tzedakaWallet, idfSupportWallet;
  const INITIAL_SUPPLY = ethers.utils.parseEther('100000000'); // 100 million

  beforeEach(async function () {
    [owner, addr1, addr2, tzedakaWallet, idfSupportWallet] = await ethers.getSigners();
    AIHCoin = await ethers.getContractFactory('AIHCoin');
    aihCoin = await AIHCoin.deploy();
    await aihCoin.deployed();
  });

  describe('Deployment', function () {
    it('Should set the right owner', async function () {
      expect(await aihCoin.owner()).to.equal(owner.address);
    });

    it('Should assign the total supply of tokens to the owner', async function () {
      const ownerBalance = await aihCoin.balanceOf(owner.address);
      expect(await aihCoin.totalSupply()).to.equal(ownerBalance);
    });
  });

  describe('Donations', function () {
    beforeEach(async function () {
      await aihCoin.setDonationWallets(tzedakaWallet.address, idfSupportWallet.address);
      await aihCoin.transfer(addr1.address, ethers.utils.parseEther('1000'));
    });

    it('Should process donations correctly', async function () {
      const transferAmount = ethers.utils.parseEther('100');
      await aihCoin.connect(addr1).transfer(addr2.address, transferAmount);

      const tzedakaBalance = await aihCoin.balanceOf(tzedakaWallet.address);
      const idfBalance = await aihCoin.balanceOf(idfSupportWallet.address);
      
      expect(tzedakaBalance).to.equal(transferAmount.mul(1).div(100));
      expect(idfBalance).to.equal(transferAmount.mul(1).div(100));
    });
  });

  describe('Business Support', function () {
    it('Should verify business correctly', async function () {
      await aihCoin.verifyBusiness(addr1.address);
      expect(await aihCoin.isVerifiedBusiness(addr1.address)).to.equal(true);
    });

    it('Should award support points', async function () {
      await aihCoin.verifyBusiness(addr1.address);
      await aihCoin.awardSupportPoints(addr1.address, 100);
      expect(await aihCoin.businessSupportPoints(addr1.address)).to.equal(100);
    });
  });
});