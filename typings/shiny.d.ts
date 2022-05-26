/* exposed global */
export as namespace Shiny;

export function addCustomMessageHandler(type: string, handler: (data: any) => void): void;
export function setInputValue(name: string, value: any, opts?: { priority: "event" }): void;
