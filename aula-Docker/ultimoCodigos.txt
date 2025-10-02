SELECT * FROM vendas_itens2;

SELECT 
    venda_id,
    ROUND(SUM(valor_unitario * quantidade) :: numeric, 2) AS total_vendas,
    data_venda

FROM 
    vendas_itens2
GROUP BY 
    venda_id, data_venda
ORDER BY total_vendas;

-- subquerys
SELECT 
    ROUND(AVG(total_vendas):: numeric, 3) AS media_total_vendas

FROM
    (
        SELECT 
        venda_id,
        ROUND(SUM(valor_unitario * quantidade) :: numeric, 2) AS total_vendas
            
        FROM 
            vendas_itens2
        GROUP BY 
            venda_id
        ORDER BY total_vendas
    ) 
    AS vendas_totais;

-- venda com valor Mínimo e MÁXIMO

SELECT 
    ROUND(AVG(total_vendas):: numeric, 3) AS media_total_vendas,
    MIN(total_vendas) AS menor_venda,
    MAX(total_vendas) AS maior_venda

FROM
    (
        SELECT 
        venda_id,
        ROUND(SUM(valor_unitario * quantidade) :: numeric, 2) AS total_vendas
        
        FROM 
            vendas_itens2
        GROUP BY 
            venda_id
        ORDER BY total_vendas
    ) 
    AS vendas_totais;


--venda com valor mínimo e id
SELECT
    venda_id,
    total_vendas
FROM(
    SELECT 
        venda_id,
        ROUND(SUM(valor_unitario * quantidade) :: numeric, 2) AS total_vendas
            
    FROM 
        vendas_itens2
    GROUP BY 
        venda_id
    ORDER BY total_vendas
) AS vendas_totais

WHERE
    total_vendas = (
        SELECT
            MIN(total_vendas)
        FROM(
            SELECT
                venda_id,
                SUM(quantidade * valor_unitario) AS total_vendas
            FROM
                vendas_itens2
            GROUP BY 
                venda_id 
        ) AS menor_venda
    );


-- CTE ( expressão de tabela comum) - compra mínima

WITH VendasTotais AS ( 
    --Calcular o total de cada venda
    SELECT
        venda_id,
        SUM(quantidade * valor_unitario) AS total_vendas
    FROM
        vendas_itens2
    GROUP BY 
        venda_id
)

SELECT 
    venda_id,
    total_vendas
FROM 
    VendasTotais
WHERE 
    total_vendas = (
        SELECT
            MIN(total_vendas)
        FROM VendasTotais
    ) ;


-- media dos valores

SELECT 
    produto_id,
    ROUND((valor_total :: numeric,2)) AS produto_total,
    ROUND((quantidade_total :: numeric,2)) AS produto_total,
    ROUND(valor_total/ NULLIF(quantidade_total,0):: numeric,3) AS valor_medio_por_produto

FROM 
    (
        SELECT
            produto_id,
            SUM(quantidade * valor_unitario) AS valor_total,
            SUM(quantidade) AS quantidade_total
        FROM
            vendas_itens2
        GROUP BY
            produto_id
    ) AS resumo_produtos
ORDER BY 
    produto_id;

