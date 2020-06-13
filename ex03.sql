create or replace function somar (num1 integer, num2 integer) returns integer security definer 
called on null input
-- returns null on null input 
language sql as 
$$
select coalesce(num1,0) + coalesce(num2,0)
$$

select somar(3,null)

-------------------------------------------------------------------------------

select * from banco order by numero

create or replace function add_banco (p_numero integer, p_nome varchar, p_ativo boolean) 
returns integer security invoker called on null input as $$
declare variavel integer;
begin
	if p_numero is null or p_nome is null or p_ativo is null then
		return 0;
	end if;
	--validação para ver se existe banco com essa numeração ... se não existir, adiciona-o
	select into variavel numero from banco where numero = p_numero;
	if variavel is null then
		insert into banco (numero,nome,ativo) values (p_numero,p_nome,p_ativo);
	else
		return variavel;--se já existir o registro, exibe-o
	end if;
	--preparar o retorno do registro adicionado
	select into variavel numero from banco where numero = p_numero;
	return variavel;

end;$$ language plpgsql

select add_banco(7, 'Banco má ideiaaaaaa', false)