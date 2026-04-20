import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../models/owner_models.dart';
import '../../../../../repositories/owner_repository.dart';
import '../../../home/providers/owner_home_providers.dart';

// Providers for Store Profile
final storeProfileProvider = FutureProvider<StoreProfileModel>((ref) {
  final branchId = ref.watch(selectedBranchProvider);
  final repo = ref.watch(ownerRepositoryProvider);
  return repo.getStoreProfile(branchId);
});
