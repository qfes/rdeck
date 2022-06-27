import type { Deck } from "@deck.gl/core";
import type { MapboxMap } from "react-map-gl";

import { cloneElement, createImage, createSvg } from "./dom";

async function drawDeckgl(context: CanvasRenderingContext2D, deck: Deck): Promise<void> {
  return new Promise((resolve, reject) => {
    const { onAfterRender } = deck.props;

    const getImage = ({ gl }: { gl: WebGLRenderingContext }) => {
      deck.setProps({ onAfterRender });
      resolve(context.drawImage(gl.canvas, 0, 0));
    };

    deck.setProps({ onAfterRender: getImage });
    deck.redraw(true);
  });
}

async function drawMapboxgl(context: CanvasRenderingContext2D, mapbox: MapboxMap): Promise<void> {
  return new Promise((resolve, reject) => {
    mapbox.once("render", ({ target }) => {
      const canvas = target.getCanvas();
      resolve(context.drawImage(canvas, 0, 0));
    });

    mapbox.triggerRepaint();
  });
}

export async function getMapImage(
  deck: Deck,
  mapbox: MapboxMap | null
): Promise<HTMLCanvasElement> {
  const canvas = document.createElement("canvas");
  const context = canvas.getContext("2d")!;
  canvas.width = deck.width;
  canvas.height = deck.height;

  if (mapbox != null) await drawMapboxgl(context, mapbox);
  await drawDeckgl(context, deck);

  return canvas;
}

export async function getSnapshot(
  mapImage: HTMLCanvasElement,
  legendImage: HTMLImageElement | null
): Promise<Blob> {
  const canvas = document.createElement("canvas");
  canvas.width = mapImage.width;
  canvas.height = mapImage.height;
  const context = canvas.getContext("2d");

  context?.drawImage(mapImage, 0, 0);
  if (legendImage != null) {
    context?.drawImage(legendImage, canvas.width - legendImage.width - 10, 10);
  }

  return new Promise((resolve, reject) => {
    canvas.toBlob((blob) => resolve(blob!));
  });
}

export async function getElementImage(element: HTMLElement): Promise<HTMLImageElement> {
  // clone element tree
  const clone = cloneElement(element);
  const { clientWidth: width, clientHeight: height } = element;

  // wrap clone inside svg
  const svg = createSvg({ width, height }, clone);

  // get datauri
  const serializer = new XMLSerializer();
  const svgText = serializer.serializeToString(svg);
  const url = "data:image/svg+xml;charset=utf-8," + encodeURIComponent(svgText);

  return createImage(url);
}
