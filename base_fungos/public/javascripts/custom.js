
// Função para inicializar componentes da interface:
function init()
{

  // Modal do popup de login
  $("#modal_login").dialog({ modal: true, autoOpen: false, width: 300, height: 140 });
  
  $("#login_link").click(function(){
    $("#modal_login").dialog("open");  
  });
  
  
  // Modal da tela de detalhes de um projeto
  $("#modal_projeto").dialog({ modal: true, autoOpen: false });
  
  // Transforma os botões da tela em... botões
  $("button").button();
  $("input:submit").button();
}


function back()
{
  window.history.back();
}
