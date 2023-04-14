import 'package:elearning/data/model/course_response.dart';
import 'package:elearning/presentation/course/course_list_controller.dart';
import 'package:elearning/presentation/dashboard/home/home_courses_widget.dart';
import 'package:elearning/presentation/dashboard/home/home_banners_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';

import '../../../routes/routes.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.shortestSide < 600;
    return SingleChildScrollView(
      child:  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 21),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _namaUser(),
                      Text('Selamat Datang'),
                    ],
                  ),
                  Icon(Icons.ad_units),
                ],
              ),
            ),
            Container(
              height: 11
            ),
        Padding(
        padding: EdgeInsets.only(left: 21.0, right: 21.0),
        child: Container(
              height: 147,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primary,
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 26.0),
                    child: Column(
                      children: [
                        Text('Mau kerjain', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.white)),
                        const SizedBox(
                          height: 3,
                        ),
                        Text('latihan soal', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.white)),
                        const SizedBox(
                          height: 3,
                        ),
                        Text('apa hari ini?', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.white)),
                      ],
                    )
                    ),
                    Image.asset(ImagesAssets.imageBannerCharacter)
                  ]
                )
            )
            ),
            Container(
                height: 6
            ),
      Padding(
        padding: EdgeInsets.only(left: 19.0, right: 21.0),
        child:
        const HomeCoursesWidget()
      ),
            const SizedBox(
              height: 11,
            ),
      Padding(
        padding: EdgeInsets.only(left: 19.0),
        child:const HomeBannersWidget(),
      )
          ],
        ),
    );
  }

  Widget _mobileWidget() {
    return Container();
  }

  Widget _tabletWidget() {
    return Container();
  }

  Widget _landscapeWidget() {
    return Container();
  }

  Widget _namaUser() {
    return GetBuilder<HomeController>(
      builder: (HomeController controller) {
        final nama = controller.userData?.userName;
        return Text(
          nama != null ? 'Hai $nama' : ' Hai -',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        );
      },
    );
  }
}
