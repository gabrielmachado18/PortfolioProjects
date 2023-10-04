# Projetos de Portfólio usando SQL

Olá, espero que esteja bem :D

Esses são os meus projetos de portfólio usando SQL para Exploração e Limpeza de Dados.

**Descrição do Projeto 1: Análise de Dados da COVID-19**

Este projeto tem como objetivo fornecer insights sobre o impacto da COVID-19 em escala global, ajudando a compreender melhor a progressão da pandemia e os esforços de vacinação.

Este projeto utiliza SQL para analisar dados da COVID-19, com foco em casos, mortes e vacinações. Aqui está uma descrição simplificada:

1. **Seleção de Dados:** Começamos selecionando dados relevantes, como localização, data, casos, mortes e população.

2. **Taxa de Mortalidade no Brasil:** Calculamos o quão letal a COVID-19 é no Brasil, encontrando a porcentagem de mortes entre o total de casos.

3. **Taxa de Infecção no Brasil:** Descobrimos qual porcentagem da população brasileira foi infectada.

4. **Percepções Globais:** Analisamos os países com as maiores taxas de infecção e os países com as maiores taxas de morte em relação às suas populações.

5. **Análise por Continente:** Também examinamos continentes com altas taxas de morte em relação às suas populações.

6. **Dados de Vacinação:** Integrados dados de vacinação para ver quantas pessoas estão sendo vacinadas ao longo do tempo.

7. **Contagem Cumulativa de Vacinação:** Acompanhamos o número total de vacinações administradas, ajudando a entender o progresso dos esforços de vacinação.

8. **Organização de Dados:** Utilizamos técnicas como Expressões Comuns de Tabela (CTEs) e tabelas temporárias para processamento eficiente de dados.

9. **Criação de Visualizações:** Criamos visualizações para simplificar a visualização de dados usando ferramentas como PowerBI ou Tableau.

--------------------------------------------------------------------------------------------------------------------------------------------------------------

**Descrição do Projeto 2: Extração e Limpeza de Dados - Endereços Residenciais de Nashville,TE**

Esse projeto tem como objetivo demonstrar recursos essenciais voltados para extração e principalmente limpeza de dados, tornando a estrutura de dados mais limpa e consistente, pronta para análises posteriores ou integração com outras fontes de dados.

O projeto usa como fonte uma planilha do Excel, tratada em SQL, com as seguintes análises:

**Padronização da coluna de Datas:** Alteração da coluna "SaleDate" para o tipo de dados "Date" para garantir consistência nas datas.

**Correção de Endereços Nulos:** Identificação e correção de endereços nulos na coluna "PropertyAddress" usando o mesmo "ParcelID" para correspondência.

**Separando Colunas de Localização:** Divisão das colunas "PropertyAddress" e "OwnerAddress" em colunas separadas de "Endereço", "Cidade" e "Estado" para facilitar a análise.

**Normalização de Valores Booleanos:** Transformação de valores booleanos ("Y" e "N") na coluna "SoldAsVacant" para "Yes" e "No" utilizando a cláusula "CASE".

**Identificação de Linhas Duplicadas:** Uso de "Common Table Expressions (CTE)" em conjunto com "Window Functions" e "ROW_NUMBER" para identificar e marcar linhas duplicadas.

**Remoção de Linhas Duplicadas:** Remoção das linhas duplicadas com um valor de "ROW_NUMBER" superior a 1, garantindo que apenas uma instância de cada conjunto de dados seja mantida.

**Remoção de Colunas Não Utilizadas:** Exclusão de colunas desnecessárias, como "OwnerAddress", "TaxDistrict", "PropertyAddress", e "SaleDate", para simplificar o conjunto de dados.

**Uso de Funções SQL - SUBSTRING e CHARINDEX:** Demonstração do uso das funções SQL "SUBSTRING" e "CHARINDEX" para extrair partes específicas de uma coluna de texto.

**Uso de Funções SQL - PARSENAME e REPLACE:** Demonstração do uso das funções SQL "PARSENAME" e "REPLACE" para manipular e dividir colunas que contêm dados estruturados.

**Uso de Cláusula UPDATE para Atualizações:** Utilização da cláusula "UPDATE" para realizar atualizações nas colunas do banco de dados com base em regras e correspondências definidas.

