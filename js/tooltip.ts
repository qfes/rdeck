import { PickInfo } from "@deck.gl/core";

export function getTooltip(info: PickInfo<any>) {
  if (!info.picked || !info.layer || !info.layer.props.tooltip) return null;

  const { id, tooltip, data } = info.layer.props;

  const index = info.index;
  const isColumnar = info.object == null;
  const object = isColumnar ? data.frame : info.object;

  const getValue = isColumnar ? (key: string) => object[key][index] : (key: string) => object[key];
  const names = typeof tooltip === "boolean" ? Object.keys(object) : [tooltip].flat();

  const rows = names.map(
    key => `<tr><td class="col-name">${key}</td><td class="col-value">${getValue(key)}</td></tr>`
  );

  return {
    html: `<div class="layer-name">${id}</div><table><tbody>${rows.join("")}</tbody></table>`
  };
}
