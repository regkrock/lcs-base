Class {
	#name : 'LcsEmailAddresses',
	#superclass : 'LcsDomainCollection',
	#category : 'Lcs-LegalEntities',
	#package : 'Lcs-LegalEntities'
}

{ #category : 'default instance' }
LcsEmailAddresses >> defaultInstance [
	^ self currentSystem legalEntitiesModule configuration unknownEmailAddress
]

{ #category : 'querying' }
LcsEmailAddresses >> findItemMatchingAddressType: anObject [
	| result |
	anObject isString ifFalse: [ ^ anObject ].
	result := self collection
			detect: [ :each | each emailAddressType code = anObject ]
			ifNone: [ nil ].
	result ifNotNil: [ ^ result ].
	^ self pendingAdds
			detect: [ :each | each emailAddressType code = anObject ]
			ifNone: [ self defaultInstance ]
]
