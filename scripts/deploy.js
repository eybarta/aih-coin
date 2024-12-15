async function main() {
  const [deployer] = await ethers.getSigners();
  console.log('Deploying contracts with the account:', deployer.address);

  const AIHCoin = await ethers.getContractFactory('AIHCoin');
  const token = await AIHCoin.deploy();
  await token.deployed();

  console.log('AIH Coin deployed to:', token.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });