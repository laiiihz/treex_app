import 'package:bot_toast/bot_toast.dart';
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
import 'package:vibration/vibration.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<SettingsPage> {
  Shared _shared;
  @override
  void initState() {
    super.initState();
    _initShared() async {
      _shared = await Shared.init(context);
    }

    _initShared();
  }

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
                    _shared.writeThemeMode(ThemeMode.system);
                  } else {
                    setDarkMode(context, ThemeMode.light);
                    _shared.writeThemeMode(ThemeMode.light);
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
                          _shared.writeThemeMode(ThemeMode.dark);
                        } else {
                          setDarkMode(context, ThemeMode.light);
                          _shared.writeThemeMode(ThemeMode.light);
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
                  _shared.writeCurvedMode(value);
                },
              ),
              SwitchListTile(
                contentPadding: edgeInsetsGeometryCurved(context),
                title: Text('沉浸式状态栏'),
                value: provider.immersiveStatusBar,
                onChanged: (status) {
                  provider.changeImmersiveStatusBar(status);
                  _shared.writeTransparent(status);
                },
              ),
              SwitchListTile(
                contentPadding: edgeInsetsGeometryCurved(context),
                title: Text('开启导航栏背景色'),
                onChanged: (value) {
                  provider.changeBottomBarColored(value);
                  _shared.writeColoredNavi(value);
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
                            _shared.writePrimaryColor(color);
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
                            _shared.writeSecondaryColor(color);
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
                  _shared.writeSlideBackMode(platform);
                },
              ),
              ListTitleWidget(title: '体感'),
              SwitchListTile(
                contentPadding: edgeInsetsGeometryCurved(context),
                title: Text('Motion Sense™'),
                subtitle: Text('动态调节震动水平'),
                value: provider.vibrationIsOpen,
                onChanged: (value) {
                  if (value) {
                    Vibration.vibrate(
                        pattern: [0, 20, 100, 20, 300, 10, 100, 20]);
                  }
                  provider.setVibrationState(value);
                  _shared.writeVibrationState(value);
                },
              ),
              ListTitleWidget(title: '其他'),
              SwitchListTile(
                contentPadding: edgeInsetsGeometryCurved(context),
                value: provider.fastInit,
                title: Text('Quick Startup™'),
                subtitle: Text('快速启动'),
                onChanged: (state) {
                  provider.setFastInit(state);
                  _shared.writeFastInit(state);
                },
              ),
              ListTile(
                onTap: () {
                  BotToast.showText(text: 'IN DEVELOPMENT');
                },
                contentPadding: edgeInsetsGeometryCurved(context),
                title: Text('导出设置'),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
