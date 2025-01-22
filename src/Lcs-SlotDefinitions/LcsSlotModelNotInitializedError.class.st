Class {
	#name : #LcsSlotModelNotInitializedError,
	#superclass : #LcsSlotModelError,
	#category : #'Lcs-SlotDefinitions-Error'
}

{ #category : #iniitialize }
LcsSlotModelNotInitializedError class >> signalWithContext: anObject [ 
	self new
		context: anObject;
		signal: 'Slot model not initialized for ' , anObject className
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
