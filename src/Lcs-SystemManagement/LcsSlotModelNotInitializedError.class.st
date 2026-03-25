Class {
	#name : 'LcsSlotModelNotInitializedError',
	#superclass : 'LcsSlotModelError',
	#category : 'Lcs-SystemManagement-Error',
	#package : 'Lcs-SystemManagement',
	#tag : 'Error'
}

{ #category : 'iniitialize' }
LcsSlotModelNotInitializedError class >> signalWithDomainObjectClass: aDomainObjectClass [ 
	self new
		context: aDomainObjectClass;
		signal: aDomainObjectClass name , ' slot model not initialized'
]

{ #category : 'gt view' }
LcsSlotModelNotInitializedError >> gtDomainClassViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Domain';
		priority: 20;
		object: [ self context ];
		view: #gtMetaFor:
]
