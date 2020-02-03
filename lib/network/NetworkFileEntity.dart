class NetFileEntity {
  int date;
  String path;
  String name;
  int length;
  bool isDir;
  NetFileEntity.fromDynamic(dynamic file) {
    this.date = file['date'];
    this.path = file['path'];
    this.name = file['name'];
    this.length = file['length'];
    this.isDir = file['isDir'];
  }
}

//"date": 1580729158231,
//"path": "./新建 Markdown.md",
//"name": "新建 Markdown.md",
//"length": 0,
//"isDir": false
