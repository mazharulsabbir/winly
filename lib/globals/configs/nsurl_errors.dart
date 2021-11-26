String? getNSURLErrorMessage(int errorCode) {
  switch (errorCode) {
    case -1:
      return "Unknown Error";
    case -2:
      return "Server not rechable";
    case -999:
      return "Cancelled";
    case -1000:
      return "Bad Url";
    case -1001:
      return "Timeout";
    case -1002:
      return "Unsupported Url";
    case -1003:
      return "Cannot Find Host";
    case -1004:
      return "Cannot Connect to Host";
    case -1005:
      return "Connection Lost";
    case -1006:
      return "Lookup Failed!";
    case -1007:
      return "Too many redirects";
    case -1008:
      return "Resource Unavailable";
    case -1009:
      return "Not connected to internet";
    case -1010:
      return "Redirect to non existent location";
    case -1011:
      return "Bad server response";
    case -1012:
      return "User cancelled authentication";
    case -1013:
      return "User authentication required";
    case -1014:
      return "Zero byte resource";
    case -1015:
      return "Cannot decode raw data";
    case -1016:
      return "Cannot decode content data";
    case -1017:
      return "Cannot parse response";
    case -1100:
      return "File does not exist";
    case -1101:
      return "File is directory";
    case -1102:
      return "No permission to read file";

    // ssl errors
    case -1200:
      return "Secure connection failed";
    case -1201:
      return "Server certificate has bad date";
    case -1202:
      return "Server certificate untrusted";
    case -1203:
      return "Server certificate has unknown root";
    case -1204:
      return "Server certificate not yet valid";
    case -1205:
      return "Client certificate rejected";
    case -1206:
      return "Client certificate required";
    case -2000:
      return "Cannot load from network";

    // download and file I/O errors
    case -3000:
      return "Cannot create file";
    case -3001:
      return "Cannot open file";
    case -3002:
      return "Cannot close file";
    case -3003:
      return "Cannot write to file";
    case -3004:
      return "Cannot remove file";
    case -3005:
      return "Cannot move file";
    case -3006:
      return "Download decoding failed mid stream";
    case -3007:
      return "Download decoding failed to complete";
  }
  return null;
}
