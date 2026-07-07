Class {
	#name : 'ToDoItemView',
	#superclass : 'WAComponent',
	#instVars : [
		'model'
	],
	#category : 'Lcs-WebComponentsTests-ToDoList',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'ToDoList'
}

{ #category : 'accessing' }
ToDoItemView >> model [
	^ model
]

{ #category : 'accessing' }
ToDoItemView >> model: anObject [
	model := anObject
]

{ #category : 'rendering' }
ToDoItemView >> renderContentOn: html [
	html heading: 'Edit'.
	html form: [
		html text: 'Title:'; break.
		html textInput
			value: self model title;
			callback: [ :value | self model title: value ].
		html break; text: 'Due:'; break.
		html dateInput
			value: self model due;
			callback: [ :value | self model due: value ].
		html break.
		"html dateInput
			value: self model due;
			callback: [ :value | self model due: value ].
		html break."
		html submitButton
			callback: [ self answer: self model ];
			text: 'Save'.
		html submitButton
			callback: [ self answer: nil ];
			text: 'Cancel'.
		]
]

{ #category : 'as yet unclassified' }
ToDoItemView >> style [
	^ '
body {
	color: #222;
	font-size: 75%;
	font-family: "Helvetical Neue", Helvetical, Arial, sans-serif;
	}
h1 {
	color: #111;
	font-size: 2em;
	font-weight: normal;
	margin-bottom: 0.5em;
	}'
]
