import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:winly/globals/controllers/auth_controller.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/helpers/text_field_helpers.dart';
import 'package:winly/models/auth/auth_form_model.dart';
import 'package:winly/widgets/common_avatar.dart';
import 'package:winly/widgets/common_leading.dart';
import 'package:winly/widgets/common_loading_overly.dart';
import 'package:image_picker/image_picker.dart';

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
      textCapitalization: TextCapitalization.words,
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
              debugPrint("=== update profile picture ===");
              var cameraPermissionResult = await Permission.camera.status;
              var storagePermissionResult = await Permission.storage.status;

              if (cameraPermissionResult == PermissionStatus.granted &&
                  storagePermissionResult == PermissionStatus.granted) {
                final ImagePicker _picker = ImagePicker();

                // pick an image
                final XFile? image = await _picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (image != null) {
                  setState(() => _isLoading = true);
                  await authController
                      .updateProfileImage(image: image)
                      .then((value) {
                    snack(
                      title: "Successfully updated",
                      desc: value,
                      icon: const Icon(Icons.done, color: Colors.green),
                    );
                    setState(() => _isLoading = false);
                  }).onError((error, stackTrace) {
                    snack(
                      title: "Update failed!",
                      desc: error.toString(),
                      icon: const Icon(Icons.warning, color: Colors.red),
                    );
                    setState(() => _isLoading = false);
                  });
                } else {
                  snack(
                    title: 'Image not selected!',
                    desc: 'No image to upload! Pick image and try again.',
                    icon: const Icon(Icons.image),
                  );
                }
              } else {
                snack(
                  title: 'Permission denied!',
                  desc: 'Permission required!',
                  icon: const Icon(Icons.image),
                );
                if (cameraPermissionResult != PermissionStatus.granted) {
                  await Permission.camera.request();
                }

                if (storagePermissionResult != PermissionStatus.granted) {
                  await Permission.storage.request();
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
          ),
        ),
      ],
    );
  }

  Widget _button() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState != null) {
          _formKey.currentState!.save();
          setState(() => _isLoading = true);

          await authController
              .updateProfile(
            name: nameController.text,
            email: emailController.text,
            phoneNumber: phoneNumberController.text,
          )
              .then((value) {
            snack(
              title: "Successfully updated",
              desc: value,
              icon: const Icon(Icons.done, color: Colors.green),
            );
            setState(() => _isLoading = false);
          }).onError((error, stackTrace) {
            snack(
              title: "Update failed!",
              desc: error.toString(),
              icon: const Icon(Icons.warning, color: Colors.red),
            );
            setState(() => _isLoading = false);
          });
        }
      },
      child: const Text('Submit'),
    );
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
