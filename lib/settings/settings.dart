import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vu/common/routes/names.dart';
import 'package:vu/common/values/constant.dart';
import 'package:vu/global.dart';
import 'package:vu/home/bloc/home_bloc.dart';
import 'package:vu/home/bloc/home_events.dart';
import 'package:vu/settings/widgets/settings_widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SettingsAppBar(),
      body: SettingsButton(
          context: context,
          onPress: () async {
            await Global.storageService
                .remove(key: AppConstants.STORAGE_USER_ACCESS_TOKEN);
            await Global.storageService.remove(key: AppConstants.USERS_UID);
            await Global.storageService.remove(key: AppConstants.USERS_AVATAR);
            await Global.storageService.remove(key: AppConstants.USERS_EMAIL);
            await Global.storageService.remove(key: AppConstants.USERS_NAME);
            await Navigator.of(context)
                .pushNamedAndRemoveUntil(AppRoutes.SIGN_IN, (route) => false);
            context.read<HomePageBloc>().add(const SliderIndexEvent(index: 0));
          }),
    );
  }
}
