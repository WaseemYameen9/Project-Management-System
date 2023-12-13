import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../configurations.dart';

class ProjectController extends GetxController
{
  // this function will make a post req to api to create a project object
  static Future<void> addProject(Map projectData) async {
    var url = Uri.parse('${Configuration.apiBaseUrl}project/create');
    try {
      final response = await http.post(url, body: projectData);
      if (response.statusCode == 200) {
        print(json.decode(response.body));

        var r = json.decode(response.body);
        print(r['code']);
        Get.back();
      }
    } catch (error) {
      print(error);
    }
  }

  // this function will make a get req to get all the projects
  static  Future<List<Map<String, dynamic>>> getProject() async {
    var url = Uri.parse('${Configuration.apiBaseUrl}project/view');
    List<Map<String, dynamic>> productList = []; // List of maps
    try {
      final response = await http.get(url);
      if (response.statusCode == 201) {
        var productResponse = json.decode(response.body);
        productResponse.forEach((result) {
          productList.add({
            "id": result['_id'],
            "name": result['name'],
            "type": result['type'],
            "description": result['description'],
            "cost": result['cost'],
            "status": result['status'],
            "repoLink": result['repoLink'],
            "deadLine": result['deadLine'],
          });
        });
      }
    } catch (error) {
      print(error);
    }
    return productList;
  }

  // this function will make a get req to get all projects assigned to a project manager
  static  Future<List<Map<String, dynamic>>> getProjectByPmId(String id) async {
    var url = Uri.parse('${Configuration.apiBaseUrl}project/getbypmid/'+id);
    List<Map<String, dynamic>> projectList = []; // List of maps
    try {
      final response = await http.get(url);
      if (response.statusCode == 201) {
        var productResponse = json.decode(response.body);
        productResponse.forEach((result) {
          projectList.add({
            "id": result['_id'],
            "name": result['name'],
            "type": result['type'],
            "description": result['description'],
            "cost": result['cost'],
            "status": result['status'],
            "repoLink": result['repoLink'],
            "deadLine": result['deadLine'],
          });
        });
      }
    } catch (error) {
      print(error);
    }
    return projectList;
  }

  // this function will make a delete req to delete a specific project and all its tasks and data
  static Future<void> deleteProject(String project_Id) async {
    var url = Uri.parse('${Configuration.apiBaseUrl}project/delete/'+project_Id);
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        print('Project deleted successfully');
        Get.back();
      } else {
        print('Failed to delete project. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting project: $error');
    }
  }


}