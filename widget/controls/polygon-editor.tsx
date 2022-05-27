import type { CSSProperties, MouseEventHandler } from "react";
import type { FeatureCollection } from "geojson";
import Lasso from "@mdi/svg/svg/lasso.svg";
import VectorSquare from "@mdi/svg/svg/vector-square.svg";
import VectorSquareEdit from "@mdi/svg/svg/vector-square-edit.svg";
import { SvgIcon } from "@mui/material";
import { Delete, PanTool } from "@mui/icons-material";

import styles from "./polygon-editor.css";
import type { PolygonEditorMode } from "../types";
import { classNames } from "../util";

const noop = () => {};

export type PolygonEditorProps = {
  mode?: PolygonEditorMode;
  polygon?: FeatureCollection;
  onSetMode?: (mode: PolygonEditorMode) => void;
  onPolygonChange?: (polygon: FeatureCollection) => void;
};

export function PolygonEditor({
  mode = "view",
  polygon = { type: "FeatureCollection", features: [] },
  onSetMode = noop,
  onPolygonChange = noop,
}: PolygonEditorProps) {
  const handleDelete = () => onPolygonChange({ type: "FeatureCollection", features: [] });

  return (
    <div className={styles.container}>
      <EditorButton
        name="Pan"
        icon={PanTool}
        active={mode === "view"}
        onClick={() => onSetMode("view")}
      />
      <EditorButton
        name="Modify"
        icon={VectorSquareEdit}
        active={mode === "modify"}
        disabled={!hasFeatures(polygon)}
        onClick={() => onSetMode("modify")}
      />
      <EditorButton
        name="Polygon"
        icon={VectorSquare}
        active={mode === "polygon"}
        onClick={() => onSetMode("polygon")}
      />
      <EditorButton
        name="Lasso"
        icon={Lasso}
        active={mode === "lasso"}
        onClick={() => onSetMode("lasso")}
      />
      <EditorButton
        name="Delete"
        icon={Delete}
        disabled={!hasFeatures(polygon)}
        onClick={handleDelete}
      />
    </div>
  );
}

type ButtonProps = {
  name?: string;
  onClick?: MouseEventHandler;
  disabled?: boolean;
  active?: boolean;
  icon?: any;
  iconStyle?: CSSProperties;
};

function EditorButton({
  name,
  onClick = noop,
  disabled = false,
  active = false,
  icon,
  iconStyle,
}: ButtonProps) {
  const buttonClass = classNames(styles.button, active ? styles.active : null);
  return (
    <button className={buttonClass} onClick={onClick} title={name} disabled={disabled}>
      {icon && (
        <SvgIcon component={icon} className={styles.icon} fontSize="small" style={iconStyle} />
      )}
    </button>
  );
}

function hasFeatures(featureCollection?: FeatureCollection) {
  return featureCollection?.features?.length !== 0;
}
