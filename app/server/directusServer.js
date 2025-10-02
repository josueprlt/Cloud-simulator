import { createDirectus, rest, staticToken } from '@directus/sdk';

const VITE_DIRECTUS_URL = import.meta.env.VITE_DIRECTUS_URL,
    VITE_DIRECTUS_TOKEN = "zk053KxbuUhsbmwLzDeuox4lmQsV_hh7"

export const directus = createDirectus(VITE_DIRECTUS_URL)
    .with(staticToken(VITE_DIRECTUS_TOKEN))
    .with(rest());

