import 'package:chat_message/utils/wechat_date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chat_message/chat_message.dart';

void main() {
  test('wechat date format', () {
    debugPrint(WeChatDateFormat.format(1772052683000).toString());
    debugPrint(WeChatDateFormat.format(DateTime.now().millisecondsSinceEpoch).toString());
  });
}
