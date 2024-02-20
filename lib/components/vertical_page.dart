import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';

class VerticalPages extends StatefulWidget {
  const VerticalPages({Key? key}) : super(key: key);

  @override
  State<VerticalPages> createState() => _VerticalPagesState();
}

class _VerticalPagesState extends State<VerticalPages> {
  final List<String> imageList = [
    "https://img.freepik.com/premium-psd/medical-icon-blood-3d-illustration_428731-239.jpg?w=740",
    "https://img.freepik.com/free-psd/blood-bag-transfusion-concept-item_23-2149257758.jpg?t=st=1708440836~exp=1708444436~hmac=d69effb9f5b00e4b21ed792c66d5f1340cea42631d5e3e1afbadd4416a9617ed&w=740",
    "https://img.freepik.com/free-psd/donate-blood-campaign-flyer-template_23-2148690134.jpg?t=st=1708440916~exp=1708444516~hmac=fa40dd89d077cb382c0846a1bd39b4edc17a6fa91c06df387aa9cb93ba93ac40&w=740",
    "https://img.freepik.com/free-psd/blood-donating-poster-template_23-2149170478.jpg?t=st=1708440951~exp=1708444551~hmac=e2e85fb33f0e73cc7bfe8346b9d6c1ca185da073db293222090e8ffa3d52723d&w=740",
    "https://img.freepik.com/premium-psd/blood-donation-poster-template_23-2149095050.jpg?w=740",
  ];

  @override
  Widget build(BuildContext context) {
    List<String> titles = List.generate(imageList.length, (index) => '');
    List<Widget> images = imageList.map((image) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black45,
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.dstATop),
            image: NetworkImage(image),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }).toList();
    return SafeArea(
      child: VerticalCardPager(
        titles: titles,
        images: images,
        textStyle: TextStyle(fontSize: 14, color: Colors.white),
      ),
    );
  }
}
