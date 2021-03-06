Dado('que acesso o cadastro de usuário') do
    @cadastro_page = CadastroPage.new
    @cadastro_page.load
end
  
Dado('preencho os campos do formulário com dados válidos de pessoa física') do
    cadastro_page.preencher_form_com_dados_validos_fixos_pf
end
  
Quando('confirmo o cadastro') do
    @cadastro_page.clicar_finalizar
end
  
Então('o sistema deve exibir a mensagem de boas vindas') do
    @cadastro_page.wait_until_msg_sucesso_visible
    expect(@cadastro_page).to have_content 'Cadastro efetuado com sucesso. Obrigado!'
end

Dado('preencho os campos do formulário com dados válidos de um novo usuário pessoa física') do
    @cadastro_page.preencher_form_com_dados_aleatorios_pf
end

Dado("eu preencha os campos com {string},{string},{string},{string},{string},{string}") do |nome, sobrenome, email, celular, tipo_de_conta, documento|
    @cadastro_page.preencher_form_com_dados_informados(nome, sobrenome, email, celular, tipo_de_conta, documento)
end
  
Então("o sistema deve exibir a mensagem de confirmação {string}") do |msgsucesso|
    expect(@cadastro_page).to have_content msgsucesso
end

Então("deve exibir no topo do formulário a mensagem de erro {string}") do |msg_falha|
    expect(@cadastro_page).to have_content msg_falha
end
  
Então("deve exibir no campo a mensagem de erro {string}") do |msg_falha_campo|
    expect(@cadastro_page).to have_content msg_falha_campo
end
  
E("permanecer na página de cadastro") do
    expect(@cadastro_page).to have_current_path '/qarentena/cadastro/'
end

Dado("eu informe os campos {string},{string},{string},{string},{string},{string} conforme arquivo") do |nome, sobrenome, email, telefone, tipo_de_conta, documento|
    @cadastro_page.preencher_form_com_dados_informados(
      UserData.get(nome),
      UserData.get(sobrenome),
      UserData.get(email),
      UserData.get(telefone),
      UserData.get(tipo_de_conta),
      UserData.get(documento)
    )
end
