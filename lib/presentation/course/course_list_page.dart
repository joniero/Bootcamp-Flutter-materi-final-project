import 'package:elearning/data/model/course_response.dart';
import 'package:elearning/presentation/course/course_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../exercise/list/exercise_list_page.dart';

class CourseListPage extends GetView<CourseListController> {
  const CourseListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mata Pelajaran'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Call API getCourses()
          return Future<void>.delayed(const Duration(seconds: 3));
        },
        child: GetBuilder<CourseListController>(
          builder: (CourseListController courseController) {
            List<CourseData> courses = courseController.courseList;

            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                var progress =
                    '${courses[index].jumlahDone}/${courses[index].jumlahMateri}';
                var progressNum = courses[index].jumlahMateri! == 0 ? 0.0 : (courses[index].jumlahDone)!.toDouble() / courses[index].jumlahMateri!.toDouble();
                return
                  Padding(
                    padding: EdgeInsets.only(left: 19.0, right: 21.0),
                child: Card(
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
                )
                );
              },
            );
          },
        ),
      ),
    );
  }
}
