///here is a sample of netFileEntity
///
///"date": 1580729158231,
///
///"path": "./Markdown.md",
///
///"name": "Markdown.md",
///
///"length": 0,
///
///"isDir": false
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



class RecycleFileEntity{
  String path;
  String name;
  RecycleFileEntity.fromDynamic(dynamic file){
    this.path = file['path'];
    this.name = file['name'];
  }
}
