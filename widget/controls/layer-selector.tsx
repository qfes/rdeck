import { Fragment, PropsWithChildren, useEffect, useRef, useState } from "react";
import { CheckBoxOutlineBlank, CheckBox, IndeterminateCheckBox, Layers } from "@mui/icons-material";

import { VisibilityInfo } from "../layer";
import { classNames, groupBy } from "../util";
import styles from "./layer-selector.module.css";

const NO_GROUP = Date.now();

export type ToggleButtonProps = PropsWithChildren<{
  className?: string;
  tooltip?: string;
  onClick: () => void;
}>;

export function ToggleButton({ className, tooltip, onClick, children }: ToggleButtonProps) {
  return (
    <button className={className} type="button" onClick={onClick} title={tooltip}>
      {children}
    </button>
  );
}

export type LayerSelectorProps = {
  layers: VisibilityInfo[];
  onVisibilityChange: (layers: VisibilityInfo[]) => void;
};

export function LayerSelector({ layers, onVisibilityChange }: LayerSelectorProps) {
  const groups = groupBy(layers, (layer) => layer.groupName ?? `${layer.name}-${NO_GROUP}`);

  const handleVisibilityChange = (changed: VisibilityInfo[], visible: boolean, focus: boolean) => {
    if (focus) {
      const notChanged = layers.filter((layer) => !changed.includes(layer));
      const nonFocus = !notChanged.some((layer) => layer.visible);
      return onVisibilityChange(
        layers.map((layer) => ({
          ...layer,
          visible: changed.includes(layer) ? visible : nonFocus,
        }))
      );
    }

    onVisibilityChange(changed.map((layer) => ({ ...layer, visible })));
  };

  const [isOpen, setIsOpen] = useState(false);
  const handleOpenChange = () => setIsOpen((isOpen) => !isOpen);

  if (!isOpen) {
    return (
      <ToggleButton
        className={styles.toggleButton}
        tooltip="Layer selector"
        onClick={handleOpenChange}
      >
        <Layers className={styles.icon} fontSize="small" />
      </ToggleButton>
    );
  }

  return (
    <div className={styles.panel}>
      <div className={styles.header}>
        <ToggleButton className={styles.button} onClick={handleOpenChange} tooltip="Close">
          <Layers className={styles.icon} fontSize="small" />
          <span className={styles.text}>Layers</span>
        </ToggleButton>
      </div>
      <div className={styles.body}>
        {Array.from(groups.entries(), ([key, layers, [{ groupName: group }] = layers]) => (
          <CheckboxGroup key={key} {...{ group, layers, onChange: handleVisibilityChange }} />
        ))}
      </div>
    </div>
  );
}

type CheckboxGroupProps = {
  group: string | null;
  layers: VisibilityInfo[];
  onChange: (layers: VisibilityInfo[], visible: boolean, focus: boolean) => void;
};

function CheckboxGroup({ group, layers, onChange }: CheckboxGroupProps) {
  const checkboxes = Array.from(
    groupBy(layers, (layer) => layer.name),
    ([name, layers]) => <Checkbox key={name} {...{ name, layers, onChange }} />
  );

  return group ? (
    <Fragment>
      <Checkbox {...{ name: group, layers, onChange }} />
      <div className={styles.groupContainer}>{checkboxes}</div>
    </Fragment>
  ) : (
    <Fragment>{checkboxes}</Fragment>
  );
}

type CheckboxProps = {
  name: string;
  layers: VisibilityInfo[];
  onChange: (layers: VisibilityInfo[], visible: boolean, focus: boolean) => void;
};

function Checkbox({ name, layers, onChange }: CheckboxProps) {
  const checked = isVisible(layers);
  const indeterminate = checked === null;

  const inputRef = useRef<HTMLInputElement>(null);
  useEffect(() => {
    if (inputRef.current) {
      inputRef.current.indeterminate = indeterminate;
    }
  }, [indeterminate]);

  const cancel = useRef<() => boolean>(() => false);
  const handleChange = () => {
    // if a delay was cancelled, checkbox was checked within delay period
    const cancelled = cancel.current();
    // double-click -> show layer and focus
    if (cancelled) onChange(layers, true, true);
    // single-click -> change layer with small delay
    else cancel.current = delay(() => onChange(layers, !checked, false), 200);
  };

  const CheckBoxIcon = checked
    ? CheckBox
    : indeterminate
    ? IndeterminateCheckBox
    : CheckBoxOutlineBlank;

  const classes = classNames(styles.label, checked || indeterminate ? styles.checked : null);
  return (
    <label className={classes}>
      <input
        ref={inputRef}
        className={styles.checkbox}
        type="checkbox"
        onChange={handleChange}
        checked={checked ?? true}
      />
      <CheckBoxIcon fontSize="small" className={styles.icon} />
      <span className={styles.text}>{name}</span>
    </label>
  );
}

function isVisible(layers: VisibilityInfo[]) {
  let visible = layers[0].visible;
  for (const layer of layers) {
    if (layer.visible !== visible) return null;
  }

  return visible;
}

const delay = (onTimeout: () => void, delay = 200) => {
  const raf = { current: 0 };
  let startTime = 0;

  const cancel = () => {
    if (raf.current === 0) return false;

    globalThis.cancelAnimationFrame(raf.current);
    raf.current = 0;
    return true;
  };

  const loop = (timestamp: number) => {
    if (!startTime) {
      startTime = timestamp;
    }

    if (timestamp - startTime > delay) {
      raf.current = 0;
      onTimeout();
      return;
    }

    raf.current = globalThis.requestAnimationFrame(loop);
  };

  raf.current = globalThis.requestAnimationFrame(loop);
  return cancel;
};
