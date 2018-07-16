export interface IExtensionResult {
  origin: string;
  value: string;
  type: string;
}

type DataFn = () => Promise<IExtensionResult>;
type CloseFn = () => void;

declare const output: {
  data: DataFn;
  close: CloseFn;
};

export default output;
