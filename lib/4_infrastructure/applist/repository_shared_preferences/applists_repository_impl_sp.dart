// import 'dart:convert';
// import 'package:rxdart/rxdart.dart';

// // import 'package:injectable/injectable.dart';
// import 'package:dartz/dartz.dart';
// import 'package:photo_app/3_domain/applist/applist_failure.dart';
// import 'package:photo_app/3_domain/entities.dart';
// import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

// // @LazySingleton(as: IAppListsRepository)
// class AppListsSharedPreferencesRepository implements IAppListsRepository {
//   final StreamingSharedPreferences sp;

//   AppListsSharedPreferencesRepository(this.sp);

//   @override
//   Stream<Either<AppListFailure, List<AppList>>> watchAllLists() async* {
//     yield* sp.getKeys().map(
//       (Set<String> keys) {
//         final keysList = keys.toList();
//         keysList.sort();
//         return right<AppListFailure, List<AppList>>(
//             keysList.map((key) => _getList(key)).toList());
//       },
//     ).onErrorReturnWith(
//       (error, stackTrace) {
//         print(error.toString());
//         return left<AppListFailure, List<AppList>>(
//             const AppListFailure.unexpected());
//       },
//     );
//   }

//   @override
//   Future<Either<AppListFailure, Unit>> create(AppList appList) {
//     // We're using the list's creation date as the unique key. It
//     // makes easier to sort later in the UI. Once we use a real db
//     // we'll use the unique id and sort by date when we pull the data.
//     if (sp.getKeys().getValue().contains(appList.createdTimestamp.toString())) {
//       return Future.value(left<AppListFailure, Unit>(
//           const AppListFailure.listIdAlreadyExists()));
//     }

//     return _writeList(appList);
//   }

//   @override
//   Future<Either<AppListFailure, Unit>> update(AppList appList) {
//     return _writeList(appList);
//   }

//   @override
//   Future<bool> delete(AppList appList) {
//     return sp.remove(appList.id.toString());
//   }

//   /// Throws [Exception] if list not found
//   AppList _getList(String id) {
//     String listJsonString = sp.getString(id, defaultValue: '').getValue();

//     return AppList.fromJson(jsonDecode(listJsonString));
//   }

//   Future<Either<AppListFailure, Unit>> _writeList(AppList appList) {
//     try {
//       sp.setString(appList.id.toString(), jsonEncode(appList.toJson()));
//       return Future.value(right<AppListFailure, Unit>(unit));
//     } catch (e) {
//       return Future.value(
//           left<AppListFailure, Unit>(const AppListFailure.unexpected()));
//     }
//   }
// }
