import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:star_wars/screens/main/main/favorites_screen.dart';
import 'package:star_wars/screens/main/main/home_screen.dart';
import 'package:star_wars/screens/main/main/reports_screen.dart';
import 'package:star_wars/widgets/button.dart';
import 'package:star_wars/widgets/internet_checker.dart';
import 'package:star_wars/widgets/tab_item.dart';
import 'package:star_wars/config/router.dart' as AppRouter;
import 'package:star_wars/constants/colors.dart' as AppColors;
import 'package:styled_text/styled_text.dart';
import 'package:star_wars/constants/routes.dart';

class MainScreen extends HookWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<TabItem> _tabs = [
    TabItem(
        tab: const Tab(
          child: Icon(Icons.home_rounded),
        ),
        screen: const HomeScreen()),
    TabItem(
        title: tr("reports"),
        tab: const Tab(
          child: Icon(Icons.report_problem_rounded),
        ),
        screen: const ReportsScreen()),
    TabItem(
        title: tr("favorites"),
        tab: const Tab(
          child: Icon(Icons.favorite_rounded),
        ),
        screen: const FavoritesScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    final tinkerMixin = useSingleTickerProvider();
    final tabController = useMemoized(
        () => TabController(vsync: tinkerMixin, length: _tabs.length));

    final tabIndex = useState(0);

    Future<bool> _onWillPop() async {
      AppRouter.Router.popRoute(context);
      return false;
    }

    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });

    return SafeArea(
        child: WillPopScope(
            onWillPop: _onWillPop,
            child: InternetChecker(
              child: Scaffold(
                backgroundColor: AppColors.Colors.black,
                resizeToAvoidBottomInset: true,
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 20, right: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _tabs[tabIndex.value].title.isNotEmpty
                              ? Text(
                                  _tabs[tabController.index].title,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StyledText(
                                      text: "${tr("hello")},",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                    StyledText(
                                      text: tr(
                                        "welcome_back",
                                      ),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomButton(
                                  onTap: () {
                                    AppRouter.Router.fluroRouter.navigateTo(
                                        context, Routes.settings.toString(),
                                        transition: TransitionType.fadeIn);
                                  },
                                  padding: const EdgeInsets.all(0),
                                  borderRadius: BorderRadius.circular(100),
                                  child: const Icon(
                                    Icons.settings_rounded,
                                    color: AppColors.Colors.blue,
                                    size: 25,
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children:
                            _tabs.map<Widget>((tab) => tab.screen).toList(),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: ColoredBox(
                  color: Colors.black,
                  child: Theme(
                    data: ThemeData(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    child: TabBar(
                      controller: tabController,
                      indicatorColor: Colors.transparent,
                      labelColor: AppColors.Colors.blue,
                      unselectedLabelColor: Colors.grey,
                      tabs: _tabs.map<Tab>((tab) => tab.tab).toList(),
                    ),
                  ),
                ),
              ),
            )));
  }
}
