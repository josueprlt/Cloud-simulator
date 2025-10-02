import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const DIRECTUS_URL = "http://localhost:8055"
const STATIC_TOKEN = "-_XZSlDdjJBcZb507A9-8QJKMCi1xQYh"
const DATA_DIR = path.join(__dirname, '../data');
 
// request helper
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
 
// Lire tous les fichiers JSON d'un dossier
function readJsonFiles(folderPath) {
  const files = fs.readdirSync(folderPath);
  const jsonFiles = files.filter(file => file.endsWith('.json'));

  let allData = [];
  for (const file of jsonFiles) {
    const filePath = path.join(folderPath, file);
    const content = fs.readFileSync(filePath, 'utf-8');
    const data = JSON.parse(content);
    allData = allData.concat(data);
  }

  return allData;
}

// Import principal
async function importJson() {
  console.log('🚀 Début de l\'import...\n');

  // Lire tous les dossiers dans data/
  const folders = fs.readdirSync(DATA_DIR, { withFileTypes: true })
    .filter(dirent => dirent.isDirectory())
    .map(dirent => dirent.name);

  console.log(`📁 Dossiers trouvés: ${folders.join(', ')}\n`);

  let totalProcessed = 0;
  let totalErrors = 0;

  for (const folder of folders) {
    const folderPath = path.join(DATA_DIR, folder);
    console.log(`\n📂 Traitement du dossier: ${folder}`);

    try {
      const data = readJsonFiles(folderPath);
      console.log(`   ${data.length} entrées trouvées\n`);

      for (const item of data) {
        try {
          console.log(`📦 ${item.sku} - ${item.service} ${item.instanceType || 'N/A'}`);

          // 1. Créer/récupérer les relations
          const serviceId = await getOrCreateService(item.service);
          const regionId = await getOrCreateRegion(item.region);

          let instanceTypeId = null;
          if (item.instanceType) {
            instanceTypeId = await getOrCreateInstanceType(
              item.instanceType,
              serviceId,
              item.vcpu,
              item.memory
            );
          }

          // 2. Vérifier si le prix existe déjà
          const existing = await directusRequest(`/items/prices?filter[sku][_eq]=${item.sku}`);

          if (existing.data && existing.data.length > 0) {
            // Mettre à jour
            await directusRequest(`/items/prices/${existing.data[0].id}`, 'PATCH', {
              service: serviceId,
              region: regionId,
              instance_type: instanceTypeId,
              os: item.os,
              price_hourly: item.pricePerUnitUSD,
              unit: item.unit,
              currency: "USD",
              description: item.description,
              updated_at: new Date().toISOString()
            });
            console.log(`  ✅ Mis à jour\n`);
          } else {
            // Créer
            await directusRequest('/items/prices', 'POST', {
              sku: item.sku,
              service: serviceId,
              region: regionId,
              instance_type: instanceTypeId,
              os: item.os,
              price_hourly: item.pricePerUnitUSD,
              unit: item.unit,
              currency: "USD",
              description: item.description,
              created_at: new Date().toISOString()
            });
            console.log(`  ✅ Créé\n`);
          }

          totalProcessed++;
        } catch (error) {
          console.error(`  ❌ Erreur: ${error.message}\n`);
          totalErrors++;
        }
      }
    } catch (error) {
      console.error(`❌ Erreur lors de la lecture du dossier ${folder}: ${error.message}\n`);
    }
  }

  console.log('\n✨ Import terminé !');
  console.log(`📊 Total traité: ${totalProcessed}`);
  console.log(`❌ Total erreurs: ${totalErrors}`);
}
    
 
// Lancer l'import
importJson();
 