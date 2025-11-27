# Banco de Dados — ProjetoDu
Este arquivo descreve o esquema de banco de dados gerado a partir das páginas em `frontend/pages`.

Arquivos criados:
- `database_schema.sql` — script SQL MySQL (compatível com MySQL Workbench) que cria o banco de dados e as tabelas.

Entidades principais geradas a partir das páginas:
- `alunos` — campos: `nome`, `cpf`, `data_nascimento`, `telefone`, `email`, `endereco`, `situacao`.
- `turmas` — campos: `nome`, `curso`, `turno`, `ano_semestre`, `vagas`.
- `matriculas` — relaciona `aluno_id` + `turma_id`, com `data_matricula`.
- `notas` — vincula `matricula_id` com `nota`, `frequencia`, `situacao`.
- `atendimentos` — solicitações vinculadas ao `aluno_id` com `tipo`, `data_solicitacao`, `status`, `observacoes`.

Como importar no MySQL Workbench:
1. Abra o MySQL Workbench e conecte-se ao seu servidor MySQL.
2. No menu, escolha `File > Open SQL Script...` e abra `database_schema.sql` na raiz do projeto.
3. Clique no botão ▶ (Execute) para executar todo o script. Isso criará o banco `projetodu` e todas as tabelas.
4. Verifique as tabelas em `Schemas > projetodu` no painel esquerdo.

Notas e recomendações:
- O charset padrão é `utf8mb4` para suportar acentuação e emojis.
- Ajuste o nome do banco (linha `CREATE DATABASE ...`) se quiser um nome diferente.
- As chaves estrangeiras usam `ON DELETE CASCADE` quando apropriado para facilitar remoção de registros relacionados.
- Os campos `cpf` e `email` têm índices únicos; remova a restrição se preferir permitir duplicados (não recomendado para CPF).

Se quiser, posso também:
- Gerar scripts de seed (dados de exemplo).
- Gerar endpoints REST no `backend/` para CRUD das entidades.
