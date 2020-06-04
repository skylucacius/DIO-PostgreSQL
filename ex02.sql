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

create or replace recursive view vw_funcionarios (id,nome,gerente) as (
		select id,nome,cast('' as varchar) as gerente from funcionarios where gerente is null --cast para ñ dar erro
	union all -- une com um select para fazer uma chamada recursiva a view com a tabela funcionarios
		select funcionarios.id, funcionarios.nome, gerentes.nome from
			funcionarios	join vw_funcionarios on funcionarios.gerente = vw_funcionarios.id
							join funcionarios as gerentes on gerentes.id = vw_funcionarios.id
);

select * from vw_funcionarios
