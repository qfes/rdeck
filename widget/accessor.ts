export interface Accessor {
  (object: object, { index, data }: { index: number; data: any }): any;
}

export const accessors: { [property: string]: Accessor } = {
  getHexagon: (object, { index, data }) => data.frame.hexagon[index],
  getHexagons: (object, { index, data }) => data.frame.hexagons[index],
  getS2Token: (object, { index, data }) => data.frame.token[index],
  getIcon: (object, { index, data }) => data.frame.icon[index],
  getText: (object, { index, data }) => data.frame.text[index],
  getPath: (object, { index, data }) => data.frame.path[index],
  getPolygon: (object, { index, data }) => data.frame.polygon[index],
  getPosition: (object, { index, data }) => data.frame.position[index],
  getSourcePosition: (object, { index, data }) => data.frame.sourcePosition[index],
  getTargetPosition: (object, { index, data }) => data.frame.targetPosition[index]
};
