use cloud_digaspi

/*declaração da variavel para identificação de qual funcionario a ser tratado */
declare @IdFuncionario int;
set @IdFuncionario = 1;

begin
 while @IdFuncionario < 11000
	begin 

	/*atualizando novo inicio do banco de horas*/
	update cloud_digaspi.dbo.funcionarios
		set
			bh_inicio = '2024-01-01'
		where funcionarios.id=@IdFuncionario

	/*adicionando o contador do id do funcionario*/
	set @IdFuncionario = @IdFuncionario +1;
	end
end