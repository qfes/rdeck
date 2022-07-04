export function cloneElement<T extends HTMLElement>(element: T) {
  const clone = element.cloneNode(true) as T;
  cloneStyle(element, clone);

  // HACK: reset positioning & force dimensions
  const { width, height } = clone.style;
  Object.assign(clone.style, {
    position: "relative",
    inset: "0",
    minWidth: width,
    minHeight: height,
  });

  return clone;
}

export function cloneStyle<T extends HTMLElement>(element: T, clone: T): T {
  const style = globalThis.getComputedStyle(element);

  for (const property of style) {
    clone.style.setProperty(
      property,
      style.getPropertyValue(property),
      style.getPropertyPriority(property)
    );
  }

  const elementChildren = [...element.children] as HTMLElement[];
  const cloneChildren = [...clone.children] as HTMLElement[];

  elementChildren.forEach((_, i) => cloneStyle(elementChildren[i], cloneChildren[i]));

  return clone;
}

export function createImage(url: string): Promise<HTMLImageElement> {
  return new Promise((resolve, reject) => {
    const img = document.createElement("img");
    img.addEventListener("load", () => resolve(img), { once: true });
    img.crossOrigin = "anonymous";
    img.src = url;
  });
}

export function createSvg(
  { width, height }: { width: number; height: number },
  ...children: HTMLElement[]
): SVGElement {
  const ns = "http://www.w3.org/2000/svg";
  const svg = document.createElementNS(ns, "svg");
  svg.setAttribute("width", `${width}`);
  svg.setAttribute("height", `${height}`);
  svg.setAttribute("viewBox", `0 0 ${width} ${height}`);

  const foreignObject = document.createElementNS(ns, "foreignObject");
  foreignObject.setAttribute("width", "100%");
  foreignObject.setAttribute("height", "100%");
  svg.appendChild(foreignObject);

  children.forEach((element) => foreignObject.appendChild(element));

  return svg;
}
