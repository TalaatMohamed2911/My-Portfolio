import 'dart:js_interop';
import 'dart:js_interop_unsafe';

@JS('document')
external JSObject get _document;

extension type _Document(JSObject _) implements JSObject {
  external JSObject createElement(String localName);
  external JSObject? get body;
}

extension type _Anchor(JSObject _) implements JSObject {
  external set href(String value);
  external set download(String value);
  external void click();
  external void remove();
}

extension type _Element(JSObject _) implements JSObject {
  external JSObject appendChild(JSObject child);
}

void openExternalUrl(String url) {
  globalContext.callMethod('open'.toJS, [url.toJS, '_blank'.toJS].toJS);
}

void downloadExternalFile(String url, String filename) {
  final document = _Document(_document);
  final anchor = _Anchor(document.createElement('a'));
  anchor
    ..href = url
    ..download = filename;
  _Element(document.body!).appendChild(anchor);
  anchor
    ..click()
    ..remove();
}
