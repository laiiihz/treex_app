import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
        return '${nowDate.hour - fileDate.hour}小时前';
      }
    } else if (timeInterval < TimeMillisecond.day * 15) {
      return '${nowDate.day - fileDate.day}天前';
    } else
      return DateTime.fromMillisecondsSinceEpoch(time).toIso8601String();
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

  static IconData parseIcon({
    String name,
    bool isDir,
  }) {
    if (isDir) {
      return AntDesign.folder1;
    } else {
      switch (FileNameClass.fromName(name).suffix) {
        case 'zip':
          return FontAwesome5.file_archive;
          break;
        case 'MD':
        case 'md':
          return AntDesign.file_markdown;
          break;
        default:
          return AntDesign.unknowfile1;
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
