import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_printer/app/config/config.dart';
import 'package:flutter_printer/app/utils/extension/extension.dart';

class ChoosePaper extends StatelessWidget {
  const ChoosePaper({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'A4',
      'A3',
    ];
    String? selectedValue = 'A4';
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'Paper',
            style: AppFont.interBlack1,
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: Text(
                    'Choose Paper',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.cGrey3,
                    ),
                  ),
                  items: items
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ))
                      .toList(),
                  value: selectedValue,
                  onChanged: (String? value) {
                    // setState(() {
                    selectedValue = value;
                    // });
                  },
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                  buttonStyleData: ButtonStyleData(
                    height: 45,
                    width: 100,
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
              5.0.width,
              const Text('Width'),
              2.0.width,
              Text(
                '55 mm',
                style: TextStyle(color: AppColor.cGrey3),
              ),
              3.0.width,
              const Text('Height'),
              2.0.width,
              Text(
                '297 mm',
                style: TextStyle(color: AppColor.cGrey3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
