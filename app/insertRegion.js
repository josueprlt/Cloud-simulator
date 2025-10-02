import awsRegions from "./data/awsRegions.js"
import dotenv from 'dotenv';
dotenv.config();
import process from 'process';

const DIRECTUS_URL = process.env.DIRECTUS_URL;
const ACCESS_TOKEN = process.env.DIRECTUS_TOKEN;

async function directusRequest(endpoint, method = 'GET', body = null) {

  console.log(ACCESS_TOKEN)

  const options = {
    method,
    headers: {
      'Authorization': `Bearer ${ACCESS_TOKEN}`,
      'Content-Type': 'application/json'
    }
  };
  
  if (body) {
    options.body = JSON.stringify(body);
  }
  
  const response = await fetch(`${DIRECTUS_URL}${endpoint}`, options);
  
  if (!response.ok) {
    const error = await response.text();
    throw new Error(`Erreur ${response.status}: ${error}`);
  }
  
  return response.json();
}

async function insertRegion() {
  console.log('🚀 Début de l\'import...\n');
  
  for (const price of awsRegions) {
    try {
      console.log(`📦 Traitement: ${price.value} - ${price.label} ${price.country}`);

        await directusRequest('/items/regions', 'POST', {
          code: price.value,
          name: price.label,
          country: price.country,
        });
      } catch (error) {
      console.error(`  ❌ Erreur: ${error.message}\n`);
    }
  }
  
  console.log('✨ Import terminé !');
}

// Lancer l'import
insertRegion();