import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blu/homee.dart';
import 'package:flutter/material.dart';

class start extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: InkWell(
        onTap: (){
          Navigator.push(context
              , PageRouteBuilder(transitionDuration: Duration( seconds: 2 ),
                  transitionsBuilder:(BuildContext context,
                  Animation<double> animation,
                  Animation<double> secanimation,Widget child){
                animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
                return ScaleTransition(scale: animation,
                alignment: Alignment.center,
                child: child,);

                  } ,
                  pageBuilder: (BuildContext context,
                  Animation<double> animation,
              Animation<double> secanimation){
                return Hom();
              }));
        },
        child: Container( width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.fill,
              image: AssetImage('assets/images/Untitled-1.png',)
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width * .3,
                child: ElevatedButton(

          style: ElevatedButton.styleFrom(

            
          primary: Color(0xff10829f), // Background color
             // Text Color (Foreground color)
          ),
                  onPressed: (){

                    Navigator.push(context
                    , PageRouteBuilder(transitionDuration: Duration( seconds: 2 ),
                        transitionsBuilder:(BuildContext context,
                            Animation<double> animation,
                            Animation<double> secanimation,Widget child){
                          animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
                          return ScaleTransition(scale: animation,
                            alignment: Alignment.center,
                            child: child,);

                        } ,
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secanimation){
                          return Hom();
                        }));},
                  child: Text('Start',style: TextStyle(fontSize: 30,color: Colors.black),),
                ),
              ),

              SizedBox(height: 80,)
            ],
          ),
        ),
      ),
    );
  }
}
