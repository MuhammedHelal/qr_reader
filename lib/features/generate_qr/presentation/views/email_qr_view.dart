import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_reader/core/functions/navbar_navigation.dart';
import 'package:qr_reader/core/widgets/custom_appbar.dart';
import 'package:qr_reader/core/widgets/show_qr_view_with_cubit.dart';
import 'package:qr_reader/features/generate_qr/presentation/widgets/generate_qr_content_container.dart';
import 'package:qr_reader/features/generate_qr/presentation/widgets/generate_qr_item_view_body.dart';

class EmailQrView extends StatefulWidget {
  const EmailQrView({super.key});

  @override
  State<EmailQrView> createState() => _EmailQrViewState();
}

class _EmailQrViewState extends State<EmailQrView> {
  late final TextEditingController emailController;
  late final TextEditingController subjectController;
  late final TextEditingController bodyController;
  late final GlobalKey<FormState> formKey;
  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    subjectController = TextEditingController();
    bodyController = TextEditingController();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();

    emailController.dispose();
    subjectController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          const BackgroundCircles(),
          SingleChildScrollView(
            child: Column(
              children: [
                const Gap(60),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GenerateQrContentContainer(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Gap(42),
                          const Icon(Icons.alternate_email),
                          const Gap(52),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter email';
                                      } else if (!value.contains('@')) {
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Email',
                                    ),
                                    maxLines: 1,
                                    expands: false,
                                    controller: emailController,
                                  ),
                                  const Gap(12),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter subject';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Subject',
                                    ),
                                    maxLines: 1,
                                    expands: false,
                                    controller: subjectController,
                                  ),
                                  const Gap(12),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter body';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      hintText: 'Body',
                                    ),
                                    maxLines: 5,
                                    expands: false,
                                    controller: bodyController,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Gap(52),
                          ElevatedButton(
                            onPressed: () {
                              bool? isValid = formKey.currentState!.validate();
                              if (isValid) {
                                final data =
                                    'mailto:${emailController.text}?subject=${subjectController.text}&body=${bodyController.text}';
                                navigateWithoutNavBar(
                                  context,
                                  ShowQrViewWithCubit(data),
                                );
                              }
                            },
                            child: const Text('Generate'),
                          ),
                          const Gap(42),
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(60),
              ],
            ),
          ),
          const CustomAppBar(title: 'Email'),
        ],
      ),
    );
  }
}
