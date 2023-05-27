import 'package:flutter/material.dart';
import 'package:platform_converter/main_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              ListTile(
                trailing: Switch(value: true, onChanged: (val) {}),
                title: const Text("Profile"),
                leading: const Icon(
                  Icons.person,
                  size: 30,
                ),
                subtitle: const Text("Update Profile Data"),
              ),
              const Divider(
                height: 2,
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                trailing: Switch(
                  value: provider.isDarkView,
                  onChanged: (val) {
                    setState(() {
                      provider.changeTheme();
                    });
                  },
                ),
                title: const Text("Theme"),
                leading: const Icon(
                  Icons.wb_sunny_outlined,
                  size: 30,
                ),
                subtitle: const Text("Change Theme"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
