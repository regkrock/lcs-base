Class {
	#name : 'LcsSystemError',
	#superclass : 'LcsError',
	#category : 'LcsBase-Error',
	#package : 'LcsBase',
	#tag : 'Error'
}

{ #category : 'gt views' }
LcsSystemError >> gtCurrentSystemViewFor: aView [
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
