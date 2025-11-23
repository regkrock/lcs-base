Class {
	#name : 'LcsLegalEntities',
	#superclass : 'LcsVirtualDomainCollection',
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'querying' }
LcsLegalEntities >> collectionSize [
	^ self parent persons collectionSize + self parent organizations collectionSize
]

{ #category : 'querying' }
LcsLegalEntities >> contactWithFirstName: aFirstName surname: aSurname [
	^ self persons contactWithFirstName: aFirstName surname: aSurname
]

{ #category : 'querying' }
LcsLegalEntities >> findContactWithFullName: aString [
	^ OrderedCollection new
		addAll: (self persons findWithFullName: aString);
		addAll: (self organizations findWithFullName: aString);
		yourself
]

{ #category : 'querying' }
LcsLegalEntities >> hasContactWithFirstName: aFirstName surname: aSurname [
	^ self persons hasContactWithFirstName: aFirstName surname: aSurname
]

{ #category : 'convenience' }
LcsLegalEntities >> organizations [
	^ self parent organizations
]

{ #category : 'convenience' }
LcsLegalEntities >> persons [
	^ self parent persons
]
