// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// mixin class HttpRequestHelper {
//   bool? hasToken;
//   // HttpRequestHelper({this.hasToken = true});
//
//   Future<Map<String, String>> _getCommonHeaders()async{
//     Map<String, String> commonHeaders = {
//       'Accept': 'application/json',
//     };
//     return commonHeaders;
//   }
//
//   final Map<String, String> _commonHeaders = {
//     'Accept': 'application/json',
//   };
//   Map<String, String> errorData({String? message}) =>
//       {"message": message ?? "no data found"};
//
//   Future<void> httpGetRequest(
//       Uri serviceUrl,
//       void Function(bool apiStatus, Map<String, dynamic> responseData)
//       completionHandler) async {
//     var headersWithToken = await _getCommonHeaders();
//     try {
//       final response =
//       await http.get(serviceUrl, headers: hasToken == true?headersWithToken:_commonHeaders);
//       if (response.statusCode == 200) {
//         final resData = response.body;
//         completionHandler(true, json.decode(resData));
//       } else {
//         completionHandler(false, errorData());
//       }
//     } catch (e) {
//       completionHandler(false, errorData(message: e.toString()));
//     }
//   }
//
//   Future<void> httpPostRequest(
//       Uri serviceUrl,
//       Map<String, dynamic> postData,
//       void Function(bool apiStatus, Map<String, dynamic> responseData)
//       completionHandler) async {
//     var headersWithToken = await _getCommonHeaders();
//     try {
//       final response = await http.post(serviceUrl,
//           body: postData, headers: hasToken == true?headersWithToken:_commonHeaders);
//       if (response.statusCode == 200) {
//         final resData = response.body;
//         completionHandler(true, json.decode(resData));
//       } else {
//         completionHandler(false, errorData());
//       }
//     } catch (e) {
//       print('Exception - $e');
//       completionHandler(false, errorData(message: e.toString()));
//     }
//   }
// }