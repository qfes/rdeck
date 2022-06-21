import type { CSSProperties, MouseEventHandler } from "react";
import type { FeatureCollection } from "geojson";

import Lasso from "@mdi/svg/svg/lasso.svg";
import VectorSquare from "@mdi/svg/svg/vector-square.svg";
import VectorSquareEdit from "@mdi/svg/svg/vector-square-edit.svg";
import VectorPolyLine from "@mdi/svg/svg/vector-polyline.svg";
import Undo from "@mdi/svg/svg/arrow-u-left-top.svg";
import Redo from "@mdi/svg/svg/arrow-u-right-top.svg";
import { SvgIcon } from "@mui/material";
import {
  PanTool,
  TouchApp,
  Transform,
  LocationOnOutlined,
  Download,
  Upload,
  Delete,
} from "@mui/icons-material";

import styles from "./editor-toolbox.css";
import type { EditorMode } from "../types";
import { classNames } from "../util";

const noop = () => {};

export type EditorToolboxProps = {
  mode: EditorMode;
  geojson: FeatureCollection;
  selectedFeatureIndices: number[];
  onSetMode?: (mode: EditorMode) => void;
  onDownload?: (geojson: FeatureCollection) => void;
  onUpload?: (geojson: FeatureCollection) => void;
  onDeleteSelected?: (indices: number[]) => void;
  // undo/redo
  canUndo: boolean;
  canRedo: boolean;
  onUndo?: () => void;
  onRedo?: () => void;
};

export function EditorToolbox({
  mode,
  geojson,
  selectedFeatureIndices,
  onSetMode = noop,
  onDownload = noop,
  onUpload = noop,
  onDeleteSelected = noop,
  canUndo,
  canRedo,
  onUndo = noop,
  onRedo = noop,
}: EditorToolboxProps) {
  const anySelected = selectedFeatureIndices?.length > 0;
  const anyFeatures = geojson?.features.length > 0;

  return (
    <div className={styles.container}>
      <div className={styles.group}>
        <EditorButton
          name="View"
          icon={PanTool}
          iconStyle={{ transform: "scale(0.9)" }}
          active={mode === "view"}
          onClick={() => onSetMode("view")}
        />
        <EditorButton
          name="Select"
          icon={TouchApp}
          active={mode === "select"}
          disabled={!anyFeatures}
          onClick={() => onSetMode("select")}
        />
      </div>
      <div className={styles.group}>
        <EditorButton
          name="Modify"
          icon={VectorSquareEdit}
          active={mode === "modify"}
          disabled={!anySelected}
          onClick={() => onSetMode("modify")}
        />
        <EditorButton
          name="Transform"
          icon={Transform}
          active={mode === "transform"}
          disabled={!anySelected}
          onClick={() => onSetMode("transform")}
        />
        <EditorButton
          name="Point"
          icon={LocationOnOutlined}
          active={mode === "point"}
          onClick={() => onSetMode("point")}
        />
        <EditorButton
          name="LineString"
          icon={VectorPolyLine}
          active={mode === "linestring"}
          onClick={() => onSetMode("linestring")}
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
      </div>
      <div className={styles.group}>
        <EditorButton
          name="Download"
          icon={Download}
          disabled={!anyFeatures}
          onClick={() => onDownload(geojson)}
        />
        <EditorButton
          name="Upload"
          icon={Upload}
          disabled={!anyFeatures}
          onClick={() => onUpload(geojson)}
        />
      </div>
      <div className={styles.group}>
        <EditorButton name="Undo" icon={Undo} disabled={!canUndo} onClick={onUndo} />
        <EditorButton name="Redo" icon={Redo} disabled={!canRedo} onClick={onRedo} />
      </div>
      <div className={styles.group}>
        <EditorButton
          name="Delete"
          icon={Delete}
          disabled={!anySelected}
          onClick={() => onDeleteSelected(selectedFeatureIndices)}
        />
      </div>
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
