import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:provider/provider.dart';
import 'package:treex_app/UI/widget/CardBar.dart';
import 'package:treex_app/UI/widget/LargeIconBackground.dart';
import 'package:treex_app/UI/widget/ListTitle.dart';
import 'package:treex_app/Utils/SharedPreferenceUtils.dart';
import 'package:treex_app/Utils/brightnessUtil.dart';
import 'package:treex_app/provider/AppProvider.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        physics: MIUIScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            stretch: true,
            floating: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('高级设置'),
              background: LargeIconBackgroundWidget(
                tag: 'settings',
                icon: Icons.settings,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTitleWidget(title: '界面显示'),
              SwitchListTile(
                contentPadding: edgeInsetsGeometryCurved(context),
                title: Text('自动切换夜间模式'),
                subtitle: Text('根据系统设置切换夜间模式'),
                value: getDarkMode(context) == ThemeMode.system,
                onChanged: (value) {
                  if (value) {
                    setDarkMode(context, ThemeMode.system);
                    Shared(context).writeThemeMode(ThemeMode.system);
                  } else {
                    setDarkMode(context, ThemeMode.light);
                    Shared(context).writeThemeMode(ThemeMode.light);
                  }
                },
              ),
              SwitchListTile(
                contentPadding: edgeInsetsGeometryCurved(context),
                title: Text('夜间模式'),
                subtitle: Text('手动切换夜间模式'),
                value: getDarkMode(context) == ThemeMode.dark,
                onChanged: getDarkMode(context) == ThemeMode.system
                    ? null
                    : (value) {
                        if (value) {
                          setDarkMode(context, ThemeMode.dark);
                          Shared(context).writeThemeMode(ThemeMode.dark);
                        } else {
                          setDarkMode(context, ThemeMode.light);
                          Shared(context).writeThemeMode(ThemeMode.light);
                        }
                      },
              ),
              SwitchListTile(
                contentPadding: edgeInsetsGeometryCurved(context),
                title: Text('曲面屏优化'),
                subtitle: Text('针对曲面屏优化界面布局'),
                value: provider.haveCurved,
                onChanged: (value) {
                  provider.setCurved(value);
                  Shared(context).writeCurvedMode(value);
                },
              ),
              SwitchListTile(
                contentPadding: edgeInsetsGeometryCurved(context),
                title: Text('沉浸式状态栏'),
                value: provider.immersiveStatusBar,
                onChanged: (status) {
                  provider.changeImmersiveStatusBar(status);
                  Shared(context).writeTransparent(status);
                },
              ),
              SwitchListTile(
                contentPadding: edgeInsetsGeometryCurved(context),
                title: Text('开启导航栏背景色'),
                onChanged: (value) {
                  provider.changeBottomBarColored(value);
                  Shared(context).writeColoredNavi(value);
                },
                value: provider.bottomBarColored,
              ),
              ListTile(
                contentPadding: edgeInsetsGeometryCurved(context),
                title: Text('主题色'),
                onTap: () {
                  showMIUIDialog(
                      context: context,
                      dyOffset: 0.5,
                      content: Container(
                        height: 200,
                        child: MaterialColorPicker(
                          physics: MIUIScrollPhysics(),
                          onColorChange: (color) {
                            provider.setPrimaryColor(color);
                            Shared(context).writePrimaryColor(color);
                          },
                          selectedColor: provider.primaryColor,
                        ),
                      ),
                      label: 'menu');
                },
                trailing: CircleAvatar(
                  backgroundColor: provider.primaryColor,
                ),
              ),
              ListTile(
                contentPadding: edgeInsetsGeometryCurved(context),
                title: Text('强调色'),
                onTap: () {
                  showMIUIDialog(
                      context: context,
                      dyOffset: 0.5,
                      content: Container(
                        height: 200,
                        child: MaterialColorPicker(
                          physics: MIUIScrollPhysics(),
                          onColorChange: (color) {
                            provider.setSecondaryColor(color);
                            Shared(context).writeSecondaryColor(color);
                          },
                          selectedColor: provider.secondaryColor,
                        ),
                      ),
                      label: 'menu');
                },
                trailing: CircleAvatar(
                  backgroundColor: provider.secondaryColor,
                ),
              ),
              ListTitleWidget(title: '手势'),
              SwitchListTile(
                contentPadding: edgeInsetsGeometryCurved(context),
                title: Text('滑动返回'),
                value: provider.iOSPlatform,
                onChanged: (platform) {
                  provider.changeIOSPlatform(platform);
                  Shared(context).writeSlideBackMode(platform);
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
