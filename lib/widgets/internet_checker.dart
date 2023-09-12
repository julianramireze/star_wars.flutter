// ignore_for_file: prefer_const_constructors

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:star_wars/stores/settings.dart';

class InternetChecker extends HookWidget {
  final Widget child;

  const InternetChecker({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final settingsStore = Provider.of<SettingsStore>(context);
    final connectivityStatus = useState<String>('Unknown');

    useEffect(() {
      final subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        var connection = result.name.split('.').last;
        connectivityStatus.value = connection;
      });
      () async {
        connectivityStatus.value =
            (await Connectivity().checkConnectivity()).name.split('.').last;
      }();

      return () {
        subscription.cancel();
      };
    }, []);

    return Column(children: [
      Expanded(child: child),
      if (connectivityStatus.value == "none")
        Container(
          color: settingsStore.darkMode ? Colors.green : Colors.green[700]!,
          padding: EdgeInsets.only(top: 3, bottom: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                  color: Colors.transparent,
                  child: Text(
                      tr(connectivityStatus.value != "none"
                          ? "again_with_internet"
                          : "mode_offline"),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 11)))
            ],
          ),
        )
    ]);
  }
}
