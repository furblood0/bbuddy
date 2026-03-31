String formatAmount(double amount, String currencySymbol) {
  final isNegative = amount < 0;
  final str = amount.abs().toStringAsFixed(2);
  final parts = str.split('.');
  final intPart = parts[0];
  final decPart = parts[1];

  final buffer = StringBuffer();
  for (int i = 0; i < intPart.length; i++) {
    if (i > 0 && (intPart.length - i) % 3 == 0) buffer.write('.');
    buffer.write(intPart[i]);
  }

  return '${isNegative ? '-' : ''}${buffer.toString()},$decPart $currencySymbol';
}
