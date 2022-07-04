interface Navigator {
  readonly userAgentData?: NavigatorUAData;
}

interface NavigatorUAData {
  readonly brands: UserAgentBrand[];
  readonly mobile: boolean;
  readonly platform: string;
}

interface UserAgentBrand {
  brand: string;
  version: string;
}
