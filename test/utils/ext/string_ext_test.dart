import 'package:flutter_test/flutter_test.dart';
import 'package:money_note/utils/ext/string_ext.dart';

void main() {
  test('Test capitalize', () {
    const testString = "abc";
    final expectString = testString.capitalize();
    expect(expectString, "Abc");
  });
  test('Test orEmpty', () {
    String? test;
    final expectString = test.orEmpty();
    expect(expectString, "");
  });
}
