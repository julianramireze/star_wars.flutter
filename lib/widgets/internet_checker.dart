// ignore_for_file: prefer_const_constructors

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InternetChecker extends HookWidget {
  final Widget child;

  const InternetChecker({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
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
          color: Colors.black,
          padding: EdgeInsets.only(top: 3, bottom: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  tr(connectivityStatus.value != "none"
                      ? "again_with_internet"
                      : "without_internet"),
                  style: TextStyle(
                      color: connectivityStatus.value != "none"
                          ? Colors.green
                          : Colors.redAccent,
                      fontSize: 11))
            ],
          ),
        )
    ]);
  }
}
