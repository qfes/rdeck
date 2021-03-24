import { Fragment, PropsWithChildren, useCallback, useState } from "react";
import { Layers, Visibility, VisibilityOff, VisibilityOutlined } from "@material-ui/icons";
import styles from "./map-controls.css";
import { VisibilityInfo } from "./layer";
import { groupBy } from "./util";
import classes from "./map-controls.css";

export type ControlButtonProps = PropsWithChildren<{
  className?: string;
  tooltip?: string;
  onClick: () => void;
}>;

export function ControlButton({ className, tooltip, onClick, children }: ControlButtonProps) {
  return (
    <button className={className} type="button" onClick={onClick} title={tooltip}>
      {children}
    </button>
  );
}

export type LayerSelectorProps = {
  layers: VisibilityInfo[];
  onChange: (layers: VisibilityInfo[]) => void;
};

export function LayerSelector({ layers, onChange }: LayerSelectorProps) {
  const [isOpen, setIsOpen] = useState(false);
  const groups = isOpen ? groupBy(layers, (x) => x.groupName ?? x.name) : null;
  const handleClick = useCallback(() => setIsOpen((isOpen) => !isOpen), []);

  return (
    <Fragment>
      {!isOpen && (
        <ControlButton
          className={styles.controlButton}
          tooltip="Layer selector"
          onClick={handleClick}
        >
          <Layers className={styles.icon} />
        </ControlButton>
      )}

      {isOpen && (
        <div className={styles.panel}>
          <div className={styles.panelHeader}>
            <ControlButton className={styles.panelButton} onClick={handleClick} tooltip="Close">
              <Layers className={styles.icon} />
              Layers
            </ControlButton>
          </div>
          <div className={classes.panelContent}>
            {Array.from(groups!.entries(), ([group, layers]) => (
              <ToggleList key={group} {...{ group, layers, onChange }} />
            ))}
          </div>
        </div>
      )}
    </Fragment>
  );
}

type ToggleProps = {
  name: string;
  visible: boolean | null;
  onChange: (visible: boolean) => void;
};

function Toggle({ name, visible, onChange }: ToggleProps) {
  const Icon = visible ? Visibility : visible === null ? VisibilityOutlined : VisibilityOff;
  const className = visible ? styles.toggle : [styles.toggle, styles.notVisible].join(" ");

  return (
    <label className={className} title={name}>
      <input
        type="checkbox"
        style={{ display: "none" }}
        checked={visible ?? false}
        onChange={() => onChange(!visible)}
      />
      <Icon className={styles.icon} />
      <div className={styles.label}>{name}</div>
    </label>
  );
}

type ToggleListProps = {
  group: string;
  layers: VisibilityInfo[];
  onChange: any;
};

function ToggleList({ group, layers, onChange }: ToggleListProps) {
  const hasGroup = layers[0].groupName === group;
  const _layers = groupBy(layers, (x) => x.name);
  function handleChange(layers: VisibilityInfo[]) {
    return (visible: boolean) => onChange(layers.map((layer) => ({ ...layer, visible })));
  }

  const toggles = Array.from(_layers.entries(), ([name, layers]) => (
    <Toggle key={name} name={name} visible={isVisible(layers)} onChange={handleChange(layers)} />
  ));

  return (
    <Fragment>
      {hasGroup && (
        <Fragment>
          <Toggle name={group} visible={isVisible(layers)} onChange={handleChange(layers)} />
          <div className={classes.togglesContainer}>{toggles}</div>
        </Fragment>
      )}
      {!hasGroup && toggles}
    </Fragment>
  );
}

function isVisible(layers: VisibilityInfo[]) {
  let visible = layers[0].visible;
  for (const layer of layers) {
    if (layer.visible !== visible) return null;
  }

  return visible;
}
