import data from './data/AmazonEC2/af-south-1.json' with { type: "json" };
import dotenv from 'dotenv';
dotenv.config();
import process from 'process';

const DIRECTUS_URL = process.env.DIRECTUS_URL;
const ACCESS_TOKEN = process.env.DIRECTUS_TOKEN;

// request helper
async function directusRequest(endpoint, method = 'GET', body = null) {

  console.log(process.env);
  

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

// Créer ou récupérer un service
async function getOrCreateService(serviceCode) {
  try {
    // Cherche si le service existe déjà
    const result = await directusRequest(`/items/services?filter[code][_eq]=${serviceCode}`);
    
    if (result.data && result.data.length > 0) {
      return result.data[0].id;
    }
    
    // Sinon, créer le service
    const newService = await directusRequest('/items/services', 'POST', {
      code: serviceCode,
      name: `Amazon ${serviceCode}`
    });
    
    return newService.data.id;
  } catch (error) {
    console.error(`Erreur service ${serviceCode}:`, error.message);
    throw error;
  }
}

// Get region or throw error
async function getOrCreateRegion(regionCode) {
  try {
    const result = await directusRequest(`/items/regions?filter[code][_eq]=${regionCode}`);
    
    if (result.data && result.data.length > 0) {
      return result.data[0].id;
    }
    
    throw new Error(`Region ${regionCode} not found`);
  } catch (error) {
    console.error(`Erreur région ${regionCode}:`, error.message);
    throw error;
  }
}

// Créer ou récupérer un type d'instance
async function getOrCreateInstanceType(instanceName, serviceId, vcpu, memory) {
  try {
    const result = await directusRequest(
      `/items/instance_types?filter[name][_eq]=${instanceName}&filter[service][_eq]=${serviceId}`
    );
    
    if (result.data && result.data.length > 0) {
      return result.data[0].id;
    }
    
    const newInstance = await directusRequest('/items/instance_types', 'POST', {
      name: instanceName,
      service: serviceId,
      vcpu: vcpu,
      memory: memory
    });
    
    return newInstance.data.id;
  } catch (error) {
    console.error(`Erreur instance ${instanceName}:`, error.message);
    throw error;
  }
}

// Import principal
async function importPrices() {
  console.log('🚀 Début de l\'import...\n');
  
  for (const price of data) {
    try {
      console.log(`📦 Traitement: ${price.sku} - ${price.service} ${price.instanceType}`);
      
      // 1. Créer/récupérer les relations
      const serviceId = await getOrCreateService(price.service);
      const regionId = await getOrCreateRegion(price.region);
      const instanceTypeId = await getOrCreateInstanceType(
        price.instanceType,
        serviceId,
        price.vcpu,
        price.memory
      );
      
      // 2. Vérifier si le prix existe déjà
      const existing = await directusRequest(`/items/prices?filter[sku][_eq]=${price.sku}`);
      
      if (existing.data && existing.data.length > 0) {
        // Mettre à jour
        await directusRequest(`/items/prices/${existing.data[0].id}`, 'PATCH', {
          service: serviceId,
          region: regionId,
          instanceType: instanceTypeId,
          os: price.os,
          price_per_unit: price.pricePerUnitUSD,
          unit: price.unit,
          currency: "USD",
          updated_at: new Date().toISOString()
        });
        console.log(`  ✅ Mis à jour\n`);
      } else {
        // Créer
        await directusRequest('/items/prices', 'POST', {
          sku: price.sku,
          service: serviceId,
          region: regionId,
          instance_type: instanceTypeId,
          os: price.os,
          price_per_unit: price.pricePerUnitUSD,
          unit: price.unit,
          currency: "USD",
          updated_at: new Date().toISOString()
        });
        console.log(`  ✅ Créé\n`);
      }
      
    } catch (error) {
      console.error(`  ❌ Erreur: ${error.message}\n`);
    }
  }
  
  console.log('✨ Import terminé !');
}

// Lancer l'import
importPrices();