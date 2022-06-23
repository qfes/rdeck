import { Deck } from "@deck.gl/core";
import { MapboxMap } from "react-map-gl";

export function download(blob: Blob, filename: string) {
  const element = document.createElement("a");
  const blobUrl = URL.createObjectURL(blob);
  element.href = blobUrl;
  element.download = filename;
  element.click();

  URL.revokeObjectURL(blobUrl);
}

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

async function getCanvasImage(canvas: HTMLCanvasElement): Promise<Blob> {
  return new Promise((resolve, reject) => {
    canvas.toBlob((blob) => resolve(blob!));
  });
}

export async function getImageData(bitmap: ImageBitmap): Promise<Blob> {
  const canvas = document.createElement("canvas");
  canvas.width = bitmap.width;
  canvas.height = bitmap.height;
  const context = canvas.getContext("2d");

  context?.drawImage(bitmap, 0, 0);
  return getCanvasImage(canvas);
}
