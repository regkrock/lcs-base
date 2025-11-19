Class {
	#name : 'LcsMAStringReader',
	#superclass : 'MAStringReader',
	#category : 'LcsBase-Visitor',
	#package : 'LcsBase',
	#tag : 'Visitor'
}

{ #category : 'visiting-description' }
LcsMAStringReader >> visitBlockDescription: aDescription [
	self object: (Smalltalk compiler evaluate: '[ :domainObject :slot | ', self contents)
]
