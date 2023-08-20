
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remixicon/remixicon.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:trac_app/contants/app_colors.dart';
import 'package:trac_app/controllers/add_image_controller.dart';
import 'package:trac_app/controllers/fraud_detail_controller.dart';
import 'package:trac_app/controllers/fraud_image_controller.dart';
import 'package:trac_app/models/fraud_detail_model.dart';
import 'package:trac_app/views/pages/imagezoomscreen/Image_zoom_screen.dart';
import 'dart:io';
import '../../../contants/app_images.dart';
import '../../../contants/app_variables.dart';

class FraudDetailScreen extends StatefulWidget {
  FraudDetailScreen( {super.key,
    required this.fId,});

  String fId;
  @override
  State<FraudDetailScreen> createState() => _FraudDetailScreenState();

}

class _FraudDetailScreenState extends State<FraudDetailScreen> {

  FraudDetailController fraudDetailController = Get.put(FraudDetailController());
  AddImageController addImageController = Get.put(AddImageController());
  late FraudImageController fraudImageController;

  String proofType ="";
  RxString prefixProof = RxString("");
  XFile? image;
  XFile? ProfImage;
  RxBool upload = RxBool(false);
  RxBool uploadProf = RxBool(false);
  bool isProfImage = false;
  final ImagePicker picker = ImagePicker();


  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      isProfImage?ProfImage = img:image =img;
      if(img!=null)
      {isProfImage?uploadProf.value=true:upload.value = true;
      addImageController.fetchData(widget.fId.toString(), isProfImage?ProfImage!.path:image!.path, fraudImageController, isProfImage);
      }else{isProfImage?uploadProf.value=false:upload.value = false;}
    });
  }



  @override
  Widget build(BuildContext context) {

    fraudDetailController.fetchData(widget.fId);
    fraudImageController = Get.put(FraudImageController());
    fraudImageController.fetchData(widget.fId);

    return Scaffold(
        backgroundColor:AppColors.inputBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: const Text('Bad Customer Details', style: TextStyle(fontSize: 14),),
        ),

        body: SafeArea(
            child: SingleChildScrollView(
              child:

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Obx(
                              () => fraudDetailController.isLoading.value? Container(height: 250, alignment: Alignment.center, child: CircularProgressIndicator(),)
                              : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 1,
                              itemBuilder: (context, i)
                              {


                                FraudDetails? fraud = fraudDetailController.fraudDetails!;
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Row(
                                        children: [

                                          Container(
                                            margin: EdgeInsets.only(top: 15),
                                            width: 130,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Stack(
                                                alignment: Alignment.bottomCenter,
                                                children: [
                                                  TouchableOpacity(
                                                    onTap:(){
                                                      if(fraud.profilePhoto!.isNotEmpty) {
                                                        Get.to(ImageZoomScreen(
                                                          imageUrl: "${AppVariables
                                                              .baseUrl}uploads/frauds/${fraud
                                                              .profilePhoto!}",));
                                                      }
                                                    },
                                                    child: SizedBox(
                                                      width: 130,
                                                      height: 150,
                                                      child:
                                                      Obx(() => uploadProf.value?Image.file(File(ProfImage!.path),
                                                        fit: BoxFit.cover,):

                                                      (fraud.profilePhoto!.isNotEmpty?Image.network(fit: BoxFit.cover,"${AppVariables.baseUrl}uploads/frauds/${fraud.profilePhoto!}",
                                                      ):Image.asset(AppImages.fraudPlaceholder, fit: BoxFit.cover))
                                                      ),
                                                    ),
                                                  ),



                                                  TouchableOpacity(
                                                    onTap: () {
                                                      isProfImage = true;
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
                                                        color: AppColors.primary,
                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                        child: Center(
                                                          child: Text(fraud.profilePhoto!.isNotEmpty?"Change Image":"Upload Image",
                                                              style: const TextStyle(
                                                                  fontWeight: FontWeight.bold,color: AppColors.fontOnSecondary, fontSize: 11)
                                                          ),
                                                        )
                                                    ),
                                                  )

                                                ],
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox( height: 10,),
                                                Text("Name", style: TextStyle(color: AppColors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                                                Text(fraud.name??"", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),

                                                SizedBox( height: 10,),
                                                Text("Mobile", style: TextStyle(color: AppColors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                                                Text(fraud.mobileNumber??"", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),

                                                SizedBox( height: 10,),
                                                Text("Proof Type", style: TextStyle(color: AppColors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                                                Text(fraud.proofType??"", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),

                                                SizedBox( height: 10,),
                                                Text("Proof Details", style: TextStyle(color: AppColors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                                                Text(fraud.proofNumber??"", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),


                                              ],
                                            ),
                                          )

                                        ],
                                      ),

                                      SizedBox( height: 20,),
                                      Text("Address", style: TextStyle(color: AppColors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                                      Text(fraud.address??"", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),

                                      SizedBox( height: 10,),
                                      Text("Description", style: TextStyle(color: AppColors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
                                      Text(fraud.description??"", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),

                                    ],
                                  ),
                                );

                              }
                          )
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text("Other Photos", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 14, fontWeight: FontWeight.bold)),
                      ),

                      SizedBox(height: 20,),

                      Obx(
                              () => fraudImageController.isLoading.value? Container(height: 250, alignment: Alignment.center, child: CircularProgressIndicator(),)
                              : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: fraudImageController.images.length+1,
                                itemBuilder: (context, i)
                                {
                                  return
                                    i==fraudImageController.images.length?
                                  Obx(() =>
                                      TouchableOpacity(
                                        onTap: () {
                                          isProfImage = false;
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
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Container(
                                              color: AppColors.grey.withOpacity(0.4),
                                              child: Center(child: addImageController.isLoading.value?const CircularProgressIndicator(color: AppColors.primary,):
                                              const Icon(Remix.image_add_line, color: Colors.grey, size: 30,)),
                                            )
                                  ),
                                      ),
                                  ):TouchableOpacity(
                                        onTap:(){
                                          Get.to(ImageZoomScreen(imageUrl: "${AppVariables.baseUrl}uploads/images/${fraudImageController.images[i]}",));
                                        },
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                    color: AppColors.primary,
                                    child: Image.network("${AppVariables.baseUrl}uploads/images/${fraudImageController.images[i]}",fit: BoxFit.cover))
                                    ),
                                  );

                                }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  crossAxisCount: 3,
                                ),
                          ),
                              )
                      ),

                      SizedBox(height: 30,)

                    ],
                  )





            ),
           ));
  }
}
