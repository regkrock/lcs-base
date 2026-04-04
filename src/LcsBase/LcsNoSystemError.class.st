Class {
	#name : 'LcsNoSystemError',
	#superclass : 'LcsError',
	#category : 'LcsBase-Error',
	#package : 'LcsBase',
	#tag : 'Error'
}

{ #category : 'initialize' }
LcsNoSystemError >> initialize [
	super initialize.
	self messageText: 'No running system'
]
