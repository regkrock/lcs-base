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
LcsLegalEntities >> findContactWithFullName: aString [
	^ OrderedCollection new
			addAll: (self parent persons findWithFullName: aString);
			addAll: (self parent organizations findWithFullName: aString);
			yourself
	
]
