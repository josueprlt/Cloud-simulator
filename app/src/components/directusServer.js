import { createDirectus, rest, staticToken } from '@directus/sdk';
import 'dotenv/config';


const { DIRECTUS_URL, STATIC_TOKEN } = process.env;

export const directus = createDirectus(DIRECTUS_URL)
    .with(staticToken(STATIC_TOKEN))
    .with(rest());

