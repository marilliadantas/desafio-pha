*** Settings ***
Documentation      Desafio PHA - Semana 2   
Library    DateTime

*** Variables ***
&{INFORMACOES}    nome=Saimon Teste    idade=21    numero=85 0000-0000    cep=60410622    bairro=Aldeota    cidade=Fortaleza    estado=CE

*** Test Cases ***
Exercicio dicionario
    Exibir informacoes do usuário

*** Keywords ***
Exibir informacoes do usuário
    Log   Nome: ${INFORMACOES.nome}
    Log   Idade: ${INFORMACOES.idade}
    Log   Número: ${INFORMACOES.numero}
    Log   CEP: ${INFORMACOES.cep}
    Log   Bairro: ${INFORMACOES.bairro}
    Log   Cidade: ${INFORMACOES.cidade}
    Log   Estado: ${INFORMACOES.estado}

*** Test Cases ***
Exercicio Argumentos e Retornos + If
    [Tags]    ExcluirCenario
    Verificar o ano de nascimento    37

*** Keywords ***
Verificar o ano de nascimento
    [Arguments]      ${idade}
    ${ano_atual}=    Get Current Date    result_format=%Y
    ${ano_nascimento}   Evaluate   ${ano_atual} - ${idade}
    
    IF    ${ano_nascimento} < 2000
        Log  Ano de nascimento: ${ano_nascimento}
        Log  Usuário nasceu no século passado.
    ELSE
        Log  Ano de nascimento: ${ano_nascimento}
        Log  Usuário nasceu neste século.
    END

    RETURN    ${ano_nascimento}

*** Test Cases ***
Exercicio For in Range
    Contar numeros pares

*** Keywords ***
Contar numeros pares
   ${numerosPares}=    Set Variable    0
    FOR    ${indice}    IN RANGE    11
        IF    ${indice} % 2 == 0
            ${numerosPares}=    Evaluate    ${numerosPares} + 1
        END
    END
    Log  O número de pares entre 0 e 10 é: ${numerosPares}

*** Variables ***
@{FRUTAS}    Morango    Manga    Abacaxi    Uva    Goiaba    Maçã

*** Test Cases ***
Exercicio For simples + lista
    Exibir as frutas da lista

*** Keywords ***
Exibir as frutas da lista
    FOR      ${listaFrutas}    IN    @{FRUTAS}
        Log  ${listaFrutas}
    END

*** Test Cases ***
Teste - Alterar senha com sucesso
    [Setup]       Criar credenciais de acesso
    Alterar senha
    [Teardown]    Retornar o valor inicial
    
*** Keywords ***
Criar credenciais de acesso
    &{CREDENCIAIS}            Create Dictionary    usuario=Marillia    senha=1234Teste
    Set Test Variable         ${CREDENCIAIS}   
    Log                       Credenciais criadas: ${CREDENCIAIS}
    
Alterar senha  
    Set Test Variable         ${CREDENCIAIS.senha}    senhaAlterada123
    Log                       Senha alterada: ${CREDENCIAIS.senha}

Retornar o valor inicial
    Set Test Variable         ${CREDENCIAIS.senha}    1234Teste 
    Log                       Senha inicial: ${CREDENCIAIS.senha}