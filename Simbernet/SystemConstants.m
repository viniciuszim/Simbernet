//
//  SystemConstants.m
//  Simbernet
//
//  Created by Rafael Paiva Silva on 11/13/14.
//  Copyright (c) 2014 in6. All rights reserved.
//

#import "SystemConstants.h"

#pragma mark Configuração de Módulo

NSString* const USA_MODULO_DOWNLOADS    = @"S";
NSString* const USA_MODULO_TWITTER      = @"S";

#pragma mark User Defaults

NSString* const UserDefaults_ListaEstados                   = @"UserDefaults_ListaEstados";
NSString* const UserDefaults_ListaCidades                   = @"UserDefaults_ListaCidades";
NSString* const UserDefaults_ListaCategoriasTwitter         = @"UserDefaults_ListaCategoriasTwitter";
NSString* const UserDefaults_ListaUltimosTweets             = @"UserDefaults_ListaUltimosTweets";
NSString* const UserDefaults_DataUltimaAtualizacaoTweets    = @"UserDefaults_DataUltimaAtualizacaoTweets";
NSString* const UserDefaults_DataUltimaAtualizacaoEventos   = @"UserDefaults_DataUltimaAtualizacaoEventos";
NSString* const UserDefaults_DataUltimaAtualizacaoNoticias  = @"UserDefaults_DataUltimaAtualizacaoNoticias";
NSString* const UserDefaults_Institucional                  = @"UserDefaults_Institucional";
NSString* const UserDefaults_ListaTiposDownload             = @"UserDefaults_ListaTiposDownload";


#pragma mark HTTP Variables

NSString* const HTTP_Get = @"GET";
NSString* const HTTP_Post = @"POST";//application/x-www-form-urlencoded
NSString* const HTTP_JSONHeaderFieldValue = @"application/json";
NSString* const HTTP_AcceptHeaderFieldKey = @"accept";
NSString* const HTTP_ContentTypeFiedKey = @"content-type";
NSString* const HTTP_ContentLengthFieldKey = @"content-length";
NSString* const HTTP_PlatformLabel = @"platform";
NSString* const HTTP_Platform = @"IOS";
NSString* const HTTP_AccessTokenLabel = @"accessToken";

NSString* const HTTP_Field_Data = @"data";
NSString* const HTTP_Field_List = @"lista";

NSString* const HTTP_Object_Categoria = @"CategoriaModel";
NSString* const HTTP_Object_Cidade = @"Cidade";
NSString* const HTTP_Object_Comentario = @"Comentario";
NSString* const HTTP_Object_Download = @"DownloadModel";
NSString* const HTTP_Object_DownloadGeneric = @"DownloadGenericModel";
NSString* const HTTP_Object_DownloadTipo = @"DownloadTipoModel";
NSString* const HTTP_Object_DownloadDiretorio = @"DownloadDiretorioArqModel";
NSString* const HTTP_Object_EstadoCivil = @"EstadoCivil";
NSString* const HTTP_Object_Evento = @"EventoModel";
NSString* const HTTP_Object_Noticia = @"Noticia";
NSString* const HTTP_Object_Tweet = @"Tweet2";
NSString* const HTTP_Object_User = @"Usuario";
NSString* const HTTP_Object_Forum = @"ForumModel";
NSString* const HTTP_Object_ForumHistorico = @"ForumHistoricoModel";
NSString* const HTTP_Object_Institucional = @"InstitucionalModel";
NSString* const HTTP_Object_Agenda = @"AgendaModel";

#pragma mark HTTP Messages

NSString* const HTTP_SERVER_ERROR_MESSAGE = @"Oops! Looks like you are not connected to Wifi. Please reconnect and try again.";
NSString* const HTTP_UNKNOWN_ERROR_MESSAGE = @"Oops! Looks like you may not be connected to Wifi. Please reconnect and try again.";
NSString* const HTTP_FAILED_TO_CONNECT_MESSAGE = @"Failed to connect";

#pragma mark Patterns

NSString* const Pattern_NUMERIC = @"0123456789";
NSString* const Pattern_UTC = @"UTC";
NSString* const Pattern_DATE_ISO = @"yyyy-MM-dd'T'HH:mm:ss.SSS zzz";
NSString* const Pattern_DATE_ISO2 = @"dd/MM/yyyy HH:mm:ss.SSS";
NSString* const Pattern_DATE_DDMMYYY_HHMM = @"dd/MM/yyyy HH:mm";
NSString* const Pattern_CPF = @"999.999.999-99";
NSString* const Pattern_CNPJ = @"99.999.999/9999-99";
NSString* const Pattern_PHONE = @"(99)9999-9999";
NSString* const Pattern_CEP = @"99999-999";
NSString* const Pattern_DATE = @"99/99/9999";

#pragma mark Regex

NSString* const Regex_NUMBER_ONLY = @"[0-9]*";
NSString* const Regex_EMAIL_FULL = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
NSString* const Regex_EMAIL_HALF = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
NSString* const Regex_CEP = @"[0-9]{5}-[0-9]{3}";
NSString* const Regex_PHONE = @"[(][0-9]{2}[)][0-9]{4}-[0-9]{4}";
NSString* const Regex_DATE = @"[0-9]{2}/[0-9]{2}/[0-9]{4}";

#pragma mark Paths

NSString* const base_path           = @"repositorio";
NSString* const base_aplicacao      = @"";
NSString* const base_download       = @"download";

#pragma mark URLs

//NSString* const HTTP_WebserviceBase = @"http://www.simber.com.br";
//NSString* const HTTP_WebserviceBase = @"http://localhost:8080/simber";
//NSString* const HTTP_WebserviceBase = @"http://10.1.1.14:8080/simber";
//NSString* const HTTP_WebserviceBase = @"http://192.168.1.86:8080/simber"; // Vinicius

NSString* const HTTP_CidadeURL = @"/Cidade.do";
NSString* const HTTP_ComentarioURL = @"/ComentarioMobile.do";
NSString* const HTTP_DownloadURL = @"/download/mobile/DownloadMobile.do";
NSString* const HTTP_DownloadTipoURL = @"/download/mobile/DownloadTipoMobile.do";
NSString* const HTTP_EstadoCivilURL = @"/EstadoCivil.do";
NSString* const HTTP_EventoURL = @"/evento/mobile/EventoMobile.do";
NSString* const HTTP_LoginURL = @"/LoginMobile.do";
NSString* const HTTP_NoticiaURL = @"/NoticiaMobile.do";
NSString* const HTTP_TwitterCategoriaURL = @"/twitter/mobile/CategoriaMobile.do";
NSString* const HTTP_TwitterURL = @"/twitter/mobile/TwitterMobile.do";
NSString* const HTTP_UserAniversarianteURL = @"/mobile/Aniversariante.do";
NSString* const HTTP_UserURL = @"/Cadastro.do";
NSString* const HTTP_ForumURL = @"/forum/mobile/ForumMobile.do";
NSString* const HTTP_ForumHistoricoURL = @"/forum/mobile/ForumHistoricoMobile.do";
NSString* const HTTP_InstitucionalURL = @"/mobile/Institucional.do";
NSString* const HTTP_AgendaURL = @"/calendario/mobile/Calendario.do";
NSString* const HTTP_DeviceURL = @"/mobile/Device.do";

NSString* const HTTP_Repositorio = @"/repositorio/";
NSString* const HTTP_PathFotosUsuarios = @"fotos_usuarios/";
NSString* const HTTP_PathFotosNoticia = @"noticia/";
NSString* const HTTP_PathFotosEvento = @"eventos/";
NSString* const HTTP_PathFotosForum = @"forum/";

#pragma mark Session Variables

NSString* const Session_UserLogged = @"UserLogged";
NSString* const Session_DeviceTokenUser = @"DeviceTokenUser";

#pragma mark Images

NSString* const ImageCheckboxChecked = @"checkbox_checked";
NSString* const ImageCheckboxUnchecked = @"checkbox_unchecked";

#pragma mark ViewController IDS

NSString* const VCFormEditViewController    = @"FormEditViewController";

NSString* const VCAniversarianteList        = @"AniversarianteListViewController";
NSString* const VCDownload                  = @"DownloadViewController";
NSString* const VCTwitterInserir            = @"TwitterInserirViewControllerID";
NSString* const VCWebView                   = @"WebViewControllerID";

#pragma mark TableViewCell IDS

NSString* const AniversarianteTableViewCellID   = @"AniversarianteTableViewCellID";
NSString* const DownloadTableViewCellID         = @"DownloadTableViewCellID";
NSString* const TwitterTableViewCellID          = @"TwitterTableViewCellID";

#pragma mark Segues

NSString* const SegueEmbedFormEditViewController = @"SegueEmbedFormEditViewController";
NSString* const SegueToImageVisualizeViewController = @"SegueToImageVisualizeViewController";
NSString* const SegueToFormEditHeaderViewController = @"SegueToFormEditHeaderViewController";
NSString* const SegueToFormEditTabViewController = @"SegueToFormEditTabViewController";

NSString* const SEGUE_NOTICIAS_COMMENTS_LIST = @"noticiasToCommentsListSegue";
NSString* const SEGUE_EVENTOS_EVENTO_VISUALIZAR = @"SEGUE_LIST_EVENTOS_TO_EVENTO_VISUALIZAR";
NSString* const SEGUE_FORUNS_FORUM_HISTORICO = @"SEGUE_LIST_FORUNS_TO_FORUM_HISTORICO";
NSString* const SEGUE_AGENDA_COMPROMISSO_DETALHE= @"agendaToDetalhesSegue";
