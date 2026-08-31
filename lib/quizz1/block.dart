import 'package:cci_app/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cci_app/data_space/controllers/resonse_controller.dart';
import 'package:cci_app/models/responce.dart' as resp;
import '../data_space/controllers/data_space_controller.dart';
import 'package:cci_app/data_space/Providers/quizz1_provider.dart';
import 'package:provider/provider.dart';
import 'package:cci_app/models/question.dart';
import 'package:cci_app/services/dowar_services.dart';
import 'package:cci_app/services/loc_service.dart';
import 'package:cci_app/collecte/collecte_screen.dart';


class writeResponse extends StatefulWidget {
  final Question question;
  final String ? Dowarid;
  TextProvider textProvider;



  writeResponse({
    required this.question,
    required this.Dowarid,
    required this.textProvider
  });

  @override
  _writeResponse createState() => _writeResponse();
}

class _writeResponse extends State<writeResponse> {
  final IntervalService IS = Get.put(IntervalService());
  final CollectePage CP = Get.put(CollectePage());
  final DowarService DS = Get.put(DowarService());
  Responsecontroller responsecontroller = Get.put(Responsecontroller());
  final DataSpeceController dataSpeceController = Get.find<DataSpeceController>();
  final List<resp.Response> reponses =  [];
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: getProportionateScreenWidth(30),right:getProportionateScreenWidth(30), top: getProportionateScreenHeight(20)),
        width: getProportionateScreenWidth(400),
        height: getProportionateScreenHeight(160),
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
            children:  [
              Center(
                child: Text (widget.question.questionCorp.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              _buildReponseField(context),


            ])
    );
  }
  Widget _buildReponseField(BuildContext context) {
    //final textProvider = Provider.of<TextProvider>(context);
    final textControllers = <String, TextEditingController>{};
    //final content = TextEditingController(text: textProvider.enteredText);
    widget.textProvider.enteredTextMap.forEach((fieldId, text) {
      textControllers[fieldId] = TextEditingController(text: text);
    });
    String fieldId = widget.question.questionId.toString();
    return Consumer<TextProvider>(
        builder: (context, textProvider, _) {
      return TextField (
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.start,
        controller: textControllers[fieldId],
      onChanged: (cont) async{
        resp.Response rp = await responsecontroller.createNewResponse(widget.question.questionId.toString(), cont, widget.Dowarid!);
        dataSpeceController.saveResponse(rp);
      },
      onSubmitted: (text)  async{
        setState(() {
        widget.textProvider.updateText(fieldId, text);
        });
      },


      decoration: const InputDecoration(
        filled: true,
        fillColor: Colors.white, // replace with desired color
        hintText: 'Votre réponse ...',
      ),
    );
        });
  }
  //Future<List<resp.Response>> _listReponses() {
    //return rep;
  //}
}




















