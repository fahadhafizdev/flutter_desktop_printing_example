import 'package:intl/intl.dart';

class UtilDateFormat {
  String formatDate(String date) {
    if (date.isEmpty) return '-';
    DateTime dateInit = DateTime.parse(date);

    String formattedDate = DateFormat('EEEE, dd MMMM yyyy', 'id').format(
      dateInit.toLocal(),
    );

    return formattedDate;
  }

  String formatDate2(String date) {
    if (date.isEmpty) return '-';
    DateTime dateInit = DateTime.parse(date);

    String formattedDate = DateFormat('dd MMMM yyyy HH:mm', 'id').format(
      dateInit.toLocal(),
    );

    return formattedDate;
  }

  String formatDate3(String date) {
    if (date.isEmpty) return '-';
    DateTime dateInit = DateTime.parse(date);

    String formattedDate = DateFormat('dd/MM/yyyy HH:mm', 'id').format(
      dateInit.toLocal(),
    );

    return formattedDate;
  }

  String formatDate4(String date) {
    if (date.isEmpty) return '-';
    DateTime dateInit = DateTime.parse(date);

    String formattedDate = DateFormat('MMMM yyyy', 'id').format(
      dateInit.toLocal(),
    );

    return formattedDate;
  }

  String formatDate5(String date) {
    if (date.isEmpty) return '-';
    DateTime dateInit = DateTime.parse(date);

    String formattedDate = DateFormat('dd-MM-yyyy', 'id').format(
      dateInit.toLocal(),
    );

    return formattedDate;
  }

  String formatDate6(String date) {
    if (date.isEmpty) return '-';
    DateTime dateInit = DateTime.parse(date);

    String formattedDate = DateFormat('MMM dd, yyyy', 'id').format(
      dateInit.toLocal(),
    );

    return formattedDate;
  }

  String formatDate7(String date) {
    if (date.isEmpty) return '-';
    DateTime dateInit = DateTime.parse(date);

    String formattedDate = DateFormat('HH:mm', 'id').format(
      dateInit.toLocal(),
    );

    return formattedDate;
  }

  String formatDate8(String date) {
    if (date.isEmpty) return '-';
    DateTime dateInit = DateTime.parse(date);

    String formattedDate = DateFormat('dd/MM/yyyy', 'id').format(
      dateInit.toLocal(),
    );

    return formattedDate;
  }

  String formatDate9(String date) {
    if (date.isEmpty) return '-';
    DateTime dateInit = DateTime.parse(date);

    String formattedDate = DateFormat('yyyy-MM-dd', 'id').format(
      dateInit.toLocal(),
    );

    return formattedDate;
  }
}
