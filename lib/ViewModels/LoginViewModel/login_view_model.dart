import 'package:al_noor_town/Models/LoginModels/login_models.dart';
import 'package:al_noor_town/Repositories/LoginRepositories/login_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Database/db_helper.dart';
import '../../Globals/globals.dart';

class LoginViewModel extends GetxController {

  var allLogin = <LoginModels>[].obs;
  LoginRepository loginRepository = LoginRepository();
  var isAuthenticated = false.obs; // To track login status

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllLight();
  }

  Future<void> checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    isAuthenticated.value = prefs.getBool('isAuthenticated') ?? false;
  }
  // Future<bool> login(String userId, String password) async {
  //   await fetchAllLogin(); // Ensure the latest data is fetched
  //
  //   // Check if the user exists and password matches
  //   for (var loginModel in allLogin) {
  //     if (loginModel.user_id == userId && loginModel.password == password) {
  //       isAuthenticated.value = true; // Set login status
  //       return true; // Login successful
  //     }
  //   }
  //   isAuthenticated.value = false; // Set login status
  //   return false; // Login failed
  // }
  Future<bool> login(String userId, String password) async {
    final user = await loginRepository.getUserByCredentials(userId, password);

    if (user != null) {
      isAuthenticated.value = true; // Set login status to true

      // Save authentication state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);

      return true; // Login successful
    }

    isAuthenticated.value = false; // Set login status to false
    return false; // Login failed
  }
   logout() async {
    isAuthenticated.value = false; // Set login status to false

    // Clear authentication state
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', false);
    await prefs.remove("userId");

    // Clear the data from all tables
    await DBHelper().clearData();
  }

  fetchAllLogin() async{
    var login = await loginRepository.getLogin();
    allLogin.value = login;
  }
  fetchAndSaveLoginData() async {
    await loginRepository.fetchAndSaveLogin();
    fetchAllLogin();
  }
  addLogin(LoginModels loginModels){
    loginRepository.add(loginModels);
  }

  updateLogin(LoginModels loginModels){
    loginRepository.update(loginModels);
    fetchAllLogin();
  }

  deleteLogin(int id){
    loginRepository.delete(id);
    fetchAllLogin();
  }

}

