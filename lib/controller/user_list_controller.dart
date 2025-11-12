import 'package:buzzify/controller/auth_controller.dart';
import 'package:buzzify/model/friend_request_model.dart';
import 'package:buzzify/model/friendship_model.dart';
import 'package:buzzify/model/user_model.dart';
import 'package:buzzify/service/firestore_service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:uuid/uuid.dart';

enum UserRelationshipStatus {
  none,
  friendRequestSent,
  friendRequestReceived,
  friends,
  blocked,
}

class UsersListController extends GetxController {
  final FirestoreService firestoreService = FirestoreService();
  final AuthController _authController = Get.find<AuthController>();
  final Uuid _uuid = Uuid();

  final RxList<UserModel> _users = <UserModel>[].obs;
  final RxList<UserModel> _filteredUsers = <UserModel>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _searchQuery = ''.obs;
  final RxString _error = ''.obs;

  final RxMap<String, UserRelationshipStatus> _userRelationships =
      <String, UserRelationshipStatus>{}.obs;
  final RxList<FriendRequestModel> _sentRequests = <FriendRequestModel>[].obs;
  final RxList<FriendRequestModel> _receivedRequests =
      <FriendRequestModel>[].obs;
  final RxList<FriendshipModel> _friendships = <FriendshipModel>[].obs;
  List<UserModel> get users => _users;
  List<UserModel> get filteredUsers => _filteredUsers;
  bool get isLoading => _isLoading.value;
  String get searchQuery => _searchQuery.value;
  String get error => _error.value;
  Map<String, UserRelationshipStatus> get userRelationships =>
      _userRelationships;
  @override
  void onInit() {
    super.onInit();
    _loadUsers();
    _loadRelationships();

    debounce(_sentRequests, (_) {
      _filteredUsers();
    }, time: Duration(milliseconds: 300));
  }

  void _loadUsers() async {
    _users.bindStream(firestoreService.getAllUsersStream());
    ever(_users, (List<UserModel> userList) {
      final currentUserId = _authController.user?.uid;
      final otherUsers = userList
          .where((user) => user.id != currentUserId)
          .toList();

      if (_searchQuery.isEmpty) {
        _filteredUsers.value = otherUsers;
      } else {
        _filterUsers();
      }
    });
  }

  void _loadRelationships() {
    final currentUserId = _authController.user?.uid;

    if (currentUserId != null) {
      _sentRequests.bindStream(
        firestoreService.getSentFriendRequestsStream(currentUserId),
      );

      _receivedRequests.bindStream(
        firestoreService.getFriendRequestsStream(currentUserId),
      );

      _friendships.bindStream(firestoreService.getFriendsStream(currentUserId));

      ever(_sentRequests, (_) => _updateAllRelationshipsStatus());
      ever(_receivedRequests, (_) => _updateAllRelationshipsStatus());
      ever(_friendships, (_) => _updateAllRelationshipsStatus());
      ever(_users, (_) => _updateAllRelationshipsStatus());
    }
  }

  void _updateAllRelationshipsStatus() {
    final currentUserId = _authController.user?.uid;
    if (currentUserId == null) return;
    for (var user in _users) {
      if (user.id != currentUserId) {
        final status = _calculateUserRelationshipStatus(user.id);
        _userRelationships[user.id] = status;
      }
    }
  }

  UserRelationshipStatus _calculateUserRelationshipStatus(String userId) {
    final currentUserId = _authController.user?.uid;
    if (currentUserId == null) return UserRelationshipStatus.none;
    // Check if they are friends
    final friendship = _friendships.firstWhereOrNull(
      (f) =>
          (f.user1Id == currentUserId && f.user2Id == userId) ||
          (f.user1Id == userId && f.user2Id == currentUserId),
    );
    if (friendship != null) {
      if (friendship.isBlocked) {
        return UserRelationshipStatus.blocked;
      } else {
        return UserRelationshipStatus.friends;
      }
    }
    final sentRequests = _sentRequests.firstWhereOrNull(
      (req) =>
          req.receiverId == userId && req.status == FriendRequestStatus.pending,
    );
    if (sentRequests != null) {
      return UserRelationshipStatus.friendRequestSent;
    }
    final receivedRequests = _receivedRequests.firstWhereOrNull(
      (req) =>
          req.senderId == userId && req.status == FriendRequestStatus.pending,
    );
    return UserRelationshipStatus.none;
  }

  void _filterUsers() {
    final currentUserId = _authController.user?.uid;
    final query = _searchQuery.value.toLowerCase();

    if (query.isEmpty) {
      _filteredUsers.value = _users
          .where((user) => user.id != currentUserId)
          .toList();
    } else {
      _filteredUsers.value = _users.where((users) {
        return users.id != currentUserId &&
            (users.displayName.toLowerCase().contains(query) ||
                users.email.toLowerCase().contains(query));
      }).toList();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery.value = query;
  }

  void clearSearch() {
    _searchQuery.value = '';
  }

  Future<void> sendFriendRequest(UserModel user) async {
    try {
      _isLoading.value =  true;
      final currentUserId = _authController.user?.uid;
      if (currentUserId != null) {
        final request = FriendRequestModel(
          id: _uuid.v4(),
          senderId: currentUserId,
          receiverId: user.id,
          createdAt: DateTime.now(),
        );

        _userRelationships[user.id] = UserRelationshipStatus.friendRequestSent;

        await firestoreService.sendFriendRequest(request);
        Get.snackbar('Success', "Friend Request Sent To ${user.displayName}");
      }
      Get.snackbar('Success', "Friend Request Sent To ${user.displayName}");
    } catch (e) {
      _userRelationships[user.id] = UserRelationshipStatus.none;
      _error.value = e.toString();
      print("Error sending friend request: $e");
      Get.snackbar('Error', "Failed to send friend request");
    } finally {
      _isLoading.value = false;
    }
  }
}
