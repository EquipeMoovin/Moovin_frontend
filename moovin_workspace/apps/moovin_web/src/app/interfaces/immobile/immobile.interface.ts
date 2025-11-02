// src/app/models/immobile.ts
export interface Immobile {
  id_immobile: number;
  owner: number;
  property_type: string;
  city: string;
  state: string;
  rent: number | string;
  status: string;
  created_at: string;
  bedrooms: number;
  bathrooms: number;
  area: number | string;
  garage: boolean;
  thumbnail: string | null;
}
