import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/helpers/text_field_helpers.dart';
import 'package:winly/models/auth/auth_form_model.dart';
import 'package:winly/services/api/api_service.dart';
import 'package:winly/services/api/auth.dart';
import 'package:winly/services/api/url.dart';
import 'package:winly/widgets/common_avatar.dart';
import 'package:winly/widgets/common_leading.dart';
import 'package:winly/widgets/common_loading_overly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_uploader/flutter_uploader.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final AuthController authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  final AuthFormModel _formModel = AuthFormModel();
  bool _isLoading = false;

  late TextEditingController nameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: authController.user?.name);
    emailController = TextEditingController(text: authController.user?.email);
    phoneNumberController =
        TextEditingController(text: authController.user?.phoneNumber);
  }

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
  }

  Widget _nameForm() {
    final _nameValidator = RequiredValidator(errorText: 'Name is required');
    return TextFormField(
      decoration: TextFieldHelpers.decoration(
        label: 'Name',
      ),
      validator: _nameValidator,
      controller: nameController,
      onSaved: (value) {
        //On saved
      },
      // initialValue: _formModel.name,
    );
  }

  Widget _phoneNumber() {
    final phoneValidator = MultiValidator([
      RequiredValidator(errorText: 'phone is required'),
      MinLengthValidator(11, errorText: 'Please enter a valid mobile number'),
      MaxLengthValidator(11, errorText: 'Please enter a valid mobile number')
    ]);

    return TextFormField(
      decoration: TextFieldHelpers.decoration(
        label: 'Phone number',
      ),
      validator: phoneValidator,
      controller: phoneNumberController,
      onSaved: (value) {
        _formModel.phoneNumber = value;
      },
      // initialValue: _formModel.phoneNumber,
    );
  }

  Widget _emailForm() {
    final emailVaidator = MultiValidator([
      RequiredValidator(errorText: 'email address is required'),
      EmailValidator(errorText: 'enter a valid email'),
    ]);

    return TextFormField(
      decoration: TextFieldHelpers.decoration(
        label: 'email',
      ),
      validator: emailVaidator,
      controller: emailController,
      onSaved: (value) {
        _formModel.email = value;
      },
      //  initialValue: _formModel.email,
    );
  }

  Widget _editPhoto() {
    return Stack(
      children: [
        const CircleAvatar(
          radius: 65,
          backgroundColor: Color(0xff808080),
        ),
        Positioned(
          right: 4.5,
          top: 4.5,
          child: CommonAvatar(
            radius: 60,
            avatarUrl: authController.user?.profileImage,
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: () async {
                var status = await Permission.camera.status;
                if (status != PermissionStatus.granted) {
                  final _request = await Permission.camera.request();
                  if (_request == PermissionStatus.granted) {
                    _pickImage();
                  }
                }
              },
              icon: const CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xff8FD8D8),
                child: Icon(
                  PhosphorIcons.pen,
                  color: Colors.white,
                ),
              ),
            )),
      ],
    );
  }

  Widget _button() {
    return ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState != null) {
            _formKey.currentState!.save();
            if (_formKey.currentState!.validate()) {
              setState(() => _isLoading = true);
              try {
                final response = await AuthAPI.updateProfile(
                    token: authController.token,
                    name: nameController.text,
                    email: emailController.text,
                    phoneNumber: phoneNumberController.text);
                if (response != null) {
                  final data = jsonDecode(response.body);
                  if (response.statusCode == 200) {
                    snack(
                      title: "Success",
                      desc: data['message'],
                      icon: const Icon(Icons.done, color: Colors.green),
                    );
                    authController.getUserProfile(authController.token!);
                  } else if (response.statusCode == 401) {
                    snack(
                      title: "Error",
                      desc: data['error'],
                      icon: const Icon(Icons.error, color: Colors.red),
                    );
                  } else if (response.statusCode == 422) {
                    final data = jsonDecode(response.body);
                    dynamic _emailError = data['errors']['email'];
                    dynamic _phoneNumberError = data['errors']['phone_number'];
                    dynamic _usernameError = data['errors']['username'];

                    String _errorMessage = data['message'];

                    try {
                      if (_emailError != null) {
                        _errorMessage += " ${_emailError[0]}";
                      }

                      if (_phoneNumberError != null) {
                        _errorMessage += " ${_phoneNumberError[0]}";
                      }

                      if (_usernameError != null) {
                        _errorMessage += " ${_usernameError[0]}";
                      }
                    } catch (e) {
                      log(e.toString());
                    }

                    snack(
                      title: "Error",
                      desc: _errorMessage,
                      icon: const Icon(Icons.error, color: Colors.red),
                    );
                  }
                }
                setState(() => _isLoading = false);
              } catch (_) {
                setState(() => _isLoading = false);
                snack(
                  title: "Error",
                  desc: "Something went wrong",
                  icon: const Icon(Icons.error, color: Colors.red),
                );
              }
            }
          }
        },
        child: const Text('Submit'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
        leading: const CommonLeading(),
        elevation: 2.0,
      ),
      body: CommonLoadingOverlay(
        loading: _isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _editPhoto(),
                  const SizedBox(
                    height: 18,
                  ),
                  _nameForm(),
                  const SizedBox(
                    height: 18,
                  ),
                  _phoneNumber(),
                  const SizedBox(
                    height: 18,
                  ),
                  _emailForm(),
                  const SizedBox(
                    height: 18,
                  ),
                  _button(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _pickImage() async {
  final ImagePicker _picker = ImagePicker();

  // pick an image
  final XFile? image = await _picker.pickImage(
    source: ImageSource.gallery,
  );

  final AuthController authController = Get.find<AuthController>();

  final _dio = Dio.Dio();
  String fileName = image!.path.split('/').last;

  Dio.FormData formData = Dio.FormData.fromMap({
    "file": await Dio.MultipartFile.fromFile(
      image.path,
      filename: fileName,
    ),
  });

  String _url = ApiService.baseUrl + "api/user";
  final response = await _dio.post(
    _url,
    data: formData,
    options: Dio.Options(
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        'Authorization': 'Bearer ${authController.token}'
      },
    ),
  );

  snack(title: 'Result', desc: '$response', icon: const Icon(Icons.image));

  // final uploader = FlutterUploader();
  // String _url = ApiService.baseUrl + "api/user";
  // snack(title: 'Url', desc: _url, icon: const Icon(Icons.link));

  // final _upload = MultipartFormDataUpload(
  //   url: _url,
  //   files: [
  //     FileItem(
  //       path: "${image?.path}",
  //       field: "image",
  //     )
  //   ],
  //   method: UploadMethod.POST,
  //   allowCellular: true,
  //   headers: {
  //     "Authorization": "Bearer ${authController.token}",
  //     "Accept": "application/json"
  //   },
  //   // showNotification: false,
  //   tag: "${authController.token}",
  // );

  // // listen upload progress
  // uploader.progress.listen((progress) {
  //   debugPrint("Progress: $progress");
  // });

  // // listen upload stream response
  // uploader.result.listen((result) {
  //   debugPrint("Result: $result");
  // }, onError: (ex, stacktrace) {
  //   debugPrint("Error: $ex");
  // });

  // final _taskId = await uploader.enqueue(_upload);
  // debugPrint("Task Id: $_taskId");
}
