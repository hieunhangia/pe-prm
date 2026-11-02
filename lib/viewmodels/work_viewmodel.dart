import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/work_model.dart';
import '../repositories/work_repository.dart';

part 'work_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class WorkViewModel extends _$WorkViewModel {
  late WorkRepository _repository;

  @override
  List<WorkModel> build() {
    _repository = ref.read(workRepositoryProvider);
    loadData();
    return [];
  }

  Future<void> loadData() async {
    state = await _repository.getAll();
  }

  Future<void> updateItem(WorkModel item, String title, String description, bool isCompleted) async {
    final updated = item.copyWith(
      title: title,
      description: description,
      isCompleted: isCompleted,
    );
    await _repository.update(updated);
    await loadData();
  }
}
