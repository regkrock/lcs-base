Class {
	#name : 'LcsStateMachineViewItem',
	#superclass : 'LcsViewItem',
	#instVars : [
		'context',
		'displaySelector'
	],
	#category : 'Lcs-StateMachine-GT View',
	#package : 'Lcs-StateMachine',
	#tag : 'GT View'
}

{ #category : 'constants' }
LcsStateMachineViewItem class >> defaultChildrenSelector [
	^ #stateMachineViewChildren
]

{ #category : 'instance creation' }
LcsStateMachineViewItem class >> newOn: anObject label: aLabel item: anItem [ 
	^ self new
		initializeOn: anObject label: aLabel item: anItem;
		yourself
]

{ #category : 'instance creation' }
LcsStateMachineViewItem class >> newOn: anObject label: aLabel item: anItem displaySelector: aSelector [
	^ self new
		initializeOn: anObject label: aLabel item: anItem displaySelector: aSelector;
		yourself
]

{ #category : 'accessing' }
LcsStateMachineViewItem >> context [
	^ context
]

{ #category : 'accessing' }
LcsStateMachineViewItem >> context: anObject [ 
	context := anObject
]

{ #category : 'accessing' }
LcsStateMachineViewItem >> displaySelector [
	^ displaySelector
]

{ #category : 'initialize' }
LcsStateMachineViewItem >> displaySelector: aSelector [ 
	displaySelector := aSelector asSymbol
]

{ #category : 'initialize' }
LcsStateMachineViewItem >> initializeOn: anObject label: aLabel item: anItem [
	self
		context: anObject;
		label: aLabel;
		item: anItem
]

{ #category : 'initialize' }
LcsStateMachineViewItem >> initializeOn: anObject label: aLabel item: anItem displaySelector: aSelector [
	self
		context: anObject;
		label: aLabel;
		item: anItem;
		displaySelector: aSelector
]

{ #category : 'accessing' }
LcsStateMachineViewItem >> itemDisplay [
	self item isNil ifTrue: [ ^self item ].
	^ self displaySelector isNil 
		ifTrue: [ self item ] 
		ifFalse: [ self item perform: self displaySelector ]
]
