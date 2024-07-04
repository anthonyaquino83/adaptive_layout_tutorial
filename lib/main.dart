import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

//? p1 - converter para StatefulWidget
//? p2 - importar o widget AdaptiveLayout
//? p3 - criar destinations (rotas)
//? SlotLayout (Map<Breakpoint, SlotLayoutConfig?>, SlotLayout.from, builder)
//? p4 - criar primaryNavigation (Breakpoint.medium)
//? p5 - criar bottomNavigation (Breakpoint.small)
//? p6 - gerenciar o estado da rota
//? p7 - criar HomeSmallBody e extrair
//? p8 - criar 5 bodies restantes
//? p9 - criar switch expression para apresentar o body de acordo com a rota
//? p10 - criar slots para os breakpoints restantes no body
//? p11 - criar slot para o breakpoint large no primaryNavigation
//? p12 - criar secondary body para o breakpoint medium e large (HomeSecondaryBody)
//? p12 - mostrar inAnimation, outAnimation e duration

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<NavigationDestination> destinations = const [
    NavigationDestination(
      icon: Icon(
        Icons.home_outlined,
      ),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(
        Icons.settings_outlined,
      ),
      label: 'Settings',
    )
  ];

  int selectedNavigation = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdaptiveLayout(
        primaryNavigation: SlotLayout(
          config: {
            Breakpoints.medium: SlotLayout.from(
              key: UniqueKey(),
              builder: (context) {
                return AdaptiveScaffold.standardNavigationRail(
                  // extended: true,
                  destinations: destinations
                      .map((e) => AdaptiveScaffold.toRailDestination(e))
                      .toList(),
                  selectedIndex: selectedNavigation,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedNavigation = value;
                    });
                  },
                );
              },
            ),
            Breakpoints.large: SlotLayout.from(
              key: UniqueKey(),
              builder: (context) {
                return AdaptiveScaffold.standardNavigationRail(
                  extended: true,
                  destinations: destinations
                      .map((e) => AdaptiveScaffold.toRailDestination(e))
                      .toList(),
                  selectedIndex: selectedNavigation,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedNavigation = value;
                    });
                  },
                );
              },
            )
          },
        ),
        body: SlotLayout(
          config: {
            Breakpoints.small: switch (selectedNavigation) {
              0 => SlotLayout.from(
                  inAnimation: AdaptiveScaffold.fadeIn,
                  duration: const Duration(seconds: 2),
                  key: UniqueKey(),
                  builder: (context) => const HomeSmallBody(),
                ),
              _ => SlotLayout.from(
                  key: UniqueKey(),
                  builder: (context) => const SettingsSmallBody(),
                ),
            },
            Breakpoints.medium: switch (selectedNavigation) {
              0 => SlotLayout.from(
                  key: UniqueKey(),
                  builder: (context) => const HomeMediumBody(),
                ),
              _ => SlotLayout.from(
                  key: UniqueKey(),
                  builder: (context) => const SettingsMediumBody(),
                ),
            },
            Breakpoints.large: switch (selectedNavigation) {
              0 => SlotLayout.from(
                  key: UniqueKey(),
                  builder: (context) => const HomeLargeBody(),
                ),
              _ => SlotLayout.from(
                  key: UniqueKey(),
                  builder: (context) => const SettingsLargeBody(),
                ),
            }
          },
        ),
        secondaryBody: SlotLayout(
          config: {
            Breakpoints.mediumAndUp: SlotLayout.from(
              key: UniqueKey(),
              builder: (context) => const HomeSecondaryBody(),
            ),
          },
        ),
        bottomNavigation: SlotLayout(
          config: {
            Breakpoints.small: SlotLayout.from(
              inAnimation: AdaptiveScaffold.bottomToTop,
              outAnimation: AdaptiveScaffold.topToBottom,
              key: UniqueKey(),
              builder: (context) {
                return AdaptiveScaffold.standardBottomNavigationBar(
                  destinations: destinations,
                  currentIndex: selectedNavigation,
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedNavigation = value;
                    });
                  },
                );
              },
            )
          },
        ),
      ),
    );
  }
}

class HomeSmallBody extends StatelessWidget {
  const HomeSmallBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Material(child: Center(child: Text('Home Small Body')));
  }
}

class SettingsSmallBody extends StatelessWidget {
  const SettingsSmallBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Material(child: Center(child: Text('Settings Small Body')));
  }
}

class HomeMediumBody extends StatelessWidget {
  const HomeMediumBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Material(child: Center(child: Text('Home Medium Body')));
  }
}

class SettingsMediumBody extends StatelessWidget {
  const SettingsMediumBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Material(child: Center(child: Text('Settings Medium Body')));
  }
}

class HomeLargeBody extends StatelessWidget {
  const HomeLargeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Material(child: Center(child: Text('Home Large Body')));
  }
}

class SettingsLargeBody extends StatelessWidget {
  const SettingsLargeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Material(child: Center(child: Text('Settings Large Body')));
  }
}

class HomeSecondaryBody extends StatelessWidget {
  const HomeSecondaryBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Material(child: Center(child: Text('Home Secondary Body')));
  }
}
