import 'package:flutter_test/flutter_test.dart';
import 'package:pw/pwutils.dart';

void main() {
  test('Utils - Format Currency', () {
    expect(PWUtils.formatCurrency(2), 'R\$ 2,00');
  });
  test('Utils - Format DateTime', () {
    expect(
        PWUtils.getDate(DateTime.parse('2022-02-02 10:36:00')), '02/02/2022');
    expect(PWUtils.getTime(DateTime.parse('2022-02-02 10:36:00')), '10:36');
    expect(PWUtils.getDateTime(DateTime.parse('2022-02-02 14:36:00')),
        '02/02/2022 14:36');
  });
  test('Utils - isDouble', () {
    expect(PWUtils.isDouble('20.0'), true);
    expect(PWUtils.isDouble('20'), false);
  });
  test('Utils - isInt', () {
    expect(PWUtils.isInt('3.5'), false);
    expect(PWUtils.isInt('3'), true);
  });
  test('Utils - isNumber', () {
    expect(PWUtils.isNumber('3.5'), true);
    expect(PWUtils.isNumber('3'), true);
    expect(PWUtils.isNumber('ab'), false);
  });
  test('Utils - String to Double', () {
    expect(PWUtils.stringToDouble('3.5'), 3.5);
    expect(PWUtils.stringToDouble('3'), 3);
    expect(PWUtils.stringToDouble('2,50'), 2.5);
    expect(PWUtils.stringToDouble('ab'), 0.0);
  });

  test('Utils - Translate', () {
    expect(PWUtils.translate('hello', {'hello': 'ola'}), 'ola');
  });
}
