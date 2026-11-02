import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import '../models/work_model.dart';
import '../viewmodels/work_viewmodel.dart';

class EditWorkScreen extends ConsumerStatefulWidget {
  final WorkModel work;

  const EditWorkScreen({super.key, required this.work});

  @override
  ConsumerState<EditWorkScreen> createState() => _EditWorkScreenState();
}

class _EditWorkScreenState extends ConsumerState<EditWorkScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.work.title);
    _descController = TextEditingController(text: widget.work.description);
    _isCompleted = widget.work.isCompleted;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = prefs.getString('appBarColor') ?? 'Blue';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa công việc'),
        backgroundColor: getAppBarColor(currentColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Tiêu đề *',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Mô tả',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Đã hoàn thành'),
                Switch(
                  value: _isCompleted,
                  onChanged: (val) {
                    setState(() {
                      _isCompleted = val;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Hủy'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(workViewModelProvider.notifier).updateItem(
                      widget.work,
                      _titleController.text,
                      _descController.text,
                      _isCompleted,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Lưu'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
