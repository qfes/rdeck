import type { MapProps } from "react-map-gl";

export class MapState implements MapProps {
  mapboxAccessToken?: string;
  mapStyle?: string;
  reuseMaps?: boolean = true;

  constructor(props?: Partial<MapProps>) {
    Object.assign(this, props);
  }
}
