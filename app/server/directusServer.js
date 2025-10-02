import { createDirectus, rest, staticToken } from '@directus/sdk';

const { VITE_DIRECTUS_URL , VITE_STATIC_TOKEN } = import.meta.env;

export const directus = createDirectus(VITE_DIRECTUS_URL)
    .with(staticToken(VITE_STATIC_TOKEN))
    .with(rest());

