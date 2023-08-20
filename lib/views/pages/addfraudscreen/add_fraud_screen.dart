
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:trac_app/contants/app_colors.dart';
import 'package:trac_app/contants/app_images.dart';
import 'package:trac_app/views/widgets/buttons.dart';
import 'dart:io';
import '../../../controllers/add_fraud_controller.dart';
import '../../../utils/snackbar.dart';
import '../../widgets/inputs.dart';

class AddFraudScreen extends StatefulWidget {
  const AddFraudScreen({super.key});

  @override
  State<AddFraudScreen> createState() => _AddFraudScreenState();

}

class _AddFraudScreenState extends State<AddFraudScreen> {
  final AddFraudController addFraudController = Get.put(AddFraudController());
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController proofController = TextEditingController();
  TextEditingController disController = TextEditingController();
  String proofType ="";
  RxString prefixProof = RxString("");
  XFile? image;
  var proFile;
  RxBool upload = RxBool(false);
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
      if(img!=null)
        {upload.value = true;
        }else{upload.value = false;}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.inputBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: const Text('Add Bad Customer', style: TextStyle(fontSize: 14),),
        ),

        body: SafeArea(
          child:
    Obx(() => addFraudController.isLoading.value?const Center(child: CircularProgressIndicator()):
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Name", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),
                            EditableBox(
                              controller: nameController,
                              hint: "Enter bad customer name",
                              onChanged: (value)
                              {
                              },
                              type: TextInputType.text,
                            ),

                            const SizedBox( height: 15,),
                            const Text("Mobile Number", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),
                            EditableBox(
                              controller: mobileController,
                              maxLength: 10,
                              hint: "Enter bad customer phone number",
                              onChanged: (value)
                              {
                              },
                              type: TextInputType.phone,
                            ),
                          ],
                        ),
                      ),

                    SizedBox( width: 20),

                      TouchableOpacity(
                        onTap: (){
    showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
    top: Radius.circular(16.0),
    ),
    ),
    builder: (BuildContext context){
    return Container(
    margin: const EdgeInsets.only(top: 5),
    padding: const EdgeInsets.symmetric( vertical: 10,),
    child: Column(
    children: [

    Padding(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: const Align(
    alignment: Alignment.centerLeft,
    child: Text("Choose Source",
    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,
    fontSize: 15),)),
    ),

    SizedBox( height: 10,),

    TouchableOpacity(
    onTap: (){
    getImage(ImageSource.camera);
    Navigator.pop(context);
    },
    child: Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
    border: Border(
    top: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
    // bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
    ),
    ),
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
    child:
    Text("Camera",
    style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),)
    ),
    ),

    TouchableOpacity(
    onTap: (){getImage(ImageSource.gallery);
    Navigator.pop(context);
    },
    child: Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
    border: Border(
    top: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
    // bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
    ),
    ),
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
    child:
    Text("Gallery",
    style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),)
    ),
    ),

    ],
    )
    );
    }
    );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          width: 130,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 130,
                                  height: 110,
                                  child:
                                  Obx(() => upload.value?Image.file(File(image!.path),
                                    fit: BoxFit.cover,):Image.asset(AppImages.fraudPlaceholder,fit: BoxFit.cover)),
                                ),

                                Container(
                                    color: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    child: Center(
                                      child: Text("Upload Image",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,color: AppColors.fontOnSecondary, fontSize: 11)
                                      ),
                                    )
                                )

                              ],
                            ),
                          ),
                        ),
                      )



                    ],
                  ),

                  SizedBox( height: 15,),
                  const Text("Address", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),
                  EditableBox(
                    controller: addressController,
                    hint: "Enter bad customer address",
                    onChanged: (value)
                    {
                    },
                    type: TextInputType.multiline,
                  ),

                  SizedBox( height: 15,),
                  const Text("Proof Type", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),

                  Obx(() => DropBox(
                      prefix: prefixProof.value,
                      onPressed: (){

                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.0),
                              ),
                            ),
                            builder: (BuildContext context){
                              return Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  padding: const EdgeInsets.symmetric( vertical: 10,),
                                  child: Column(
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                        child: const Align(
                                          alignment: Alignment.centerLeft,
                                            child: Text("Choose proof type",
                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,
                                            fontSize: 15),)),
                                      ),

                                      SizedBox( height: 10,),

                                      TouchableOpacity(
                                        onTap: (){proofType = "Aadhaar";
                                        prefixProof.value = proofType;
                                        Navigator.pop(context);
                                        },
                                        child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 20),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
                                                // bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
                                              ),
                                            ),
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                                            child:
                                            Text("Aadhaar",
                                              style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),)
                                        ),
                                      ),

                                      TouchableOpacity(
                                        onTap: (){proofType = "Pan Card";
                                        prefixProof.value = proofType;
                                        Navigator.pop(context);
                                        },
                                        child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 20),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
                                                // bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
                                              ),
                                            ),
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                                            child:
                                            Text("Pan Card",
                                              style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),)
                                        ),
                                      ),

                                      TouchableOpacity(
                                        onTap: (){proofType = "Voter ID";
                                        prefixProof.value = proofType;
                                        Navigator.pop(context);
                                        },
                                        child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 20),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
                                                // bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
                                              ),
                                            ),
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                                            child:
                                            Text("Voter ID",
                                              style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),)
                                        ),
                                      ),

                                      TouchableOpacity(
                                        onTap: (){proofType = "Driving Licence";
                                        prefixProof.value = proofType;
                                        Navigator.pop(context);
                                        },
                                        child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 20),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
                                                // bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
                                              ),
                                            ),
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                                            child:
                                            Text("Driving Licence",
                                              style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),)
                                        ),
                                      ),

                                      TouchableOpacity(
                                        onTap: (){proofType = "Passport";
                                        prefixProof.value = proofType;
                                        Navigator.pop(context);
                                        },
                                        child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 20),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
                                                bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
                                              ),
                                            ),
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                                            child:
                                            Text("Passport",
                                              style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),)
                                        ),
                                      ),


                                    ],
                                  )
                              );
                            }
                        );

                      },
                      hint: "Choose proof type")),


                  SizedBox( height: 15,),
                  const Text("Proof Details", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),
                  EditableBox(
                    controller: proofController,
                    hint: "Enter bad customer proof details",
                    onChanged: (value)
                    {
                    },
                    type: TextInputType.text,
                  ),


                  SizedBox( height: 15,),
                  const Text("Description", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),
                  EditableBox(
                    controller: disController,
                    hint: "Enter description",
                    onChanged: (value)
                    {
                    },
                    type: TextInputType.text,
                  ),

                  SizedBox( height: 25,),

                  PrimaryButton(buttonText: "Submit", onTap: (){

                    if(nameController.text.length > 0 && mobileController.text.length == 10 && addressController.text.length > 0 &&
                    proofType.isNotEmpty && proofController.text.length > 0 && disController.text.length > 0)
                      {
                        addFraudController.fetchData(
                            nameController.text.toString(),
                            mobileController.text.toString(),
                            addressController.text.toString(),
                            proofType,
                            proofController.text.toString(),
                            disController.text.toString(),
                            image!.path,
                            context
                        );
                      }
                    else
                      {
                        Snack.show("","Some mandatory fields are empty!");
                      }

                  })


                ],
              ),
            ),
          ),
        )));
  }
}
