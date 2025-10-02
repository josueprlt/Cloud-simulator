import awsRegions from "../data/awsRegions.js"

const DIRECTUS_URL = "http://localhost:8055"
const STATIC_TOKEN = "sqdI9gHDEUicFil6PLCM2lC9mmYRMqpK"

async function directusRequest(endpoint, method = 'GET', body = null) {

  const options = {
    method,
    headers: {
      'Authorization': `Bearer ${STATIC_TOKEN}`,
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