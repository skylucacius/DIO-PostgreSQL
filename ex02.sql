create table if not exists funcionarios (
	id serial primary key,
	nome varchar(50),
	gerente integer references funcionarios(id)
);
insert into funcionarios (nome,gerente) values ('Anselmo',null);
insert into funcionarios (nome,gerente) values ('Beatriz', 1);
insert into funcionarios (nome,gerente) values ('Magno', 1);
insert into funcionarios (nome,gerente) values ('Cremilda', 2);
insert into funcionarios (nome,gerente) values ('Vagner', 4);
/*
SOLUÇÃO 1: USANDO A VIEW DO SLIDE
create or replace recursive view vw_funcionarios (id,nome,gerente) as (
 		select id,nome,cast('' as varchar) as gerente from funcionarios where gerente is null --cast para ñ dar erro
 	union all -- une com um select para fazer uma chamada recursiva a view com a tabela funcionarios
 		select funcionarios.id, funcionarios.nome, gerentes.nome from
 			funcionarios	join vw_funcionarios on funcionarios.gerente = vw_funcionarios.id
 							join funcionarios as gerentes on gerentes.id = vw_funcionarios.id
 );
 select * from vw_funcionarios
*/

--SOLUÇÃO 2: USANDO A VIEW DA AULA
create or replace recursive view vw_func (id,nome,gerente) as (
		select id,nome,gerente from funcionarios where gerente is null
	union all
		select funcionarios.id, funcionarios.nome, funcionarios.gerente from funcionarios
			join vw_func on funcionarios.gerente = vw_func.id
);

SELECT vw_func.id, vw_func.nome, gerentes.nome as "nome do gerente" FROM vw_func
LEFT JOIN funcionarios as gerentes ON vw_func.gerente = gerentes.id;