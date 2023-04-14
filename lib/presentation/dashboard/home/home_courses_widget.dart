import 'package:elearning/data/model/course_response.dart';
import 'package:elearning/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


import '../../exercise/list/exercise_list_page.dart';
import 'home_controller.dart';

class HomeCoursesWidget extends StatefulWidget {
  const HomeCoursesWidget({Key? key}) : super(key: key);

  @override
  State<HomeCoursesWidget> createState() => _HomeCoursesWidgetState();
}

class _HomeCoursesWidgetState extends State<HomeCoursesWidget> {
  @override
  void initState() {
    Get.find<HomeController>().getCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        List<CourseData> courses = controller.courseList;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pilih Pelajaran', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              if (courses.length > controller.maxHomeCourseCount)
                TextButton(
                  child: const Text('Lihat Semua'),
                  onPressed: () {
                    Get.toNamed(Routes.courseList);
                  },
                ),
            ]
            ),
            if (controller.isGetCoursesLoading == true)
              const Center(child: CircularProgressIndicator())
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    courses.length > controller.maxHomeCourseCount ? controller.maxHomeCourseCount : courses.length,
                itemBuilder: (context, index) {
                  var progress =
                      '${courses[index].jumlahDone}/${courses[index].jumlahMateri}';
                  var progressNum = (courses[index].jumlahDone)!.toDouble() / courses[index].jumlahMateri!.toDouble();
                  return Card(
                    child: ListTile(
                      leading: Container(
                        height: 100,
                        width: 50,
                        child: SizedBox(
                          child: Container(
                            height: 100,
                            width: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  courses[index].urlCover!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(courses[index].courseName ?? ''),
                      subtitle:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(courses[index].courseCategory == 'latihan_soal' ? '${progress} Paket Latihan Soal' : '-'),
                          const SizedBox(
                            height: 4,
                          ),
                          LinearProgressIndicator(
                            value: progressNum,
                            minHeight: 5,
                            backgroundColor: Colors.black,
                          )
                        ]
                      ),
                      onTap: () {
                        Get.toNamed(
                            Routes.exerciseList,
                            arguments: ExerciseListPageArgs(
                            courseId: courses[index].courseId!,
                            courseName: courses[index].courseName ?? '',
                        ),
                        );
                      },
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }

  Future<http.Response> fetchIcon(String iconUri) {
    return http.get(Uri.parse(iconUri));
  }

}
