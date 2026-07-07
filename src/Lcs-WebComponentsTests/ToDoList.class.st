Class {
	#name : 'ToDoList',
	#superclass : 'Object',
	#instVars : [
		'title',
		'items'
	],
	#classInstVars : [
		'Default'
	],
	#category : 'Lcs-WebComponentsTests-ToDoList',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'ToDoList'
}

{ #category : 'initialize' }
ToDoList class >> default [
	^ Default ifNil: [ Default := self new ] 
]

{ #category : 'initialize' }
ToDoList class >> intializeExamples [
	"self intializeExamples. self default"
	self default
		title: 'Seaside ToDo';
		add: (ToDoItem new
			title: 'Finish todo app chapter';
			due: '04/21/2008' asDate;
			done: true);
		add: (ToDoItem new
			title: 'Annotate first chapter';
			due: '04/21/2027' asDate;
			done: true);
		add: (ToDoItem new
			title: 'Watch out for UNIX Millenium bug';
			due: '01/19/2038' asDate;
			done: true)

]

{ #category : 'initialize' }
ToDoList class >> reset [
	Default := nil
]

{ #category : 'items' }
ToDoList >> add: anItem [
	self items add: anItem
]

{ #category : 'initialize' }
ToDoList >> initialize [
	super initialize.
	self items: OrderedCollection new.
	self title: 'To DO List'
]

{ #category : 'accessing' }
ToDoList >> items [
	^ items
]

{ #category : 'accessing' }
ToDoList >> items: anObject [
	items := anObject
]

{ #category : 'items' }
ToDoList >> remove: anItem [
	self items remove: anItem
]

{ #category : 'items' }
ToDoList >> replace: anItem with: anotherItem [
	self items at: (self items indexOf: anItem) put: anotherItem
]

{ #category : 'accessing' }
ToDoList >> title [
	^ title
]

{ #category : 'accessing' }
ToDoList >> title: anObject [
	title := anObject
]
