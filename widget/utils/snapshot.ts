import type { Deck } from "@deck.gl/core";
import type { MapboxMap } from "react-map-gl";

import { cloneElement, createImage, createSvg } from "./dom";

async function getDeckglImageBitmap(deck: Deck): Promise<ImageBitmap> {
  return new Promise((resolve, reject) => {
    const { onAfterRender } = deck.props;

    const getImage = ({ gl }: { gl: WebGLRenderingContext }) => {
      deck.setProps({ onAfterRender });
      resolve(createImageBitmap(gl.canvas));
    };

    deck.setProps({ onAfterRender: getImage });
    deck.redraw(true);
  });
}

async function getMapboxImageBitmap(mapbox: MapboxMap): Promise<ImageBitmap> {
  return new Promise((resolve, reject) => {
    mapbox.once("render", ({ target }) => {
      const canvas = target.getCanvas();
      resolve(createImageBitmap(canvas));
    });

    mapbox.triggerRepaint();
  });
}

export async function getMapImageBitmap(deck: Deck, mapbox?: MapboxMap): Promise<ImageBitmap> {
  if (mapbox == null) return getDeckglImageBitmap(deck);

  const images = await Promise.all([getMapboxImageBitmap(mapbox), getDeckglImageBitmap(deck)]);

  // create canvas to draw images
  const canvas = document.createElement("canvas");
  canvas.width = images[0].width;
  canvas.height = images[0].height;
  const context = canvas.getContext("2d");

  for (const image of images) {
    context?.drawImage(image, 0, 0);
    image.close();
  }

  return createImageBitmap(canvas);
}

export async function getSnapshot(
  mapImage: ImageBitmap,
  legendImage?: ImageBitmap | null
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
    mapImage.close();
    legendImage?.close();
  });
}

export async function transferToBlob(image: ImageBitmap): Promise<Blob> {
  const canvas = document.createElement("canvas");
  canvas.width = image.width;
  canvas.height = image.height;
  const context = canvas.getContext("2d");

  context?.drawImage(image, 0, 0);
  return new Promise((resolve, reject) => {
    canvas.toBlob((blob) => resolve(blob!));
    image.close();
  });
}

export async function getElementImageBitmap(element: HTMLElement): Promise<ImageBitmap> {
  // clone element tree
  const clone = cloneElement(element);
  const { clientWidth: width, clientHeight: height } = element;

  // wrap clone inside svg
  const svg = createSvg({ width, height });
  svg.firstChild?.appendChild(clone);

  // get datauri
  const serializer = new XMLSerializer();
  const svgText = serializer.serializeToString(svg);
  const url = "data:image/svg+xml;charset=utf-8," + encodeURIComponent(svgText);

  // img > canvas > imagebitmap
  const img = await createImage(url);
  const canvas = document.createElement("canvas");
  const context = canvas.getContext("2d");
  Object.assign(canvas, { width, height });

  context?.drawImage(img, 0, 0);
  return createImageBitmap(canvas);
}
