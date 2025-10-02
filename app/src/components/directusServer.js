import { createDirectus, rest, staticToken } from '@directus/sdk';

console.log(import.meta);

export const directus = createDirectus(import.meta.env.VITE_DIRECTUS_URL)
    .with(staticToken(import.meta.env.VITE_STATIC_TOKEN))
    .with(rest());