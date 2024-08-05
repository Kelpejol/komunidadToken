import { ethers } from "ethers";

import {KomEngineAddress, KomEngineAbi} from "./constants";
export async function connectToEthereum() {
  // Check if MetaMask is installed
  if (typeof window.ethereum !== "undefined") {
    try {
      // Request account access
      await window.ethereum.request({ method: "eth_requestAccounts" });

      // Create Web3Provider instance
      const provider = new ethers.providers.Web3Provider(window.ethereum);

      // Get the signer
      const signer = provider.getSigner();

      // Get the connected wallet address
     
     const  contract =  new ethers.Contract(KomEngineAddress, KomEngineAbi, signer);
     console.log(contract);
    //  await contract.claimToken(2);

      return { provider, signer };
    } catch (error) {
      console.error("Failed to connect to Ethereum:", error);
      return null;
    }
  } else {
    console.log("Please install MetaMask!");
    return null;
  }
}
