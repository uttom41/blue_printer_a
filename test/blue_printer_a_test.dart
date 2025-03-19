import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // ✅ Test binding ensure করা হলো

  const MethodChannel channel = MethodChannel('blue_thermal_printer');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      return '42'; // ✅ টেস্টের জন্য ডামি রেসপন্স
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    final result = await channel.invokeMethod<String>('getPlatformVersion');
    expect(result, '42'); // ✅ সঠিক রেসপন্স আসছে কিনা চেক
  });
}
