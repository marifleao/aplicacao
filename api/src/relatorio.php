<?php

include_once 'bd/bd.php';

class Relatorio{

    private $banco;

    public function __construct(){
        $this->banco = new BD();
    }

    public function rel_FuncSetor(){
        try {
            $conexao = $this->banco->mysql();


            $query = $conexao->prepare("select 
                                            f.matricula, 
                                            f.nome, 
                                            f.bloqueado, 
                                            f.id_setor, 
                                            s.setor 
                                        from 
                                            funcionario f, 
                                            setor s 
                                        where 
                                            f.id_setor = s.id 
                                        order by
                                            s.setor,
                                            f.nome;");

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

    public function rel_QdtFuncSetor(){
        try {
            $conexao = $this->banco->mysql();


            $query = $conexao->prepare("select 
                                            s.setor 'Setor', 
                                            count(f.id_setor) 'Quantidade de Funcionários'
                                        from 
                                            setor s, 
                                            funcionario f 
                                        where 
                                            s.id = f.id_setor 
                                        group by 
                                            f.id_setor;");

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

    public function rel_QdtFuncAtivos(){
        try {
            $conexao = $this->banco->mysql();


            $query = $conexao->prepare("select
                                            count(f.bloqueado) 'Funcionários Ativos'
                                        from
                                            funcionario f
                                        where 
                                            bloqueado = 'N'
                                        group by
                                            f.bloqueado;");

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

}