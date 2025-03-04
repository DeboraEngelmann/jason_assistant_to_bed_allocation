// Agent sample_agent in project assistant

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+runValidator
	: true
<-
	!validarPlano
	.

+retornovalidador(Ret)
	: (Ret == "fail") & erro(Erro) & tipo(Tipo) & reparo(Reparo)
<-
	.print("================ Retorno do Validador: Há falhas no plano \n Erro: ", Erro);
	retornoChatbot(Ret,Tipo,Erro,"O seu plano de alocação de leitos possui falhas.", Reparo);
	.
	
+retornovalidador(Ret)
	: (Ret == "failGoal") & erro(Erro) & tipo(Tipo) & reparo(Reparo)
<-
	.print("================ Retorno do Validador: Há falhas no plano \n Erro: ", Erro);
	retornoChatbot(Ret,Tipo,Erro,"O seu plano de alocação de leitos é válido mas não atende a todos os objetivos.", Reparo);
	.
	
+retornovalidador(Ret)
	: (Ret == "success") & reparo(Reparo)
<-
	.print("================ Retorno do Validador: Plano válido");
	retornoChatbot(Ret,"","","O seu plano de alocação de leitos não possui nenhuma falha.", Reparo);
	.
	
+!start 
	: true 
<- 
	.print("Assistant enabled.");
	!registrar.


+!registrar
	: .my_name(Nome)
<- 
	.print("### Registrar Nome: ", Nome)
	registrar(Nome);
	!validarPlano;
	.
	
+!validarPlano
	: relatorio(Relatorio) & problema(Problema) & plano(Plano)
<-
	.print("### Validar: Problema: ", Problema, " Plano: ", Plano, " Relatorio: ", Relatorio);
	rodarValidador(Relatorio, Problema, Plano);
	.print("### ler relatório");
	readLatex(Relatorio);
	.

//+!validarPlano
//	: true
//<-
//	.print("### Validar Palno...");
//	!validarPlano;
//	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moiseJar/asl/org-obedient.asl") }
