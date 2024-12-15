# AIH Coin (Am Israel Hai - עם ישראל חי)

A blockchain-powered initiative to support Israel through decentralized technology. AIH Coin is an ERC-20 token built on the Ethereum blockchain that automatically contributes to Israeli causes with every transaction.

## Core Features

- **Automatic Tzedaka**: 1% of every transaction is automatically directed to verified Israeli charities
- **IDF Support**: 1% transaction fee directed to authorized IDF support organizations
- **Business Integration**: Special features for businesses supporting Israel
- **Transparent Donations**: All charitable contributions are tracked on-chain
- **Community Governance**: Token holders can vote on supported causes

## Technical Overview

AIH Coin is implemented as an ERC-20 smart contract with the following features:
- Transaction fee splitting mechanism for automatic donations
- Governance functionality for cause selection
- Business integration APIs
- Enhanced security features
- Gas optimization

## Smart Contract Architecture

```solidity
interface IAIHCoin {
    function transfer(address to, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function mint(address to, uint256 amount) external;
    function burn(uint256 amount) external;
}
```

## Getting Started

### Prerequisites
- Node.js v16+
- npm or yarn
- Hardhat
- MetaMask or similar Web3 wallet

### Installation

1. Clone the repository:
```bash
git clone https://github.com/eybarta/aih-coin.git
cd aih-coin
```

2. Install dependencies:
```bash
npm install
```

3. Create a .env file:
```env
PRIVATE_KEY=your_private_key
ETHERSCAN_API_KEY=your_etherscan_api_key
ALCHEMY_API_KEY=your_alchemy_api_key
```

4. Compile contracts:
```bash
npx hardhat compile
```

5. Run tests:
```bash
npx hardhat test
```

## Deployment

### Local Testing
```bash
npx hardhat node
npx hardhat run scripts/deploy.js --network localhost
```

### Testnet Deployment
```bash
npx hardhat run scripts/deploy.js --network goerli
```

### Mainnet Deployment
```bash
npx hardhat run scripts/deploy.js --network mainnet
```

## Exchange Listing Process

1. **Initial Requirements**
   - Complete security audit
   - Minimum liquidity provision
   - Legal documentation
   - Token utility documentation

2. **DEX Listing**
   - Deploy liquidity pools on Uniswap
   - Create trading pairs (ETH/AIH, USDT/AIH)
   - Configure initial price and liquidity

3. **CEX Listing**
   - Submit listing applications
   - Prepare required documentation
   - Meet liquidity requirements
   - Complete compliance checks

## Marketing Strategy

### Target Audience
1. Pro-Israel businesses worldwide
2. Cryptocurrency investors interested in social impact
3. Jewish communities globally
4. Israel support organizations

### Marketing Channels
- Social media presence (Twitter, LinkedIn, Facebook)
- Jewish community outreach
- Business partnerships
- Cryptocurrency forums and communities
- Israeli tech conferences

### Value Propositions
1. Direct support for Israeli causes
2. Transparent donation tracking
3. Business integration opportunities
4. Community governance
5. Social impact through technology

## Roadmap

### Phase 1: Development (Q1 2025)
- Smart contract development
- Security audit
- Testnet deployment
- Community building

### Phase 2: Launch (Q2 2025)
- Mainnet deployment
- Initial DEX listing
- Marketing campaign
- Business partnerships

### Phase 3: Growth (Q3 2025)
- CEX listings
- Additional features
- Expanded partnerships
- International marketing

### Phase 4: Scaling (Q4 2025)
- Additional use cases
- Enhanced governance
- Mobile app development
- Global expansion

## Contributing

We welcome contributions from the community. Please read our contributing guidelines and submit pull requests.

## Security

### Audit Status
- Initial audit planned for Q1 2025
- Bug bounty program to be launched
- Regular security reviews scheduled

### Smart Contract Security
- Multi-signature wallet implementation
- Time-locked contracts
- Emergency pause functionality
- Rate limiting mechanisms

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

- Website: [aihcoin.org](https://aihcoin.org)
- Email: support@aihcoin.org
- Twitter: [@AIHCoin](https://twitter.com/AIHCoin)
- Telegram: [t.me/AIHCoin](https://t.me/AIHCoin)

## Disclaimer

This project is in development. Cryptocurrency investments carry inherent risks. Always conduct your own research before investing.