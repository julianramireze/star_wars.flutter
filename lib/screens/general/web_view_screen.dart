import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:star_wars/constants/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:star_wars/config/router.dart' as AppRouter;
import 'package:star_wars/constants/colors.dart' as AppColors;
import 'package:lottie/lottie.dart';

class WebViewScreen extends HookWidget {
  final String? url;
  final String? title;

  const WebViewScreen({Key? key, required this.url, this.title = "Web"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      AppRouter.Router.popRoute(context);
      return false;
    }

    final progress = useState(0);
    final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
      Factory(() => EagerGestureRecognizer())
    };

    return SafeArea(
        child: WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          resizeToAvoidBottomInset: true,
          body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 10, top: 20, bottom: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    splashRadius: 1,
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      size: 22,
                                    ),
                                    onPressed: () {
                                      AppRouter.Router.popRoute(context);
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(title ?? "",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Container(
                                    width: 45,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Stack(
                          children: [
                            if (progress.value != 100)
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Center(
                                    child: Lottie.asset(
                                  loadingAnimation,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                )),
                              ),
                            Visibility(
                              visible: progress.value == 100,
                              maintainState: true,
                              maintainSize: true,
                              maintainAnimation: true,
                              child: InAppWebView(
                                initialUrlRequest:
                                    URLRequest(url: Uri.parse((url ?? ""))),
                                initialOptions: InAppWebViewGroupOptions(
                                    crossPlatform: InAppWebViewOptions(
                                        cacheEnabled: true,
                                        disableHorizontalScroll: true,
                                        transparentBackground: true,
                                        supportZoom: false)),
                                onProgressChanged:
                                    (controller, progressInternal) {
                                  progress.value = progressInternal;
                                },
                              ),
                            ),
                          ],
                        )),
                      ],
                    ))
              ])),
    ));
  }
}
