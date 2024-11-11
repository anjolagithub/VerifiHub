// backend/euclidClient.js
import axios from 'axios';  // Use ES module import
import dotenv from 'dotenv';
dotenv.config();

// Euclid Protocol API base URL and key
const EUCLID_API_URL = 'https://testnet.api.euclidprotocol.com/api/v1';
const API_KEY = process.env.EUCLID_API_KEY;

// Example function to get token metadata for a user's wallet address
export async function getTokenMetadata(walletAddress) {
  try {
    const response = await axios.get(`${EUCLID_API_URL}/tokens/details`, {
      params: { wallet: walletAddress },
      headers: { 'Authorization': `Bearer ${API_KEY}` }
    });
    return response.data;
  } catch (error) {
    console.error('Error fetching token metadata:', error);
    throw error;
  }
}

// Example function to get token price for verification
export async function getTokenPrice(tokenAddress) {
  try {
    const response = await axios.get(`${EUCLID_API_URL}/token/price`, {
      params: { token: tokenAddress },
      headers: { 'Authorization': `Bearer ${API_KEY}` }
    });
    return response.data;
  } catch (error) {
    console.error('Error fetching token price:', error);
    throw error;
  }
}
