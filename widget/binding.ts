import { Widget } from "./widget";

export const binding: HTMLWidgets.Binding = {
  name: "rdeck",
  type: "output",
  factory(el, _width, _height) {
    let instance: Widget | null = null;
    return {
      get instance() {
        return instance;
      },
      renderValue(props: any) {
        instance = new Widget(el, props);
        instance.render();
      },
      resize() {},
    } as const;
  },
};

type ContainerElement = Element & {
  htmlwidget_data_init_result: HTMLWidgets.Widget & { instance: Widget | null };
};

/**
 * Get an rdeck widget instance by id
 * @param id the widget id
 * @returns {Widget}
 */
export function getWidgetById(id: string): Widget | null {
  const element = document.getElementById(id) as ContainerElement | null;
  return element && getInstance(element);
}

/**
 * Get all rdeck widget instances
 */
export function getWidgets(): Widget[] {
  const elements = [...document.querySelectorAll(".rdeck.html-widget")] as ContainerElement[];
  return elements.map((x) => getInstance(x)).filter((x): x is Widget => isWidget(x));
}

function getInstance(element: ContainerElement): Widget | null {
  return element?.htmlwidget_data_init_result?.instance;
}

function isWidget(object: unknown | null): object is Widget {
  return object instanceof Widget;
}

/* register widget */
HTMLWidgets.widget(binding);
