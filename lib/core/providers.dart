import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterx/constants/appwrite_constants.dart';

final appWriteClientProvider = Provider((ref) {
  Client client = Client();
  return client
      .setEndpoint(AppWriteConstants.endPoint)
      .setProject(AppWriteConstants.projectId)
      .setSelfSigned(status: true);
});

final appwriteAccountProvider = Provider((ref) {
  final client = ref.watch(appWriteClientProvider);
  return Account(client);
});
