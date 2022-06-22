export function download(blob: Blob, filename: string) {
  const element = document.createElement("a");
  const blobUrl = URL.createObjectURL(blob);
  element.href = blobUrl;
  element.download = filename;
  element.click();

  URL.revokeObjectURL(blobUrl);
}
