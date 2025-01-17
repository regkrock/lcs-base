Class {
	#name : #LcsSlotModelNotInitializedError,
	#superclass : #LcsError,
	#instVars : [
		'context'
	],
	#category : #'Lcs-SlotDefinitions'
}

{ #category : #iniitialize }
LcsSlotModelNotInitializedError class >> signalWithContext: anObject [ 
	self new
		context: anObject;
		signal: 'Slot model not initialized for ' , anObject className
]

{ #category : #'as yet unclassified' }
LcsSlotModelNotInitializedError >> context [
	^ context
]

{ #category : #iniitialize }
LcsSlotModelNotInitializedError >> context: anObject [ 
	context := anObject
]

{ #category : #'gt view' }
LcsSlotModelNotInitializedError >> gtCurrentSystemViewFor: aView [
	<gtView>
	<gtExceptionView>
	self currentSystem ifNil: [ 
		^ aView list
			title: 'No Current System';
			priority: 20;
			items: [ {'No current system'} ]; 
			yourself].
	^ aView forward
		title: 'Current System';
		priority: 20;
		object: [ self currentSystem ];
		view: #gtMetaFor:
]

{ #category : #'gt view' }
LcsSlotModelNotInitializedError >> gtDomainClassViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Domain';
		priority: 20;
		object: [ self context ];
		view: #gtMetaFor:
]
