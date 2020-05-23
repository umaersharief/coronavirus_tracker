import 'package:http/http.dart' as http;
import 'package:coronavirus_tracker/models/daily_updates_model.dart';

class DailyUpdatesService {
  static const String url = 'https://covid19.mathdro.id/api/daily';
  static Future<List<DailyUpdatesModel>> getModel() async{
    try{
      final response = await http.get(url);
      if(200 == response.statusCode){
        final List<DailyUpdatesModel> models = dailyUpdatesModelFromJson(response.body);
        return models;
      }else{
        return List<DailyUpdatesModel>();
      }
    }catch(e){
      return List<DailyUpdatesModel>();
    }
  }
}