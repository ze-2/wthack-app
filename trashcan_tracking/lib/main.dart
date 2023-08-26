import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrashAI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0CA716)),
        useMaterial3: true,
        fontFamily: "Rubik",
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Color(0xFF000000),
            fontFamily: "Rubik",
          ),
        ),
      ),
      home: const Homepage(title: 'TrashAI'),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.title});

  final String title;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    CounterPage(),
    VouchersPage(),
    FriendsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.discount),
            label: 'Vouchers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Friends',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({
    super.key,
  });

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  String _counter = '0';
  late Map<String, String> items = {'': '', '': ''};
  List<Widget> items_list = [];

  @override
  void initState() {
    fetch();
    Timer timer = Timer.periodic(Duration(seconds: 3), (timer) {
      fetch();
      log("fetched inside timer");
    });
    if (this.mounted) {
      setState(() {});
      super.initState();
    } else {
      timer.cancel();
      super.dispose();
    }
  }

  void fetch() async {
    // final httpPackageUrl = Uri.parse('https://dart.dev/f/packages/http.json');
    // final httpPackageInfo = await http.read(httpPackageUrl);
    // final httpPackageJson =
    //     json.decode(httpPackageInfo) as Map<String, dynamic>;
    final httpPackageJson = {
      'counter': '0',
      'items': {
        'item1': '1',
        'item2': '2',
        'item3': '1',
        'item4': '2',
        'item5': '1',
        'item6': '2',
      }
    };
    if (this.mounted) {
      setState(() {
        items_list = [];
        _counter = httpPackageJson['counter'] as String;
        items = httpPackageJson['items'] as Map<String, String>;
        items.forEach((key, value) {
          items_list.add(
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "$key: $value\n",
                  style: TextStyle(
                    fontSize: 18,
                    height: 1,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ),
          );
          log("fetched");
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${_counter}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Text(
                'things recycled',
              ),
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: items_list,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class VouchersPage extends StatefulWidget {
  VouchersPage({super.key});

  @override
  State<VouchersPage> createState() => _VouchersPageState();
}

class _VouchersPageState extends State<VouchersPage> {
  String _counter = '0';
  late Map<String, String> items = {'': '', '': ''};
  List<Widget> items_list = [];

  @override
  void initState() {
    fetch();
    Timer timer = Timer.periodic(Duration(seconds: 3), (timer) {
      fetch();
      log("fetched inside timer");
    });
    if (this.mounted) {
      setState(() {});
      super.initState();
    } else {
      timer.cancel();
      super.dispose();
    }
  }

  void fetch() async {
    // final httpPackageUrl = Uri.parse('https://dart.dev/f/packages/http.json');
    // final httpPackageInfo = await http.read(httpPackageUrl);
    // final httpPackageJson =
    //     json.decode(httpPackageInfo) as Map<String, dynamic>;
    final httpPackageJson = {
      'counter': '0',
      'items': {
        'item1': '1',
        'item2': '2',
        'item3': '1',
        'item4': '2',
        'item5': '1',
        'item6': '2',
      }
    };

    if (this.mounted) {
      setState(() {
        items_list = [];
        _counter = httpPackageJson['counter'] as String;
        items = httpPackageJson['items'] as Map<String, String>;
        items.forEach((key, value) {
          items_list.add(
            Card(
              child: SizedBox(
                width: 300,
                height: 100,
                child: Center(
                  child: Text(
                    "$key: $value\n",
                    style: TextStyle(
                      fontSize: 18,
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
          log("fetched");
        });
      });
    }
  }

  List<String> vouchers = [
    'Voucher X',
    'Voucher Y',
    'Voucher Z',
    'Voucher I',
    'Voucher J',
    'Voucher K',
  ];

  List<int> points = [3, 5, 7, 9, 11, 13];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 70.0,
            right: 30,
            left: 30,
            bottom: 20,
          ),
          child: Center(
            child: Text(
              "Vouchers",
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: items_list,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
