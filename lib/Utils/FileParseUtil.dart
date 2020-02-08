import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';

class FileParseUtil {
  static String parseDate(int time) {
    DateTime nowDate = DateTime.now();
    DateTime fileDate = DateTime.fromMillisecondsSinceEpoch(time);
    int timeInterval = nowDate.millisecondsSinceEpoch - time;
    if (timeInterval < TimeMillisecond.hour) {
      return '${(timeInterval / 1000 / 60).floor()}分钟前';
    } else if (timeInterval < TimeMillisecond.day) {
      if (nowDate.day != fileDate.day) {
        return '昨天';
      } else {
        return '${DateTime.fromMillisecondsSinceEpoch(timeInterval).hour}小时前';
      }
    } else if (timeInterval < TimeMillisecond.day * 15) {
      return '${DateTime.fromMillisecondsSinceEpoch(timeInterval).day}天前';
    } else
      return DateFormat('yy年MM月dd日')
          .format(DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String parseLength(int length) {
    if (length < 1024) {
      return '${length}B';
    } else if ((length / 1024) < 1024) {
      return '${(length / 1024).toStringAsFixed(2)}K';
    } else {
      return '${(length / 1024 / 1024).toStringAsFixed(2)}M';
    }
  }

  static Icon parseIcon({
    String name,
    bool isDir,
  }) {
    String suffix = FileNameClass.fromName(name).suffix;
    if (isDir) {
      return Icon(MaterialCommunityIcons.folder,
          color: Colors.yellow, size: 30);
    } else {
      switch (suffix) {
        case 'MD':
        case 'md':
          return Icon(MaterialCommunityIcons.markdown, color: Colors.blue);
        case 'jpg':
        case 'png':
        case 'webp':
        case 'bmp':
          return Icon(MaterialCommunityIcons.image, color: Colors.green);
        case 'txt':
          return Icon(MaterialCommunityIcons.text, color: Colors.grey);
        case 'pdf':
          return Icon(MaterialCommunityIcons.file_pdf, color: Colors.lightBlue);
        case 'aac':
        case 'mp3':
          return Icon(MaterialCommunityIcons.music, color: Colors.lightGreen);
        case 'mp4':
        case 'mkv':
        case 'mov':
          return Icon(MaterialCommunityIcons.video, color: Colors.blueAccent);
        case 'apk':
        case 'xapk':
          return Icon(MaterialCommunityIcons.android, color: Color(0xff3DDC84));
        case 'exe':
          return Icon(MaterialCommunityIcons.windows, color: Colors.grey);
        case 'docx':
        case 'doc':
        case 'rtf':
          return Icon(MaterialCommunityIcons.file_word, color: Colors.blue);
        case 'pptx':
        case 'ppt':
          return Icon(MaterialCommunityIcons.file_powerpoint,
              color: Colors.red);
        case 'pub':
          return Icon(MaterialCommunityIcons.file_powerpoint,
              color: Colors.green);
        case 'sql':
        case 'accdb':
        case 'db':
          return Icon(MaterialCommunityIcons.database, color: Colors.red);
        case 'lnk':
          return Icon(MaterialCommunityIcons.launch, color: Colors.grey);
        case 'pdf':
          return Icon(MaterialCommunityIcons.file_pdf, color: Colors.grey);
        case 'cad':
          return Icon(MaterialCommunityIcons.file_cad, color: Colors.grey);
        default:
          return Icon(MaterialCommunityIcons.file, color: Colors.blueGrey);
      }
    }
  }
}

class TimeMillisecond {
  static int minute = 1000 * 60;
  static int hour = 1000 * 60 * 60;
  static int day = 1000 * 60 * 60 * 24;
}

class FileNameClass {
  String prefix;
  String suffix;
  FileNameClass.fromName(String name) {
    int lastIndex = name.lastIndexOf('.');
    if (lastIndex == -1) {
      prefix = name;
      suffix = '';
    } else {
      prefix = name.substring(0, lastIndex);
      suffix = name.substring(lastIndex + 1);
    }
  }
}
