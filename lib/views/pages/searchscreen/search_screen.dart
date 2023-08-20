import 'package:flutter/material.dart';
import 'package:trac_app/contants/app_colors.dart';
import 'package:trac_app/models/search_model.dart';
import 'package:trac_app/views/widgets/shimmers/widgets/frauds_card_shimmer.dart';
import 'package:get/get.dart';
import '../../../controllers/search_controller.dart';
import '../../../utils/snackbar.dart';
import '../../widgets/frauds_card.dart';
import '../../widgets/inputs.dart';
import '../../widgets/shimmers/search_fraud_shimmer.dart';

class SearchScreen extends StatefulWidget {
   SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();


}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController  = TextEditingController();
  final SearchFraudsController searchFraudsController = Get.put(SearchFraudsController());

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    FocusNode focusNode  = FocusNode ();

    RxBool showCloseBtn = RxBool(true);
    FocusScope.of(context).requestFocus(focusNode);

    return Scaffold(
      backgroundColor: AppColors.inputBackgroundColor,
        body: SafeArea(
            child: Container(
                child: Column(
              children: [
                SearchBox(
                  showCloseBtn: showCloseBtn,
                  controller: searchController,
                  onChanged: (value){
                    if(value.length>1)
                      {
                        searchFraudsController.fetchData(value);
                      }else
                        {
                          searchFraudsController.frauds.clear();
                        }
                    if (value.isNotEmpty) {
                      showCloseBtn.value=true;
                    }else
                    {
                      showCloseBtn.value=false;
                    }

                  },
                  hint: 'Search bad customers ...',
                  type: TextInputType.text,),


                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox( height:5),


                            Obx(
                                    () => searchFraudsController.isLoading.value?FraudCardShimmer()
                                    : ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: searchFraudsController.frauds?.length ?? 0,
                                    itemBuilder: (context, i)
                                    {
                                      Frauds fraud = searchFraudsController.frauds[i];
                                      return FraudCard(
                                        fId: fraud.id.toString(),
                                        name: fraud.name.toString(), date: fraud.createdAt.toString(),
                                        mobile: fraud.mobileNumber.toString(), address: fraud.address.toString(),
                                        description: fraud.description.toString(), image: fraud.profilePhoto.toString(),);
                                    }
                                )
                            ),

                            SizedBox( height:10),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),




              ],
            ))));
  }
}

