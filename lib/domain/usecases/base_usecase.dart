import 'package:flutter_getx_starter/core/network/models/failure_model.dart';

/// Base class untuk semua use cases
/// 
/// [T] adalah tipe return value dari use case
/// [P] adalah tipe parameter yang dibutuhkan use case
/// 
/// Contoh penggunaan:
/// ```dart
/// // 1. Buat parameter class
/// class GetUserParams {
///   final String userId;
///   GetUserParams(this.userId);
/// }
/// 
/// // 2. Implement BaseUseCase
/// class GetUserUseCase implements BaseUseCase<User, GetUserParams> {
///   final UserRepository repository;
///   
///   GetUserUseCase(this.repository);
///   
///   @override
///   Future<UseCaseResult<User>> call(GetUserParams params) async {
///     try {
///       final user = await repository.getUser(params.userId);
///       return UseCaseResult.success(user);
///     } catch (error) {
///       final failure = FailureModel(
///         code: 500,
///         msgShow: 'Gagal mengambil data user',
///         msgSystem: error.toString(),
///       );
///       return UseCaseResult.failure(failure);
///     }
///   }
/// }
/// 
/// // 3. Gunakan di controller/service
/// final useCase = GetUserUseCase(userRepository);
/// final result = await useCase(GetUserParams('123'));
/// 
/// if (result.isSuccess) {
///   final user = result.data!;
///   print('User: ${user.name}');
/// } else {
///   print('Error: ${result.error?.msgShow}');
/// }
/// ```
abstract class BaseUseCase<T, P> {
  Future<UseCaseResult<T>> call(P params);
}

/// Use case yang tidak memerlukan parameter
/// 
/// Contoh penggunaan:
/// ```dart
/// // 1. Implement BaseUseCaseNoParams
/// class GetAllUsersUseCase implements BaseUseCaseNoParams<List<User>> {
///   final UserRepository repository;
///   
///   GetAllUsersUseCase(this.repository);
///   
///   @override
///   Future<UseCaseResult<List<User>>> call() async {
///     try {
///       final users = await repository.getAllUsers();
///       return UseCaseResult.success(users);
///     } catch (error) {
///       final failure = FailureModel(
///         code: 500,
///         msgShow: 'Gagal mengambil data users',
///         msgSystem: error.toString(),
///       );
///       return UseCaseResult.failure(failure);
///     }
///   }
/// }
/// 
/// // 2. Gunakan di controller/service
/// final useCase = GetAllUsersUseCase(userRepository);
/// final result = await useCase();
/// 
/// if (result.isSuccess) {
///   final users = result.data!;
///   print('Total users: ${users.length}');
/// } else {
///   print('Error: ${result.error?.msgShow}');
/// }
/// ```
abstract class BaseUseCaseNoParams<T> {
  Future<UseCaseResult<T>> call();
}

/// Result wrapper untuk use case
/// 
/// Membungkus hasil dari use case dengan status success/error
/// 
/// Contoh penggunaan:
/// ```dart
/// // Success case
/// final successResult = UseCaseResult.success(userData);
/// if (successResult.isSuccess) {
///   final data = successResult.data!; // data tidak null
///   // Process data
/// }
/// 
/// // Failure case
/// final failure = FailureModel(
///   code: 404,
///   msgShow: 'User tidak ditemukan',
///   msgSystem: 'User not found',
/// );
/// final failureResult = UseCaseResult.failure(failure);
/// if (!failureResult.isSuccess) {
///   final error = failureResult.error!; // error tidak null
///   print('Error: ${error.msgShow}');
/// }
/// 
/// // Pattern matching style
/// final result = await getUserUseCase(params);
/// result.isSuccess
///   ? handleSuccess(result.data!)
///   : handleError(result.error!);
/// ```
class UseCaseResult<T> {
  final T? data;
  final FailureModel? error;
  final bool isSuccess;

  /// Constructor untuk success result
  /// 
  /// Contoh:
  /// ```dart
  /// UseCaseResult.success(userData);
  /// ```
  UseCaseResult.success(this.data)
      : error = null,
        isSuccess = true;

  /// Constructor untuk failure result
  /// 
  /// Contoh:
  /// ```dart
  /// UseCaseResult.failure(FailureModel(
  ///   code: 500,
  ///   msgShow: 'Terjadi kesalahan',
  ///   msgSystem: 'Internal server error',
  /// ));
  /// ```
  UseCaseResult.failure(this.error)
      : data = null,
        isSuccess = false;
}

