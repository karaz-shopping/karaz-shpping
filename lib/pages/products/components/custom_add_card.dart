import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:share_plus/share_plus.dart';

class CustomAdsCard extends StatefulWidget {
  const CustomAdsCard({super.key});

  @override
  State<CustomAdsCard> createState() => _CustomAdsCardState();
}

class _CustomAdsCardState extends State<CustomAdsCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 230,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              clipBehavior: Clip.none,
                              width: double.infinity,
                              height: 110,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/manPerfume.jpg'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.all(7).copyWith(bottom: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        'title',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        'color',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'descreption',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  //const SizedBox(height: 10),
                                  const Divider(
                                    height: 10,
                                    thickness: 2,
                                  ),
                                  Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: const [
                                            Text(
                                              '1000',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'JD',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Expanded(
                                        child: SizedBox(
                                          height: 30,
                                          child: VerticalDivider(
                                            width: 5,
                                            thickness: 1.5,
                                            indent: 5,
                                            //endIndent: 7,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            size: 20,
                                            color: Colors.grey[700],
                                            Icons.add_shopping_cart_rounded,
                                          ),
                                        ),
                                      ),
                                      const Expanded(
                                        child: SizedBox(
                                          height: 30,
                                          child: VerticalDivider(
                                            width: 5,
                                            thickness: 1.5,
                                            indent: 5,
                                            endIndent: 7,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 25,
                                            height: 25,
                                            child: FavoriteButton(
                                              //isFavorite: widget._isFavorite,
                                              iconSize: 33,
                                              valueChanged: () {},
                                            ),
                                          ),
                                          IconButton(
                                            iconSize: 20,
                                            onPressed: () async {
                                              const urlPost = "url post";
                                              await Share.share('Karaz \n' +
                                                  'descreption' +
                                                  '\n\n $urlPost');
                                            },
                                            icon: Icon(
                                              size: 20,
                                              Icons.share,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Positioned(
            //   bottom: 110,
            //   left: 20,
            //   child: Text(
            //     'price',
            //     style: TextStyle(
            //       color: AppColors.blueGreen3,
            //       fontSize: 20,
            //       decoration: TextDecoration.underline,
            //     ),
            //   ),
            // ),
          ],
        ),
        //const SizedBox(height: 5),
      ],
    );
  }
}
