# SpeedRun Ethereum Quest 2 - Decentralized Staking Challenge

This repository contains the completed SpeedRun Ethereum decentralized staking challenge. The challenge involves building a decentralized staking contract where users can stake ETH, and if the total staked amount reaches a threshold before a deadline, the funds are sent to an external contract. If the threshold is not met, users can withdraw their stakes.

## Project Structure

This is a monorepo using Yarn workspaces with the following packages:
- `packages/hardhat`: Smart contracts and deployment scripts
- `packages/nextjs`: Frontend application built with Next.js

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/dharmanan/speedrun-ethereum-quest2.git
   cd speedrun-ethereum-quest2/challenge-decentralized-staking
   ```

2. Install dependencies:
   ```bash
   yarn install
   ```

3. Set up environment variables:
   - Copy `.env.example` to `.env.local` (if exists) or create one
   - Add your private key and RPC URLs for Sepolia testnet
   - Add Etherscan API key for contract verification

## Contract Overview

### Staker.sol
The main staking contract with the following features:
- `stake()`: Payable function to stake ETH
- `execute()`: Called after deadline to either complete staking or allow withdrawals
- `timeLeft()`: View function to check remaining time until deadline
- `withdraw()`: Allows users to withdraw their stake if threshold not met
- `receive()`: Fallback function to accept direct ETH transfers

Key modifiers and events:
- `notCompleted`: Ensures functions can't be called after completion
- `Stake(address, uint256)`: Emitted when ETH is staked

### ExampleExternalContract.sol
A simple contract that receives funds when staking threshold is met.

## Steps to Complete the Challenge

### 1. Set Up the Project
- Use `npx create-eth@latest` to scaffold the project
- Configure Hardhat for Solidity 0.8.20
- Set up Next.js frontend with Scaffold-ETH-2

### 2. Implement the Staker Contract
- Create `Staker.sol` with required functions
- Implement state machine logic (staking → completed/withdrawable)
- Add proper modifiers and events
- Ensure contract interacts with `ExampleExternalContract`

### 3. Write Tests
- Test all contract functions
- Verify staking logic, deadline handling, and withdrawal mechanics
- Run tests with `yarn test`

### 4. Deploy to Sepolia Testnet
- Configure Sepolia network in `hardhat.config.ts`
- Deploy contracts using Hardhat scripts
- Note the deployed contract addresses

### 5. Verify Contracts on Etherscan
- Use Hardhat's verification plugin
- Submit source code for verification
- Get verified contract links

### 6. Deploy Frontend to Vercel
- Build the Next.js application
- Configure Vercel for monorepo deployment
- Ensure the staking UI is accessible
- Handle routing issues (redirect from / to /staker-ui)

### 7. Submit to SpeedRun Ethereum
- Visit https://speedrunethereum.com/
- Submit your deployed contract addresses and frontend URL
- Complete all 6 checkpoints

## Deployed Contracts (Sepolia Testnet)

- **Staker Contract**: [0x4EE0f9D34361B746867C1EE344f141BDC72C0c2F](https://sepolia.etherscan.io/address/0x4EE0f9D34361B746867C1EE344f141BDC72C0c2F)
- **ExampleExternalContract**: [0x9181Ec6823A888A24b11abD9D6dDD0B78562343d](https://sepolia.etherscan.io/address/0x9181Ec6823A888A24b11abD9D6dDD0B78562343d)

## How to Run Locally

### Start the Development Server
```bash
yarn start
```
This will start both the Next.js frontend and local Hardhat network.

### Run Tests
```bash
yarn test
```

### Deploy Contracts Locally
```bash
cd packages/hardhat
yarn deploy
```

### Build Frontend
```bash
cd packages/nextjs
yarn build
```

## Deployment

### Contract Deployment
```bash
cd packages/hardhat
yarn deploy --network sepolia
```

### Contract Verification
```bash
yarn verify --network sepolia
```

### Frontend Deployment
```bash
vercel --prod
```
Note: For monorepo deployment, ensure `vercel.json` is configured correctly.

## Technologies Used

- **Solidity 0.8.20**: Smart contract development
- **Hardhat**: Development framework, testing, deployment
- **Next.js 15.2.5**: Frontend framework
- **Scaffold-ETH-2**: Project template
- **Ethers.js/Viem**: Blockchain interactions
- **Wagmi**: Wallet connections
- **DaisyUI**: UI components
- **Vercel**: Frontend hosting

## Challenge Checkpoints

✅ **Checkpoint 1**: `stake()` function implemented  
✅ **Checkpoint 2**: State machine logic (staking → completed/withdrawable)  
✅ **Checkpoint 3**: `withdraw()` and `receive()` functions  
✅ **Checkpoint 4**: Contracts deployed to Sepolia testnet  
✅ **Checkpoint 5**: Frontend deployed to Vercel  
✅ **Checkpoint 6**: Contracts verified on Etherscan  

## Submission Links

- **SpeedRun Ethereum**: https://speedrunethereum.com/
- **Frontend URL**: https://speedrunquest2.vercel.app/
- **Contract Verification**: See deployed contracts section above

## Contributing

This challenge is completed, but feel free to fork and experiment with the code.

## License

See LICENCE file for details.
