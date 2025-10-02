import { createDirectus, rest, staticToken } from '@directus/sdk';

const VITE_DIRECTUS_URL = import.meta.env.VITE_DIRECTUS_URL,
    VITE_STATIC_TOKEN = import.meta.env.VITE_STATIC_TOKEN || "sqdI9gHDEUicFil6PLCM2lC9mmYRMqpK";

export const directus = createDirectus(VITE_DIRECTUS_URL)
    .with(staticToken(VITE_STATIC_TOKEN))
    .with(rest());

