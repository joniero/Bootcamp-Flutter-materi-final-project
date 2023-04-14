import 'package:elearning/data/model/user_response.dart';
import 'package:elearning/data/repository/banner_repository.dart';
import 'package:elearning/data/repository/course_repository.dart';
import 'package:elearning/data/services/firebase_auth_service.dart';
import 'package:get/get.dart';

import '../../../data/model/banner_response.dart';
import '../../../data/model/course_response.dart';
import '../../../data/repository/auth_repository.dart';


class HomeController extends GetxController {
  final FirebaseAuthService firebaseAuthService;
  final CourseRepository courseRepository;
  final BannerRepository bannerRepository;
  final AuthRepository authRepository;


  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(milliseconds: 100)).then((value) async {
      await getUserData();
    });
  }

  HomeController(this.firebaseAuthService, this.courseRepository, this.bannerRepository, this.authRepository);

  UserData? userData;

  Future<void> getUserData() async {
    final String? email = firebaseAuthService.getCurrentSignedInUserEmail();
    if (email != null) {
      final user = await authRepository.getUserByEmail(email: email);
      if (user != null) userData = user;

      update();
    }
  }

  List<CourseData> courseList = [];
  List<BannerData> bannerList = [];

  bool isGetCoursesLoading = false;
  bool isGetBannersLoading = false;

  // Currently set to static
  String majorName = 'IPA';
  int maxHomeCourseCount = 3;

  Future<void> getCourses() async {
    // Set Loading
    isGetCoursesLoading = true;
    update();
    //String? email = firebaseAuthService.getCurrentSignedInUserEmail();
    String? email = "testerngbayu@gmail.com";
    if (email != null) {
      List<CourseData> result = await courseRepository.getCourses(
        majorName: majorName,
        email: email,
      );
      isGetCoursesLoading = false;
      courseList = result;
      update();
    }
  }

  Future<void> getBanners() async {
    // Set Loading
    isGetBannersLoading = true;
    update();
    String? email = firebaseAuthService.getCurrentSignedInUserEmail();
    if (email != null) {
      List<BannerData> result = await bannerRepository.getBanners(limit: 5);
      isGetBannersLoading = false;
      bannerList = result;
      update();
    }
  }
}
