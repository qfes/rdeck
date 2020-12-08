/* exposed global */
export as namespace HTMLWidgets;

export function widget(definition: Binding): void;

export interface Binding {
  name: string;
  type: "output";
  sizing?: object;

  factory(el: Element, width: number, height: number): Widget;
}

export interface Widget {
  renderValue(x: { props: any; layers: any[]; theme: "kepler" | "light" }): void;
  resize(width: number, height: number): void;
}
