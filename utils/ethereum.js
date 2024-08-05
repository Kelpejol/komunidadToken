
import { ethers } from "ethers";
import { KomEngineAddress, KomEngineAbi } from "./constants";


const provider = new ethers.JsonRpcProvider(
  process.env.NEXT_PUBLIC_INFURA_API_KEY
);
let wallet;
const privateKey = process.env.NEXT_PUBLIC_PRIVATE_KEY;

export async function connectToEthereum() {
  if (typeof window.ethereum !== "undefined") {
    try {
      await window.ethereum.request({ method: "eth_requestAccounts" });
      const browserProvider = new ethers.BrowserProvider(window.ethereum);
      wallet = new ethers.Wallet(privateKey, provider);
      const signer = await browserProvider.getSigner();
      return { signer, browserProvider };
    } catch (error) {
      throw error;
    }
  } else {
    return null;
  }
}

export async function signMessage(message) {
  const signature = await wallet.signMessage(ethers.getBytes(message));
  return ethers.Signature.from(signature);
}

export async function callClaimToken(contract, sig, amountInWei) {
  try {
    console.log("Contract address:", contract.target);
    const owner = await contract.owner();
    console.log("Owner address:", owner);
    console.log(sig.v, sig.r, sig.s);
   await contract.claimToken(
     amountInWei,
     sig.v,
     sig.r,
     sig.s
   );
    
  } catch (error) {
    console.error("Error in callClaimToken:", error);
    if (error.reason) console.error("Error reason:", error.reason);
    if (error.data) console.error("Error data:", error.data);
  }
}

export default async function handleInteraction() {
  try {
    const { signer, browserProvider } = await connectToEthereum();
    if (!signer) {
      console.error("Failed to connect to Ethereum");
      return;
    }

    const contract = new ethers.Contract(
      KomEngineAddress,
      KomEngineAbi,
      signer
    );

    const amount = "1000";
    const amountInWei = ethers.parseEther(amount);
    const walletAddress = await contract.owner();
    console.log("Wallet Address (message signer):", walletAddress);
    console.log(
      "Signer Address (transaction sender):",
      await signer.getAddress()
    );
    console.log("Amount in Wei:", amountInWei.toString());

    const messageHash = await contract.getMessageHash(signer, amountInWei);
    console.log("Message Hash:", messageHash);
    const sig = await signMessage(messageHash);
    console.log("Signature:", sig);

    await callClaimToken(contract, sig, amountInWei);
  } catch (error) {
    console.error("Error in handleInteraction:", error);
  }
}


