import type { CSSProperties, MouseEventHandler } from "react";
import type { FeatureCollection } from "geojson";

import Lasso from "@mdi/svg/svg/lasso.svg";
import VectorSquare from "@mdi/svg/svg/vector-square.svg";
import VectorSquareEdit from "@mdi/svg/svg/vector-square-edit.svg";
import VectorPolyLine from "@mdi/svg/svg/vector-polyline.svg";
import { SvgIcon } from "@mui/material";
import {
  Delete,
  PanTool,
  TouchApp,
  LocationOnOutlined,
  Download,
  Upload,
} from "@mui/icons-material";

import styles from "./editor-panel.css";
import type { EditorMode } from "../types";
import { classNames } from "../util";

const noop = () => {};

export type EditorPanelProps = {
  mode: EditorMode;
  geojson: FeatureCollection;
  selectedFeatureIndices: number[];
  setMode?: (mode: EditorMode) => void;
  download?: (geojson: FeatureCollection) => void;
  upload?: (geojson: FeatureCollection) => void;
  deleteSelected?: (indices: number[]) => void;
};

export function EditorPanel({
  mode = "view",
  geojson,
  selectedFeatureIndices,
  setMode = noop,
  download = noop,
  upload = noop,
  deleteSelected = noop,
}: EditorPanelProps) {
  const anySelected = selectedFeatureIndices?.length !== 0;

  return (
    <div className={styles.container}>
      <div className={styles.group}>
        <EditorButton
          name="Pan"
          icon={PanTool}
          iconStyle={{ transform: "scale(0.9)" }}
          active={mode === "view"}
          onClick={() => setMode("view")}
        />
        <EditorButton
          name="Select"
          icon={TouchApp}
          active={mode === "select"}
          onClick={() => setMode("select")}
        />
      </div>
      <div className={styles.group}>
        <EditorButton
          name="Modify"
          icon={VectorSquareEdit}
          active={mode === "modify"}
          disabled={!anySelected}
          onClick={() => setMode("modify")}
        />
        <EditorButton
          name="Point"
          icon={LocationOnOutlined}
          active={mode === "point"}
          onClick={() => setMode("point")}
        />
        <EditorButton
          name="LineString"
          icon={VectorPolyLine}
          active={mode === "linestring"}
          onClick={() => setMode("linestring")}
        />
        <EditorButton
          name="Polygon"
          icon={VectorSquare}
          active={mode === "polygon"}
          onClick={() => setMode("polygon")}
        />
        <EditorButton
          name="Lasso"
          icon={Lasso}
          active={mode === "lasso"}
          onClick={() => setMode("lasso")}
        />
      </div>
      <div className={styles.group}>
        <EditorButton name="Download" icon={Download} onClick={() => download(geojson)} />
        <EditorButton name="Upload" icon={Upload} onClick={() => upload(geojson)} />
      </div>
      <div className={styles.group}>
        <EditorButton
          name="Delete"
          icon={Delete}
          disabled={!anySelected}
          onClick={() => deleteSelected(selectedFeatureIndices)}
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
