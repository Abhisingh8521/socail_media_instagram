// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:got_app/views/utils/extensions/text_style_extensions.dart';
// import 'package:got_app/views/utils/extensions/widget_extensions.dart';
// import 'package:search_choices/search_choices.dart';
//
// import '../colors.dart';
//
// class DropDownSearchBuilder {
//   static Widget searchBuilder(List<String> items,
//       {required void Function(String? value) onChanged,
//       required String itemSelected}) {
//     return DropdownSearch<String>(
//       items: items,
//       popupProps: PopupProps.dialog(
//         searchFieldProps: TextFieldProps(
//             decoration: InputDecoration(
//                 hintText: "search...",
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(60.0),
//                     borderSide:
//                         const BorderSide(width: 1, color: kPrimaryColor)))),
//         showSearchBox: true,
//       ),
//       dropdownButtonProps: const DropdownButtonProps(
//         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//         color: kPrimaryColor,
//       ),
//       dropdownDecoratorProps: DropDownDecoratorProps(
//         textAlign: TextAlign.start,
//         baseStyle: const TextStyle().primaryTextStyle,
//         textAlignVertical: TextAlignVertical.center,
//         dropdownSearchDecoration: InputDecoration(
//             border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(50),
//         )),
//       ),
//       onChanged: onChanged,
//       selectedItem: itemSelected,
//     );
//   }
//
//   static searchChoicesBuilder(List<String> items,
//       {required void Function(String? value) onChanged,
//       required String searchHint}) {
//     return SearchChoices.single(
//       padding: 00.0,
//       displayClearIcon: false,
//       underline: SizedBox(),
//       items: items.map((item) {
//         return DropdownMenuItem(
//           value: item,
//           child: Center(
//               child: Text(item,
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.poppins(color: colorBlack))),
//         );
//       }).toList(),
//       hint: searchHint,
//       searchHint: searchHint,
//       onChanged: onChanged,
//       onSaved: onChanged,
//       isExpanded: true,
//     ).paddingSymmetric(horizontal: 20);
//   }
// }
