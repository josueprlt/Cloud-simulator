import fs from "fs";
import axios from "axios";
import awsRegions from "../data/awsRegions.js";

const services = ["AmazonEC2", "AmazonRDS", "AmazonS3", "AWSLambda", "AmazonECS", "AmazonEKS"];

async function fetchPricing(service, region) {

  try {
    const url = `https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/${service}/current/${region}/index.json`;
    console.log(`🔄 Fetching ${service} - ${region}`);
    const { data } = await axios.get(url, { timeout: 60000 });

    const cleanData = [];

    for (const [sku, product] of Object.entries(data.products)) {
      const attr = product.attributes;

      const terms = data.terms.OnDemand[sku] || {};
      for (const term of Object.values(terms)) {
        for (const price of Object.values(term.priceDimensions)) {
          cleanData.push({
            sku,
            service,
            region,
            location: attr.location,
            productFamily: product.productFamily || null,
            instanceType: attr.instanceType || null,
            vcpu: attr.vcpu || null,
            memory: attr.memory || null,
            storage: attr.storage || null,
            os: attr.operatingSystem || null,
            tenancy: attr.tenancy || null,
            marketOption: "OnDemand",
            unit: price.unit,
            description: price.description,
            pricePerUnitUSD: parseFloat(price.pricePerUnit.USD || 0)
          });
        }
      }
    }

    // Save in clear json
    const folder = `./data/${service}`;
    if (!fs.existsSync(folder)) fs.mkdirSync(folder, { recursive: true });
    fs.writeFileSync(
      `${folder}/${region}.json`,
      JSON.stringify(cleanData, null, 2)
    );

    console.log(`✅ Saved ${service} - ${region} (${cleanData.length} offers)`);
  } catch (err) {
    console.error(`❌ Error for ${service} - ${region}`, err.message);
  }
}

async function main() {
  for (const service of services) {
    for (const region of awsRegions) {
      await fetchPricing(service, region.value);
    }
  }
}

main(); 
