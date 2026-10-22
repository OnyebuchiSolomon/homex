// import 'package:craveconnect/features/common_bloc/bloc/common.dart';
// import 'package:craveconnect/handlers/app_handler.dart';
// import 'package:craveconnect/ui/global.dart';
// import 'package:flutter/material.dart';
//
//
// class PushNotificationCard extends StatefulWidget {
//   const PushNotificationCard({
//     super.key,
//     required this.userId,
//     required this.fcmToken,
//     required this.role,
//     this.isSingle = true
//   });
//   final List<String> userId;
//   final List<String> fcmToken;
//   final String role;
//   final bool isSingle;
//
//   @override
//   State<PushNotificationCard> createState() => _PushNotificationCardState();
// }
//
// class _PushNotificationCardState extends State<PushNotificationCard> {
//   final messageController = TextEditingController();
//   String? messageType;
//   final messageTitleController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//      return Form(
//       key: _formKey,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       child: Container(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 18.0),
//           child: Column(
//             spacing: 8,
//             children: [
//               InputLabel(
//                 label: "Enter message title",
//                 child: TextEditView(
//                   validator: Validator.validate,
//                   controller: messageTitleController,
//                   hintText: "Enter your message title",
//                 ),
//               ),
//               InputLabel(
//                 label: "Message type",
//                 child: DropdownView.form(
//                   validator: Validator.validateDropdown,
//                   isExpanded: true,
//                   value:
//                       [
//                             'Order',
//                             'Approval',
//                             'Platform',
//                             'other',
//                           ].contains(messageType)
//                           ? messageType
//                           : null,
//                   hintText: 'Select Message type',
//                   icon: ImageView.svgs(AppImages.icArrowBoldDown),
//                   items:
//                       <String>[
//                         'Order',
//                         'Approval',
//                         'Platform',
//                         'other',
//                       ].map<DropdownMenuItem<String>>((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       messageType = value;
//                     });
//                   },
//                 ),
//               ),
//
//               InputLabel(
//                 label: "Enter your message",
//                 child: TextEditView(
//                   maxLines: 2,
//                   maxLength: 100,
//                   validator: Validator.validate,
//                   controller: messageController,
//                   hintText: "Enter your message here",
//                 ),
//               ),
//
//               ButtonView(
//                 onPressed: () {
//                   if(_formKey.currentState!.validate()){
//                     debugPrint(widget.fcmToken.toString());
//                     injector.get<CommonCubit>().sendMessageToUser(
//                       message: messageController.text,
//                       userId: widget.userId,
//                       messgType: messageType,
//                       title: messageTitleController.text,
//                       fcmToken: widget.fcmToken,
//                       role: widget.role,
//                     );
//                   }
//
//                 },
//                 child: Text('Send message', style: AppTextStyles.inter()),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
