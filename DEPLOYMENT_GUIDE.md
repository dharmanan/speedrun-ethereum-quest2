# 🚀 Ethereum Staking Challenge - Deployment Guide

## Project Status: ✅ READY FOR DEPLOYMENT

All smart contracts have been written and tested. Here's what was implemented:

### ✅ Completed Features

1. **Checkpoint 1: Staking Contract** ✓
   - `stake()` function to collect ETH
   - `balances` mapping to track individual stakes
   - `Stake` event for frontend display
   - All tests passing (5/5)

2. **Checkpoint 2: State Machine** ✓
   - `execute()` function to trigger completion or enable withdrawals
   - `timeLeft()` view function for UI
   - `deadline` set to 30 seconds after deployment
   - `notCompleted` modifier to prevent state conflicts

3. **Checkpoint 3: UX Improvements** ✓
   - `withdraw()` function for failed staking scenarios
   - `receive()` function to accept direct ETH transfers
   - Frontend updated with named event parameters

4. **Contract Security** ✓
   - Prevents funds from getting trapped
   - Protects against executing twice
   - Guards against premature withdrawals

### 📝 Contract Details

**Contract: Staker.sol**
- Threshold: 1 ETH
- Deadline: block.timestamp + 30 seconds
- External Contract: ExampleExternalContract

### 🔧 Local Testing

```bash
# Terminal 1: Start local blockchain
yarn chain

# Terminal 2: Deploy contracts
yarn deploy

# Terminal 3: Start frontend
yarn start
```

Then visit http://localhost:3000

### 🌐 Sepolia Deployment

**Deployer Address:** `0x285ea08fcec123e6670a75e6f912817114800f62`

#### Step 1: Get Sepolia ETH
- Visit https://www.alchemy.com/faucets/ethereum-sepolia
- Request ETH for the deployer address
- Or use https://sepoliafaucet.com

#### Step 2: Deploy to Sepolia
```bash
yarn deploy --network sepolia
```

#### Step 3: Update Frontend Config
Update `packages/nextjs/scaffold.config.ts`:
- Add `chains.sepolia` to `targetNetworks`
- Set `onlyLocalBurnerWallet: false`

#### Step 4: Deploy Frontend to Vercel
```bash
yarn vercel
# Follow prompts, use --prod for production deployment
```

#### Step 5: Verify Contract
```bash
yarn verify --network sepolia
```

Then submit the Etherscan URL to SpeedRunEthereum.com

### 📊 Test Results

```
✔ Should deploy ExampleExternalContract
✔ Should deploy Staker
✔ Balance should go up when you stake()
✔ If enough is staked and time has passed, you should be able to complete
✔ Should redeploy Staker, stake, not get enough, and withdraw

5 passing tests
```

### 🎯 Next Steps

1. Run local tests to verify everything works
2. Deploy to Sepolia testnet
3. Submit the Vercel URL and Etherscan link to the challenge

---

**Note:** All code is production-ready and has been tested. Just follow the deployment steps above!
