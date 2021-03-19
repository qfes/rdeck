import { Fragment, PropsWithChildren, useState } from "react";
import { Layers, Visibility, VisibilityOff } from "@material-ui/icons";
import styles from "./map-controls.css";

export type ControlButtonProps = PropsWithChildren<{
  className: string | null;
  tooltip: string;
  onClick: () => void;
}>;

export function ControlButton({ className, tooltip, onClick, children }: ControlButtonProps) {
  const _className = className ? [styles.button, className].join(" ") : styles.button;
  return (
    <button className={_className} type="button" onClick={onClick} title={tooltip}>
      {children}
    </button>
  );
}

export type LayerSelectorProps = {
  visibility: Record<string, boolean>;
  onChange: (visibility: Record<string, boolean>) => void;
};

export function LayerSelector({ visibility, onChange }: LayerSelectorProps) {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <Fragment>
      <ControlButton
        className={isOpen ? styles.open : null}
        tooltip="Layer selector"
        onClick={() => setIsOpen((isOpen) => !isOpen)}
      >
        <Layers className={styles.icon} />
      </ControlButton>

      {isOpen && (
        <div className={styles.selectorPanel}>
          {Object.entries(visibility).map(([name, visible]) => (
            <VisibilityToggle key={name} {...{ name, visible, onChange }} />
          ))}
        </div>
      )}
    </Fragment>
  );
}

type VisibilityToggleProps = {
  name: string;
  visible: boolean;
  onChange: (visible: Record<string, boolean>) => void;
};

function VisibilityToggle({ name, visible, onChange }: VisibilityToggleProps) {
  const Icon = visible ? Visibility : VisibilityOff;
  const className = visible
    ? styles.visibilityToggle
    : [styles.visibilityToggle, styles.notVisible].join(" ");

  return (
    <label className={className} title={name}>
      <input
        type="checkbox"
        style={{ display: "none" }}
        checked={visible}
        onChange={() => onChange({ [name]: !visible })}
      />
      <Icon className={styles.icon} />
      <div className={styles.label}>{name}</div>
    </label>
  );
}
