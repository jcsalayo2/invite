import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BunbuyVoucherService {
  final CollectionReference attend =
      FirebaseFirestore.instance.collection('attend');

  Future<bool> addAttend(
      String pangalan, String pagkain, String mensahe) async {
    try {
      final response = await http.post(
        Uri.parse('https://wt4hpsdd-5000.asse.devtunnels.ms/api/Invite'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          <String, Object>{
            "Name": pangalan,
            "Food": pagkain,
            "Comment": mensahe,
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (ex) {
      return false;
    }

    // If the server did not return a 200 OK response,
    // then throw an exception.
    // throw Exception('Failed to load Vouchers');
  }

  Future<bool> addAttendFirebase(
      String pangalan, String pagkain, String mensahe, bool answer) async {
    return await attend.add({
      "Name": pangalan,
      "Food": pagkain,
      "Message": mensahe,
      "DateTime": DateTime.now(),
      "Answer" : answer
    }).then((value) {
      return true;
    }).catchError((error) {
      return false;
    });
  }
}
