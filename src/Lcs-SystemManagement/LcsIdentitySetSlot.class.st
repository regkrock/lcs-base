Class {
	#name : 'LcsIdentitySetSlot',
	#superclass : 'LcsCollectionSlot',
	#category : 'Lcs-SystemManagement-Slot',
	#package : 'Lcs-SystemManagement',
	#tag : 'Slot'
}

{ #category : 'slot model' }
LcsIdentitySetSlot >> add: aDomainObject to: aDomainCollection [
	"self verifyCanAdd: anObject."
	aDomainObject parent ifNil: [ aDomainObject parent: aDomainCollection ].
	self currentUnitOfWork addPendingAddOf: aDomainObject to: aDomainCollection.
	self dependentCollections do: [ :each |
		each add: aDomainObject to: aDomainCollection ].
	^ aDomainObject
	
	
]

{ #category : 'configuration' }
LcsIdentitySetSlot >> typeClass [
	^ IdentitySet 
]
