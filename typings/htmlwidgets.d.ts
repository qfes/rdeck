declare namespace HTMLWidgets {
  const shinyMode: boolean;
  const viewerMode: boolean;
  const widgets: BoundWidget[];

  type Scope = HTMLElement | Document;
  type PostRenderHandler = () => void;
  type DataFrame = Record<string | number, unknown[]>;

  export interface Binding {
    name: string;
    type: "output";
    sizing?: object;

    factory(el: HTMLElement, width: number, height: number): Widget;
    find?(scope: Scope): this;
    renderError?(el: HTMLElement, err: Error): void;
    clearError?(el: HTMLElement): void;
  }

  interface Widget {
    renderValue<T extends object>(x: T): void;
    resize(width: number, height: number): void;
  }

  interface BoundWidget extends Widget, Required<Omit<Binding, "factory">> {
    initialize(el: HTMLElement, width: number, height: number): Widget;
  }

  function addPostRenderHandler(callback: PostRenderHandler): void;
  function dataframeToD3(df: DataFrame): Record<string | number, unknown>[];
  function evaluateStringMember<T extends object, K extends keyof T>(o: T, member: K): T;
  function find<T extends Widget>(scope: Scope, selector: string): T;
  function findAll<T extends Widget>(scope: Scope, selector: string): T[];
  function getAttachmentUrl(depname: string, key: string): string;
  function getInstance<T extends Widget>(el: HTMLElement): T;
  function staticRender(): void;
  function transposeArray2D<T extends unknown[][]>(array: T): T;
  function widget(definition: Binding): void;
}
