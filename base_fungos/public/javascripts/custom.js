
// Função para inicializar componentes da interface:
function init()
{
	
	// Modal do popup de login
	$("#modal_login").dialog({ modal: true, autoOpen: false, width: 420, height: 170 });
	
	$("#login_link").click(function(){
		$("#modal_login").dialog("open");  
	});
	
	$("#login_link_a").click(function(){
		$("#modal_login").dialog("open");  
	});
	
	
	// Transforma os botões da tela em... botões
	$("button").button();
	$("input:submit").button();
	
	
	// Modal da tela de detalhes de um projeto
	$("#modal_projeto").dialog({ modal: true, autoOpen: false });
	
	// Cria os itens da tela de projetos
	$("#proj_items").accordion({
		collapsible: 	true,
		active:			false
	});
}


function back()
{
	window.history.back();
}
