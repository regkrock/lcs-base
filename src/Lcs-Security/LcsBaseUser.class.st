Class {
	#name : 'LcsBaseUser',
	#superclass : 'LcsDomainObject',
	#category : 'Lcs-Security-Core',
	#package : 'Lcs-Security',
	#tag : 'Core'
}

{ #category : 'slot definitions' }
LcsBaseUser class >> parentSlotDefinition [
	<slotDefinition>
	^ LcsGlobalCollectionReferenceSlot new
			slotName: 'parent';
			collectionSlotModuleName: LcsSecurityModule defaultModuleName;
			collectionSlotName: 'users';
			addSlotType: LcsUsers;
			yourself 
]

{ #category : 'permissions' }
LcsBaseUser >> hasPermissionToReadSlot: aSlotDefinition in: aDomainObject [
	^ true
]

{ #category : 'permissions' }
LcsBaseUser >> hasPermissionToWriteSlot: aSlotDefinition in: aDomainObject [
	^ true
]
