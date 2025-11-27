-- Database schema for ProjetoDu
-- MySQL / MySQL Workbench compatible
-- Run this script in MySQL Workbench to create the schema and tables

-- Ajuste o nome do banco abaixo, se desejar
CREATE DATABASE IF NOT EXISTS projetodu CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE projetodu;

-- Remover tabelas existentes (ordem segura para chaves estrangeiras)
DROP TABLE IF EXISTS notas;
DROP TABLE IF EXISTS atendimentos;
DROP TABLE IF EXISTS matriculas;
DROP TABLE IF EXISTS turmas;
DROP TABLE IF EXISTS alunos;

-- Tabela de alunos
CREATE TABLE alunos (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  cpf VARCHAR(14) NOT NULL,
  data_nascimento DATE NULL,
  telefone VARCHAR(30) NULL,
  email VARCHAR(255) NULL,
  endereco VARCHAR(255) NULL,
  situacao ENUM('ativo','inativo') NOT NULL DEFAULT 'ativo',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY ux_alunos_cpf (cpf),
  UNIQUE KEY ux_alunos_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de turmas
CREATE TABLE turmas (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  curso VARCHAR(100) NULL,
  turno ENUM('matutino','vespertino','noturno') NULL,
  ano_semestre VARCHAR(20) NULL,
  vagas INT NULL DEFAULT 30,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY ux_turmas_nome (nome)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de matrículas (relaciona aluno -> turma)
CREATE TABLE matriculas (
  id INT NOT NULL AUTO_INCREMENT,
  aluno_id INT NOT NULL,
  turma_id INT NOT NULL,
  data_matricula DATE NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_matriculas_aluno FOREIGN KEY (aluno_id) REFERENCES alunos(id) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_matriculas_turma FOREIGN KEY (turma_id) REFERENCES turmas(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  UNIQUE KEY ux_matriculas_aluno_turma (aluno_id, turma_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de notas vinculada a uma matrícula
CREATE TABLE notas (
  id INT NOT NULL AUTO_INCREMENT,
  matricula_id INT NOT NULL,
  nota DECIMAL(4,2) NOT NULL DEFAULT 0.00,
  frequencia DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  situacao ENUM('cursando','aprovado','reprovado') NOT NULL DEFAULT 'cursando',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_notas_matricula FOREIGN KEY (matricula_id) REFERENCES matriculas(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabela de atendimentos/solicitações
CREATE TABLE atendimentos (
  id INT NOT NULL AUTO_INCREMENT,
  aluno_id INT NOT NULL,
  tipo ENUM('declaracao','historico','boleto','outros') NOT NULL,
  data_solicitacao DATE NOT NULL,
  status ENUM('aberto','andamento','concluido') NOT NULL DEFAULT 'aberto',
  observacoes TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_atendimentos_aluno FOREIGN KEY (aluno_id) REFERENCES alunos(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Índices adicionais para consultas
CREATE INDEX idx_matriculas_aluno ON matriculas(aluno_id);
CREATE INDEX idx_matriculas_turma ON matriculas(turma_id);
CREATE INDEX idx_notas_matricula ON notas(matricula_id);
CREATE INDEX idx_atendimentos_aluno ON atendimentos(aluno_id);

-- Exemplo de inserção básica (opcional)
-- INSERT INTO turmas (nome, curso, turno, ano_semestre, vagas) VALUES ('DDS-7', 'Desenvolvimento', 'vespertino', '2025/2', 30);

-- Fim do script
