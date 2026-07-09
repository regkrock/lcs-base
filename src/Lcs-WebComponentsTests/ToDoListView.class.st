Class {
	#name : 'ToDoListView',
	#superclass : 'WAComponent',
	#instVars : [
		'editor',
		'visible'
	],
	#category : 'Lcs-WebComponentsTests-ToDoList',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'ToDoList'
}

{ #category : 'initialize' }
ToDoListView class >> initialize [
	"self initialize"
	| application |
	application := WAAdmin register: self asApplicationAt: 'todo'.
	application preferenceAt: #scriptGeneratorClass put: JQScriptGenerator.
	application 
		addLibrary: JQDeploymentLibrary";
		addLibrary: JQAllFunctionalTestsLibrary".
]

{ #category : 'rendering' }
ToDoListView >> add [
	editor := ToDoItemView new model: ToDoItem new.
	editor onAnswer: [ : value |
		value notNil ifTrue: [ self model add: value ].
		editor := nil ]
]

{ #category : 'as yet unclassified' }
ToDoListView >> children [
	^ Array with: editor
]

{ #category : 'rendering' }
ToDoListView >> edit: anItem [ 
	"self inform: anItem title"
	| edited |
	edited := self call: (ToDoItemView new model: anItem).
	edited notNil ifTrue: [ self model replace: anItem with: edited ]
]

{ #category : 'initialize' }
ToDoListView >> initialize [
	super initialize.
	visible := false.
]

{ #category : 'model' }
ToDoListView >> model [
	^ ToDoList default
]

{ #category : 'rendering' }
ToDoListView >> remove: anItem [ 
	(self confirm: 'Are you sure you want to remove ' , anItem title printString , '?')
		ifTrue: [ self model remove: anItem ]
]

{ #category : 'rendering' }
ToDoListView >> renderContentOn: html [
	self renderHeadingOn: html.
	html
		form: [ html unorderedList: [ self renderItemsOn: html ].
			html submitButton text: 'Save'.
			html submitButton
				callback: [ self add ];
				text: 'Add' ].
	html render: editor
]

{ #category : 'rendering' }
ToDoListView >> renderHeadingOn: html [
	| helpId |
	helpId := html nextId.
	html heading
		class: 'helplink';
		onClick: ((html jQuery id: helpId) slideToggle: 1 seconds callback: [ visible := visible not ]);
		with: self model title.
	html div
		id: helpId;
		class: 'help';
		style: (visible ifFalse: [ 'display: none' ]);
		with: 'The todo application from the Seaside book'
]

{ #category : 'rendering' }
ToDoListView >> renderItem: anItem on: html [ 
	html listItem
		passenger: anItem;
		class: 'done' if: anItem isDone;
		class: 'overdue' if: anItem isOverdue;
		with: [ 
			html checkbox
				value: anItem done;
				callback: [ :value | anItem done: value ].
			html text: anItem title.
			html space.
			html anchor 
				callback: [ self edit: anItem ];
				with: 'edit'.
			html space.
			html anchor 
				callback: [ self remove: anItem ];
				with: 'remove' ]
]

{ #category : 'rendering' }
ToDoListView >> renderItemsOn: html [ 
	self model items do: [ :each |
		self renderItem: each on: html ]
]

{ #category : 'css' }
ToDoListView >> style [
	^ '
.help {
	padding: 1em;
	margin-bottom: 1em;
	border: 1px solid #008aff;
	background-color: #e6f4ff;
	}
.helplink {
	cursor: help;
	}
body {
	color: #222;
	font-size: 75%;
	font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
	}
h1 {
	color: #111;
	font-size: 2em;
	font-weight: normal;
	margin-bottom: 0.5em
	}
ul {
	list-style: none;
	padding-left: 0;
	margin-bottom: 1em;
	}
li.overdue {
	color: #8a1f11;
	}
li.done {
	color: #264409;
	}
'
]
