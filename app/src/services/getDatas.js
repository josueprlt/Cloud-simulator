import { directus } from "../../server/directusServer.js";
import { createItem, readItems } from '@directus/sdk';

export class DirectusDatas {
    // GET
    static async getRegions() {
        try {
        const regions = await directus.request(readItems('regions'));
        return regions;
        } catch (error) {
        console.error('Failed to fetch regions:', error);
        throw error;
        }
    }

    static async getServices() {
        try {
        const services = await directus.request(readItems('services'));
        return services;
        } catch (error) {
        console.error('Failed to fetch services:', error);
        throw error;
        }
    }

    static async getPrices() {
        try {
        const prices = await directus.request(readItems('prices'));
        return prices;
        } catch (error) {
        console.error('Failed to fetch prices:', error);
        throw error;
        }
    }

    static async getSimulations() {
        try {
            const simulations = await directus.request(readItems('simulations'));
            return simulations;
        } catch (error) {
        console.error('Failed to fetch simulations:', error);
        throw error;
        }
    }

    static async getInstanceType() {
        try {
        const instance_types = await directus.request(readItems('instance_types'));
        return instance_types;
        } catch (error) {
        console.error('Failed to fetch instance_types:', error);
        throw error;
        }
    }
    // CREATE
    static async createResources(formData) {
        try {
            const resourcePayload = {
                service: formData.service,
                region: formData.region,
                instance_types: formData.instance_types,
                configuration: formData.configuration,
                monthly_cost: formData.monthly_cost,
                unit_price: formData.unit_price,
                created_at: new Date().toISOString(),
                resource_name: formData.resource_name,
                simulations_id: formData.simulations_id,
            };
            const resourcesCreated = await directus.request(createItem('resources', resourcePayload));
            return resourcesCreated;
        } catch (error) {
            console.error('Failed to create resources:', error);
            throw error;
        }
    }

    static async createSimulation(formData) {
        try {
            const simulationPayload = {
                name: formData.name,
                description: formData.description,
                status: formData.status || 'draft',
                scenario_type: formData.scenario_type || 'current',
                monthly_coast: formData.monthly_coast,
                created_at: formData.created_at || new Date().toISOString(),
            };
            const simulationCreated = await directus.request(createItem('simulations', simulationPayload));
            return simulationCreated;
        } catch (error) {
            console.error('Failed to create simulation:', error);
            throw error;
        }
    }
}
