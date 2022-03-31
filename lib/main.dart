import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderModel(),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProviderModel>();
    return MaterialApp(
      theme: vm.isSwitched ? ThemeData.dark() : ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const MySwitcher(),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  vm.title,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const MyGridWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyGridWidget extends StatelessWidget {
  const MyGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProviderModel>().colorThemeMode;
    return Expanded(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: vm.length,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: vm[index],
              ),
            );
          }),
    );
  }
}

class MySwitcher extends StatelessWidget {
  const MySwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProviderModel>();
    return Switch(
      value: vm.isSwitched,
      onChanged: (newValue) => vm.onSwitch(newValue),
    );
  }
}

class ProviderModel with ChangeNotifier {
  late bool isSwitched;
  late List colorThemeMode;
  late String title;

  ProviderModel() {
    colorThemeMode = darkThemeColors;
    isSwitched = true;
    title = "Dark mode";
  }

  final List<Color> lightThemeColors = [
    Colors.black38,
    Colors.orange,
    Colors.blue,
    Colors.yellow,
    Colors.green.shade300,
    Colors.blue.shade300
  ];
  final List<Color> darkThemeColors = [
    Colors.black,
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.green.shade700,
    Colors.blue.shade700
  ];

  void onSwitch(bool value) {
    isSwitched
        ? colorThemeMode = lightThemeColors
        : colorThemeMode = darkThemeColors;
    isSwitched ? title = "Light mode" : title = "Dark mode";
    isSwitched = value;
    notifyListeners();
  }
}
