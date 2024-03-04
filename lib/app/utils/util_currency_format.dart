import 'package:intl/intl.dart';

class UtilCurrencyFormat {
  String currency1(var value) {
    bool isDecimal = false;
    if (value % 1 == 0) {
      isDecimal = false;
    } else {
      isDecimal = true;
    }
    return NumberFormat.currency(
            locale: 'id', decimalDigits: isDecimal ? 1 : 0, symbol: 'Rp ')
        .format(value);
  }

  String currency2(int value) {
    if (value == 0) {
      return "Gratis";
    }
    {
      return NumberFormat.currency(
              locale: 'id', decimalDigits: 0, symbol: 'Rp ')
          .format(value);
    }
  }
}
