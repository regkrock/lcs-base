Class {
	#name : 'LcsLocalCollectionSlotBuilder',
	#superclass : 'LcsDomainCollectionSlotBuilder',
	#category : 'Lcs-SlotTools-Core',
	#package : 'Lcs-SlotTools',
	#tag : 'Core'
}

{ #category : 'defaults' }
LcsLocalCollectionSlotBuilder class >> slotClass [
	^ LcsLocalCollectionSlot
]

{ #category : 'margritte' }
LcsLocalCollectionSlotBuilder >> collectionMemberTypesDescription [
	<magritteDescription>
	^ super collectionMemberTypesDescription
]

{ #category : 'job steps' }
LcsLocalCollectionSlotBuilder >> localCollectionReferenceSlotBuilder: aClassName [
	^ LcsLocalCollectionReferenceSlotBuilder new
		targetClassName: aClassName;
		collectionSlotName: self slotName;
		addSlotType: self slotTypes first;
		yourself
]
