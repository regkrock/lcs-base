Class {
	#name : 'LcsUnitOfWorkAddObjectError',
	#superclass : 'LcsSystemError',
	#instVars : [
		'newObject'
	],
	#category : 'LcsBase-Error',
	#package : 'LcsBase',
	#tag : 'Error'
}

{ #category : 'gtviews' }
LcsUnitOfWorkAddObjectError >> gtCurrentSystemViewFor: aView [
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

{ #category : 'gtviews' }
LcsUnitOfWorkAddObjectError >> gtDomainObjectViewFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Domain Class';
		priority: 10;
		object: [ self newObject ];
		view: #gtMetaFor:
]

{ #category : 'gtviews' }
LcsUnitOfWorkAddObjectError >> gtLiveFor: aView [
	<gtView>
	<gtExceptionView>
	^ aView forward
		title: 'Live';
		priority: 5;
		object: [ self newObject ];
		view: #gtLiveFor:
]

{ #category : 'accessing' }
LcsUnitOfWorkAddObjectError >> newObject [
	^ newObject
]

{ #category : 'accessing' }
LcsUnitOfWorkAddObjectError >> newObject: anObject [
	newObject := anObject
]
