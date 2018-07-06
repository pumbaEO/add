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

Procedure CloseWindows () export
	
	var windows;
	
	again = false;
	while ( true ) do
		if ( again ) then
			if ( thesame ( windows ) ) then
				break;
			else
				clickNo ();
			endif; 
		endif; 
		windows = App.GetChildObjects ();
		for each window in windows do
			if ( standard ( window ) ) then
				continue;
			endif;
			tryClose ( window );
		enddo;
		if ( closingComplete ( windows ) ) then
			break;
		endif; 
		again = true;
	enddo; 
	CurrentSource = undefined;
	ТекущийОбъект = undefined;
	
EndProcedure 

Function thesame ( Windows )
	
	currentWindows = App.GetChildObjects ();
	if ( currentWindows.Count () <> Windows.Count () ) then
		return false;
	endif; 
	for each window in currentWindows do
		if ( Windows.Find ( window ) = undefined ) then
			return false;
		endif;
	enddo;
	return true;
	
EndFunction

Procedure clickNo ()
	
	fieldType = Type ( "TestedFormField" );
	labels = App.FindObjects ( fieldType, "*Сохранить изменения?" );
	if ( labels.Count () = 0 ) then
		labels = App.FindObjects ( fieldType, "*Do you want*?" );
	endif; 
	buttonType = Type ( "TestedFormButton");
	for each label in labels do
		dialog = label.GetParent ();
		button = dialog.FindObject ( buttonType, "Нет" );
		if ( button = undefined ) then
			button = dialog.FindObject ( buttonType, "No" );
		endif; 
		if ( button = undefined ) then
			continue;
		endif;
		button.Click ();
	enddo; 
	
EndProcedure 

Function standard ( Window )
	
	return Window.IsMain
	or Window.HomePage;
	
EndFunction 

Procedure tryClose ( Window )
	
	closeWindow ( Window );
	stillHere = App.GetChildObjects ().Find ( Window ) <> undefined;
	if ( stillHere ) then
		if ( cancelInput ( window ) ) then
			closeWindow ( Window );
		endif; 
	endif; 
	
EndProcedure 

Procedure closeWindow ( Window )
	
	try
		Window.Close ();
	except
	endtry;
	
EndProcedure 

Function cancelInput ( Window )
	
	try
		input = Window.GetObject ().GetCurrentItem ();
	except
		return false;
	endtry;
	type = TypeOf ( input );
	if ( type = Type ( "TestedFormField" ) ) then
		if ( input.Type = FormFieldType.InputField ) then
			try // Form could be locked by another Dialog
				input.CancelEdit ();
				return true;
			except
			endtry;
		endif; 
	elsif ( type = Type ( "TestedFormTable" ) ) then
		try // Form could be locked by another Dialog
			if ( input.CurrentModeIsEdit () ) then
				input.EndEditRow ( true );
				return true;
			endif; 
		except
		endtry;
	endif; 
	return false;
	
EndFunction

Function closingComplete ( Windows )
	
	currentWindows = new Array ( App.GetChildObjects () );
	if ( currentWindows.Count () > Windows.Count () ) then
		return false;
	endif; 
	oldWindows = new Array ( Windows );
	i = oldWindows.UBound ();
	while ( i >= 0 ) do
		window = oldWindows [ i ];
		if ( standard ( window )
			or currentWindows.Find ( window ) = undefined ) then
			oldWindows.Delete ( i );
		endif;
		i = i - 1;
	enddo; 
	if ( oldWindows.Count () > 0 ) then
		return false;
	endif; 
	for each window in currentWindows do
		if ( not standard ( window ) ) then
			return false;
		endif; 
	enddo; 
	return true;
	
EndFunction 

Function Get1C ( TimeOut = 0 ) export

	formType = Type ( "TestedForm" );
	try
		form = App.GetObject ( formType, "1?:*", , TimeOut );
	except
		form = undefined;
	endtry;
	return form;
	
EndFunction 

Function SetCurrent ( Source, Activate ) export
	
	target = ? ( Source = undefined, App.GetActiveWindow ().Caption, Source );
	if ( TypeOf ( target ) = Type ( "String" ) ) then
		window = App.FindObject ( Type ( "TestedClientApplicationWindow" ), target );
		if ( window = undefined ) then
			CurrentSource = App.FindObject ( Type ( "TestedForm" ), target );
			if ( CurrentSource = undefined ) then
				raise Output.SourceNotFound ();
			endif; 
		else
			CurrentSource = window.GetObject ();
		endif; 
	else
		CurrentSource = target;
	endif; 
	ТекущийОбъект = CurrentSource;
	if ( Activate
		and TypeOf ( CurrentSource ) = Type ( "TestedForm" ) ) then
		CurrentSource.Activate ();
	endif; 
	return CurrentSource;
	
EndFunction

Procedure ClickMenu ( Path ) export
	
	points = StrSplit ( Path, "/" );
	level = points.Count ();
	section = TrimAll ( points [ 0 ] );
	commands = MainWindow.GetCommandInterface ();
	buttonType = Type ( "TestedCommandInterfaceButton" );
	menu = commands.GetObject ( buttonType, section );
	menu.Click ();
	if ( level = 2 ) then
		button = TrimAll ( points [ 1 ] );
		link = commands.GetObject ( buttonType, button );
		link.Click ();
	endif; 

EndProcedure 

Function GetFrame ( Form = undefined ) export
	
	windowType = Type ( "TestedClientApplicationWindow" );
	if ( Form = undefined ) then
		target = CurrentSource;
	else
		if ( TypeOf ( Form ) = Type ( "String" ) ) then
			target = App.GetObject ( windowType, Form, , 3 ).GetObject ();
		else
			target = Form;
		endif; 
	endif; 
	if ( TypeOf ( target ) = windowType ) then
		return target;
	endif; 
	windows = App.GetChildObjects ();
	list = new Array ();
	for each window in windows do
		if ( window.IsMain ) then
			continue;
		endif;
		object = window.GetObject ();
		if ( target = object ) then
			return window;
		endif;
		list.Add ( new Structure ( "Window, Name", window, object.FormName ) );
	enddo;
	target = target.FormName;
	for each item in list do
		if ( target = item.Name ) then
			return item.window;
		endif;
	enddo;
	return undefined;
	
EndFunction

Function SearchForm ( Name ) export
	
	window = App.FindObject ( Type ( "TestedClientApplicationWindow" ), Name );
	if ( window = undefined ) then
		return App.GetObject ( Type ( "TestedForm" ), Name );
	else
		return window.GetObject ();
	endif; 
	
EndFunction 

Function Wait ( Name, Timeout, Type ) export
	
	target = ? ( Type = undefined, Type ( "TestedForm" ), Type );
	sign = Left ( Name, 1 );
	if ( sign = "#"
		or sign = "!" ) then
		id = Mid ( Name, 2 );
		title = undefined;
	else
		title = Name;
		id = undefined;
	endif;
	return App.WaitForObjectDisplayed ( target, title, id, Timeout );
	
EndFunction 

Procedure DoCommand ( Action ) export
	
	MainWindow.ExecuteCommand ( Action );
	
EndProcedure 

Function Shoot ( Pattern, Compressed ) export
	
	//if ( ExternalLibrary = undefined ) then
	//	return undefined;
	//else
	//	title = ? ( Pattern = "", ScreenshotsLocator, Pattern );
	//	if ( title = "" ) then
	//		return undefined;
	//	else
	//		quality = ? ( Compressed = undefined, ScreenshotsCompressed, Compressed );
	//		return ExternalLibrary.Shoot ( title, quality );
	//	endif; 
	//endif; 
	
EndFunction 

Procedure BroadcastMessage ( Text ) export
	
	Message ( Text );
	//if ( TesterServerMode ) then
	//	Watcher.AddMessage ( Text, Enum.MessageTypesHint () );
	//endif;
	
EndProcedure
