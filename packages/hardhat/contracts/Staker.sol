// SPDX-License-Identifier: MIT
pragma solidity 0.8.20; //Do not change the solidity version as it negatively impacts submission grading

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {
    ExampleExternalContract public exampleExternalContract;

    // Track individual staker balances
    mapping(address => uint256) public balances;
    
    // Minimum threshold required to complete staking
    uint256 public constant threshold = 1 ether;
    
    // Deadline for staking period - 30 seconds after deployment
    uint256 public deadline = block.timestamp + 30 seconds;
    
    // Flag to indicate if withdrawals are allowed
    bool public openForWithdraw;

    // Event emitted when a user stakes funds
    event Stake(address indexed staker, uint256 amount);

    constructor(address exampleExternalContractAddress) {
        exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
    }

    // Modifier to prevent actions after staking is completed
    modifier notCompleted() {
        require(!exampleExternalContract.completed(), "Staking is already completed");
        _;
    }

    /**
     * @dev Allows users to stake ETH before deadline
     * Tracks individual balances and emits Stake event
     */
    function stake() public payable notCompleted {
        require(msg.value > 0, "Must stake some amount");
        require(block.timestamp < deadline, "Staking period has ended");
        
        balances[msg.sender] += msg.value;
        emit Stake(msg.sender, msg.value);
    }

    /**
     * @dev Execute function called after deadline
     * If threshold is met, sends all funds to ExampleExternalContract
     * If threshold is not met, enables withdrawals
     */
    function execute() public notCompleted {
        require(block.timestamp >= deadline, "Deadline has not passed yet");

        if (address(this).balance >= threshold) {
            // Threshold met: send balance to external contract and complete staking
            exampleExternalContract.complete{value: address(this).balance}();
        } else {
            // Threshold not met: allow users to withdraw their funds
            openForWithdraw = true;
        }
    }

    /**
     * @dev Returns time remaining until deadline
     * Returns 0 if deadline has passed
     */
    function timeLeft() public view returns (uint256) {
        if (block.timestamp >= deadline) {
            return 0;
        }
        return deadline - block.timestamp;
    }

    /**
     * @dev Allows users to withdraw their funds if staking failed
     * Only available if threshold was not met
     */
    function withdraw() public notCompleted {
        require(openForWithdraw, "Withdrawals are not open");
        require(balances[msg.sender] > 0, "No balance to withdraw");

        uint256 userBalance = balances[msg.sender];
        balances[msg.sender] = 0;
        
        (bool success, ) = msg.sender.call{value: userBalance}("");
        require(success, "Withdrawal failed");
    }

    /**
     * @dev Special function to receive ETH sent directly to contract
     * Automatically calls stake() to update user balance
     */
    receive() external payable {
        stake();
    }
}
