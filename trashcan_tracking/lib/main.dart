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
    // FriendsPage(),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.discount),
            label: 'Vouchers',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.people),
          //   label: 'Friends',
          // ),
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
  late Map<String, dynamic> items = {'': '', '': ''};
  List<Widget> items_list = [];

  @override
  void initState() {
    fetch();
    Timer timer = Timer.periodic(Duration(seconds: 3), (timer) {
      fetch();
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
    final httpPackageUrl = Uri.parse('http://35.240.151.168:5000/trash_info');
    final httpPackageInfo = await http.read(httpPackageUrl);
    final httpPackageJson =
        json.decode(httpPackageInfo) as Map<String, dynamic>;

    if (this.mounted) {
      setState(() {
        items_list = [];
        _counter = httpPackageJson['total_trash'] as String;
        items = httpPackageJson['trash_types'];
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
  late Map<String, dynamic> items = {'': '', '': ''};
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
    final httpPackageUrl = Uri.parse('http://35.240.151.168:5000/trash_info');
    final httpPackageInfo = await http.read(httpPackageUrl);
    final httpPackageJson =
        json.decode(httpPackageInfo) as Map<String, dynamic>;

    Map<String, String> vouchers = {
      'Voucher X': '3',
      'Voucher Y': '5',
      'Voucher Z': '7',
      'Voucher I': '9',
      'Voucher J': '11',
      'Voucher K': '13',
    };

    if (this.mounted) {
      setState(() {
        items_list = [];
        _counter = httpPackageJson['total_trash'] as String;
        items = httpPackageJson['trash_types'];
        vouchers.forEach((key, value) {
          if (int.parse(_counter) < int.parse(value))
            items_list.add(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color.fromARGB(255, 255, 117, 114),
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          '$key',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 234, 234),
                          ),
                        ),
                        subtitle: Text(
                          'Points needed: $value',
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Color.fromARGB(255, 255, 234, 234),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          else {
            items_list.add(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text('$key'),
                        subtitle: ElevatedButton(
                          child: Text(
                            'Redeem!',
                            // style: TextStyle(
                            //   color: Colors.white,
                            // ),
                          ),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _redeemVoucherDialog(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          log("fetched");
        });
      });
    }
  }

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

Widget _redeemVoucherDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Redeem your voucher below!'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("<Process to redeem the voucher>"),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Close'),
      ),
    ],
  );
}

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
