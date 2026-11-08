# EconoChain - Econometric Model Registry & Prediction Audit dApp

**Course:** MG3012 - Blockchain Technology for Business  
**Semester:** BSFT - 5th Semester (Fall 2026)  
**Instructor:** Dr. Usama Arshad  
**Network:** Sepolia Testnet  

---

## 1. Project Overview
**EconoChain** is a decentralized application (dApp) built to address hindsight bias and unverified statistical forecasting in quantitative finance and economics. By utilizing smart contracts deployed on the Sepolia Ethereum testnet, data analysts can log time-stamped econometric models, regression parameters, predicted target values, and IPFS data reference hashes prior to real-world market realizations.

---

## 2. Deployed Contract Details
* **Network:** Sepolia Testnet
* **Smart Contract Address:** `0xAb0461c36296Fe9A1B8320BDFF709bba9d8Bc93f`
* **Etherscan Explorer Link:** `https://sepolia.etherscan.io/address/0xAb0461c36296Fe9A1B8320BDFF709bba9d8Bc93f`

---

## 3. Smart Contract Architecture (`SmartContract.sol`)
The contract includes 5 key functions:
1. `publishForecast(...)` (*Write*): Registers a model, target variable, predicted value, and dataset hash on-chain.
2. `resolveOutcome(...)` (*Write*): Allows the analyst to log the true realized market outcome to audit prediction variance.
3. `getForecastDetails(...)` (*Read*): Returns complete historical details for any registered forecast ID.
4. `getTotalForecasts()` (*Read*): Returns the total count of registered models.
5. `getAnalystForecasts(...)` (*Read*): Returns an array of forecast IDs authored by a specific wallet address.

---

## 4. How to Deploy & Setup

### A. Deploy Smart Contract on Remix IDE
1. Open [Remix IDE](https://remix.ethereum.org/).
2. Create a file named `SmartContract.sol` and paste the Solidity code provided in this repository.
3. Under the **Solidity Compiler** tab, select compiler version `0.8.20` and click **Compile SmartContract.sol**.
4. Switch to the **Deploy & Run Transactions** tab.
5. Set Environment to **Injected Provider - MetaMask** (ensure MetaMask is connected to Sepolia Testnet).
6. Click **Deploy** and confirm the transaction in MetaMask.
7. Copy the deployed contract address.

### B. Configure Frontend (`index.html`)
1. Open `index.html` in an editor.
2. Replace `CONTRACT_ADDRESS = "0x0000000000000000000000000000000000000000";` with your deployed Sepolia contract address.
3. Open `index.html` in your web browser or run it via a local web server (e.g., Live Server extension).

---

## 5. Folder Structure for Submission ZIP

```text
├── SmartContract.sol
├── index.html
├── style.css
├── README.md
└── screenshots/
    ├── 1_metamask_connect.png
    ├── 2_contract_deployment.png
    └── 3_ui_transaction_execution.png