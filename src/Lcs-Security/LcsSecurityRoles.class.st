Class {
	#name : 'LcsSecurityRoles',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-Security-Core',
	#package : 'Lcs-Security',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
LcsSecurityRoles >> defaultInstance [
	^ self 
		find: [ :each | each role = 'guest' ] 
		ifNone: [ LcsError signal: 'No default item defined for ', self printString]
]
