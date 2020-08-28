import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/model/data/Products.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';

class SearchTabWidget extends StatefulWidget {
  final ProdProducts product;
  final PageStorageKey pageStorageKey;
  final void Function() onTapProductDetails;
  final void Function() onTapAddToBag;
  final UnmodifiableListView<ProdProducts> prods;

  SearchTabWidget({
    Key key,
    this.product,
    this.pageStorageKey,
    this.onTapProductDetails,
    this.onTapAddToBag,
    this.prods,
  }) : super(key: key);

  @override
  _SearchTabWidgetState createState() => _SearchTabWidgetState(
        product,
        pageStorageKey,
        onTapProductDetails,
        onTapAddToBag,
        prods,
      );
}

class _SearchTabWidgetState extends State<SearchTabWidget> {
  _SearchTabWidgetState(
    this.product,
    this.pageStorageKey,
    this.onTapProductDetails,
    this.onTapAddToBag,
    this.prods,
  );
  ProdProducts product;
  PageStorageKey pageStorageKey;
  void Function() onTapProductDetails;
  void Function() onTapAddToBag;
  UnmodifiableListView<ProdProducts> prods;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height) / 2.5;
    final double itemWidth = size.width / 2;
    double _picHeight;

    if (itemHeight >= 315) {
      _picHeight = itemHeight / 2;
    } else if (itemHeight <= 315 && itemHeight >= 280) {
      _picHeight = itemHeight / 2.2;
    } else if (itemHeight <= 280 && itemHeight >= 200) {
      _picHeight = itemHeight / 2.7;
    } else {
      _picHeight = 30;
    }

    return primaryContainer(GridView.count(
      physics: BouncingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
      children: List<Widget>.generate(prods.length, (i) {
        return GestureDetector(
          onTap: () async => onTapProductDetails,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MColors.primaryWhite,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.03),
                    offset: Offset(0, 10),
                    blurRadius: 10,
                    spreadRadius: 0),
              ],
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Hero(
                      child: FadeInImage.assetNetwork(
                        image: product.productImage,
                        fit: BoxFit.fill,
                        height: _picHeight,
                        placeholder: "assets/images/placeholder.jpg",
                        placeholderScale:
                            MediaQuery.of(context).size.height / 2,
                      ),
                      tag: product.productID,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    child: Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: normalFont(MColors.textGrey, 14.0),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "\$${product.price}",
                          style: boldFont(MColors.primaryPurple, 20.0),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => onTapAddToBag,
                        child: Container(
                          width: 40.0,
                          height: 40.0,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: MColors.dashPurple,
                            borderRadius: new BorderRadius.circular(8.0),
                          ),
                          child: SvgPicture.asset(
                            "assets/images/icons/basket.svg",
                            height: 22.0,
                            color: MColors.textGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ));
  }
}
