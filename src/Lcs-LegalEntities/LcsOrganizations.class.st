Class {
	#name : 'LcsOrganizations',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-LegalEntities-Core',
	#package : 'Lcs-LegalEntities',
	#tag : 'Core'
}

{ #category : 'querying' }
LcsOrganizations >> findWithFullName: aString [
	self find: [ :each | each fullName = aString ] ifNone: [ ^ OrderedCollection new ]
]
