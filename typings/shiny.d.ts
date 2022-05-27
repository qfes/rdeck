declare namespace Shiny {
  type Handler<T> = (message: T) => void;
  type EventPriority = "deferred" | "immediate" | "event";
  type InputValueOptions = { priority?: EventPriority };

  export function addCustomMessageHandler<T>(type: string, handler: Handler<T>): void;
  export function setInputValue<T>(name: string, value: T, opts?: InputValueOptions): void;
}
