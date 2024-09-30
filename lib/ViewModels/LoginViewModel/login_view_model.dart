import 'package:al_noor_town/Models/LoginModels/login_models.dart';
import 'package:al_noor_town/Repositories/LoginRepositories/login_repository.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {

  var allLogin = <LoginModels>[].obs;
  LoginRepository loginRepository = LoginRepository();

  @override
  void onInit(){
    // TODO: implement onInit
    super.onInit();
    //fetchAllLight();
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

