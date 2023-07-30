import 'package:flutter/material.dart';

import '../constant/colors/colors.dart';

const CircularProgressIndicator indicator = CircularProgressIndicator.adaptive(
  backgroundColor: primary,
  valueColor: AlwaysStoppedAnimation<Color>(white),
);
