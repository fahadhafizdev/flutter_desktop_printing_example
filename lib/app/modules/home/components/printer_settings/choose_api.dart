// import 'dart:developer';

// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_printer/app/config/config.dart';
// import 'package:flutter_printer/app/modules/home/controllers/home_controller.dart';
// import 'package:get/get.dart';

// class ChooseApi extends StatelessWidget {
//   const ChooseApi({super.key});

//   @override
//   Widget build(BuildContext context) {
//     HomeController c = Get.find();

//     // String? selectedValue;
//     return Row(
//       children: [
//         Expanded(
//           flex: 1,
//           child: Text(
//             'API',
//             style: AppFont.interBlack1,
//           ),
//         ),
//         Expanded(
//           flex: 4,
//           child: Obx(
//             () => DropdownButtonHideUnderline(
//               child: DropdownButton2<String>(
//                 isExpanded: true,
//                 hint: Text(
//                   'Choose API',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: AppColor.cGrey3,
//                   ),
//                 ),
//                 items: c.dataAPI
//                     .where((element) => element != 'none')
//                     .map((String item) => DropdownMenuItem<String>(
//                           value: item,
//                           child: Text(
//                             item,
//                             style: const TextStyle(fontSize: 14),
//                           ),
//                         ))
//                     .toList(),
//                 value:
//                     c.APISelected.value == 'none' ? null : c.APISelected.value,
//                 onChanged: (String? value) {
//                   c.APISelected.value = value!;
//                   log('value printer : $value');
//                 },
//                 iconStyleData: IconStyleData(
//                   icon: Icon(Icons.keyboard_arrow_down),
//                 ),
//                 buttonStyleData: ButtonStyleData(
//                   height: 45,
//                   padding: const EdgeInsets.only(left: 14, right: 14),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                     color: AppColor.cGrey6,
//                     border: Border.all(
//                       color: AppColor.cGrey3,
//                     ),
//                   ),
//                 ),
//                 menuItemStyleData: const MenuItemStyleData(
//                   height: 40,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
