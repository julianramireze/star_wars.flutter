import 'package:easy_localization/easy_localization.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:star_wars/screens/main/main/favorites_screen.dart';
import 'package:star_wars/screens/main/main/home_screen.dart';
import 'package:star_wars/screens/main/main/reports_screen.dart';
import 'package:star_wars/widgets/custom_boxhsadow.dart';
import 'package:star_wars/widgets/custom_button.dart';
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
            child: Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
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
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StyledText(
                                      text: "${tr("hello")},",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface),
                                    ),
                                    StyledText(
                                      text: tr(
                                        "welcome_back",
                                      ),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface),
                                    ),
                                  ],
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomBoxShadow(
                                padding: const EdgeInsets.all(4),
                                radius: 50,
                                colorBackground: Colors.white.withOpacity(0.2),
                                colorShadow: Colors.transparent,
                                child: CustomButton(
                                    onTap: () {
                                      AppRouter.Router.fluroRouter.navigateTo(
                                          context, Routes.settings.toString(),
                                          transition: TransitionType.fadeIn);
                                    },
                                    borderRadius: BorderRadius.circular(100),
                                    padding: const EdgeInsets.all(0),
                                    child: const Icon(
                                      Icons.settings_rounded,
                                      color: AppColors.Colors.blue,
                                      size: 25,
                                    )),
                              ),
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
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).colorScheme.onBackground,
                          blurRadius: 0.1),
                    ],
                  ),
                  child: ColoredBox(
                    color: Theme.of(context).colorScheme.background,
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
                ))));
  }
}
