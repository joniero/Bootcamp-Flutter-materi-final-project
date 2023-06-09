import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:elearning/presentation/auth/regist_form/regist_form_controller.dart';

import '../../../core/values/colors.dart';
import '../../../routes/routes.dart';
import '../../widgets/form_text_field_widget.dart';

class RegistFormPage extends StatefulWidget {
  const RegistFormPage({Key? key}) : super(key: key);

  @override
  State<RegistFormPage> createState() => _RegistFormPageState();
}

class _RegistFormPageState extends State<RegistFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameTextController = TextEditingController();
  final TextEditingController _schoolNameTextController = TextEditingController();
  String? selectedKelas;
  String jenisKelamin = '';

  bool isAllValid = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistFormController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          leading: IconButton(
            onPressed: () {},
            color: AppColors.black,
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text(
            'Yuk isi data diri',
            style: TextStyle(
              color: AppColors.black,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(28),
            children: [
              const Text('Email',style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              )),
              TextFormField(
                controller: controller.emailTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Email',
                ),
                enabled: false,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.email(),
                ]),
              ),
              SizedBox(height: 16),
              const Text('Nama Lengkap', style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              )),
              TextFormField(
                controller: _fullNameTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Nama Lengkap',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                ]),
              ),
              SizedBox(height: 16),
              const Text('Jenis Kelamin', style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              )),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          jenisKelamin = 'Laki-Laki';
                        });
                      },
                      child: Container(
                        color: jenisKelamin == 'Laki-Laki' ? Colors.green : Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: Text(
                          'Laki-Laki',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: jenisKelamin == 'Laki-Laki' ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          jenisKelamin = 'Perempuan';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: jenisKelamin == 'Perempuan' ? Colors.green : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xFFD6D6D6), width: 1),
                        ),
                        child: Text(
                          'Perempuan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: jenisKelamin == 'Perempuan' ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'Kelas',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                child: DropdownButtonFormField<String?>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Pilih Kelas',
                  ),
                  value: selectedKelas,
                  items: ['10', '11', '12']
                      .map((element) => DropdownMenuItem<String?>(
                    value: element,
                    child: Text('Kelas $element'),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        selectedKelas = value;
                      }
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              const Text('Nama Sekolah', style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              )),
              TextFormField(
                controller: _schoolNameTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Nama Sekolah',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(6),
                ]),
              ),
              SizedBox(height: 16),
              Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: SizedBox(
              height: 65,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(46),
                    ),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate() == true) {
                    if (selectedKelas != null) {
                      if (jenisKelamin != '') {
                        // Sementara redirect ke Dashboard Page, tapi nanti harus call RegistFormController.registerUser()
                        Get.snackbar('Valid!!!', '.......', snackPosition: SnackPosition.BOTTOM);

                        //registerUser(String fullName, String email, String schoolName, String schoolLevel, String schoolGrade, String gender) async {
                        //schoolLevel ??
                        controller.registerUser(_fullNameTextController.text, controller.emailTextController.text, _schoolNameTextController.text, "SMA", selectedKelas!, jenisKelamin);
                        Get.offAllNamed(Routes.dashboard);
                      } else {
                        Get.snackbar(
                          'Invalid!!!',
                          'Jenis Kelamin Harus Diisi!',
                          backgroundColor: Colors.red,
                        );
                      }
                    } else {
                      Get.snackbar(
                        'Invalid!!!',
                        'Kelas Harus Diisi!',
                        backgroundColor: Colors.red,
                      );
                    }
                  } else {
                    Get.snackbar(
                      'Invalid!!',
                      'Ada input tidak valid',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.blue,
                    );
                  }
                },
                child: const Text('DAFTAR'),
              ),
              ),
              )
            ],
          ),
        ),
      );
    });
  }
}
