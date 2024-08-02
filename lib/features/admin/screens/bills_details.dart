import 'package:eshop/constants/global_variables.dart';
import 'package:eshop/models/order.dart';
import 'package:flutter/material.dart';

import 'package:eshop/common/widgets/sinwave_horizontal_line.dart';
import 'package:eshop/features/admin/screens/cart_subtotal.dart';
import 'package:flutter/services.dart';

class BillDetails extends StatefulWidget {
  final String selectedScheduleValue;
  const BillDetails({super.key, required this.selectedScheduleValue});

  @override
  State<BillDetails> createState() => _BillDetailsState();
}

class _BillDetailsState extends State<BillDetails> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20  ,left: 15),
              child: Row(
                children: [
                  Text(
                    "Bill details",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SemiBold',
                        color: GlobalVariables.faintBlackColor),
                  ),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15 , top: 10 ,bottom: 10),
              child: Row(
                children: [
                  Icon(Icons.event_note_sharp ,size: 15,),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Items total" ,style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold ,fontFamily: 'Regular',color: GlobalVariables.faintBlackColor),),
                  Spacer(),
                  CartSubtotal(),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15,bottom: 10, top: 10),
              child: Row(
                children: [
                  Icon(Icons.shopping_bag_rounded ,size: 15,),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Handeling Charge", style: TextStyle(color: GlobalVariables.faintBlackColor,fontSize: 14 , fontWeight: FontWeight.bold ,fontFamily: 'Regular'),),
                  Spacer(),
                  Text("₹10" ,style: TextStyle(fontSize: 14 ,color: GlobalVariables.faintBlackColor, fontWeight: FontWeight.bold ),),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
              child: Row(
                children: [
                  Icon(Icons.motorcycle ,size: 18,),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Delivery Charge" ,style: TextStyle(fontSize: 14 ,color: GlobalVariables.faintBlackColor, fontWeight: FontWeight.bold ,fontFamily: 'Regular'),),
                  Spacer(),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: 10), // Adjust this value for spacing
                        child: Text(
                          '₹150  ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            
                            color: GlobalVariables.greyTextColor,
                            decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                          ),
                        ),
                      ),
                      
                
                      Padding(
                        padding: EdgeInsets.only(
                            left: 30 ), // Adjust this value for spacing
                        child: Text(
                          '  FREE' ,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Regular',
                            fontWeight: FontWeight.bold,
                            color: GlobalVariables.blueTextColor,
                          ),
                        ),
                      ),
                    ],
                  )

        
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10 ),
              child: Row(
                children: [
                  const Icon(Icons.person,size: 15,),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text("Tip for your delivery partner",style: TextStyle(fontSize: 14 ,color: GlobalVariables.faintBlackColor, fontWeight: FontWeight.bold ,fontFamily: 'Regular'),),
                  const Spacer(),
                  Text("${widget.selectedScheduleValue}",style: const TextStyle(fontSize: 14 ,color: GlobalVariables.faintBlackColor, fontWeight: FontWeight.bold ,),),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(left: 15 ,right: 15 , bottom: 10),
              child: Row(
                children: [
                  Text(
                    "Grand total",
                    style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold ,fontFamily: 'Regular'),
                  ),
                  Spacer(),
                  CartTotal(),
                ],
              ),
            ),
            Stack(
              children: [
                ClipPath(
                  clipper: SineWaveClipper(
                    amplitude: 3,
                    frequency: 15,
                  ),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(),
                    child: Container(
                      width: double.infinity,
                      height: 70, // Adjust the height as needed

                      decoration: const BoxDecoration(
                          color:GlobalVariables.savingColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 15 , right: 15 ,top: 20),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                
                          Positioned(
                    top: 19, // Adjust this value to position the text correctly
                    left: 20,
                    right: 10,
                    child: Row(
                      children: [
                        Text(
                          "Your total savings",
                          style:
                              TextStyle(fontSize: 14, color: GlobalVariables.blueTextColor, fontWeight: FontWeight.bold ,fontFamily: 'Regular',),
                        ),
                
                
                        
                      ],
                    ),
                  ),
                          Positioned(
                    top: 35, // Adjust this value to position the text correctly
                    left: 20,
                    right: 10,
                    child: Row(
                      children: [
                        Text(
                          "Includes 150 savings through free delivery",
                          style:
                              TextStyle(fontSize: 12, color: GlobalVariables.lightBlueTextColor),
                        ),
                 
                      ],
                    ),
                  ),
                
                
                  
                
                        ],
                      ),
                      Spacer(),
                      CartTotalSaving(),
                    ],
                  ),
                )
                

                
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderBillDetails extends StatefulWidget {
  final Order? order;
  const OrderBillDetails({
    super.key,
    required this.order,
  });

  @override
  State<OrderBillDetails> createState() => _OrderBillDetailsState();
}

class _OrderBillDetailsState extends State<OrderBillDetails> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Bill details",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'RegularBold',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(Icons.event_note_sharp),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Items Total" ,style: TextStyle(fontFamily: 'Regular' ,fontSize: 16 , ),),
                  Spacer(),
                  CartSubtotal(),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, right: 20),
              child: Row(
                children: [
                  Icon(Icons.shopping_bag_rounded),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Handeling Charge"),
                  Spacer(),
                  Text("₹10"),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(
                    "Grand Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  CartTotal(),
                ],
              ),
            ),
            Stack(
              children: [
                ClipPath(
                  clipper: SineWaveClipper(
                    amplitude: 3,
                    frequency: 15,
                  ),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(),
                    child: Container(
                      width: double.infinity,
                      height: 50, // Adjust the height as needed

                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 168, 182, 255),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15))),
                    ),
                  ),
                ),
                // CustomPaint(
                //   size: Size(MediaQuery.of(context).size.width, 10),
                //   painter: SineWavePainter(
                //     color: Colors.blue,
                //     amplitude: 5,
                //     frequency: 10,
                //   ),
                // ),
                const Positioned(
                  top: 12, // Adjust this value to position the text correctly
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        "Your total savings",
                        style: TextStyle(
                            fontSize: 15, color: GlobalVariables.blueTextColor),
                      ),
                      Spacer(),
                      //                       Text(
                      //                         "₹24",
                      //                         style: TextStyle(fontSize: 15, color: Color(0xFF0000FF)
                      // ),
                      //                       ),

                      CartTotalSaving(),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
