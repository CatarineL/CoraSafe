import 'package:cora_safe/classes/DoacaoProvider.dart';
import 'package:cora_safe/classes/InstituicaoCFLProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../classes/InstituicaoSFLProvider.dart';

class Pedidosdoacoes extends StatefulWidget {
  const Pedidosdoacoes({super.key});

  @override
  State<Pedidosdoacoes> createState() =>
      _PedidosdoacoesState();
}

class _PedidosdoacoesState extends State<Pedidosdoacoes> {
  @override
  void initState() {
    super.initState();
    final idISFL = Provider.of<InstituicaosflProvider>(
      context,
      listen: false,
    ).idISFL.text;

    Provider.of<DoacaoProvider>(context, listen: false).lendoSolicitacoes(int.parse(idISFL));

  }
  @override
  Widget build(BuildContext context) {
    final controller_doacoes_colicitadas = context.read<DoacaoProvider>();
    var controller_icfl = context.read<Instituicaocflprovider>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pedidos solicitados",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Veja o status dos seus pedidos",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.redAccent[400],
        iconTheme: IconThemeData(color: Colors.white),
      ),

      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: controller_doacoes_colicitadas.doacoes.length,
          itemBuilder: (context, index) {
            final doacao = controller_doacoes_colicitadas.doacoes[index];
            var nomeICFL = controller_icfl.lendoNome(doacao.idICFL_fk);
            Text("");
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),

              child: ListTile(
                //metodo de recebimento de id pegar o nome da instituição - doacao.idICFL_fk

                title: FutureBuilder(future: nomeICFL,
                    builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Text("Carregando instituição");
                  }
                  if(snapshot.hasError){
                    return Text("Erro ao carregar instituição");
                  }
                  return Text(snapshot.data ?? "Instituição não encontrada");
                  },),
                subtitle: Text(
                  "Status: ${doacao.statusSolicitacao}",
                  style: TextStyle(fontSize: 12,),
                ),

              ), color: Colors.white70,
            );
          },
        ),
      ),
    );
  }
}

