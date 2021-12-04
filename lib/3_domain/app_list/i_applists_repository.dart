import '../entities.dart';

abstract class IAppListsRepository {
  // Future<List<AppList>?> loadLists();
  Stream<List<AppList>> watchLists();

  Future<bool> create(AppList appList);
  Future<bool> update(AppList appList);
  Future<bool> delete(AppList appList);

  // Stream<Either<NoteFailure, KtList<Note>>> watchAll();
  // Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted();
  // Future<Either<NoteFailure, Unit>> create(Note note);
  // Future<Either<NoteFailure, Unit>> update(Note note);
  // Future<Either<NoteFailure, Unit>> delete(Note note);
}
