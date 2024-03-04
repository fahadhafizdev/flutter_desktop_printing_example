import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/config.dart';
import 'package:flutter_printer/app/data/models/log_model.dart';
import 'package:flutter_printer/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class ChoosePrinter extends StatelessWidget {
  const ChoosePrinter({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController c = Get.find();

    // String? selectedValue;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Printer',
            style: AppFont.interBlack1,
          ),
        ),
        Expanded(
          flex: 4,
          child: Obx(
            () => DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  'Choose Printer',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.cGrey3,
                  ),
                ),
                items: c.dataPrinter
                    .where((element) => element != 'none')
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ))
                    .toList(),
                value: c.printerSelected.value == 'none'
                    ? null
                    : c.printerSelected.value,
                onChanged: (String? value) {
                  c.printerSelected.value = value!;
                  log('value printer : $value');
                  c.addLog(LogModel(
                      title: 'SUCCESS',
                      status: 'Printer Changed to ${c.printerSelected.value}'));
                },
                iconStyleData: IconStyleData(
                  icon: Icon(Icons.keyboard_arrow_down),
                ),
                buttonStyleData: ButtonStyleData(
                  height: 45,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColor.cGrey6,
                    border: Border.all(
                      color: AppColor.cGrey3,
                    ),
                  ),
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
