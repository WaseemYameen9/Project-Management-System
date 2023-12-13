import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../configurations.dart';

class TeamController extends GetxController
{
  // this function will make a post req to create a team
  static Future<void> createTeam(String teamName, Set<String>teamMembers) async {
    var url = Uri.parse('${Configuration.apiBaseUrl}team/create');
    var memberIds = json.encode(teamMembers.toList());
    try {
      final response = await http.post(
        url,
        body: {
          'title': teamName,
          'member_id': memberIds,
        },
      );

      if (response.statusCode == 200) {
        print(json.decode(response.body));

        var responseData = json.decode(response.body);
        print(responseData['code']);
        Get.back();
      }
    } catch (error) {
      print(error);
    }
  }

  // this function will return List of all the teams
  static Future<List<Map<String, dynamic>>> getTeams() async {
    var url = Uri.parse('${Configuration.apiBaseUrl}team/view');
    List<Map<String, dynamic>> teamsList = []; // List of maps
    try {
      final response = await http.get(url);
      if (response.statusCode == 201) {
        List<dynamic> teamResponse = json.decode(response.body);
        teamResponse.forEach((result) {
          teamsList.add({
            "team_id":result['_id'],
            "title": result['title'],
            // "member_ids": result['member_id']
            //     .map((member) => member['_id'])
            //     .toList(),
          });
        });
      }
    } catch (error) {
      print(error);
    }
    return teamsList;
  }

  // this function will return details of a specific team
  static Future<Map> getTeambyId(var id) async {
    Map team = {
      "title": '',
    };
    var url = Uri.parse('${Configuration.apiBaseUrl}team/view');
    try {
      final response = await http.get(url);
      if (response.statusCode == 201) {
        Map<String,dynamic> teamResponse = json.decode(response.body);
        Map team = {
          "title": teamResponse['title'].toString(),
        };
      }
    } catch (error) {
      print(error);
    }
    return team;
  }

  // this function will return teams in which the member is present
  // member id is given to this function
  static Future<List<Map<String, dynamic>>> getTeamByMemberId(var id) async {
    var url = Uri.parse('${Configuration.apiBaseUrl}team/getbymember/'+id.toString());
    List<Map<String, dynamic>> teamsList = []; // List of maps
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<dynamic> teamResponse = json.decode(response.body);
        print(teamResponse);
        teamResponse.forEach((result) {
          teamsList.add({
            "team_id":result['_id'],
            "title": result['title'],
            // "member_ids": result['member_id']
            //     .map((member) => member['_id'])
            //     .toList(),
          });
        });
      }
    } catch (error) {
      print(error);
    }
    return teamsList;
  }




}