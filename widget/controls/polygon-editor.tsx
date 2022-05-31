import type { CSSProperties, MouseEventHandler } from "react";
import type { FeatureCollection } from "geojson";
import type { EditAction } from "@nebula.gl/edit-modes";

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
  mode: PolygonEditorMode;
  polygon: FeatureCollection;
  onModeChange?: (mode: PolygonEditorMode) => void;
  onPolygonChange?: (action: EditAction<FeatureCollection>) => void;
};

export function PolygonEditor({
  mode = "view",
  polygon = { type: "FeatureCollection", features: [] },
  onModeChange = noop,
  onPolygonChange = noop,
}: PolygonEditorProps) {
  const handleDelete = () => {
    onPolygonChange({
      updatedData: { type: "FeatureCollection", features: [] } as FeatureCollection,
      editType: "deleteFeature",
      editContext: {
        featureIndexes: polygon.features.map((_, i) => i),
      },
    });
  };

  return (
    <div className={styles.container}>
      <EditorButton
        name="Pan"
        icon={PanTool}
        active={mode === "view"}
        onClick={() => onModeChange("view")}
      />
      <EditorButton
        name="Modify"
        icon={VectorSquareEdit}
        active={mode === "modify"}
        disabled={!hasFeatures(polygon)}
        onClick={() => onModeChange("modify")}
      />
      <EditorButton
        name="Polygon"
        icon={VectorSquare}
        active={mode === "polygon"}
        onClick={() => onModeChange("polygon")}
      />
      <EditorButton
        name="Lasso"
        icon={Lasso}
        active={mode === "lasso"}
        onClick={() => onModeChange("lasso")}
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
