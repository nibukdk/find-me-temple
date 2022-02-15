import 'package:church/models/events.dart';
import 'package:church/models/temple.dart';

class UserAuthModel {
  final String emailId;
  final String password;
  // final UserProfileModel userProfile;

  const UserAuthModel(
      // this.userProfile,
      {
    required this.emailId,
    required this.password,
  });
}

class UserProfileModel {
  final String imageUrl;
  final String address;
  final String lat;
  final String long;
  final EventsModel favaoriteEvents;
  final TempleModel favoriteTemples;

  UserProfileModel({
    required this.imageUrl,
    required this.address,
    required this.lat,
    required this.long,
    required this.favaoriteEvents,
    required this.favoriteTemples,
  });
}
