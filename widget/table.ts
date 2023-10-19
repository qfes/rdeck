import { assert, decodeRle, replicate, sum } from "./utils";

export interface TableProps {
  readonly columns: Record<string, any[]>;
  readonly length: number;
  readonly lengths?: number[];
}

export class Table {
  readonly columns: Record<string, any[]>;
  readonly length: number;
  readonly featureIds?: number[];

  constructor({ columns, length, lengths }: TableProps) {
    this.columns = { ...columns };
    this.length = length;

    if (!Array.isArray(lengths)) return;
    assert(length === sum(lengths));

    this.featureIds = replicate((i) => i, lengths);
    for (const [name, values] of Object.entries(this.columns)) {
      if (values.length === length) continue;

      this.columns[name] = decodeRle(values, lengths);
    }
  }

  get(index: number, column: string): any {
    return this.columns[column]?.[index];
  }
}

export function isTable(obj: any): obj is Table {
  return obj != null && typeof obj === "object" && "columns" in obj;
}
