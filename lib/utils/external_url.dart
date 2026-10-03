import 'external_url_stub.dart'
    if (dart.library.js_interop) 'external_url_web.dart'
    as platform;

void openExternalUrl(String url) => platform.openExternalUrl(url);

void downloadExternalFile(String url, String filename) =>
    platform.downloadExternalFile(url, filename);
