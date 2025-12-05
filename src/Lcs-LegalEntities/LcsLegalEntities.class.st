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
LcsLegalEntities >> contactWithFirstName: aFirstName familyName: aFamilyName [
	^ self persons contactWithFirstName: aFirstName familyName: aFamilyName
]

{ #category : 'querying' }
LcsLegalEntities >> findContactWithFullName: aString [
	^ OrderedCollection new
		addAll: (self persons findWithFullName: aString);
		addAll: (self organizations findWithFullName: aString);
		yourself
]

{ #category : 'querying' }
LcsLegalEntities >> hasContactWithFirstName: aFirstName familyName: aFamilyName [
	^ self persons hasContactWithFirstName: aFirstName familyName: aFamilyName
]

{ #category : 'convenience' }
LcsLegalEntities >> organizations [
	^ self parent organizations
]

{ #category : 'convenience' }
LcsLegalEntities >> persons [
	^ self parent persons
]
