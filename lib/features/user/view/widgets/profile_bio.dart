import 'package:flutter/material.dart';
import 'package:chaty/core/constants/constants.dart';
import 'package:chaty/features/user/cubit/user_cubit.dart';
import 'package:chaty/features/auth/view/widgets/custom_text_input_filed.dart';

class ProfileBio extends StatefulWidget {
  const ProfileBio({super.key, required this.pioTxtController});
  final TextEditingController pioTxtController;

  @override
  State<ProfileBio> createState() => _ProfileBioState();
}

class _ProfileBioState extends State<ProfileBio> {
  double height = 60;
  @override
  void initState() {
    super.initState();
    _listeningToBioChanges();
  }

  void _listeningToBioChanges() {
    final profileCubit = UserCubit.get(context);
    widget.pioTxtController.text = profileCubit.currentUser.bio ?? '';
    widget.pioTxtController.addListener(
      () {
        if (widget.pioTxtController.text.length > 40) {
          _resizeInputField(120);
        }
        if (widget.pioTxtController.text.length < 40) {
          _resizeInputField(40);
        }
      },
    );
  }

  void _resizeInputField(double h) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        height = h;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileCubit = UserCubit.get(context);
    return Card(
      color: theme.colorScheme.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 16),
            child: Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.secondary,
                )),
          ),
          Expanded(
            child: CustomTextInputField(
              textEditingController: widget.pioTxtController,
              initText: profileCubit.currentUser.bio ?? dummyBio,
              maxLines: 5,
              height: widget.pioTxtController.text.length > 40 ? 120 : 60,
              onSubmitted: (value) async {
                profileCubit.currentUser.bio = value;
                await profileCubit.updateUserProfile();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    widget.pioTxtController.removeListener(_listeningToBioChanges);
    super.dispose();
  }
}
