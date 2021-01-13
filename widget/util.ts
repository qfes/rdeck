export function properCase(camelCase: string) {
  return camelCase.replace(/([A-Z])/g, " $1").replace(/^./, (s) => s.toUpperCase());
}

export function words(camelCase: string) {
  return camelCase.replace(/([A-Z])/g, " $1").toLowerCase();
}

function getFirstVisible(el: HTMLElement): Element | null {
  if (el.clientHeight > 0 && el.clientHeight > 0) {
    return el;
  }

  return el.parentElement ? getFirstVisible(el.parentElement) : null;
}

export function getElementDimensions(el: HTMLElement): [number, number] {
  const visible = getFirstVisible(el);

  if (el === visible || visible == null) {
    return [el.clientWidth, el.clientHeight];
  }

  const { width, height } = getComputedStyle(el);
  const node = document.createElement("div");
  Object.assign(node.style, {
    width,
    height,
    display: "hidden",
  });

  visible.appendChild(node);
  const dims: [number, number] = [node.clientWidth, node.clientHeight];
  visible.removeChild(node);

  return dims;
}
