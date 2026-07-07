Class {
	#name : 'ToDoItem',
	#superclass : 'Object',
	#instVars : [
		'title',
		'due',
		'done'
	],
	#category : 'Lcs-WebComponentsTests-ToDoList',
	#package : 'Lcs-WebComponentsTests',
	#tag : 'ToDoList'
}

{ #category : 'accessing' }
ToDoItem >> done [
	^ done
]

{ #category : 'accessing' }
ToDoItem >> done: anObject [
	done := anObject
]

{ #category : 'accessing' }
ToDoItem >> due [
	^ due
]

{ #category : 'accessing' }
ToDoItem >> due: anObject [
	due := anObject
]

{ #category : 'initialize' }
ToDoItem >> initialize [
	super initialize.
	self title: 'ToDo Item'.
	self due: Date tomorrow.
	self done: false
]

{ #category : 'testing' }
ToDoItem >> isDone [
	^ self done
]

{ #category : 'testing' }
ToDoItem >> isOverdue [
	^ self done not and: [ Date today > self due ]
]

{ #category : 'accessing' }
ToDoItem >> title [
	^ title
]

{ #category : 'accessing' }
ToDoItem >> title: anObject [
	title := anObject
]
