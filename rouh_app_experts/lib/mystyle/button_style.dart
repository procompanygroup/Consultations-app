import 'package:flutter/material.dart';

import 'constantsColors.dart';

ButtonStyle bs_flatFill(BuildContext context ,Color backgroundColor)
{
  return ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(backgroundColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: backgroundColor),
          )
      )
  );
}

ButtonStyle bs_checkBox(BuildContext context, bool active)
{
  return ButtonStyle(
      foregroundColor: MaterialStateProperty.all( active ? Colors.white: Theme.of(context).primaryColor),
      backgroundColor: MaterialStateProperty.all(active ? Theme.of(context).primaryColor : Colors.white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Theme.of(context).primaryColor),
          )
      )
  );
}


