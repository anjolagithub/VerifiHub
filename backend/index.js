// backend/index.js
import 'dotenv/config';  // Load environment variables
import express from 'express';
import { verifyIdentity } from './verifiHubClient.js';  // Correct import
import { getTokenMetadata, getTokenPrice } from './euclidClient.js';  // Assuming you're importing correctly

const app = express();
app.use(express.json());

app.post('/verifyIdentity', async (req, res) => {
    const { userAddress } = req.body;
    try {
        const identityHash = await getTokenMetadata(userAddress);  // Example usage
        const verificationStatus = await verifyIdentity(userAddress);  // Using the imported function
        res.status(200).send(`Identity verification status: ${verificationStatus}`);
    } catch (error) {
        res.status(500).send('Verification failed');
    }
});

app.listen(3000, () => {
    console.log('Server running on port 3000');
});
