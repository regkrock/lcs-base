Class {
	#name : #LcsBaseUser,
	#superclass : #LcsDomainObject,
	#category : #'Lcs-Security-Core'
}

{ #category : #'slot definitions' }
LcsBaseUser class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
		slotName: 'parent';
		collectionSlotModuleName: LcsSecurityModule defaultModuleName;
		collectionSlotName: 'users';
		addSlotType: LcsUsers;
		yourself 
]
