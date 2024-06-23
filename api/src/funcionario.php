<?php
include_once 'bd/bd.php';

class Funcionario{

    private $banco;

    public function __construct(){
        $this->banco = new BD();
    }

    public function listarFuncionarios(){
        try {
            $conexao = $this->banco->mysql();
            $query = $conexao->prepare("select f.matricula
                                             , f.nome
                                             , f.bloqueado
                                             , s.id
                                             , s.setor
                                     from funcionario f
                                         , setor s
                                    where f.id_setor = s.id
                                    order by f.matricula desc");
            $query->execute();
            $result = $query->fetchAll(\PDO::FETCH_ASSOC);

            echo json_encode($result);

        } catch (PDOException $e) {
            http_response_code(500);
            print "Error!: " . $e->getMessage();
            exit;
        } finally {
            $conexao = null;
        }
    }

    public function cadastro_funcionarios(){
        try {
            $conexao = $this->banco->mysql();
            $query = $conexao->prepare("INSERT INTO funcionario (nome, bloqueado, id_setor) VALUES ('".$_POST['nome']."','S','". $_POST['id_setor'] ."')");
            $query->execute();
            echo json_encode($conexao->lastInsertId());

        } catch (PDOException $e) {
            http_response_code(500);
            print "Error!: " . $e->getMessage();
            exit;
        } finally {
            $conexao = null;
        }
    }

    public function atualizar_funcionarios(){
        try {
            $conexao = $this->banco->mysql();

            $query = $conexao->prepare("update funcionario set nome = '".$_POST['nome']."', bloqueado = '".$_POST['bloqueado']."', id_setor = '".$_POST['id_setor']."' WHERE matricula = '". $_POST['matricula']."'");
            $query->execute();
            echo json_encode($query->rowCount());

        } catch (PDOException $e) {
            http_response_code(500);
            print "Error!: " . $e->getMessage();
            exit;
        } finally {
            $conexao = null;
        }
    }

}