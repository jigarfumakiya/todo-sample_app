import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ScreenUtilsExtension on num {
  double get toHeight => ScreenUtil().setHeight(this);

  double get toWidth => ScreenUtil().setWidth(this);

  double get toFont => ScreenUtil().setSp(this);
}
