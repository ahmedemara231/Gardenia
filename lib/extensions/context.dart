import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext
{
  double setWidth(double width)
  {
    return MediaQuery.of(this).size.width / width;
  }

  double setHeight(double height)
  {
    return MediaQuery.of(this).size.height / height;
  }
  
  // double setHeightForCharPages(int currentTab)
  // {
  //   switch(currentTab)
  //   {
  //     case 0:
  //       return setHeight(1);
  //     case 1:
  //       return setHeight(1);
  //     default:
  //       return setHeight(3);
  //   }
  // }
  double setHeightForCharPages(int currentTab)
  {
    switch(currentTab)
    {
      case 0:
        return setHeight(1.7);
      case 1:
        return setHeight(1.5);
      default:
        return setHeight(3.7);
    }
  }
}