import 'package:intl/intl.dart'; // pubspec.yaml-এ intl dependency যুক্ত করতে হবে

// createdAt থেকে formatted date নেওয়া
String formatDate(String createdAt) {
  final date = DateTime.parse(createdAt); // String -> DateTime
  return DateFormat('dd MMM, yyyy').format(date); // 15 Mar, 2026
}