import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../constant.dart';
import 'package:flutter_svg/svg.dart';


class DetailScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              // imagem de fundo
              image: AssetImage('assets/bginfo.png'),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        // icon de voltar
                        'assets/back.svg',
                        height: 18,
                      ),
                    ),
                    SvgPicture.asset(
                      // icon 3 pontos
                      'assets/3dots.svg',
                      height: 18,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.24,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kyshade,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Recomenda????es',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kgreen,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Ao sentir algum sintoma suspeito que possa ser compat??vel com a var??ola dos macacos, tamb??m conhecida como monkeypox, procure uma Unidade B??sica de Sa??de (UBS) ou Unidade de Pronto Atendimento para avalia????o. Informe se voc?? teve contato pr??ximo com algu??m com suspeita ou confirma????o da doen??a. Se poss??vel, isole-se e evite o contato pr??ximo com outras pessoas.\n',
                        style: TextStyle(
                          height: 1.6,
                          color: kgreen.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Sintomas',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: kgreen,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Erup????o cut??nea ou les??es de pele;\nAdenomegalia/Linfonodos inchados (??nguas);\nFebre;\nDores no corpo;\nDor de cabe??a;\nCalafrio;\nFraqueza.\n',
                        style: TextStyle(
                          height: 1.6,
                          color: kgreen.withOpacity(0.7),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
