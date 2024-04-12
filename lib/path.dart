class Path {
  String path;
  String name;

  Path({required this.path, required this.name});
}

class NavPath {
  static final Path home = Path(path: '/home', name: '/home');
  static final Path webview = Path(path: 'webview', name: 'webview');
}
