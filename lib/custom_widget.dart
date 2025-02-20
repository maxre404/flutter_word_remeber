import 'package:flutter/material.dart';

ElevatedButton getElevatedButton(String? text, VoidCallback? onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue, // 背景色
      foregroundColor: Colors.white, // 文字颜色
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // 圆角
      ),
    ),
    child: Text(text ?? ""),
  );
}

TextField getTextField(String labelText,String hintText,TextEditingController textController) {
  return TextField(
    autofocus: true,
    controller: textController,
    keyboardType: TextInputType.multiline,
    textInputAction: TextInputAction.newline,
    maxLines: null, // 允许换行
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: OutlineInputBorder(),
    ),
  );
}
