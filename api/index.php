<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header('Access-Control-Allow-Methods: GET, POST');
header("Content-Type: application/json; charset=UTF-8");

/*
GET 	-> Todos dos funcionario
GET 	-> Todos os setor
GET	  -> Relatorio
          Funcionario por setor
          Quantidade de funcionario por setor
          Quantidade de funcionario ativos

POST	-> Cadastro de funcionario
POST	-> Cadastro de setor
POST	-> Atualizar de funcionario
*/

if ($_SERVER["REQUEST_METHOD"] == 'GET' && isset($_GET["acao"])) {
  $acao = $_GET["acao"];
  switch($acao){
    case 'funcionario':
      include('src/funcionario.php');
      $funcionario = new Funcionario();
      $funcionario->listarFuncionarios();
      break;
    case 'setor':
      include('src/setor.php');
      $setor = new Setor();
      $setor->listarSetor();
      break;
    case 'relatorio1':
      include('src/relatorio.php');
      $relatorio = new Relatorio();
      $relatorio->rel_FuncSetor();
      break;
    case 'relatorio2':
        include('src/relatorio.php');
        $relatorio = new Relatorio();
        $relatorio->rel_QdtFuncSetor();
        break;
    case 'relatorio3':
        include('src/relatorio.php');
        $relatorio = new Relatorio();
        $relatorio->rel_QdtFuncAtivos();
        break;
  }

}else if ($_SERVER["REQUEST_METHOD"] == 'POST' && isset($_POST["acao"])) {
  $acao = $_POST["acao"];
  switch($acao){
    case 'cadastro_funcionario':
      include('src/funcionario.php');
      $funcionario = new Funcionario();
      $funcionario->cadastro_funcionarios();
      break;
    case 'cadastro_setor':
      include('src/setor.php');
      $setor = new Setor();
      $setor->cadastro_setor();
      break;
    case 'atualizar_funcionario':
      include('src/funcionario.php');
      $funcionario = new Funcionario();
      $funcionario->atualizar_funcionarios();
      break;
    case 'atualizar_setor':
      include('src/setor.php');
      $setor = new Setor();
      $setor->atualizar_setor();
      break;
  }
}else{
  echo json_encode("METHOD OU ACAO INVALIDA ");
}
