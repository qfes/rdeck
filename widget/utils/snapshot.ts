import type { Deck } from "@deck.gl/core";
import type { MapboxMap } from "react-map-gl";

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
