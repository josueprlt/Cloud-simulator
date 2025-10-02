import { directus } from "../components/directusServer.js";
import {readItems} from '@directus/sdk';

export class DirectusDatas {
    async getRegions() {
        try {
        const regions = await directus.request(readItems('regions'));
        return regions;
        } catch (error) {
        console.error('Failed to fetch regions:', error);
        throw error;
        }
    }

    async getServices() {
        try {
        const services = await directus.request(readItems('services'));
        return services;
        } catch (error) {
        console.error('Failed to fetch services:', error);
        throw error;
        }
    }

    async getPrices() {
        try {
        const prices = await directus.request(readItems('prices'));
        return prices;
        } catch (error) {
        console.error('Failed to fetch prices:', error);
        throw error;
        }
    }

    async getInstanceType() {
        try {
        const instance_types = await directus.request(readItems('instance_types'));
        return instance_types;
        } catch (error) {
        console.error('Failed to fetch instance_types:', error);
        throw error;
        }
    }
}
