use cloud_digaspiconsulta2023
/*select * from funcionarios where invisivel=0 order by nome
select * from calculos where funcionario_id=8949 and data >= '2023-31-12 00:00:00' order by id
*/

/*declaração da variavel para identificação de qual funcionario a ser tratado */
declare @IdFuncionario int;
set @IdFuncionario = 1;

begin
 while @IdFuncionario < 11000
	begin 
	/*declaração da variavel para data de inicio do banco de horas do funcionario*/
	declare @dataBh smalldatetime; 
	/*declaração da variavel da data atual*/
	declare @dataAtual smalldatetime;
	/*declaração da variavel para saldo do banco */
	declare @saldoBanco int;
	/*inserindo dado de data atual -1 dia*/
	set @dataAtual = '01-01-2024';
	/*id de identificação do funcionario *//*teste realizado com funcionario de id 8949*/
	/*set @IdFuncionario = 8949;*/
	/*inserindo dado na variavel - data de inicio do banco de horas do funcionario*/
	set @dataBh = (select bh_inicio from funcionarios where id=@IdFuncionario) 
	/*banco de horas total apartir da data inicio do banco - resultado retorna em minutos*/
	set @saldoBanco = (select sum (btotal)as valor_banco from calculos where calculos.funcionario_id=@IdFuncionario and calculos.data>=@dataBh and data<@dataAtual)

	/*confirmando resultado do BH
	declare @minutos int;
	set @minutos=60;
	select @saldoBanco/@minutos, @saldoBanco%@minutos
	*/

	/*atualizando valor do banco de horas*/
	update cloud_digaspi.dbo.calculos 
		set	
			bajuste = @saldoBanco
		where calculos.funcionario_id=@IdFuncionario and data = '2024-01-01 00:00:00' 
	/*atualizando novo inicio do banco de horas*/
	/*update cloud_digaspi.dbo.funcionarios
		set
			bh_inicio = '2024-01-01'
		where funcionarios.id=@IdFuncionario
		*/

	/*adicionando o contador do id do funcionario*/
	set @IdFuncionario = @IdFuncionario +1;
	end
end

 
/*listando funcionarios dos dois bancos de dados 
SELECT *
FROM cloud_digaspi.dbo.funcionarios AS A
JOIN cloud_digaspiConsulta2023.dbo.funcionarios AS B ON A.id=B.id where A.id=B.id 
*/
