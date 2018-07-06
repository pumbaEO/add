#region BSDLicense

// Copyright (c) 2016, Reshitko Dmitry
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
//    clist of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#endregion

Procedure Connect ( ClearErrors = true, Port = undefined, Computer = undefined ) export
	
	Test.ConnectClient ( ClearErrors, Port, Computer );
	
EndProcedure 

Procedure Подключить ( ClearErrors = true, Port = undefined, Computer = undefined ) export
	
	Connect ( ClearErrors, Port, Computer );
	
EndProcedure 

Procedure Disconnect ( Close = false ) export
	
	Test.DisconnectClient ( Close );
	
EndProcedure 

Procedure Отключить ( Close = false ) export
	
	Disconnect ( Close );
	
EndProcedure 

Procedure CloseAll () export
	
	Test.CheckConnection ();
	Forms.CloseWindows ();
	
EndProcedure 

Procedure ЗакрытьВсе () export
	
	CloseAll ();
	
EndProcedure 

Procedure ЗакрытьВсё () export
	
	CloseAll ();
	
EndProcedure 

Function Get ( Name, Source = undefined, Type = undefined ) export
	
	Test.CheckConnection ();
	return Fields.GetControl ( Name, findSource ( Source ), Type ).Field;
	
EndFunction

Function findSource ( Source )
	
	if ( TypeOf ( Source ) = Type ( "String" ) ) then
		return FindForm ( Source );
	else
		return Source;
	endif; 
	
EndFunction 

Function FindForm ( Name ) export
	
	Test.CheckConnection ();
	return Forms.SearchForm ( Name );
	
EndFunction 

Function НайтиФорму ( Name ) export
	
	return FindForm ( Name );
	
EndFunction 

Function Получить ( Name, Source = undefined, Type = undefined ) export
	
	return Get ( Name, Source, Type );
	
EndFunction

Function Clear ( Name, Source = undefined, Type = undefined ) export
	
	Test.CheckConnection ();
	target = findSource ( Source );
	arrayStrings = StrSplit ( Name, ",", false );
	for each item in arrayStrings do
		data = Fields.ClearControl ( item, target, Type );
	enddo; 
	return data.Field;
	
EndFunction 

Function Очистить ( Name, Source = undefined, Type = undefined ) export
	
	return Clear ( Name, Source, Type );
	
EndFunction 

Function Fetch ( Name, Source = undefined, Type = undefined ) export
	
	Test.CheckConnection ();
	return Fields.FetchValue ( Name, findSource ( Source ), Type );
	
EndFunction

Function Взять ( Name, Source = undefined, Type = undefined ) export
	
	return Fetch ( Name, Source, Type );
	
EndFunction

Function Set ( Name, Value, Source = undefined, Type = undefined ) export
	
	Test.CheckConnection ();
	return Fields.SetValue ( Name, Value, findSource ( Source ), Type );
	
EndFunction 

Function Установить ( Name, Value, Source = undefined, Type = undefined ) export
	
	return Set ( Name, Value, Source, Type );
	
EndFunction 

Function Put ( Name, Value, Source = undefined, Type = undefined, TestValue = false ) export
	
	Test.CheckConnection ();
	return Fields.SetValue ( Name, Value, findSource ( Source ), Type, true, TestValue );
	
EndFunction 

Function Ввести ( Name, Value, Source = undefined, Type = undefined, TestValue = false ) export
	
	return Put ( Name, Value, Source, Type, TestValue );
	
EndFunction 

Procedure Pick ( Name, Value, Source = undefined, Type = undefined ) export
	
	Test.CheckConnection ();
	Fields.Select ( Name, Value, findSource ( Source ), Type );

EndProcedure 

Procedure Подобрать ( Name, Value, Source = undefined, Type = undefined ) export
	
	Pick ( Name, Value, Source, Type );

EndProcedure 

Function Activate ( Name, Source = undefined, Type = undefined ) export
	
	Test.CheckConnection ();
	return Fields.Focus ( Name, findSource ( Source ), Type ).Field;
	
EndFunction

Function Фокус ( Name, Source = undefined, Type = undefined ) export
	
	return Activate ( Name, Source, Type );
	
EndFunction

Function Click ( Name, Source = undefined, Type = undefined ) export
	
	Test.CheckConnection ();
	if ( TypeOf ( Source ) = Type ( "TestedWindowCommandInterface" ) ) then
		field = Fields.Retrieve ( Name, Source, Type ).Field;
	else
		field = Activate ( Name, Source, Type );
	endif; 
	if ( TypeOf ( field ) = Type ( "TestedFormField" )
		and field.Type = FormFieldType.CheckBoxField ) then
		field.SetCheck ();
	else
		field.Click ();
	endif; 
	return field;
	
EndFunction

Function Нажать ( Name, Source = undefined, Type = undefined ) export
	
	return Click ( Name, Source, Type );
	
EndFunction

//Function Call ( Scenario, Params = undefined, Application = undefined ) export
//	
//	return Runtime.Perform ( Scenario, Params, Application, false );
//	
//EndFunction

//Function Вызвать ( Scenario, Params = undefined, Application = undefined ) export
//	
//	return Call ( Scenario, Params, Application );
//	
//EndFunction

//Function Run ( Scenario, Params = undefined, Application = undefined ) export
//	
//	return Runtime.Perform ( Scenario, Params, Application, true );
//	
//EndFunction

//Function Позвать ( Scenario, Params = undefined, Application = undefined ) export
//	
//	return Run ( Scenario, Params, Application );
//	
//EndFunction

Procedure OpenMenu ( Path ) export
	
	Test.CheckConnection ();
	Forms.ClickMenu ( Path );
	
EndProcedure 

Procedure Меню ( Path ) export
	
	OpenMenu ( Path );
	
EndProcedure 

Function With ( Name = undefined, Activate = false ) export
	
	Test.CheckConnection ();
	return Forms.SetCurrent ( Name, Activate );

EndFunction

Function Здесь ( Name = undefined, Activate = false ) export
	
	return With ( Name, Activate );

EndFunction

Function Choose ( Name, Source = undefined, Type = undefined ) export
	
	Test.CheckConnection ();
	return Fields.StartChoosing ( Name, Source, Type );
	
EndFunction

Function Выбрать ( Name, Source = undefined, Type = undefined ) export
	
	return Choose ( Name, Source, Type );
	
EndFunction 

Procedure CheckValue ( Name, Value, Source = undefined, Type = undefined ) export
	
	Test.CheckConnection ();
	Fields.CheckValue ( Name, Value, findSource ( Source ), Type );
	
EndProcedure 

Procedure ПроверитьЗначение( Name, Value, Source = undefined, Type = undefined ) export
	
	CheckValue ( Name, Value, Source, Type );
	
EndProcedure 

Procedure CheckState ( Name, Value, Flag = true, Source = undefined, Type = undefined ) export
	
	Test.CheckConnection ();
	parts = StrSplit ( Name, "," );
	for each part in parts do
		Fields.CheckAppearance ( TrimAll ( part ), Value, Flag, findSource ( Source ), Type );
	enddo; 
		
EndProcedure 

Procedure ПроверитьСтатус ( Name, Value, Flag = true, Source = undefined, Type = undefined ) export
	
	CheckState ( Name, Value, Flag, Source, Type );
		
EndProcedure 

Procedure CheckTemplate ( Name, Source = undefined, Type = undefined, Template = undefined ) export
	
	Test.CheckConnection ();
	Fields.CheckSpreadsheet ( Name, findSource ( Source ), Type, Template );
		
EndProcedure 

Procedure ПроверитьШаблон ( Name, Source = undefined, Type = undefined, Template = undefined ) export
	
	CheckTemplate ( Name, Source, Type, Template );
		
EndProcedure 

Procedure CheckErrors () export
	
	Test.CheckConnection ();
	errors = GetErrors ();
	if ( errors.Count () > 0 ) then
		raise errors [ 0 ];
	endif; 
	
EndProcedure 

Procedure ПроверитьОшибки () export
	
	CheckErrors (); 
	
EndProcedure 

Function GetMessages () export
	
	Test.CheckConnection ();
	return GetErrors ();
	
EndFunction

Function ПолучитьСообщения () export
	
	return GetMessages ();
	
EndFunction

Function FindMessages ( Template ) export
	
	Test.CheckConnection ();
	return FindErrors ( Template );
	
EndFunction

Function НайтиСообщения ( Template ) export
	
	return FindMessages ( Template );
	
EndFunction

Procedure Stop ( Reason = undefined ) export
	
	if ( Reason = undefined ) then
		raise NStr ("en='Scenario stopped';ru='Сценарий остановлен'" );
	else
		raise String ( Reason );
	endif; 
	
EndProcedure 

Procedure Стоп ( Reason = undefined ) export
	
	Stop ( Reason );
	
EndProcedure 

Procedure Close ( Form = undefined ) export
	
	Test.CheckConnection ();
	target = Forms.GetFrame ( Form );
	target.Close ();
	
EndProcedure 

Procedure Закрыть ( Form = undefined ) export
	
	Close ( Form );
	
EndProcedure 

Function Waiting ( Name, Timeout = 3, Type = undefined ) export
	
	Test.CheckConnection ();
	return Forms.Wait ( Name, Timeout, Type );
	
EndFunction 

Function Дождаться ( Name, Timeout = 3, Type = undefined ) export
	
	return Waiting ( Name, Timeout, Type );
	
EndFunction 

Function GetWindow ( Form = undefined ) export
	
	Test.CheckConnection ();
	return Forms.GetFrame ( Form );
	
EndFunction 

Function ПолучитьОкно ( Form = undefined ) export
	
	return GetWindow ( Form );
	
EndFunction 

Function GetLinks ( Form = undefined ) export
	
	Test.CheckConnection ();
	return Forms.GetFrame ( Form ).GetCommandInterface ();
	
EndFunction 

Function ПолучитьСсылки ( Form = undefined ) export
	
	return GetLinks ( Form );
	
EndFunction 

Procedure Pause ( Seconds ) export
	
	start = CurrentDate () + Seconds;
	while ( true ) do
		if ( CurrentDate () > start ) then
			break;
		endif; 
	enddo; 

EndProcedure

Procedure Пауза1 ( Seconds ) export
	
	Pause ( Seconds ); 

EndProcedure

Function CurrentTab ( Name, Source = undefined, Type = undefined ) export
	
	Test.CheckConnection ();
	tab = Fields.GetControl ( Name, findSource ( Source ), Type ).Field;
	return tab.GetCurrentPage ();
	
EndFunction

Function ТекущаяВкладка ( Name, Source = undefined, Type = undefined ) export
	
	return CurrentTab ( Name, Source, Type );
	
EndFunction

Procedure Next () export
	
	Test.CheckConnection ();
	Fields.NextField ();
	
EndProcedure 

Procedure Далее () export
	
	Next ();
	
EndProcedure 
         
Function GotoRow ( Table, Column, Value, FromStart = true, Source = undefined ) export
	
	Test.CheckConnection ();
	if ( TypeOf ( Table ) = Type ( "TestedFormTable" ) ) then
		target = Table;
	else
		target = Fields.GetControl ( Table, findSource ( Source ), "Table" ).Field;
	endif; 
	if ( FromStart ) then
		try
			// This navigation is "just in case".
			// We do not care if first row is aready activated
			target.GotoFirstRow ( false );
		except
		endtry;
	endif; 
	search = new Map ();
	search [ Column ] = Value;
	try
		return target.GotoRow ( search );
	except
		error = ErrorDescription ();
	endtry; 
	tableIsEmpty = target.FindObject ( , Column ) <> undefined;
	if ( tableIsEmpty ) then
		return false;
	else
		raise error;
	endif; 
	
EndFunction
         
Function КСтроке ( Table, Column, Value, FromStart = true, Source = undefined ) export
	
	return GotoRow ( Table, Column, Value, FromStart, Source );
	
EndFunction

Procedure Commando ( Action ) export
	
	Test.CheckConnection ();
	Forms.DoCommand ( Action );
	
EndProcedure 

Procedure Коммандос ( Action ) export
	
	Commando ( Action );
	
EndProcedure 

Procedure LogError ( Text ) export
	
	raise "Not implemeted";
	//Runtime.WriteError ( Text );
	
EndProcedure 

Procedure ЗаписатьОшибку ( Text ) export
	
	LogError ( Text );
	
EndProcedure 

//Function MyVersion ( Expression ) export
//	
//	return TestSrv.Version ( Expression );
//	
//EndFunction 

//Function МояВерсия ( Expression ) export
//	
//	return MyVersion ( Expression );
//	
//EndFunction 

//Procedure DebugStart () export
//	
//	Debugger.Toggle ( true );
//	
//EndProcedure 

//Procedure ОтладкаСтарт () export
//	
//	DebugStart ();
//	
//EndProcedure 

//Function EnvironmentExists ( ID ) export
//	
//	return Environment.FindByID ( ID );
//	
//EndFunction 

//Function СозданоОкружение ( ID ) export
//	
//	return EnvironmentExists ( ID );
//	
//EndFunction 

//Procedure RegisterEnvironment ( ID ) export
//	
//	Environment.Register ( ID );
//	
//EndProcedure 

//Procedure СохранитьОкружение ( ID ) export
//	
//	RegisterEnvironment ( ID );
//	
//EndProcedure 

Function Screenshot ( Pattern = "", Compressed = undefined ) export
	
	return Forms.Shoot ( Pattern, Compressed );
	
EndFunction 

Function Снимок ( Pattern = "", Compressed = undefined ) export
	
	return Screenshot ( Pattern, Compressed );
	
EndFunction 

//Procedure VStudio ( Text ) export
//	
//	Forms.BroadcastMessage ( Text );
//	
//EndProcedure

//Procedure ВСтудию ( Text ) export
//	
//	VStudio ( Text );
//	
//EndProcedure

//Procedure PinApplication ( Name ) export
//	
//	Environment.ChangeApplication ( Name );
//	
//EndProcedure

//Procedure УстановитьПриложение ( Name ) export
//	
//	PinApplication ( Name );
//	
//EndProcedure

Function GetErrors () export
	App = undefined;	
	try
		errors = App.GetActiveWindow ().GetUserMessageTexts ();
	except
		errors = new Array ();
	endtry;
	if ( errors.Count () = 0 ) then
		form = Forms.Get1C ();
		if ( form <> undefined ) then
			type = Type ( "TestedFormField" );
			label = form.FindObject ( type, , "Field1" );
			if ( label = undefined ) then
				label = form.FindObject ( type, , "Поле1" );
			endif; 
			if ( label <> undefined ) then
				errors.Add ( label.TitleText );
			endif; 
		endif; 
	endif; 
	return errors;
	
EndFunction

Function FindErrors ( Template ) export
	
	raise "Not implement";
	
	result = new Array ();
	messages = GetErrors ();
	if ( messages.Count () > 0 ) then
		//result = RuntimeSrv.FindErrors ( Template, messages );
	endif; 
	return result;
	
EndFunction

