import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MainProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  int index = 0;

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: (Provider.of<MainProvider>(context, listen: false).isDarkView)
          ? ThemeData.dark(
              useMaterial3: true,
            )
          : ThemeData.light(
              useMaterial3: true,
            ),
      home: Consumer<MainProvider>(
        builder: (context, provider, child) => DefaultTabController(
          length: 4,
          initialIndex: 1,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.person_add_alt_1_outlined,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "CHATS",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "CALLS",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "SETTINGS",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              toolbarHeight: 70,
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      Provider.of<MainProvider>(context, listen: false)
                          .changeTheme();
                    });
                  },
                  icon: Icon(CupertinoIcons.sun_min),
                ),
                (Provider.of<MainProvider>(context, listen: false).isIOS)
                    ? CupertinoSwitch(
                        onChanged: (val) {
                          Provider.of<MainProvider>(context, listen: false)
                              .changePlatform();
                        },
                        value: Provider.of<MainProvider>(context).isIOS,
                      )
                    : Switch(
                        value: Provider.of<MainProvider>(context, listen: false)
                            .isIOS,
                        onChanged: (val) {
                          Provider.of<MainProvider>(context, listen: false)
                              .changePlatform();
                        },
                      ),
              ],
              title: const Text("Platform Converter"),
            ),
            body: TabBarView(
              children: [
                ...provider.pageList,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
