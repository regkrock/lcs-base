Class {
	#name : 'LcsNoSystemError',
	#superclass : 'LcsSystemError',
	#category : 'LcsBase-Error',
	#package : 'LcsBase',
	#tag : 'Error'
}

{ #category : 'initialize' }
LcsNoSystemError >> initialize [
	super initialize.
	self messageText: 'No running system'
]
