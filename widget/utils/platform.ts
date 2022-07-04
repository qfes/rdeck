export const isMacOS = /(mac ?os)|(macintosh)/i.test(
  // eslint-disable-next-line compat/compat
  navigator.userAgentData?.platform ?? navigator.userAgent
);
