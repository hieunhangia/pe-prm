import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import '../viewmodels/work_viewmodel.dart';
import 'edit_work_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void _showColorDialog(BuildContext context) {
    String currentColor = prefs.getString('appBarColor') ?? 'Blue';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Chọn màu thanh ứng dụng'),
              content: RadioGroup<String>(
                groupValue: currentColor,
                onChanged: (val) async {
                  if (val != null) {
                    await prefs.setString('appBarColor', val);
                    setDialogState(() {
                      currentColor = val;
                    });
                    setState(() {});
                  }
                },
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RadioListTile<String>(
                      title: Text('Xanh dương'),
                      value: 'Blue',
                    ),
                    RadioListTile<String>(
                      title: Text('Xanh lá'),
                      value: 'Green',
                    ),
                    RadioListTile<String>(
                      title: Text('Tím'),
                      value: 'Purple',
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Đóng'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = prefs.getString('appBarColor') ?? 'Blue';
    final works = ref.watch(workViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý công việc'),
        backgroundColor: getAppBarColor(currentColor),
        actions: [
          IconButton(
            icon: const Icon(Icons.palette),
            onPressed: () => _showColorDialog(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: works.length,
        itemBuilder: (context, index) {
          final item = works[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text(item.description),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditWorkScreen(work: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
