import { Geometry, Position } from "geojson";

export function coordsLength(geometry: Geometry): number {
  switch (geometry.type) {
    case "Point":
      return 1;
    case "MultiPoint":
    case "LineString":
      return geometry.coordinates.length;
    case "MultiLineString":
    case "Polygon":
      return polygonCoordsLength(geometry.coordinates);
    case "MultiPolygon":
      return multipolygonCoordsLength(geometry.coordinates);
    case "GeometryCollection":
      return geometry.geometries.reduce((count, geometry) => count + coordsLength(geometry), 0);
    default:
      // @ts-ignore
      throw new TypeError(`Geomtry type ${geometry.type} not supported.`);
  }
}

function polygonCoordsLength(coordinates: Position[][]): number {
  return coordinates.reduce((count, ring) => count + ring.length, 0);
}

function multipolygonCoordsLength(coordinates: Position[][][]): number {
  return coordinates.reduce((count, polygon) => count + polygonCoordsLength(polygon), 0);
}
